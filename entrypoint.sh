#!/bin/sh
set -e

if [ -z "$BEANCOUNT_FILE" ]; then
    echo "Error: BEANCOUNT_FILE environment variable is not set." >&2
    exit 1
fi

BEAN_DIR=$(dirname "$BEANCOUNT_FILE")
USER_PYPROJECT="$BEAN_DIR/pyproject.toml"

if [ -f "$USER_PYPROJECT" ]; then
    echo "Found user pyproject.toml at $USER_PYPROJECT"
    echo "Installing additional dependencies..."
    if uv pip install --python /app/.venv/bin/python -r "$USER_PYPROJECT"; then
        echo "Additional dependencies installed successfully."
    else
        echo "Warning: Failed to install additional dependencies from $USER_PYPROJECT" >&2
    fi
fi

exec fava "$@"
