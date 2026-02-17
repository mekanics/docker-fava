# Using Python 3.12 instead of 3.13 due to compatibility issues with Cheroot WSGI server in Python 3.13
# Python 3.13 causes "OSError: [Errno 9] Bad file descriptor" errors in socket handling during garbage collection
# See issue: https://github.com/cherrypy/cheroot/issues/597
FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

# Install base dependencies (cached layer — only re-runs when lock or project metadata changes)
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-dev --no-install-project

ENV BEANCOUNT_FILE=""
ENV FAVA_HOST="0.0.0.0"
ENV PATH="/app/.venv/bin:$PATH"

RUN useradd -m favauser && chown -R favauser:favauser /app
USER favauser

COPY --chown=favauser:favauser entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]
