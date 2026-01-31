#!/bin/bash

# Comprehensive script to rename all "black" references to "censura"
# This consolidates all the sed commands used in the Black to Censura rebranding

echo "Starting comprehensive Black to Censura renaming..."

# ============================================================================
# FILE RENAMING
# ============================================================================

echo "Renaming files with 'black' in their names..."

# Rename test files
if [ -f "tests/test_black.py" ]; then
    mv tests/test_black.py tests/test_censura.py
    echo "  ✓ tests/test_black.py → tests/test_censura.py"
fi

if [ -f "tests/test_blackd.py" ]; then
    mv tests/test_blackd.py tests/test_censurad.py
    echo "  ✓ tests/test_blackd.py → tests/test_censurad.py"
fi

# Rename test data files
if [ -f "tests/data/project_metadata/only_black_pyproject.toml" ]; then
    mv tests/data/project_metadata/only_black_pyproject.toml tests/data/project_metadata/only_censura_pyproject.toml
    echo "  ✓ only_black_pyproject.toml → only_censura_pyproject.toml"
fi

if [ -f "tests/data/miscellaneous/blackd_diff.py" ]; then
    mv tests/data/miscellaneous/blackd_diff.py tests/data/miscellaneous/censurad_diff.py
    echo "  ✓ blackd_diff.py → censurad_diff.py"
fi

if [ -f "tests/data/miscellaneous/blackd_diff.diff" ]; then
    mv tests/data/miscellaneous/blackd_diff.diff tests/data/miscellaneous/censurad_diff.diff
    echo "  ✓ blackd_diff.diff → censurad_diff.diff"
fi

# Rename plugin file
if [ -f "plugin/black.vim" ]; then
    mv plugin/black.vim plugin/censura.vim
    echo "  ✓ plugin/black.vim → plugin/censura.vim"
fi

# Delete docs folder (will be recreated from scratch)
if [ -d "docs" ]; then
    rm -rf docs
    echo "  ✓ Deleted docs/ folder"
fi

# Rename script file
if [ -f "scripts/migrate-black.py" ]; then
    mv scripts/migrate-black.py scripts/migrate-censura.py
    echo "  ✓ migrate-black.py → migrate-censura.py"
fi

echo ""

# ============================================================================
# TEST FILES
# ============================================================================

echo "Fixing test_censurad.py..."
sed -i '' 's/import blackd$/import censurad/g' tests/test_censurad.py
sed -i '' 's/import blackd\.client/import censurad.client/g' tests/test_censurad.py
sed -i '' 's/@pytest\.mark\.blackd/@pytest.mark.censurad/g' tests/test_censurad.py
sed -i '' 's/class BlackDTestCase/class CensuraDTestCase/g' tests/test_censurad.py
sed -i '' 's/class BlackDClientTestCase/class CensuraDClientTestCase/g' tests/test_censurad.py
sed -i '' 's/def test_blackd_/def test_censurad_/g' tests/test_censurad.py
sed -i '' 's/"blackd\./"censurad./g' tests/test_censurad.py
sed -i '' 's/blackd\.main/censurad.main/g' tests/test_censurad.py
sed -i '' 's/blackd\.make_app/censurad.make_app/g' tests/test_censurad.py
sed -i '' 's/blackd\.PROTOCOL_VERSION_HEADER/censurad.PROTOCOL_VERSION_HEADER/g' tests/test_censurad.py
sed -i '' 's/blackd\.PYTHON_VARIANT_HEADER/censurad.PYTHON_VARIANT_HEADER/g' tests/test_censurad.py
sed -i '' 's/blackd\.DIFF_HEADER/censurad.DIFF_HEADER/g' tests/test_censurad.py
sed -i '' 's/blackd\.LINE_LENGTH_HEADER/censurad.LINE_LENGTH_HEADER/g' tests/test_censurad.py
sed -i '' 's/blackd\.SKIP_SOURCE_FIRST_LINE/censurad.SKIP_SOURCE_FIRST_LINE/g' tests/test_censurad.py
sed -i '' 's/blackd\.PREVIEW/censurad.PREVIEW/g' tests/test_censurad.py
sed -i '' 's/blackd\.BLACK_VERSION_HEADER/censurad.CENSURA_VERSION_HEADER/g' tests/test_censurad.py
sed -i '' 's/blackd\.client\.BlackDClient/censurad.client.CensuraDClient/g' tests/test_censurad.py
sed -i '' 's/black\.InvalidInput/censura.InvalidInput/g' tests/test_censurad.py
sed -i '' 's/"blackd_diff"/"censurad_diff"/g' tests/test_censurad.py
sed -i '' 's/"blackd_diff\.diff"/"censurad_diff.diff"/g' tests/test_censurad.py
sed -i '' 's/test_censurad_response_black_version_header/test_censurad_response_censura_version_header/g' tests/test_censurad.py

echo "Fixing test_format.py..."
sed -i '' 's/^import black$/import censura/g' tests/test_format.py
sed -i '' 's/from black\.mode/from censura.mode/g' tests/test_format.py
sed -i '' 's/"black\.dump_to_file"/"censura.dump_to_file"/g' tests/test_format.py
sed -i '' 's/black\.Mode/censura.Mode/g' tests/test_format.py
sed -i '' 's/black\.TargetVersion/censura.TargetVersion/g' tests/test_format.py
sed -i '' 's/black\.parsing\.InvalidInput/censura.parsing.InvalidInput/g' tests/test_format.py

echo "Fixing test_no_ipynb.py..."
sed -i '' 's/from black import/from censura import/g' tests/test_no_ipynb.py
sed -i '' 's/"black\[jupyter\]"/"censura[jupyter]"/g' tests/test_no_ipynb.py

echo "Fixing test_tokenize.py..."
sed -i '' 's/^import black$/import censura/g' tests/test_tokenize.py
sed -i '' 's/black\.format_str/censura.format_str/g' tests/test_tokenize.py
sed -i '' 's/black\.Mode/censura.Mode/g' tests/test_tokenize.py

echo "Fixing test_ipynb.py..."
sed -i '' 's/from black import/from censura import/g' tests/test_ipynb.py
sed -i '' 's/from black\.handle_ipynb_magics/from censura.handle_ipynb_magics/g' tests/test_ipynb.py
sed -i '' 's/"black\.jupyter_dependencies_are_installed"/"censura.jupyter_dependencies_are_installed"/g' tests/test_ipynb.py
sed -i '' 's/"black\.files\.jupyter_dependencies_are_installed"/"censura.files.jupyter_dependencies_are_installed"/g' tests/test_ipynb.py
sed -i '' "s/'black': venv/'censura': venv/g" tests/test_ipynb.py
sed -i '' 's/Black was not able/Censura was not able/g' tests/test_ipynb.py

echo "Fixing test_schema.py..."
sed -i '' 's/name="black"/name="censura"/g' tests/test_schema.py
sed -i '' 's/black_fn("black")/black_fn("censura")/g' tests/test_schema.py

echo "Fixing test_ranges.py..."
sed -i '' 's/"Test the black\.ranges/"Test the censura.ranges/g' tests/test_ranges.py
sed -i '' 's/from black\.ranges/from censura.ranges/g' tests/test_ranges.py

echo "Fixing test_concurrency_manager_shutdown.py..."
sed -i '' 's/import black\.concurrency/import censura.concurrency/g' tests/test_concurrency_manager_shutdown.py
sed -i '' 's/from black import/from censura import/g' tests/test_concurrency_manager_shutdown.py
sed -i '' 's/from black\.report/from censura.report/g' tests/test_concurrency_manager_shutdown.py

echo "Fixing test_docs.py..."
sed -i '' 's/from black\.mode/from censura.mode/g' tests/test_docs.py

echo "Fixing test_trans.py..."
sed -i '' 's/from black\.trans/from censura.trans/g' tests/test_trans.py

echo "Fixing test_censura.py..."
sed -i '' 's/black\.InvalidInput/censura.InvalidInput/g' tests/test_censura.py
sed -i '' 's/black\.NothingChanged/censura.NothingChanged/g' tests/test_censura.py
sed -i '' 's/black\.syms/censura.syms/g' tests/test_censura.py
sed -i '' 's/black\.token/censura.token/g' tests/test_censura.py
sed -i '' 's/black\.get_sources/censura.get_sources/g' tests/test_censura.py
sed -i '' 's/black\.format_file_contents/censura.format_file_contents/g' tests/test_censura.py
sed -i '' 's/black\.format_stdin_to_stdout/censura.format_stdin_to_stdout/g' tests/test_censura.py
sed -i '' 's/black\.reformat_one/censura.reformat_one/g' tests/test_censura.py
sed -i '' 's/black\.Cache/censura.Cache/g' tests/test_censura.py
sed -i '' 's/black\.parse_pyproject_toml/censura.parse_pyproject_toml/g' tests/test_censura.py
sed -i '' 's/black\.read_pyproject_toml/censura.read_pyproject_toml/g' tests/test_censura.py
sed -i '' 's/black\.find_project_root/censura.find_project_root/g' tests/test_censura.py
sed -i '' 's/black\.__version__/censura.__version__/g' tests/test_censura.py
sed -i '' 's/black\.format_str/censura.format_str/g' tests/test_censura.py
sed -i '' 's/black\.FileMode/censura.FileMode/g' tests/test_censura.py
sed -i '' 's/black\.parsing\.InvalidInput/censura.parsing.InvalidInput/g' tests/test_censura.py
sed -i '' 's/patch\.object(black,/patch.object(censura,/g' tests/test_censura.py
sed -i '' 's/black\.parse_ast/censura.parse_ast/g' tests/test_censura.py
sed -i '' 's/open(black\.__file__/open(censura.__file__/g' tests/test_censura.py
sed -i '' 's/if not black\.COMPILED:/if not censura.COMPILED:/g' tests/test_censura.py
sed -i '' 's/when testing Black via/when testing Censura via/g' tests/test_censura.py
sed -i '' 's/ensure black can/ensure censura can/g' tests/test_censura.py
sed -i '' 's/CLI (`black \./CLI (`censura ./g' tests/test_censura.py
sed -i '' 's/since we are forcing stdin, black/since we are forcing stdin, censura/g' tests/test_censura.py
sed -i '' 's/\[tool\.black\]/[tool.censura]/g' tests/test_censura.py
sed -i '' 's/missing the \[tool\.black\]/missing the [tool.censura]/g' tests/test_censura.py
sed -i '' 's|"black"|"censura"|g' tests/test_censura.py
sed -i '' 's|/ "black"|/ "censura"|g' tests/test_censura.py
sed -i '' 's|\.black"|.censura"|g' tests/test_censura.py
sed -i '' "s|'\.black'|'.censura'|g" tests/test_censura.py
sed -i '' 's/Run Black over/Run Censura over/g' tests/test_censura.py
sed -i '' "s/given to Black through/given to Censura through/g" tests/test_censura.py
sed -i '' 's|from black/__init__|from censura/__init__|g' tests/test_censura.py
sed -i '' 's|black/__init__|censura/__init__|g' tests/test_censura.py
sed -i '' "s/Exclude shouldn't touch files that were explicitly given to Black/Exclude shouldn't touch files that were explicitly given to Censura/g" tests/test_censura.py
sed -i '' 's/BlackBaseTestCase/CensuraBaseTestCase/g' tests/test_censura.py
sed -i '' 's/class BlackTestCase/class CensuraTestCase/g' tests/test_censura.py
sed -i '' 's/def invokeBlack/def invokeCensura/g' tests/test_censura.py
sed -i '' 's/invokeBlack/invokeCensura/g' tests/test_censura.py
sed -i '' 's/self\.invokeBlack/self.invokeCensura/g' tests/test_censura.py
sed -i '' 's/class TestASTSafety(BlackBaseTestCase)/class TestASTSafety(CensuraBaseTestCase)/g' tests/test_censura.py

echo "Fixing tests/util.py..."
sed -i '' 's/to check that Black formats/to check that Censura formats/g' tests/util.py
sed -i '' "s/ensure that Black doesn't/ensure that Censura doesn't/g" tests/util.py
sed -i '' 's/Black crashed formatting/Censura crashed formatting/g' tests/util.py
sed -i '' "s/Black's autodetection/Censura's autodetection/g" tests/util.py
sed -i '' 's/class BlackBaseTestCase/class CensuraBaseTestCase/g' tests/util.py

# ============================================================================
# TEST DATA FILES
# ============================================================================

echo "Fixing test data files..."
sed -i '' 's/make Black/make Censura/g' tests/data/cases/line_ranges_diff_edge_case.py
sed -i '' 's/for Black'"'"'s/for Censura'"'"'s/g' tests/data/cases/line_ranges_two_passes.py
sed -i '' 's/"black\.out"/"censura.out"/g' tests/data/cases/composition.py
sed -i '' 's/"black\.out"/"censura.out"/g' tests/data/cases/composition_no_trailing_comma.py
sed -i '' 's/black\.main/censura.main/g' tests/data/cases/function2.py
sed -i '' 's/`black`/`censura`/g' tests/data/cases/comments8.py
sed -i '' 's/short, black will/short, censura will/g' tests/data/cases/long_strings_flag_disabled.py
sed -i '' 's/short, black will/short, censura will/g' tests/data/cases/preview_long_strings.py
sed -i '' 's/string, black needs/string, censura needs/g' tests/data/cases/long_strings_flag_disabled.py
sed -i '' 's/string, black needs/string, censura needs/g' tests/data/cases/preview_long_strings.py
sed -i '' 's/Black does not support/Censura does not support/g' tests/data/cases/fmtonoff.py

# ============================================================================
# SOURCE CODE
# ============================================================================

echo "Fixing source code comments..."
sed -i '' 's/Black treats/Censura treats/g' src/blib2to3/pgen2/tokenize.py
sed -i '' "s/Black doesn't/Censura doesn't/g" src/blib2to3/pgen2/tokenize.py
sed -i '' 's/Black uses/Censura uses/g' src/blib2to3/pgen2/tokenize.py

sed -i '' "s/for Black's/for Censura's/g" src/blib2to3/pgen2/parse.py

sed -i '' 's/When Black expands/When Censura expands/g' src/censura/comments.py
sed -i '' "s/after Black's/after Censura's/g" src/censura/comments.py

sed -i '' 's/When trailing commas or optional parens are inserted by Black/When trailing commas or optional parens are inserted by Censura/g' src/censura/lines.py

sed -i '' "s/once Black figures/once Censura figures/g" src/censura/trans.py

echo "Fixing src/censura/__init__.py..."
sed -i '' 's/"Inject Black configuration"/"Inject Censura configuration"/g' src/censura/__init__.py
sed -i '' "s/should be supported by Black's/should be supported by Censura's/g" src/censura/__init__.py
sed -i '' 's/By default, Black will/By default, Censura will/g' src/censura/__init__.py
sed -i '' 's/Black will use/Censura will use/g' src/censura/__init__.py
sed -i '' "s/to Black's main/to Censura's main/g" src/censura/__init__.py
sed -i '' "s/into the stable style Black's/into the stable style Censura's/g" src/censura/__init__.py
sed -i '' "s/Black would've/Censura would've/g" src/censura/__init__.py
sed -i '' 's/Black will try/Censura will try/g' src/censura/__init__.py
sed -i '' 's/By default, Black performs/By default, Censura performs/g' src/censura/__init__.py
sed -i '' 's/version of Black/version of Censura/g' src/censura/__init__.py
sed -i '' 's/versions of Black/versions of Censura/g' src/censura/__init__.py
sed -i '' 's/By default, Black also/By default, Censura also/g' src/censura/__init__.py
sed -i '' 's/invoking Black programmatically/invoking Censura programmatically/g' src/censura/__init__.py
sed -i '' 's/make sure Black/make sure Censura/g' src/censura/__init__.py
sed -i '' 's/If Black is using/If Censura is using/g' src/censura/__init__.py
sed -i '' 's/forcing Black to/forcing Censura to/g' src/censura/__init__.py
sed -i '' 's/_black_info/_censura_info/g' src/censura/__init__.py

echo "Fixing src/censura/files.py..."
sed -i '' 's/pulling out relevant parts for Black/pulling out relevant parts for Censura/g' src/censura/files.py
sed -i '' "s/Infer Black's target/Infer Censura's target/g" src/censura/files.py
sed -i '' 's/top-level user configuration for black/top-level user configuration for censura/g' src/censura/files.py
sed -i '' 's/~\\\.black/~\\.censura/g' src/censura/files.py
sed -i '' 's/~\/\.config\/black/~\/.config\/censura/g' src/censura/files.py

# ============================================================================
# SCRIPTS
# ============================================================================

echo "Fixing scripts..."
sed -i '' 's/latest version of Black/latest version of Censura/g' scripts/check_pre_commit_rev_in_example.py

sed -i '' "s/for psf\/black's/for kactlabs\/censura's/g" scripts/diff_shades_gha_helper.py
sed -i '' 's/run Black on/run Censura on/g' scripts/diff_shades_gha_helper.py
sed -i '' 's/default="psf\/black"/default="kactlabs\/censura"/g' scripts/diff_shades_gha_helper.py
sed -i '' 's/pypi\.org\/pypi\/black/pypi.org\/pypi\/censura/g' scripts/diff_shades_gha_helper.py
sed -i '' 's/PyPI Black/PyPI Censura/g' scripts/diff_shades_gha_helper.py

sed -i '' 's/import black$/import censura/g' scripts/generate_schema.py
sed -i '' 's/black\.main/censura.main/g' scripts/generate_schema.py
sed -i '' 's/psf\/supergreen\/blob\/main\/src\/black\/resources\/black\.schema\.json/kactlabs\/censura\/blob\/main\/src\/censura\/resources\/censura.schema.json/g' scripts/generate_schema.py
sed -i '' 's/tool\.black/tool.censura/g' scripts/generate_schema.py
sed -i '' 's/partial-black\.json/partial-censura.json/g' scripts/generate_schema.py

sed -i '' 's/-black"/-censura"/g' scripts/migrate-censura.py
sed -i '' 's/-black\.\./-censura../g' scripts/migrate-censura.py
sed -i '' 's/--black_command/--censura_command/g' scripts/migrate-censura.py
sed -i '' 's/default="black -q \."/default="censura -q ."/g' scripts/migrate-censura.py

# Fix release.py variable names
sed -i '' 's/black_repo_dir/censura_repo_dir/g' scripts/release.py
sed -i '' 's/black_repo_path/censura_repo_path/g' scripts/release.py
sed -i '' 's/_Blackd_/_Censurad_/g' scripts/release.py
sed -i '' 's/Changes to blackd/Changes to censurad/g' scripts/release.py

# Fix migrate-censura.py - blackify → censurize
sed -i '' 's/blackify/censurize/g' scripts/migrate-censura.py
sed -i '' 's/blackified/censurized/g' scripts/migrate-censura.py
sed -i '' 's/black_command/censura_command/g' scripts/migrate-censura.py

# ============================================================================
# CONFIGURATION FILES
# ============================================================================

echo "Updating configuration files..."


# Fix .github templates
sed -i '' "s/improve Black's quality/improve Censura's quality/g" .github/ISSUE_TEMPLATE/bug_report.md
sed -i '' 's/Update Black'"'"'s version/Update Censura'"'"'s version/g' .github/ISSUE_TEMPLATE/bug_report.md
sed -i '' 's/pip install -U black/pip install -U censura/g' .github/ISSUE_TEMPLATE/bug_report.md
sed -i '' 's/run `black`/run `censura`/g' .github/ISSUE_TEMPLATE/bug_report.md
sed -i '' "s/Black's configuration/Censura's configuration/g" .github/ISSUE_TEMPLATE/bug_report.md
sed -i '' 's/\$ black file\.py/$ censura file.py/g' .github/ISSUE_TEMPLATE/bug_report.md
sed -i '' "s/Black's version:/Censura's version:/g" .github/ISSUE_TEMPLATE/bug_report.md

sed -i '' 's/improve the Black code style/improve the Censura code style/g' .github/ISSUE_TEMPLATE/style_issue.md
sed -i '' 's/as per the current Black style/as per the current Censura style/g' .github/ISSUE_TEMPLATE/style_issue.md

sed -i '' "s/familiarize yourself with Black's/familiarize yourself with Censura's/g" .github/PULL_REQUEST_TEMPLATE.md
sed -i '' 's|black\.readthedocs\.io|censura.readthedocs.io|g' .github/PULL_REQUEST_TEMPLATE.md

# Fix AUTHORS.md email references
sed -i '' 's/ahrex-gh-psf-black@/ahrex-gh-kactlabs-censura@/g' AUTHORS.md
sed -i '' 's/aaossa+black@/aaossa+censura@/g' AUTHORS.md

# ============================================================================
# FINAL CLEANUP
# ============================================================================

echo "Final cleanup of remaining references..."

# Fix test_censura.py
sed -i '' 's/only_black_pyproject\.toml/only_censura_pyproject.toml/g' tests/test_censura.py
sed -i '' 's/black_source_lines/censura_source_lines/g' tests/test_censura.py

# Fix test_docs.py - path reference
sed -i '' 's|docs/the_black_code_style/future_style\.md|docs/the_censura_code_style/future_style.md|g' tests/test_docs.py

# Fix test_schema.py - variable names
sed -i '' 's/black_ep,/censura_ep,/g' tests/test_schema.py
sed -i '' 's/black_ep\./censura_ep./g' tests/test_schema.py
sed -i '' 's/black_fn/censura_fn/g' tests/test_schema.py

# Fix test data - these are in string literals and comments
sed -i '' 's/{black}/{censura}/g' tests/data/cases/preview_long_strings.py
sed -i '' 's/{black}/{censura}/g' tests/data/cases/long_strings_flag_disabled.py
sed -i '' 's/{black}/{censura}/g' tests/data/cases/preview_long_strings__regression.py

# Fix test data - function/variable names in test cases
sed -i '' 's/black(1)/censura(1)/g' tests/data/cases/remove_await_parens.py
sed -i '' 's/await black(/await censura(/g' tests/data/cases/remove_await_parens.py

# Fix docstring test data
sed -i '' 's/without another non-empty line black is stable/without another non-empty line censura is stable/g' tests/data/cases/docstring.py

# Fix pattern matching test data
sed -i '' 's/black_check/censura_check/g' tests/data/cases/pattern_matching_complex.py

# Fix type_params test data - variable names
sed -i '' 's/MakeBlackSplitThisLine/MakeCensuraSplitThisLine/g' tests/data/cases/type_params.py

# Fix expression test data - łukasz references
sed -i '' 's/authors\.łukasz\.say_thanks()/authors.raja.say_thanks()/g' tests/data/cases/expression.py

# Fix test_ipynb.py - venv display name in test data
sed -i '' "s/\\\\'black\\\\'/\\\\'censura\\\\'/g" tests/test_ipynb.py

# Fix src/censura/__init__.py docstring
sed -i '' 's/"Inject Black configuration"/"Inject Censura configuration"/g' src/censura/__init__.py

echo ""
echo "✅ All Black to Censura renaming completed successfully!"
echo ""
