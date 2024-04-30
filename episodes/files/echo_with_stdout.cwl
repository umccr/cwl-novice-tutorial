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