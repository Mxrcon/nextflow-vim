nextflow.enable.dsl = 2
//this is a process inclusion
include { BOO as FOO} from "./modules/foo.nf"

/*

Lot of comments
*/

process FOO2 {
    tag "${tag}"
    publishDir params.outdir, mode: params.some_param
    container 'some_container_link'
    cpus 1
    memory "2 GB"

    input:
    tuple val(value),  path(path_to_file)

    output:
    file (some_file), optional: true, emit: CHANNEL

    script:

    """
    echo "Helo nextflow vim ${name}"
    """

    stub:
    """
    echo "stub stub stub"
    """
}

workflow test {

	input = Channel.fromFilePairs(params.filepairs)
	FOO(input)
	FOO2(FOO.out.CHANNEL)

}
