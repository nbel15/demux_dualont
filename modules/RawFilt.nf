
process RawFilt {

    input:
    path BC_out_fq
    val qscore

    output:
    path "Seq_q9.fastq", emit: fq_file

    script:
    """
    NanoFilt -q ${qscore} ${BC_out_fq} > Seq_q9.fastq
    """
}