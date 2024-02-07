FROM python:3.12.2-slim

WORKDIR /app

# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

ENV BEANCOUNT_FILE=""
ENV FAVA_HOST="0.0.0.0"

RUN useradd -m favauser
USER favauser

CMD ["fava"]