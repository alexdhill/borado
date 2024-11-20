process basecall {
    publishDir "${params.outdir}/reads", mode: 'copy', overwrite: params.force
    container "genomicpariscentre/dorado:0.8.3"
    cpus 24
    memory '128 GB'
    label 'with_gpus'
    input:
        tuple(
            val(sample),
            path(pod5),
            path(model)
        )
    output:
        path("${sample}.fastq.gz")
    script:
        '''
            /opt/dorado/bin/dorado basecaller \
                !{model} \
                !{pod5} \
                -x "cuda:auto" \
                -r \
                --emit-fastq \
                | gzip \
                > ${sample}.fastq.gz
        '''
}