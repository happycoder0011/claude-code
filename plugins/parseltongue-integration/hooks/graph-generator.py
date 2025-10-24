#!/usr/bin/env python3
import os
import json
import subprocess
import sys
from pathlib import Path

def run_command(cmd, cwd=None):
    """Run a shell command and return output or raise error."""
    try:
        result = subprocess.run(cmd, shell=True, cwd=cwd, capture_output=True, text=True, timeout=60)
        if result.returncode != 0:
            raise RuntimeError(f"Command failed: {result.stderr}")
        return result.stdout.strip()
    except subprocess.TimeoutExpired:
        raise RuntimeError("Command timed out")

def main():
    # Get current working directory (codebase path)
    codebase_path = os.getcwd()
    cache_file = "/tmp/parseltongue-graph.json"

    # Check if cache exists and is recent (e.g., within last hour)
    if os.path.exists(cache_file):
        mtime = os.path.getmtime(cache_file)
        if (os.time() - mtime) < 3600:  # 1 hour
            print("Using cached graph")
            return

    # Run parseltongue ingest
    print("Ingesting codebase with Parseltongue...")
    try:
        run_command(f"parseltongue ingest {codebase_path}", cwd=codebase_path)
        print("Ingestion complete")
    except RuntimeError as e:
        print(f"Ingestion failed: {e}")
        sys.exit(1)

    # Optionally generate context if needed (can be customized per command)
    # For now, just note that graph is ready

if __name__ == "__main__":
    main()
