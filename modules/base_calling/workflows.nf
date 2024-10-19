params.results_dir = ""

if (params.results_dir != "") {
    params.results_subdir = "${params.results_dir}/base_calling"
} else {
    params.results_subdir = ""
}


include {
    dorado ;
} from './processes'


workflow baseCalling {
    take:
    pod5_file

    main:
    dorado(
        pod5_file,
    )

    emit:
    fastq_file = dorado.out.fastq_file
}
