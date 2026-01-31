import importlib.resources
import json
from typing import Any


def get_schema(tool_name: str = "censura") -> Any:
    """Get the stored complete schema for censura's settings."""
    assert tool_name == "censura", "Only censura is supported."

    pkg = "censura.resources"
    fname = "censura.schema.json"

    schema = importlib.resources.files(pkg).joinpath(fname)
    with schema.open(encoding="utf-8") as f:
        return json.load(f)
