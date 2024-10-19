params.results_subdir = ""


process nanoplot {
    publishDir params.results_subdir, mode: 'rellink', overwrite: true, pattern: "nanoplot/*.{log,txt,png,html}", enabled: params.results_subdir ? true : false

    input:
    path fastq_file

    output:
    path("nanoplot/*")

    script:
    """
    NanoPlot \
        --fastq ${fastq_file} \
        --loglength \
        -o nanoplot \
        --plots dot
    """
}
