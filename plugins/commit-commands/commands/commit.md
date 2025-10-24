---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: Create a git commit
integrations: ["parseltongue"]
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

- If integrations include "parseltongue", run parseltongue-enhancer to generate context for changed files using --format json before committing
- Create a commit message based on the changes and context
- Run `git add .` if needed, then `git commit -m "commit message"`
