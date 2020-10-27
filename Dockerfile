FROM python:alpine3.10 as builder

ADD . /workflows
WORKDIR /workflows

RUN pip3 install --no-cache --upgrade pip jsonschema && \
    wget http://media-cloud.ai/standard/1.7/workflow-definition.schema.json && \
    mv workflow-definition.schema.json / && \
    ls && \
    pwd && \
    for workflow_filename in *.json ; do jsonschema -i $workflow_filename /workflow-definition.schema.json ; done

FROM alpine

WORKDIR /workflows
COPY --from=builder /workflows/*.json ./
