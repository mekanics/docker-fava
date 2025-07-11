# Using Python 3.12 instead of 3.13 due to compatibility issues with Cheroot WSGI server in Python 3.13
# Python 3.13 causes "OSError: [Errno 9] Bad file descriptor" errors in socket handling during garbage collection
# See issue: https://github.com/cherrypy/cheroot/issues/597
FROM python:3.13-slim

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