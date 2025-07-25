#!/bin/bash

# Script to replicate directory structure with hard links (non-destructive)

replicate () {

    # Check for correct number of arguments

    if [ "$#" -ne 2 ]; then
        echo "Error: Invalid number of arguments"
        echo "Usage: $0 <source_dir> <destination_dir>"
        exit 1
    fi
    
    SOURCE_DIR="$1"
    DEST_DIR="$2"
    
    # Verify source directory exists

    if [ ! -d "$SOURCE_DIR" ]; then
        echo "Error: Source directory does not exist: $SOURCE_DIR"
        exit 1
    fi
    
    # Resolve absolute paths

    SOURCE_DIR=$(realpath -e "$SOURCE_DIR")
    DEST_DIR=$(realpath -m "$DEST_DIR")
    
    # Safety checks

    if [ "$SOURCE_DIR" = "$DEST_DIR" ]; then
        echo "Error: Source and destination directories must be different"
        exit 1
    fi
    
    if [[ "$DEST_DIR" == "$SOURCE_DIR"/* ]]; then
        echo "Error: Destination cannot be inside source directory"
        exit 1
    fi
    
    # Create destination root

    echo "Creating destination directory: $DEST_DIR"
    sudo mkdir -p "$DEST_DIR" || exit 1
    
    # Find and replicate directory structure

    echo "Replicating directory structure..."
    sudo find "$SOURCE_DIR" -type d -print0 | while IFS= read -r -d '' dir; do
        rel_path="${dir#$SOURCE_DIR/}"
        dest_path="$DEST_DIR/$rel_path"

	if [ "$rel_path" = "$SOURCE_DIR" ]; then
	    continue
	fi

        if [ ! -d "$dest_path" ]; then
            echo "Creating: $dest_path"
            sudo mkdir -p "$dest_path"
        fi
    done
    
    # Create hard links for files (only if destination doesn't exist)

    echo "Creating hard links..."
    sudo find "$SOURCE_DIR" -type f -print0 | while IFS= read -r -d '' file; do
        rel_path="${file#$SOURCE_DIR/}"
        dest_file="$DEST_DIR/$rel_path"
        
        if [ ! -e "$dest_file" ]; then
            echo "Linking: $file -> $dest_file"
            sudo ln "$file" "$dest_file"
        else
            echo "Skipping existing file: $dest_file"
        fi
    done

    # Process symbolic links

    echo "Processing symbolic links..."
    find "$SOURCE_DIR" -type l -print0 | while IFS= read -r -d '' symlink; do
        rel_path="${symlink#$SOURCE_DIR/}"
        target_symlink="$DEST_DIR/$rel_path"
        
        # Resolve symlink target

        target=$(readlink -f "$symlink")
        
        # Validate target

        if [ -z "$target" ]; then
            echo "Warning: Broken symlink: $symlink" >&2
            continue
        fi
        
        if [ ! -e "$target" ]; then
            echo "Warning: Target does not exist: $symlink → $target" >&2
            continue
        fi
        
	if [ -d "$target" ]; then
            echo "Linking (dereferencing directory): $target → $target_symlink"
	    replicate "$target" "$target_symlink"
            echo "Linked (dereferenced directory): $target → $target_symlink"
	    continue
	elif [ ! -f "$target" ]; then
            echo "Skipped: Non-file target ($(file -b "$target")): $symlink → $target" >&2
            continue
        fi

        # Skip if destination already exists

        if [ -e "$target_symlink" ]; then
            echo "Skipped (exists): $target_symlink"
            continue
        fi

        # Create hard link to target
        if ln "$target" "$target_symlink" 2>/dev/null; then
            echo "Linked (dereferenced): $target → $target_symlink"
        else
            # Handle cross-filesystem errors
            if [ $? -eq 1 ]; then
                echo "Error: Cross-filesystem link not possible: $symlink → $target" >&2
                echo "       Target is on different filesystem: $(stat -c %m "$target")" >&2
            else
                echo "Error: Failed to link: $symlink → $target" >&2
            fi
        fi
    done
    
    echo "Operation completed successfully"
}
