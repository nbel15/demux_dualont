
process GuppyBC_outer {
    
    // container "genomicpariscentre/guppy-gpu"

    input:
    path Seq_q9

    output:
    path "BC_outer"

    script:
    """
    guppy_barcoder -i ./ -s BC_outer --fastq_out --config configuration.cfg --barcode_kits SQK-NBD114-24 -t 20
    """
}