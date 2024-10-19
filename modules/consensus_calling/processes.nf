params.results_subdir = ""


process medakaConsensus {
    publishDir params.results_subdir, mode: 'rellink', overwrite: true, pattern: "medaka_consensus/*.{fasta,bam,bai}", enabled: params.results_subdir ? true : false

    input:
    path reads
    path draft

    output:
    path("medaka_consensus/consensus.fasta"), emit: consensus
    tuple path("medaka_consensus/calls_to_draft.bam"), path("medaka_consensus/calls_to_draft.bam.bai"), emit: bam_and_bai

    script:
    """
    medaka_consensus \
        -i ${reads} \
        -d ${draft} \
        -o medaka_consensus \
        -t ${task.cpus}
    """
}
