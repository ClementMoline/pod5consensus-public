params.results_subdir = ""


process canu {
    publishDir params.results_subdir, mode: 'rellink', overwrite: true, pattern: "canu/canu_${output_name}.{contigs.fasta,report}", enabled: params.results_subdir ? true : false

    input:
    path fastq_file
    val genome_size

    output:
    path("canu/canu_${output_name}.contigs.fasta"), emit: contigs
    path("canu/canu_${output_name}.report")

    script:
    output_name = (fastq_file.getFileName().toString() =~ /(.+)\.fastq$/)[0][1]
    """
    canu \
        -p canu_${output_name} \
        -d canu \
        genomeSize=${genome_size} \
        -nanopore-raw ${fastq_file}
    """
}

process flye {
    publishDir params.results_subdir, mode: 'rellink', overwrite: true, pattern: "flye/{assembly.fasta,assembly_info.text}", enabled: params.results_subdir ? true : false

    input:
    path fastq_file
    val genome_size

    output:
    path("flye/assembly.fasta"), emit: contigs
    path("flye/assembly_info.txt")

    script:
    """
    flye \
        --nano-hq ${fastq_file} \
        --out-dir flye \
        --genome-size ${genome_size} \
        --threads ${task.cpus}
    """
}
