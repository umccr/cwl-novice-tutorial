---
title: Setup
---

## OS Setup

These lessons assume that you are using the freely available Visual Studio Code application with the
Benten extension along with the CWL reference runner (`cwltool`).

This tutorial requires three pieces of software to run and visualize the workflows: Docker, cwltool, and graphviz.

Please follow instructions for your OS by clicking on the relevant link below.

* [Windows Setup](#windows-setup)

* [MacOS Setup](#macos-setup)

* [Linux Setup](#linux-setup)






## Windows Setup

### WSL2 Installation

::::::::::::::::::prereq

Ensure you're running Windows 10 or higher

To check your Windows version and build number, press the Windows logo key + <kbd>R</kbd>, type `winver`, select OK.
You can update to the latest Windows version by selecting "Start" > "Settings" > "Windows Update" > "Check for updates".

It is also expected you download the 'terminal' app from the Microsoft store:

::::::::::::::::::

Follow the [wsl installation instructions][wsl_installation_instructions].

You may also wish to go through [Getting started with WSL2][getting_started_with_wsl2].

::::::::::::::: callout

### Choosing your Linux Flavour of Choice

For this tutorial, we expect you use the Ubuntu distribution as your WSL2 distribution of choice.

::::::::::::::::

### Confirm WSL2 is installed

Open PowerShell as Administrator and type in the following

```bash
wsl --list
```

You should see your linux distribution you have installed in the previous step.

### Installing apt tools

For this tutorial, we will require a few linux tools to be installed.

Open up the 'terminal' app and select a new tab of the Ubuntu version you have just installed

```bash
sudo apt-get update -y -q && \
sudo apt-get install -y -q \
  python3-venv \
  wget \
  graphviz \
  nodejs \
  wslu
```

### Install Docker Desktop

Install Docker Desktop by following the instructions on the [Docker Desktop Installation Page][windows_docker_desktop_installation_page]

* Accept the terms and conditions, if prompted
* Wait for Docker Desktop to finish starting
* Skip the tutorial, if prompted


#### Ensure Docker Desktop is Using the WSL2 Backend

* From the top menu choose "Settings" > "General"

* Make sure 'Use the WSL 2 based engine' is selected

<br>

### VSCode Installation

Download and install [VSCode][vs_code]


#### Install VSCode Extensions



**Install the WSL Integration extension**

[Open WSL2 Extension in the marketplace][remote_wsl_vs_code_marketplace]

You should now see 'WSL Targets' under the 'Remote Explorer' tab on the left hand side of the screen.

Right-click Ubuntu to set it as the default distribution



**Install Benten VSCode Extension**

[Open Benten in the marketplace][benten_vs_code_marketplace] and click the `Install` button.

If you are given the option to enable the extension on 'WSL: Ubuntu' please do so.



**Install Redhat Yaml VSCode Extension**

[Open RedHad Yaml in the marketplace][redhat_yaml_vs_code_marketplace] and click the `Install` button.

If you are given the option to enable the extension on 'WSL: Ubuntu' please do so.



#### Attribute CWL files to the yaml file type

Add the following chunk to the VSCode [user settings json][user_settings_json] to attribute CWL to the YAML file type.

```json
{
    "files.associations": {
        "*.cwl": "yaml"
    }
}
```


### Install cwltool (latest)

First we will make a Python virtual environment by running the following commands in the terminal.

```bash
python3 -m venv env       # Create a virtual environment named 'env' in the current directory
source env/bin/activate   # Activate the 'env' environment
```

You will know that this worked as the terminal prompt will now have `(env)` at the beginning.


### Reactivating the python virtual environment

Every time you launch VS Code or launch a new terminal, you must run `source env/bin/activate`
to re-enable access to this Python Virtual Environment.

Next, install cwltool by running the following in the terminal:

```bash
pip install cwltool
```


[vs_code]: https://code.visualstudio.com/
[benten_vs_code_marketplace]: https://marketplace.visualstudio.com/items?itemName=sbg-rabix.benten-cwl
[redhat_yaml_vs_code_marketplace]: https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml
[user_settings_json]: https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
[wsl_installation_instructions]: https://learn.microsoft.com/en-us/windows/wsl/install
[getting_started_with_wsl2]: https://medium.com/@awlucattini_60867/getting-started-with-wsl2-c11826654776?source=friends_link&sk=ddd411c0794ba2fce877984c300882ae
[windows_docker_desktop_installation_page]: https://docs.docker.com/desktop/install/windows-install/
[remote_wsl_vs_code_marketplace]: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl

Continue to [Confirm Software Installations](#confirm-software-installations) after completing the setup for Windows.






<br>

## MacOS Setup

### VSCode Installation

Download and install [VSCode][vs_code]

<br>

### VSCode Extensions

**Install Benten Extension**

[Open Benten in the marketplace](https://marketplace.visualstudio.com/items?itemName=sbg-rabix.benten-cwl) and click the `Install` button or follow the directions.

**Install Redhat Yaml VSCode Extension**

[Open RedHad Yaml in the marketplace][redhat_yaml_vs_code_marketplace] and click the `Install` button.

#### Attribute CWL files to the yaml file type

Add the following chunk to the VSCode [user settings json][user_settings_json] to attribute CWL to the YAML file type.

```json
{
    "files.associations": {
        "*.cwl": "yaml"
    }
}
```

<br>

### Docker Installation

[Install docker](https://docs.docker.com/desktop/mac/install)

<br>

### Install Conda

[Install Miniconda][miniconda_install]

<br>

### Conda Setup

#### Update Conda sources configuration

Tell conda about which channels (sources) we will use

```bash
conda config --add channels conda-forge
```

<br>

#### Create a virtual environment

Create a virtual environment using conda

```bash
conda create --name cwltutorial python==3.11
```

<br>

#### Activate the virtual environment

```bash
conda activate cwltutorial
```

<br>

#### Install prerequisites via conda

```bash
conda install --yes \
  cwltool \
  graphviz \
  wget \
  git \
  nodejs
```

:::::::::::::::: callout

### Reactivating the conda virtual environment

The virtual environment needs to be activated every time you start a terminal using
`conda activate cwltutorial`.

::::::::::::::::


[docker_install]: https://docs.docker.com/desktop/mac/install
[miniforge]: https://github.com/conda-forge/miniforge
[miniconda_install]: https://docs.anaconda.com/free/miniconda/miniconda-install/
[vs_code]: https://code.visualstudio.com/
[benten_vs_code_marketplace]: https://marketplace.visualstudio.com/items?itemName=sbg-rabix.benten-cwl
[redhat_yaml_vs_code_marketplace]: https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml
[user_settings_json]: https://code.visualstudio.com/docs/getstarted/settings#_settingsjson

Continue to [Confirm Software Installations](#confirm-software-installations) after completing the setup for MacOS.






## Linux Setup

<br>

### Install VSCode

Download and install [VSCode](https://code.visualstudio.com/)

<br>

### VSCode extensions


**Install Benten VSCode Extension**

[Open Benten in the marketplace][benten_vs_code_marketplace] and click the `Install` button.


**Install Redhat Yaml VSCode Extension**

[Open RedHad Yaml in the marketplace][redhat_yaml_vs_code_marketplace] and click the `Install` button.


#### Attribute CWL files to the yaml file type

Add the following chunk to the VSCode [user settings json][user_settings_json] to attribute CWL to the YAML file type.

```json
{
    "files.associations": {
        "*.cwl": "yaml"
    }
}
```

<br>

### Install Docker

[Click here to follow the instructions for installing docker on linux][docker_server_install]

<br>

:::::::: callout

## Extra action if you install Docker using Snap
[Snap](https://snapcraft.io/) is an app management system for linux - which is popular on
Ubuntu and other systems. Docker is available via Snap - if you have installed it using
this service you will need to take the following steps, to ensure docker will work properly.

```bash
mkdir ~/tmp
export TMPDIR=~/tmp
```

Each time you open a new terminal you will have to enter the `export TMPDIR=~/tmp` command,
or you can add it to your `~/.profile` or `~/.bashrc` file.

::::::::::::::

#### Enable docker usage as a non-root user

Follow the instructions in the Docker documentation to [enable docker usage as a non-root user][enable_user_docker_usage]

You will need to logout for this to take effect.


### Install cwltool

First we will make a Python virtual environment by running the following commands in the terminal.

```bash
python3 -m venv env       # Create a virtual environment named 'env' in the current directory
source env/bin/activate   # Activate the 'env' environment
```

You will know that this worked as the terminal prompt will now have `(env)` at the beginning.

:::::::::::: callout

### Reactivating the python virtual environment

Every time you launch VS Code or launch a new terminal, you must run `source env/bin/activate`
to re-enable access to this Python Virtual Environment.

::::::::::::::

Next, install cwltool by running the following in the terminal:

```bash
pip install cwltool
```

Later we will make visualisations of our workflows.
To support that we need to install `graphviz`.

##### Install graphviz

Here is the command for Debian-based Linux systems to install `graphviz` and other helpful programs:

```bash
sudo apt-get install -y graphviz wget git nodejs
```

For other Linux systems, check [the graphviz download page][graphviz_download_page]


[vs_code]: https://code.visualstudio.com/
[benten_vs_code_marketplace]: https://marketplace.visualstudio.com/items?itemName=sbg-rabix.benten-cwl
[redhat_yaml_vs_code_marketplace]: https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml
[user_settings_json]: https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
[docker_server_install]: https://docs.docker.com/engine/install/#server
[enable_user_docker_usage]: https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user
[graphviz_download_page]: https://graphviz.org/download/#linux

Continue to [Confirm Software Installations](#confirm-software-installations) after completing the setup for Linux.

## Confirm Software Installations

### Docker

To confirm docker is installed, run the following command to display the version number:

```bash
docker version
```

You should see something similar to the output shown below.

:::::::::::::::::::::::: spoiler

### Docker Version Output Example

```
Client: Docker Engine - Community
 Version:           20.10.13
 API version:       1.41
 Go version:        go1.16.15
 Git commit:        a224086
 Built:             Thu Mar 10 14:08:15 2022
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.13
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.15
  Git commit:       906f57f
  Built:            Thu Mar 10 14:06:05 2022
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.5.10
  GitCommit:        2a1d4dbdb2a1030dc5b01e96fb110a9d9f150ecc
 runc:
  Version:          1.0.3
  GitCommit:        v1.0.3-0-gf46b6ba
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

::::::::::::::::::::::::::::::

### Confirm cwltool is installed

To confirm `cwltool` is installed, run the following command to display the version number:

```bash
cwltool --version
```

You should see something similar to the output shown below.

:::::::::::::::::::::::: spoiler

### Cwltool Version Output Example

```
/home/learner/env/bin/cwltool 3.1.20220224085855
```

::::::::::::::::::::::::

### GraphViz

To confirm `graphviz` is installed, run the following command to display the version number:

```bash
dot -V
```

You should see something similar to the output shown below.

:::::::::::::::::::::::: spoiler

### Graphviz version output example

```
dot - graphviz version 2.43.0 (0)
```

::::::::::::::::::::::::







## Containers Requirements

To avoid having to wait during the class, please run the following which will download all the
required software containers.

```bash
docker pull quay.io/biocontainers/star:2.7.5c--0
docker pull quay.io/biocontainers/fastqc:0.11.9--hdfd78af_1
docker pull quay.io/biocontainers/cutadapt:3.7--py39hbf8eff0_1
docker pull quay.io/biocontainers/samtools:1.14--hb421002_0
docker pull quay.io/biocontainers/subread:2.0.6--he4a0461_0
```


## Data Requirements

You will need to download some example files for this lesson. In this tutorial we will use RNA sequencing data.

### Setting up a practice Git repository

For this tutorial some existing tools are needed to build the workflow. These existing tools will be imported via GitHub.
First we need to create an empty git repository for all our files. To do this, use this command:

```bash
git init novice-tutorial-exercises
```

Next, we need to move into our empty git repo:

```bash
cd novice-tutorial-exercises
```

Then import bio-cwl-tools with this command:

```bash
git submodule add https://github.com/common-workflow-library/bio-cwl-tools.git
```

### Downloading sample and reference data
Create a new directory inside the `novice-tutorial-exercises` directory and download the data:

:::::::::::::::: callout

### Using subshells

By running the following chunk in brackets the console will return to the
original working directory after the download is complete

::::::::::::::::

```bash
mkdir rnaseq
(
  cd rnaseq
  wget https://zenodo.org/record/4541751/files/GSM461177_1_subsampled.fastqsanger
  wget https://zenodo.org/record/4541751/files/GSM461177_2_subsampled.fastqsanger
  wget https://zenodo.org/record/4541751/files/Drosophila_melanogaster.BDGP6.87.gtf
  wget https://hgdownload.soe.ucsc.edu/goldenPath/dm6/bigZips/dm6.fa.gz
  gunzip dm6.fa.gz  # STAR index requires an uncompressed reference genome
)
```

### STAR Genome index

To run the STAR aligner tool, index files generated from the reference genome are needed.
The index files can be downloaded, or generated yourself from the unindexed reference genome.

These two options are detailed below -- choose the one most appropriate to your set-up.

:::::::::::::::::::: spoiler

#### Option 1: Download the index

At least 9 GB of memory is required to generate the index, which will occupy 3.3GB of disk.

If your computer doesn't have that much memory, then you can download the directory
by running the following in the `rnaseq` directory:

```bash
wget https://dataverse.nl/api/access/datafile/266295 --output-document - | tar -C rnaseq -x --xz
```

:::::::::::::::::::::

::::::::::::::::::::: spoiler

#### Option 2: Generate the index yourself

To generate the genome index yourself: create a new file named `dm6-star-index.yaml`
in the the `novice-tutorial-exercises` directory with the following contents:

```yaml
InputFiles:
 - class: File
   location: rnaseq/dm6.fa
   format: http://edamontology.org/format_1929  # FASTA
IndexName: 'dm6-STAR-index'
Overhang: 36
Gtf:
 class: File
 location: rnaseq/Drosophila_melanogaster.BDGP6.87.gtf
```

Next use the CWL reference runner `cwltool` that you installed above and the CWL description
for the indexing mode of the STAR aligner that was downloaded in the `bio-cwl-tools` directory
to index the genome and place the result in the `rnaseq` directory alongside the other files:

```
cwltool --outdir rnaseq/ bio-cwl-tools/STAR/STAR-Index.cwl dm6-star-index.yaml
```

It should take 10-15 minutes for the index to be generated.

::::::::::::::::::::: callout

### STAR Index Memory Requirements
To generate the genome index you will need at least 9 GB of RAM.

If you do not allocate enough RAM the tool will not crash, but the process will stick
on the following step:
```
... sorting Suffix Array chunks and saving them to disk...
```
If this step does not finish within 10 minutes then it is likely the process has failed,
and should be cancelled.

MacOS users can configure  Docker Desktop to allocate more memory
from the menu "Preferences" and then selecting "Resources".

Windows users can configure WSL 2 to allocate more memory by opening the PowerShell
and entering the following:

```bash
# turn off all wsl instances such as docker-desktop
wsl --shutdown

notepad "$env:USERPROFILE/.wslconfig"
```

In `.wslconfig` add the following

```text
[wsl2]
memory=9GB
```

Save the file and right-click the Docker icon in the notifications area (or System tray)
and then click "Restart Docker…"

:::::::::::::::::::::

:::::::::::::::::::::
