"""
Naming convention fixes for censura.

This module provides functionality to fix pylint naming convention issues,
particularly converting module-level variables to UPPER_CASE constants.
"""

import ast
from typing import Dict, Set


class ConstantRenamer(ast.NodeTransformer):
    """AST transformer that renames module-level constants to UPPER_CASE."""

    def __init__(self, renames: Dict[str, str]):
        self.renames = renames
        self.in_function = 0
        self.in_class = 0

    def visit_FunctionDef(self, node):
        self.in_function += 1
        self.generic_visit(node)
        self.in_function -= 1
        return node

    def visit_AsyncFunctionDef(self, node):
        return self.visit_FunctionDef(node)

    def visit_ClassDef(self, node):
        self.in_class += 1
        self.generic_visit(node)
        self.in_class -= 1
        return node

    def visit_Name(self, node):
        if node.id in self.renames:
            node.id = self.renames[node.id]
        return node


class ConstantDetector(ast.NodeVisitor):
    """Detect module-level constants that should be UPPER_CASE."""

    def __init__(self):
        self.constants: Set[str] = set()
        self.modified_vars: Set[str] = set()  # Variables that are reassigned
        self.in_function = 0
        self.in_class = 0

    def visit_FunctionDef(self, node):
        self.in_function += 1
        self.generic_visit(node)
        self.in_function -= 1

    def visit_AsyncFunctionDef(self, node):
        self.visit_FunctionDef(node)

    def visit_ClassDef(self, node):
        self.in_class += 1
        self.generic_visit(node)
        self.in_class -= 1

    def visit_Assign(self, node):
        # Only process module-level assignments
        if self.in_function == 0 and self.in_class == 0:
            for target in node.targets:
                if isinstance(target, ast.Name):
                    name = target.id
                    # Check if it's not already UPPER_CASE and not a special name
                    if (
                        not name.isupper()
                        and not name.startswith("_")
                        and name != name.upper()
                    ):
                        # Check if this variable is already in our list
                        # If so, it's being reassigned, so it's not a constant
                        if name in self.constants:
                            self.modified_vars.add(name)
                        else:
                            self.constants.add(name)
        self.generic_visit(node)

    def visit_AugAssign(self, node):
        """Detect augmented assignments like +=, -=, etc."""
        if self.in_function == 0 and self.in_class == 0:
            if isinstance(node.target, ast.Name):
                name = node.target.id
                # Mark as modified variable, not a constant
                self.modified_vars.add(name)
                self.constants.discard(name)
        self.generic_visit(node)

    def get_true_constants(self) -> Set[str]:
        """Return only variables that are never modified."""
        return self.constants - self.modified_vars


def fix_naming_conventions(src_contents: str) -> str:
    """
    Fix naming convention issues in Python source code.
    
    Converts module-level constants (never modified) to UPPER_CASE.
    Variables that are reassigned or modified remain snake_case.
    
    Args:
        src_contents: Python source code as a string
        
    Returns:
        Modified source code with fixed naming conventions
    """
    try:
        tree = ast.parse(src_contents)
    except SyntaxError:
        # If we can't parse it, return unchanged
        return src_contents

    # Detect constants that need renaming
    detector = ConstantDetector()
    detector.visit(tree)

    # Only rename true constants (never modified)
    true_constants = detector.get_true_constants()

    if not true_constants:
        return src_contents

    # Build rename mapping
    renames = {name: name.upper() for name in true_constants}

    # Apply renames using simple string replacement
    # This preserves formatting better than AST manipulation
    result = src_contents
    for old_name, new_name in renames.items():
        # Use word boundaries to avoid partial replacements
        import re

        # Match the name as a whole word (not part of another identifier)
        pattern = r"\b" + re.escape(old_name) + r"\b"
        result = re.sub(pattern, new_name, result)

    return result
