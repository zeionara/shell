hfg () {
    name=$1

    # GIT_LFS_SKIP_SMUDGE=1 git clone git@hf.co:$name.git
    git clone git@hf.co:$name.git
}

hfgs () {
    name=$1

    GIT_LFS_SKIP_SMUDGE=1 git clone git@hf.co:$name.git
}
