# Stay on Python 3.12. On 3.13 and 3.14, Cheroot raises
# OSError: [Errno 9] Bad file descriptor from IOBase.__del__ when a client
# drops a connection. No Cheroot release fixes this.
# See https://github.com/cherrypy/cheroot/issues/734
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
