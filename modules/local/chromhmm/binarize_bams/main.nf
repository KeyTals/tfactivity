process BINARIZE_BAMS {
    tag "$meta.id"
    label "process_high"

    conda "bioconda::chromhmm=1.25"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/chromhmm:1.25--hdfd78af_0' :
        'biocontainers/chromhmm:1.25--hdfd78af_0' }"

    input:
    tuple val(meta), path(bams, stageAs: "input/*")
    tuple val(meta2), path(table)
    tuple val(meta3), path(chromsizes)

    output:
    tuple val(meta), path("output")

    script:
    """
    ChromHMM.sh BinarizeBam \\
        $chromsizes \\
        input \\
        $table \\
        output
    """
}
