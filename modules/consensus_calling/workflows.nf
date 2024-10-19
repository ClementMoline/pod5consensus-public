params.results_dir = ""

if (params.results_dir != "") {
    params.results_subdir = "${params.results_dir}/consensus_calling"
} else {
    params.results_subdir = ""
}


include {
    medakaConsensus ;
} from './processes'


workflow consensusCalling {
    take:
    fastq_file
    contigs

    main:
    medakaConsensus(
        fastq_file,
        contigs,
    )
}
