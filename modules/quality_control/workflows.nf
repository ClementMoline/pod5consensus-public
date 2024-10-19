params.results_dir = ""

if (params.results_dir != "") {
    params.results_subdir = "${params.results_dir}/quality_control"
} else {
    params.results_subdir = ""
}


include {
    nanoplot ;
} from './processes'


workflow qualityControl {
    take:
    fastq_file

    main:
    nanoplot(
        fastq_file,
    )

    emit:
    fastq_file
}
