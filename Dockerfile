ARG PYTHON_VERSION=3.10

FROM oziproject/supported-python:2023

RUN set -ex \
  && apt-get update \
  && apt-get install --no-install-recommends -y git-lfs

COPY . .

RUN python${PYTHON_VERSION} -m pip install . && python${PYTHON_VERSION} -m pip uninstall -y pip

RUN mkdir /pyc_wheel
WORKDIR /pyc_wheel
COPY action.sh /pyc_wheel/action.sh
RUN chmod +x /pyc_wheel/action.sh

ENTRYPOINT ["bash", "/pyc_wheel/action.sh" ]
