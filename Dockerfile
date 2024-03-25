ARG PYTHON_VERSION=3.11

FROM oziproject/supported-python:2023

COPY . .

RUN python3.12 -m pip install . && python3.12 -m pip uninstall -y pip
RUN python3.11 -m pip install . && python3.11 -m pip uninstall -y pip
RUN python3.10 -m pip install . && python3.10 -m pip uninstall -y pip

ENTRYPOINT [ "action.sh" ]
