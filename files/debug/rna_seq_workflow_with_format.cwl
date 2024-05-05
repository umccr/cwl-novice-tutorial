cwlVersion: v1.2
class: Workflow

inputs:
  rna_reads_fruitfly: File
  ref_fruitfly_genome: Directory

steps:
  quality_control:
    run: bio-cwl-tools/fastqc/fastqc_2.cwl
    in:
      reads_file: rna_reads_fruitfly
    out: [html_file]

  mapping_reads:
    requirements:
      ResourceRequirement:
        ramMin: 5120
    run: bio-cwl-tools/STAR/STAR-Align.cwl
    in:
      RunThreadN: {default: 4}
      GenomeDir: ref_fruitfly_genome
      ForwardReads: rna_reads_fruitfly
      OutSAMtype: {default: BAM}
      SortedByCoordinate: {default: true}
      OutSAMunmapped: {default: Within}
    out: [alignment]

  index_alignment:
    run: bio-cwl-tools/samtools/samtools_index.cwl
    in:
      bam_sorted: mapping_reads/alignment
    out: [bam_sorted_indexed]

outputs:
  qc_html:
    type: File
    outputSource: quality_control/html_file
  bam_sorted_indexed:
    type: File
    outputSource: index_alignment/bam_sorted_indexed
