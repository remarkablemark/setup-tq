# setup-tq

[![GitHub Release](https://img.shields.io/github/v/release/remarkablemark/setup-tq)](https://github.com/remarkablemark/setup-tq/releases)
[![test](https://github.com/remarkablemark/setup-tq/actions/workflows/test.yml/badge.svg)](https://github.com/remarkablemark/setup-tq/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

⚙️ Set up GitHub Actions with [tq](https://github.com/cryptaliagy/tomlq) (tomlq).

## Quick Start

```yaml
on: push
jobs:
  setup-tq:
    runs-on: ubuntu-latest
    steps:
      - name: Setup tq
        uses: remarkablemark/setup-tq@v1
```

## Usage

**Basic:**

```yaml
- uses: remarkablemark/setup-tq@v1
```

See [action.yml](action.yml)

## Inputs

### `version`

**Optional**: The version. Defaults to `1.2.3`:

```yaml
- uses: remarkablemark/setup-tq@v1
  with:
    version: 1.2.3
```

## License

[MIT](LICENSE)
