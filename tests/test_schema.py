import importlib.metadata


def test_schema_entrypoint() -> None:
    (censura_ep,) = importlib.metadata.entry_points(
        group="validate_pyproject.tool_schema", name="censura"
    )

    censura_fn = censura_ep.load()
    schema = censura_fn()
    assert schema == censura_fn("censura")
    assert schema["properties"]["line-length"]["type"] == "integer"
