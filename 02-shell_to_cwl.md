---
title: "CWL and Shell Tools"
teaching: 0
exercises: 0
---

:::::::::::::::::::::::::::::::::::::: questions

- What is the difference between a CWL tool description and a CWL workflow?
- How can we create a tool descriptor?
- How can we use this in a single step workflow?

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::: objectives

- describe the relationship between a tool and its corresponding CWL document
- exercise good practices when naming inputs and outputs
- understand how to reference files for input and output
- explain that only files explicitly mentioned in a description will be included in the output of a step/workflow
- implement bulk capturing of all files produced by a step/workflow for debugging purposes
- use STDIN and STDOUT as input and output
- capture output written to a specific directory, the working directory, or the same directory where input is located

::::::::::::::::::::::::::::::::::::::::::::::::

CWL workflows are written in the YAML syntax. This [short tutorial][yaml_tutorial]
explains the parts of YAML used in CWL. A CWL document contains the workflow and the
requirements for running that workflow. All CWL documents should start with two lines of code:

```yaml
cwlVersion: v1.2
class:
```


The `cwlVersion` string defines which standard of the language is required for the tool or workflow. The most recent version is v1.2.

The `class` field defines what this particular document is. The majority of CWL documents will fall into
one of two classes: `CommandLineTool`, or `Workflow`. The `CommandLineTool` class is used for
describing the interface for a command-line tool, while the `Workflow` class is used for connecting those
tool descriptions into a workflow. In this lesson the differences between these two classes are explained,
how to pass data to and from command-line tools and specify working environments for these, and finally
how to use a tool description within a workflow.

You should follow the examples in this lesson from your `novice-tutorial-exercises` directory.

```bash
$ cd novice-tutorial-exercises
```

## Our first CWL CommandLineTool

To demonstrate the basic requirements for a tool descriptor a CWL description for the popular "Hello world!" demonstration will be examined.

**echo.cwl**

```yaml
cwlVersion: v1.2
class: CommandLineTool

baseCommand: echo

inputs:
  message_text:
    type: string
    inputBinding:
      position: 1

outputs: []
```

Next, the input file to the command line tool: `hello_world.yml`.

**hello_world.yml**

```yaml
message_text: Hello world!
```

We will use the reference CWL runner, `cwltool` to run this CWL document (the `.cwl` workflow file) along with the `.yml` input file.

```bash
$ cwltool echo.cwl hello_world.yml
```

:::::::::::::::::::::::::::: spoiler

### Tool Output

```text
INFO Resolved 'echo.cwl' to 'file:///.../echo.cwl'
INFO [job echo.cwl] /private/tmp/docker_tmprm65mucw$ echo \
    'Hello world!'
Hello world!
INFO [job echo.cwl] completed success
{}
INFO Final process status is success
```

::::::::::::::::::::::::::::

The output displayed above shows that the program has run successfully and its output, `Hello world!`.

Let's take a look at the `echo.cwl` script in more detail.

### The CommandLineTool Skeleton

As explained above, the first 2 lines are always the same, the CWL version and the class of the script are defined.

In this example the class value is `CommandLineTool`.

For a _CommandLineTool_ the `baseCommand`, contains the command that will be run `echo`.

```yaml
inputs:
  message_text:
    type: string
    inputBinding:
       position: 1
```

### Inputs

This block of code contains the `inputs` section of the tool description. This section provides the inputs that are needed for running this specific tool.

To run this example we can provide the input on the command line. In this case, we have only one input called `message_text` and it is of type `string`.

::::::::::::::::::::::::: callout

### Input Binding

A CommandLineTool will run a command. The `inputBinding` field is used to define how the input is passed to the command as parameters.

Here the `position` field indicates at which position the input will be on the command line; in this case the `message_text` value will be the first thing added to the command line (after the `baseCommand`, `echo`).

Another common inputBinding attribute is `prefix` for adding a prefix to the input value like `--arg`. If the input value is not prefixed, the `prefix` attribute is not attached to the command line string.

Arguments that are required for a command line tool should be added to the `arguments` section

::::::::::::::::::::::::

### Outputs

Lastly the `outputs` of the tool description. This example doesn't have a formal output.
The text is printed directly in the terminal. So an empty YAML list (`[]`) is used as the output.

```yaml
outputs: []
```

### Semantics

:::::::::::::::::::::::::::::::::::::: callout

To make the script more readable the `input` field is put in front of the `output` field.
However, CWL syntax requires only that each field is properly defined, it does not require them to be in a particular order.

:::::::::::::::::::::::::::::::::::::::::::::

### Challenges

:::::::::::::::::::::::::::::::::::::: challenge

### Changing the output string 🌶

What do you need to change to print a different text on the command line?

:::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::: solution


To change the text on the command line, you only have to change the text in the `hello_world.yml` file.

For example

```yaml
message_text: Good job!
```

:::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::: challenge

### Updating the arguments 🌶🌶

How can one add the `-e` argument to the echo command to interpret backslashes?

:::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::: solution

```yaml
baseCommand: echo

arguments:
  - position: 0  
    valueFrom: "-e"
```

:::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::: challenge

### Redirecting cwltool stdout and stderr 🌶🌶

Rerun the `echo.cwl` script but point stdout and stderr to different files.

What is the difference between the stdout and stderr from the `echo.cwl` script?

::::::::::::::::::::::::::::

:::::::::::::::::::::::::::: hint

### Hint: Redirecting CLI stdout and stderr

Use the redirectors `1>` and `2>` to redirect stdout and stderr to different files respectively

::::::::::::::::::::::::::::

:::::::::::::::::::::::::::: solution

```bash
$ cwltool echo.cwl hello_world.yml 1>echo_stdout.txt 2>echo_stderr.txt
```

::::::::::::::::::::::::::::

:::::::::::::::::::::::::::: challenge

### Specifying the stdout of the tool as a CWL output 🌶🌶🌶

Using [this tutorial][capturing_stdout_tutorial] as a guide

Use the `stdout` field in the `outputs` section of the tool description.

The output id should be 'message_out' and the type of the output should be 'string'.

You will need to add in the InlineJavascriptRequirement to the requirements section of the tool description.

How does this change the output of the cwltool command?

::::::::::::::::::::::::::::

:::::::::::::::::::::::::::: hint

### Hint - stdout output binding

Copy the 'outputBinding' from the tutorial 'verbatim'.

Your output key should look like this

```yaml
outputs:
  message_out:
    type: string
    outputBinding:
      glob: message
      loadContents: true
      outputEval: $( self[0].contents )
```

::::::::::::::::::::::::::::

:::::::::::::::::::::::::::: solution

```yaml
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

baseCommand: echo

inputs:
  message_text:
    type: string
    inputBinding:
      position: 1

stdout: message

outputs:
  message_out:
    type: string
    outputBinding:
      glob: message
      loadContents: true
      outputEval: $( self[0].contents )
```

::::::::::::::::::::::::::::


## CWL single step workflow

The RNA-seq data from the introduction episode will be used for the first CWL workflow.
The first step of RNA-sequencing analysis is a quality control of the RNA reads using the `fastqc` tool.
This tool is already available to use so there is no need to write a new CWL tool description.

This is the workflow file (`rna_seq_workflow_1.cwl`).

### rna_seq_workflow_1.cwl

```yaml
cwlVersion: v1.2
class: Workflow

inputs:
  rna_reads_fruitfly: File

steps:
  quality_control:
    run: bio-cwl-tools/fastqc/fastqc_2.cwl
    in:
      reads_file: rna_reads_fruitfly
    out: [html_file]

outputs:
  quality_report:
    type: File
    outputSource: quality_control/html_file
```

In a __workflow__ the fields `inputs`, `steps` and `outputs` must always be present.

The workflow tasks or steps that you want to run are listed in this field.
At the moment the workflow only contains one step: `quality_control`. In the next episodes more steps will be added to the workflow.

### Workflow Inputs

Let's take a closer look at the workflow inputs section:

```yaml
inputs:
  rna_reads_fruitfly: File
```

We have one variable `rna_reads_fruitfly` and it has `File` as its type.

This input is used in the step _quality_control_ by the fastqc tool.

In this example the fastq file consists of *Drosophila melanogaster* RNA reads.

::::::::::::::::::::::::::::::::::::::::::::: callout

### Input and output names

To make this workflow interpretable for other researchers, self-explanatory and sensible variable names are used.

It is very important to give inputs and outputs a sensible name. Try not to use variable names like `inputA` or `inputB` because others might not understand what is meant by it

:::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::: discussion

### Input Types

Workflow Inputs may be of different types, such as 

* `File`
* `Directory`
* `string`
* `int`
* `float`
* `boolean`
* `array`
* `record`
* `enum`
* `Any` 
* `null`.

:::::::::::::::::::::::::::::::::::::::::::::::::::::

### Workflow Steps

The next part of the script is the `steps` field.

```yaml
steps:
  quality_control:
    run: bio-cwl-tools/fastqc/fastqc_2.cwl
    in:
      reads_file: rna_reads_fruitfly
    out: [html_file]
```

Every step of a workflow needs a name, the first step of the workflow is called `quality_control`. 

Each step needs a `run` field, an `in` field and an `out` field.

The `run` field contains the location of the CWL file of the tool to be run OR the contents of the tool description itself.

The `in` field connects the `inputs` field to the `fastqc` tool.

The `fastqc` tool has an input parameter called `reads_file`, so it needs to connect the `reads_file` to `rna_reads_fruitfly`.

Lastly, the `out` field is a list of output parameters from the tool to be used.

In this example, the `fastqc` tool produces an output file called `html_file`.

### Workflow Outputs

The last part of the script is the `output` field.
```yaml
outputs:
  quality_report:
    type: File
    outputSource: quality_control/html_file
```

Each output in the `outputs` field needs its own name. In this example the output is called `quality_report`.

Inside `quality_report` the type of output is defined. The output of the `quality_control` step is a file, so the `quality_report` type is `File`.

The `outputSource` field refers to where the output is located after the commandline tool is complete, in this example it came from the step `quality_control` and it is called `html_file`.

::::::::::::::::::::::::::::::::::::::::::::: discussion

### Output Types

Like workflow inputs, workflow outputs can be of different types. 
Refer to the list of input types above for the different types of outputs for a workflow.

:::::::::::::::::::::::::::::::::::::::::::::::::::::

## Running the workflow

When you want to run this workflow, you need to provide a file with the inputs the workflow needs. This file is similar to the `hello_world.yml` file in the previous section.
The input file is called `workflow_input_1.yml`

**workflow_input_1.yml**

```yaml
rna_reads_fruitfly:
  class: File
  location: rnaseq/GSM461177_2_subsampled.fastqsanger
  format: http://edamontology.org/format_1930  # FASTA
```

In the input file the values for the inputs that are declared in the `inputs` section of the workflow are provided.

The workflow takes `rna_reads_fruitfly` as an input parameter. We use the same variable name in the input file.

When using `File` or `Directory` inputs, the class of the object needs to be defined, for example `class: File` or `class: Directory`.

The `location` field contains the location of the input file, in this case it is a local path, but we could have directly used the original url `location: https://zenodo.org/record/4541751/files/GSM461177_2_subsampled.fastqsanger`

In this example the last line is needed to provide a format for the fastq file.
This is not always necessary, but it is good practice to provide this information.


::::::::::::::::::::::::: callout

### Specifying the location of an input

As shown above, we can use urls or local paths for the location of the input file.

For local paths, if the path is a relative path, it should be relative to the current working directory.

:::::::::::::::::::::::::

### Running with workflow

Now you can run the workflow using the following command:

```bash
cwltool --cachedir cache rna_seq_workflow_1.cwl workflow_input_1.yml
```

::::::::::::::::::::: spoiler

### Console Outputs

```
...
Analysis complete for GSM461177_2_subsampled.fastqsanger
INFO [job quality_control] Max memory used: 179MiB
INFO [job quality_control] completed success
INFO [step quality_control] completed success
INFO [workflow ] completed success
{
    "quality_report": {
        "location": "file:///.../GSM461177_2_subsampled.fastqsanger_fastqc.html",
        "basename": "GSM461177_2_subsampled.fastqsanger_fastqc.html",
        "class": "File",
        "checksum": "sha1$e820c530b91a3087ae4c53a6f9fbd35ab069095c",
        "size": 378324,
        "path": "/.../GSM461177_2_subsampled.fastqsanger_fastqc.html"
    }
}
INFO Final process status is success
```

::::::::::::::::::::::::::::


<br>

::::::::::::::::::::::::::::::::::::::::::::: callout

### Cache Directory 

To save intermediate results for re-use later we use `--cachedir cache`; where `cache` is the directory
for storing the cache (it can be given any name, here we are just using `cache` for simplicity). You can safely
delete the `cache` directory anytime, if you need to reclaim the disk space.

:::::::::::::::::::::::::::::::::::::::::::::

### Challenges

:::::::::::::::::::::::::::::::::::::: challenge

### Directly embed a Commandlinetool into a file 🌶🌶

How could one embed the fastqc tool description directly into the workflow?

::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::: solution

The `run` field in the step can be replaced with the `CommandLineTool` definition.

```yaml
steps:
  quality_control:
    run:
      class: CommandLineTool
      baseCommand: fastqc
      inputs:
        reads_file:
          type: File
          inputBinding:
            position: 1
      outputs:
        html_file:
          type: File
    in:
      reads_file: rna_reads_fruitfly
    out: [html_file]
```

::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::: callout

### Embedding Tool Descriptions

Embedding tool descriptions directly into the workflow can be useful when the tool is very simple and only used once in the workflow.

This is not recommended for complex tools or tools that are used in multiple workflows and as such is not common practise

::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::: instructor


### Exercise

Needs some exercises?

- Ask the students to get some information from each report generated for the different data files we've downloaded. This will involve them making simple changes to the yaml configuration file.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::: keypoints


- A tool description describes the interface to a command line tool.
- A workflow describes which command line tools to use in one or more steps.
- A tool descriptor is defined using the `ComandLineTool` class.
- How can we use a tool descriptor in a single step workflow?

:::::::::::::::::::::::::::::::::::::: 


[yaml_tutorial]: https://www.commonwl.org/user_guide/topics/yaml-guide.html
[capturing_stdout_tutorial]: https://cwl-for-eo.github.io/guide/how-to/cwl-how-to/02-stdout/capture-stdout/
