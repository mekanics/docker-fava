# 🐳 `ghcr.io/mekanics/fava`

Docker image to run [Fava](https://beancount.github.io/fava/) for [Beancount](https://beancount.github.io/).

## Usage

```
docker run -v $PWD:/bean -e BEANCOUNT_FILE=/bean/main.bean -p 5000:5000 ghcr.io/mekanics/fava
```

## Custom Dependencies

You can install additional beancount plugins or Python packages without rebuilding the image by placing a `pyproject.toml` in the same directory as your `BEANCOUNT_FILE`.

Create a `pyproject.toml` next to your main beancount file:

```toml
[project]
name = "my-beancount"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = [
    "smart-importer>=0.4",
    "beancount-import>=1.0",
]
```

Then run as usual. The container will detect the file at startup and install the additional dependencies before launching Fava:

```
docker run -v $PWD:/bean -e BEANCOUNT_FILE=/bean/main.bean -p 5000:5000 ghcr.io/mekanics/fava
```

Git dependencies are also supported:

```toml
[project]
name = "my-beancount"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = [
    "my-plugin",
]

[tool.uv.sources]
my-plugin = { git = "https://github.com/user/my-plugin.git" }
```

## Included Packages

The image ships with these packages pre-installed:

- [fava](https://beancount.github.io/fava/)
- [beanprice](https://github.com/beancount/beanprice)
- [beancount-reds-plugins](https://github.com/redstreet/beancount_reds_plugins)
- [beancount-periodic](https://pypi.org/project/beancount-periodic/)
- [fava-dashboards](https://github.com/andreasgerstmayr/fava-dashboards)
- [fava-investor](https://github.com/redstreet/fava_investor)
- [loguru](https://github.com/Delgan/loguru)
- [ibflex](https://github.com/csingley/ibflex)
- [beancount-tools-collection](https://github.com/mekanics/beancount-tools-collection)
