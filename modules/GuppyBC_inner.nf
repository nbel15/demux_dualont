process GuppyBC_inner {
    
    // container "genomicpariscentre/guppy-gpu"

    input:
    path BC_outer

    output:
    path "BC_inner", emit: dir
    path "concatenation_summary.tsv", emit: file

    script:
    """
    mkdir -p BC_inner
    for subfolder in BC_outer/*/; do
        # Get the base name of the subfolder
        subfolder_name=\$(basename \$subfolder)
        subfolder_inners="\${subfolder_name}_inners"

        # Enter the subfolder
        echo "Processing subfolder: \$subfolder"

        # Perform your operation here
        guppy_barcoder -i "\$subfolder" -s "\$subfolder_inners" --fastq_out --enable_trim_barcodes \
        --config configuration.cfg -t 48 --barcode_kits EXP-PBC096
                       
        # After guppy — iterate through barcode folders
        for bcdir in "\$subfolder_inners"/*/; do
            [ -d "\$bcdir" ] || continue
            bcname="\$(basename \$bcdir)"

            # Name for merged file
            merged="\${subfolder_name}_\${bcname}.fastq"

            # Count input FASTQ files
            n="\$(ls -1 \$bcdir/*.fastq 2>/dev/null | wc -l)"

            if [ "\$n" -gt 0 ]; then
                echo "Concatenating \$n files in \$bcname -> \$merged"

                # Concatenate into parent directory (or change destination if needed)
	            cat "\$bcdir"/*.fastq > "BC_inner/\${merged}"

                # Add to summary table
                echo -e "BC_inner/\${merged}\t\${n}" >> concatenation_summary.tsv
            else
                echo "No FASTQ files found in \$bcname"
            fi
        done
    done
    """
}