params.results_subdir = ""


process dorado {
    input:
    path pod5_file

    output:
    path("${output_name}.fastq"), emit: fastq_file

    script:
    output_name = (pod5_file.getFileName().toString() =~ /(.+)\.pod5$/)[0][1]
    """
    dorado basecaller \
        --min-qscore 10 \
        --trim primers \
        --emit-fastq \
        hac \
        ${pod5_file} \
        > ${output_name}.fastq
    """
}
