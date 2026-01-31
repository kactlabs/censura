# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-01-31

### Added
- Automatic pylint naming convention fixes
- Smart detection of module-level constants vs variables
- Constants (assigned once, never modified) are automatically converted to UPPER_CASE
- Variables (reassigned or modified with +=, -=, etc.) remain snake_case
- New `src/censura/naming.py` module for naming convention transformations
- Utility script `scripts/fix_pylint_naming.py` for standalone naming fixes
- Documentation for naming fix feature in README.md and scripts/README.md

### Changed
- Enhanced `format_str()` to apply naming convention fixes after formatting
- Updated equivalence checks to account for naming transformations

## [0.0.1] - 2026-01-31

### Added
- Initial release of Censura
- Fork of Black with enhanced features
- PEP 8 compliant opinionated formatter
- Support for Python 3.10+
- Jupyter Notebook formatting support
- Configuration via pyproject.toml
- Command-line interface compatible with Black

[Unreleased]: https://github.com/kactlabs/censura/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/kactlabs/censura/compare/v0.0.1...v0.1.0
[0.0.1]: https://github.com/kactlabs/censura/releases/tag/v0.0.1
