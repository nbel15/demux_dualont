/*
 * Use echo to print 'Hello World!' to a file
 */
process BaseCal {
        
    input:
    path pod5

    output:
    path "Bcall_out.sam"
    script:
    """
    dorado basecaller hac ${pod5} --emit-moves --no-trim > Bcall_out.sam
    """
}
