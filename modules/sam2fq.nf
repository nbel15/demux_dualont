process sam2fq {

     container 'demux_dualont'
    // conda 'conda-forge::cowpy==1.1.5'
    
    input:
    path BC_out

    output:
    path "BC_out.fastq"

    script:
    """
    samtools fastq ${BC_out} > BC_out.fastq
    """
}
