# pod5consensus

## A Nextflow-based app to build consensus sequences from pod5 data

pod5consensus consists in a Nextflow-based workflow of processes running within Docker containers, following the following architecture of sub-workflows:

1) **Base Calling**

Base Calling on pod5 files is done using Oxford Nanopore Technologies's Dorado tool. It also conducts a trimming of reads, including a trimming of adapters and primers, but not of potential barcodes, as well as a quality-trimming of the reads with a minimal average quality threshold score of 10.

2) **Quality Control**

Quality Control of the reads is done using NanoPlot. It does not impede the rest of the workflow to progress in the meantime.

3) **Assembly**

A draft assembly is conducted using Flye.

4) **Consensus Calling**

Using the contigs assembled by Flye, consensus sequences are then called by Oxford Nanopore Technologies's Medaka Consensus tool.


## Using Docker

pod5consensus can be run using a "Docker outside Docker" approach, whereby a Docker container running nextflow calls other Docker containers as required by the processes of the workflow.

1) [Install Docker](https://docs.docker.com/get-docker/)

2) Build the pod5consensus Docker image

```
git clone git@github.com:ClementMoline/pod5consensus.git
cd pod5consensus/
docker build -t pod5consensus:v0.0.0 .
```

3) Run a Docker container (here interactively)

`docker run -it --entrypoint /bin/bash -v /var/run/docker.sock:/var/run/docker.sock -v /<path_to_workspace>/:/<path_to_workspace>/ pod5consensus:v0.0.0`

Mounting the Docker socket file onto this primary container allows secondary containers run by the workflow to use the host's daemon.

It is crucial the the `/<path_to_workspace>/` path is the same on the host as in the container that encapsulates the workflow, as nextflow will create paths based on what is the running container, but the new Docker containers it will create will be run from the host's daemon, looking for paths existing outside the primary container.

Users need to mount the pod5consensus directory onto the the primary container, so the chosen workspace directory may be one containing the pod5consensus directory.


## How to launch a pod5consensus analysis

Any pod5consensus analysis requires an input pod5 file along with a case-specific JSON file defining the parameters to use in the workflow. It is advised to keep these two files together in the same location, e.g., under `/<path_to_workspace>/<case_id>/`.

Check pod5consensus's `test/params.json` example JSON file to see an exhaustive list and examples of all parameters required by the workflow.

General pod5consensus parameters are defined in pod5consensus's `nextflow.config` file. The values given in the case-specific parameters JSON files have the priority over those defined in pod5consensus's `nextflow.config` file, should any parameter ever be defined in both files.

Once the input data is ready, pod5consensus analyses can be run as follows when using the dedicated Docker image:

```
cd /<path_to_workspace>/pod5consensus/
nextflow run main.nf -profile standard,docker -params-file /<path_to_workspace>/<case_id>/params.json
```

**NB:** Add `-resume` to the previous command in order to resume an interrupted analysis using cached files.


## Test example

In the test example using `pod5consensus/test`, where `<case_id>` would be `test`, the exact commands would be:
```
docker run -it --entrypoint /bin/bash -v /var/run/docker.sock:/var/run/docker.sock -v /work/pod5consensus/:/work/pod5consensus/ pod5consensus:v0.0.0
cd /work/pod5consensus/
nextflow run main.nf -profile standard,docker -params-file /work/pod5consensus/params.json
```
