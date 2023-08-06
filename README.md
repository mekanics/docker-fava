# 🐳 `ghcr.io/mekanics/fava`

Docker image to run [Fava](https://beancount.github.io/fava/) for [Beancount](https://beancount.github.io/).

## Example Usage

```
docker run -v $PWD:/bean -e BEANCOUNT_FILE=/bean/main.bean -p 5000:5000 ghcr.io/mekanics/fava
```
