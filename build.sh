#!/usr/bin/env bash

function show_usage() {
    echo -e "Usage\n"
    echo -e "  ./build.sh [build options] <path-to-binary-output>\n"
    echo -e "Specify a binary directory to place the compiled binary"
    echo -e "executables in after they have been built and compiled."
    echo -e "If no directory is passed the default ./bin/ directory"
    echo -e "will be created and used.\n"
}

function show_help() {
    show_usage
    echo -e "\nBuild Options"
    echo -e "  build                        = Build and compile the project"
    echo -e "  clean                        = Remove build intermediaries and binaries"
    echo -e "  cleanbuild                   = Build and compile the project then remove build intermediaries"
    echo -e "  help                         = Print this usage information and exit.\n"
}

function build() {
    echo -e "Building project"
    if [ ! -d "./build" ]; then
        mkdir ./build
    fi
    cmake -S ./src/ -B ./build/
    make -C ./build/
    if [ ! -d "$1" ]; then
        mkdir "$1"
    fi
    cp -rv ./build/bin/* "$1"/.
}

function clean() {
    echo -e "Cleaning project"
    rm -Rfv ./build/* ./build/.*
}

function clean_all() {
    clean
    echo -e "Cleaning binaries"
    rm -Rfv $1/* $1/.*
}

# Check number of args is valid
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo -e "Invalids number of arguments"
    show_usage
    echo -e "Run ./build.sh help for more information.\n"
    exit 1
fi

# Set binary output dir
if [ $# -eq 2 ]; then
    output_dir="$2"
else
    output_dir="./bin"
fi

if [ "$1" = "build" ]; then
    build ${output_dir}
    exit 0
elif [ "$1" = "clean" ]; then
    clean_all ${output_dir}
    exit 0
elif [ "$1" = "cleanbuild" ]; then
    build ${output_dir}
    clean ${output_dir}
    exit 0
elif [ "$1" = "help" ]; then
    show_help
    exit 1
else
    echo -e "Invalid argument passed"
    show_usage
    echo -e "Run ./build.sh help for more information.\n"
    exit 1
fi