FROM python:3.11.4-bookworm

ADD requirements.txt .
RUN pip3 install -U -r requirements.txt

ENV BEANCOUNT_FILE ""
ENV FAVA_HOST "0.0.0.0"

ENTRYPOINT [ "fava" ]