# Censura Utility Scripts

This directory contains utility scripts for development, maintenance, and code quality tasks.

## User-Facing Scripts

### fix_pylint_naming.py

Automatically fixes pylint naming convention issues by converting module-level variables to UPPER_CASE constants.

**Usage:**
```bash
# Fix naming issues in files or directories
python scripts/fix_pylint_naming.py <path>

# Preview changes without modifying files
python scripts/fix_pylint_naming.py <path> --dry-run
```

**Example:**
```bash
# Fix all Python files in a directory
python scripts/fix_pylint_naming.py ./my_project

# Preview changes
python scripts/fix_pylint_naming.py ./my_project --dry-run
```

This script detects module-level variables that pylint considers constants and renames them according to PEP 8 conventions (UPPER_CASE).

## Development Scripts

### migrate-censura.py
Migration utility for updating code from Black to Censura.

### generate_schema.py
Generates JSON schema for Censura configuration.

### make_width_table.py
Generates character width tables for formatting.

### fuzz.py
Fuzzing script for testing Censura's robustness.

### release.py
Release automation script.

### release_tests.py
Tests for the release process.

### diff_shades_gha_helper.py
Helper for diff-shades GitHub Actions integration.

### check_pre_commit_rev_in_example.py
Validates pre-commit configuration examples.

### check_version_in_basics_example.py
Validates version references in documentation.
