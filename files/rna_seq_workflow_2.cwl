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
