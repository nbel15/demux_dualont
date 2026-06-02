#!/usr/bin/env nextflow

// Include modules
include { BaseCal } from './modules/BaseCal.nf'
include { BaseCal_sum } from './modules/BaseCal_sum.nf'
include { RawQC } from './modules/RawQC.nf'
include { sam2fq } from './modules/sam2fq.nf'
include { RawFilt } from './modules/RawFilt.nf'
include { GuppyBC_outer } from './modules/GuppyBC_outer.nf'
include { GuppyBC_inner } from './modules/GuppyBC_inner.nf'
include { Rename_out } from './modules/Rename_out.nf'



/*
 * Pipeline parameters
 */
params {
    pod5: Path
    qscore: Integer
    names: Path
}

workflow {

    main:
    // BaseCaling
    BaseCal(params.pod5)
    // Create summary file
    BaseCal_sum(BaseCal.out)
    // QC
    RawQC(BaseCal_sum.out)
    // Convert SAM to fastq 
    sam2fq(BaseCal.out)
    // Filter reads by mean quality
    RawFilt(sam2fq.out, params.qscore)
    // Guppy demultiplexing outer barcode
    GuppyBC_outer(RawFilt.out)
    // Guppy demultiplexing inner barcode
    GuppyBC_inner(GuppyBC_outer.out)
    // Rename demultiplexed FASTQs based on mapping file (.txt)
    Rename_out(GuppyBC_inner.out.dir, params.names)

    publish:
    BaseCal_output = BaseCal.out
    BaseCal_sum_output = BaseCal_sum.out
    RawQC_output = RawQC.out
    sam2fq_output = sam2fq.out
    RawFilt_fq = RawFilt.out.fq_file
    GuppyBC_outer_dir = GuppyBC_outer.out
    GuppyBC_inner_dir = GuppyBC_inner.out.dir
    GuppyBC_inner_file = GuppyBC_inner.out.file
    Rename_out_dir = Rename_out.out.dir

}

output {
    BaseCal_output {
        path { "1_BaseCal/" }
    }
    BaseCal_sum_output {
        path { "1_BaseCal/" }
    }
    RawQC_output {
        path { "1_BaseCal/" }
    }
    sam2fq_output {
        path { "2_Convert/" }
    }
    RawFilt_fq {
        path { "2_Convert/" }
    }
    GuppyBC_outer_dir {
        path { "3_GuppyBC/" }
    }
    GuppyBC_inner_dir {
        path { "3_GuppyBC/" }
    }
    GuppyBC_inner_file {
        path { "3_GuppyBC/" }
    }
    Rename_out_dir{
        path { "4_DemuxFq" }
    }
}