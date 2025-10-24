#!/bin/bash

# Parseltongue Wrapper Script
# Handles CLI invocations with error checking and fallbacks

PARSEL_TONGUE_CMD="parseltongue"  # Assume it's in PATH or set full path

function check_parseltongue() {
    if ! command -v $PARSEL_TONGUE_CMD &> /dev/null; then
        echo "Error: Parseltongue not found in PATH. Please install or add to PATH."
        return 1
    fi
    return 0
}

function run_ingest() {
    local codebase="$1"
    if [ -z "$codebase" ]; then
        echo "Error: Codebase path required for ingest"
        return 1
    fi
    echo "Running: $PARSEL_TONGUE_CMD ingest $codebase"
    $PARSEL_TONGUE_CMD ingest "$codebase"
    if [ $? -ne 0 ]; then
        echo "Error: Ingest failed"
        return 1
    fi
    echo "Ingest successful"
}

function run_generate_context() {
    local entity="$1"
    local format="${2:-json}"
    if [ -z "$entity" ]; then
        echo "Error: Entity required for generate-context"
        return 1
    fi
    echo "Running: $PARSEL_TONGUE_CMD generate-context $entity --format $format"
    $PARSEL_TONGUE_CMD generate-context "$entity" --format "$format"
    if [ $? -ne 0 ]; then
        echo "Error: Generate-context failed"
        return 1
    fi
}

function run_query() {
    local query="$1"
    local format="${2:-json}"
    if [ -z "$query" ]; then
        echo "Error: Query required"
        return 1
    fi
    echo "Running: $PARSEL_TONGUE_CMD query $query --format $format"
    $PARSEL_TONGUE_CMD query "$query" --format "$format"
    if [ $? -ne 0 ]; then
        echo "Error: Query failed"
        return 1
    fi
}

# Main logic based on arguments
case "$1" in
    "ingest")
        check_parseltongue && run_ingest "$2"
        ;;
    "generate-context")
        check_parseltongue && run_generate_context "$2" "$3"
        ;;
    "query")
        check_parseltongue && run_query "$2" "$3"
        ;;
    *)
        echo "Usage: $0 {ingest <path>|generate-context <entity> [format]|query <query> [format]}"
        exit 1
        ;;
esac
