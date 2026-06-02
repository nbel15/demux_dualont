/*
 * Collect uppercase greetings into a single output file
 */
process BaseCal_sum {

    input:
    path BC_out

    output:
    path "sequencingsummary-report.txt"

    script:
    """
    dorado summary ${BC_out} > sequencingsummary-report.txt
    """
}
