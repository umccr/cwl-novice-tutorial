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