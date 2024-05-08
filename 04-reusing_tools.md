---
title: "Resources for Reusing Tools and Scripts"
teaching: 0
exercises: 0
---

::::::::::::::::::::::::::::::: questions

- How to find other solutions/CWL recipes for awkward problems?

:::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::: objectives

- Know good resources for finding solutions to common problems

:::::::::::::::::::::::::::::::

## Pre-written tool descriptions
When you start a CWL workflow, it is recommended to check if there is already a CWL document available for the tools you want to use.
[Bio-cwl-tools][bio-cwl-tools] is a library of CWL documents for biology/life-sciences related tools.

The CWL documents of the previous steps were already provided for you, however, you can also find them in this library.
In this episode you will use the bio-cwl-tools library to add the last step to the workflow.

## Adding new step in workflow
The last step of our workflow is counting the RNA-seq reads for which we will use the [`featureCounts`][featurecounts] tool.

:::::::::::::::::::::::::::::: challenge

### Find the featureCounts tool in the bio-cwl-tools library 🌶

Find the `featureCounts` tool in the [bio-cwl-tools library][bio-cwl-tools].
Have a look at the CWL document. Which inputs does this tool need? And what are the outputs of this tool?

::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::: solution

The `featureCounts` CWL document can be found in the [GitHub repo][featurecounts-cwl].

It has three inputs:
- annotations
  - A GTF or GFF file containing the gene annotations
- mapped_reads
  - A BAM file containing the mapped reads
- reads_are_paired
  - A boolean value. These inputs can be found on lines 6, 9, and 12.

The output of this tool is a file called `featurecounts` (line 27).

::::::::::::::::::::::::::::::

<br>

### Appending the featureCounts step to the workflow

We need a local copy of `featureCounts` in order to use it in our workflow.

We already imported this as a git submodule during setup,
so the tool should be located at `bio-cwl-tools/subread/featureCounts.cwl`.

::::::::::::::::::::::::::::: challenge

### Add the featureCounts tool to the workflow 🌶🌶

Please copy the `rna_seq_workflow_2.cwl` file to create `rna_seq_workflow_3.cwl`.

Add the `featureCounts` tool to the workflow as a workflow step.

**Bonus**: 🌶🌶🌶

Similar to the `STAR` tool, this tool also needs more RAM than the default.

Update the RAM used to run the tool without editing the commandlinetool

::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::: hint

### Hint: Feature Counts Workflow Step

Use the `run` field to add the `featureCounts` tool as a step in the workflow.

::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::: hint

### Hint: Upgrade RAM

Use a `requirements` entry with `ResourceRequirement` to allocate a `ramMin` of 500.

::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::: solution

### Solution: workflow_3.yml (Click to expand)

```yaml
cwlVersion: v1.2
class: Workflow
inputs:
  rna_reads_fruitfly_forward:
    type: File
    format: http://edamontology.org/format_1930  # FASTQ
  rna_reads_fruitfly_reverse:
    type: File
    format: http://edamontology.org/format_1930  # FASTQ
  ref_fruitfly_genome: Directory
  fruitfly_gene_model: File
steps:
  quality_control_forward:
    run: bio-cwl-tools/fastqc/fastqc_2.cwl
    in:
      reads_file: rna_reads_fruitfly_forward
    out: [html_file]
  quality_control_reverse:
    run: bio-cwl-tools/fastqc/fastqc_2.cwl
    in:
      reads_file: rna_reads_fruitfly_reverse
    out: [html_file]
  trim_low_quality_bases:
    run: bio-cwl-tools/cutadapt/cutadapt-paired.cwl
    in:
      reads_1: rna_reads_fruitfly_forward
      reads_2: rna_reads_fruitfly_reverse
      minimum_length: { default: 20 }
      quality_cutoff: { default: 20 }
    out: [ trimmed_reads_1, trimmed_reads_2, report ]
  mapping_reads:
    requirements:
      ResourceRequirement:
        ramMin: 5120
    run: bio-cwl-tools/STAR/STAR-Align.cwl
    in:
      RunThreadN: {default: 4}
      GenomeDir: ref_fruitfly_genome
      ForwardReads: trim_low_quality_bases/trimmed_reads_1
      ReverseReads: trim_low_quality_bases/trimmed_reads_2
      OutSAMtype: {default: BAM}
      SortedByCoordinate: {default: true}
      OutSAMunmapped: {default: Within}
      Overhang: { default: 36 }  # the length of the reads - 1
      Gtf: fruitfly_gene_model
    out: [alignment]
  index_alignment:
    run: bio-cwl-tools/samtools/samtools_index.cwl
    in:
      bam_sorted: mapping_reads/alignment
    out: [bam_sorted_indexed]
  count_reads:
    requirements:
      ResourceRequirement:
        ramMin: 500
    run: bio-cwl-tools/subread/featureCounts.cwl
    in:
      mapped_reads: index_alignment/bam_sorted_indexed
      annotations: fruitfly_gene_model
      reads_are_paired: {default: true}
    out: [featurecounts]
outputs:
  quality_report_forward:
    type: File
    outputSource: quality_control_forward/html_file
  quality_report_reverse:
    type: File
    outputSource: quality_control_reverse/html_file
  bam_sorted_indexed:
    type: File
    outputSource: index_alignment/bam_sorted_indexed
  featurecounts:
    type: File
    outputSource: count_reads/featurecounts
```

::::::::::::::::::::::::::::::


## Running the new workflow

The workflow is complete and we only need to complete the YAML input file.

Copy the `workflow_input_2.yml` file to `workflow_input_3.yml`, and
add the last entry in the input file, which is the `fruitfly_gene_model` file.

::::::::::::::::::::::::::::: spoiler

### workflow_input_3.yml (Click to expand)

```yaml
rna_reads_fruitfly_forward:
  class: File
  location: rnaseq/GSM461177_1_subsampled.fastqsanger
  format: http://edamontology.org/format_1930  # FASTQ
rna_reads_fruitfly_reverse:
  class: File
  location: rnaseq/GSM461177_2_subsampled.fastqsanger
  format: http://edamontology.org/format_1930  # FASTQ
ref_fruitfly_genome:
  class: Directory
  location: rnaseq/dm6-STAR-index
fruitfly_gene_model:
  class: File
  location: rnaseq/Drosophila_melanogaster.BDGP6.87.gtf
  format: http://edamontology.org/format_2306
```

:::::::::::::::::::::::::::::


::::::::::::::::::::::::::::: prereq

You have finished the workflow and the input file and now you can run the whole workflow.

:::::::::::::::::::::::::::::

```bash
cwltool --cachedir cache rna_seq_workflow_3.cwl workflow_input_3.yml
```


::::::::::::::::::::::::::::: keypoints

- [bio-cwl-tools][bio-cwl-tools] is a library of CWL documents for biology/life-sciences related tools

:::::::::::::::::::::::::::


[bio-cwl-tools]: https://github.com/common-workflow-library/bio-cwl-tools
[featurecounts]: https://bio.tools/featurecounts
[featurecounts-cwl]: https://github.com/common-workflow-library/bio-cwl-tools/blob/release/subread/featureCounts.cwl
