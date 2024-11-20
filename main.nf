include { basecall } from "./modules/basecall.nf"

params.outdir = "."
params.force = false
params.pod5 = ""
if (params.pod5 == "") throw new IllegalArgumentException("Must provide a POD5")
params.model = ""
if (params.model == "") throw new IllegalArgumentException("Must provide a model")
params.name = ""
if (params.name == "") throw new IllegalArgumentException("Must provide a sample name")
params.demux = ""

workflow {
    pod5 = Channel.fromPath(params.pod5)
    model = Channel.fromPath(params.model)
    if (params.demux != "") demux = Channel.fromPath(params.demux)

    Channel.from(params.name)
    | combine(pod5)
    | combine(model)
    basecall()
}