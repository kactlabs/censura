#!/usr/bin/env python3
"""
Fix pylint naming convention issues for module-level variables.

This script identifies module-level variables that pylint considers constants
(assigned once at module level) and converts them to UPPER_CASE naming.
"""

import ast
import sys
from pathlib import Path
from typing import Dict, List, Set, Tuple


class ConstantDetector(ast.NodeVisitor):
    """Detect module-level constants that should be UPPER_CASE."""

    def __init__(self):
        self.constants: Dict[str, int] = {}  # name -> line number
        self.in_function = False
        self.in_class = False

    def visit_FunctionDef(self, node):
        old_in_function = self.in_function
        self.in_function = True
        self.generic_visit(node)
        self.in_function = old_in_function

    def visit_AsyncFunctionDef(self, node):
        self.visit_FunctionDef(node)

    def visit_ClassDef(self, node):
        old_in_class = self.in_class
        self.in_class = True
        self.generic_visit(node)
        self.in_class = old_in_class

    def visit_Assign(self, node):
        # Only process module-level assignments
        if not self.in_function and not self.in_class:
            for target in node.targets:
                if isinstance(target, ast.Name):
                    name = target.id
                    # Check if it's not already UPPER_CASE
                    if not name.isupper() and name != name.upper():
                        self.constants[name] = node.lineno
        self.generic_visit(node)


def rename_constant(name: str) -> str:
    """Convert a variable name to UPPER_CASE."""
    return name.upper()


def fix_file(file_path: Path, dry_run: bool = False) -> Tuple[bool, List[str]]:
    """
    Fix naming conventions in a Python file.
    
    Returns:
        (changed, messages) tuple
    """
    messages = []
    
    try:
        content = file_path.read_text()
        tree = ast.parse(content)
    except Exception as e:
        messages.append(f"Error parsing {file_path}: {e}")
        return False, messages

    detector = ConstantDetector()
    detector.visit(tree)

    if not detector.constants:
        messages.append(f"No naming issues found in {file_path}")
        return False, messages

    # Sort by line number in reverse to avoid offset issues
    constants_sorted = sorted(detector.constants.items(), key=lambda x: x[1], reverse=True)
    
    lines = content.splitlines(keepends=True)
    changed = False

    for old_name, line_num in constants_sorted:
        new_name = rename_constant(old_name)
        
        # Replace in the entire file (all occurrences)
        new_content = content.replace(old_name, new_name)
        
        if new_content != content:
            messages.append(f"  Line {line_num}: {old_name} -> {new_name}")
            content = new_content
            changed = True

    if changed and not dry_run:
        file_path.write_text(content)
        messages.append(f"✓ Fixed {file_path}")
    elif changed:
        messages.append(f"Would fix {file_path} (dry run)")

    return changed, messages


def main():
    import argparse
    
    parser = argparse.ArgumentParser(
        description="Fix pylint naming convention issues"
    )
    parser.add_argument(
        "paths",
        nargs="+",
        type=Path,
        help="Python files or directories to fix"
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show what would be changed without modifying files"
    )
    
    args = parser.parse_args()
    
    files_to_process = []
    for path in args.paths:
        if path.is_file() and path.suffix == ".py":
            files_to_process.append(path)
        elif path.is_dir():
            files_to_process.extend(path.rglob("*.py"))
    
    if not files_to_process:
        print("No Python files found to process")
        return 1
    
    total_changed = 0
    for file_path in files_to_process:
        changed, messages = fix_file(file_path, dry_run=args.dry_run)
        if messages:
            print(f"\n{file_path}:")
            for msg in messages:
                print(msg)
        if changed:
            total_changed += 1
    
    print(f"\n{'Would fix' if args.dry_run else 'Fixed'} {total_changed} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
