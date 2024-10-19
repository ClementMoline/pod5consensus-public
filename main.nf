#!/usr/bin/env nextflow

/*
* pod5consensus
*/

nextflow.enable.dsl=2

// Include various sub-workflows and processes

include {
    baseCalling;
} from "./modules/base_calling/workflows"

include {
    qualityControl;
} from "./modules/quality_control/workflows"

include {
    assembly;
} from "./modules/assembly/workflows"

include {
    consensusCalling;
} from "./modules/consensus_calling/workflows"

// Main workflow

workflow {
    baseCalling(
        params.pod5,
    )

    qualityControl(
        baseCalling.out.fastq_file,
    )

    assembly(
        baseCalling.out.fastq_file,
        params.genome_size,
    )

    consensusCalling(
        baseCalling.out.fastq_file,
        assembly.out.contigs,
    )
}
