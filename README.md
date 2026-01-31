# Censura

<h2 align="center">Black++ - The Enhanced Python Code Formatter</h2>

> "Any color you like, with extra features."

_Censura_ is an enhanced Python code formatter built on Black's proven foundation. It extends Black's uncompromising approach with additional features and improvements, delivering the same speed and determinism you expect, plus more.

Like Black, Censura reformats your code consistently across projects. But as Black++, it adds powerful enhancements for modern Python development while maintaining full compatibility with Black's core philosophy.

_Censura_ makes code review faster by producing the smallest diffs possible, just like Black, but with enhanced capabilities.

---

## Installation and usage

### Installation

_Censura_ can be installed by running `pip install censura`. It requires Python 3.10+ to
run. If you want to format Jupyter Notebooks, install with
`pip install "censura[jupyter]"`.

### Usage

To get started right away with sensible defaults:

```sh
censura {source_file_or_directory}
```

You can run _Censura_ as a package if running it as a script doesn't work:

```sh
python -m censura {source_file_or_directory}
```

## The _Censura_ code style

_Censura_ is a PEP 8 compliant opinionated formatter built on Black's foundation. _Censura_ reformats entire files in place with enhanced features. Style configuration options are deliberately limited and rarely added, maintaining Black's philosophy while adding powerful improvements.

### Pragmatism

_Censura_ inherits Black's pragmatic approach to code formatting. As a mature tool built on Black's foundation, _Censura_ makes smart exceptions to rules when necessary, just like Black does, while adding enhanced capabilities for modern Python development.

## Configuration

_Censura_ is able to read project-specific default values for its command line options
from a `pyproject.toml` file. This is especially useful for specifying custom
`--include` and `--exclude`/`--force-exclude`/`--extend-exclude` patterns for your
project.

**Pro-tip**: If you're asking yourself "Do I need to configure anything?" the answer is
"No". _Censura_ is all about sensible defaults, just like Black. Applying those defaults will have your
code in compliance with many other _Censura_ formatted projects.

## License

MIT

## Contributing

Welcome! Happy to see you willing to make the project better.

## Authors

See [AUTHORS.md](./AUTHORS.md)

## About

Censura is a fork of [Black](https://github.com/psf/black), the uncompromising Python code formatter created by Łukasz Langa and contributors. We extend Black's excellent foundation with additional features and enhancements.

