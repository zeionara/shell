#!/bin/bash

retry () {
    command=$1
    filter=$2
    delay=${3:-2} # seconds
    max_iterations=${4:-100}
    tmp_file=${5:-/tmp/log.txt}

    if [ -z "$command" ]; then
        echo 'Command must not be empty'
        exit 1
    fi

    if [ -z "$filter" ]; then
        echo 'Retry filter must not be empty'
        exit 1
    fi


    for i in $(seq 1 $max_iterations); do
        # output=$(eval "$command" 2>&1 | tee >(tail -n 1))
        # occurrence=$(echo "$output" | grep "$filter")

        eval "$command" 2>&1 | tee "$tmp_file"
        output=$(tail -n 1 "$tmp_file")

        rm "$tmp_file"
        occurrence=$(echo "$output" | grep "$filter")

        echo ''
        if [ -z "$occurrence" ]; then
            echo '🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢'
            echo "No occurrence of '$filter' in the last line of output '$output' from command '$command'"
            echo '🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢'
            break
        else
            echo '🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴'
            echo "Found occurrence of '$filter' in the last line of output '$output' from command '$command'. Retrying..."
            echo '🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴'
            sleep "$delay"
        fi
        echo ''
    done

    # command=$1
    # filter=$2
    # max_iterations=${3:-100}
    # delay=${4:-2} # seconds

    # if [ -z "$command" ]; then
    #     echo 'Command must not be empty'
    #     exit 1
    # fi

    # if [ -z "$filter" ]; then
    #     echo 'Retry filter must not be empty'
    #     exit 1
    # fi

    # for i in $(seq 1 $max_iterations); do
    #     output=$(eval "$command" 2>&1 | tail -n 1)
    #     occurrence=$(echo "$output" | grep "$filter")

    #     if [ -z "$occurrence" ]; then
    #         echo "No occurrence of '$filter' in the last line of output '$output' from command '$command'"
    #         break
    #     else
    #         echo "Found occurrence of '$filer' in the last line of output '$output' from command '$command'. Retrying..."
    #         sleep "$delay"
    #     fi
    # done
}
