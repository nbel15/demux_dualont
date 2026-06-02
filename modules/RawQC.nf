/*
 * Use a text replacement tool to convert the greeting to uppercase
 */
process RawQC {

    container 'demux_dualont'
    
    input:
    path seqsum_out

    output:
    path "pycoQC-report.html"

    script:
    """
    pycoQC --summary_file ${seqsum_out} --html_outfile pycoQC-report.html
    """
}
