params.results_dir = ""

if (params.results_dir != "") {
    params.results_subdir = "${params.results_dir}/assembly"
} else {
    params.results_subdir = ""
}


include {
    flye ;
} from './processes'


workflow assembly {
    take:
    fastq_file
    genome_size

    main:
    flye(
        fastq_file,
        genome_size,
    )

    emit:
    contigs = flye.out.contigs
}
