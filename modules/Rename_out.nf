
process Rename_out {

    input:
    path BC_inner
    path names_map


    output:
    path "BC_final", emit: dir

    script:
    """
        mkdir -p BC_final
        # Read mapping table into associative array
        tail -n +2 "${names_map}" > map.tsv

        # Process all .fastq files
        for src in ${BC_inner}/*.fastq; do

            # Get filename without extension
            base=\$(basename "\$src" .fastq)

            new=\$(awk -v x="\$base" '\$1==x {print \$2}' map.tsv)
            if [ -z "\$new" ]; then
                new="\$base"
                mkdir -p BC_final/BC_notIncluded
                cp "\$src" BC_final/BC_notIncluded/\${new}.fastq
            else
                cp "\$src" "BC_final/\${new}.fastq"
            fi
done
    """
}