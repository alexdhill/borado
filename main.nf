include { basecall } from "modules/basecall.nf"

params.outdir = "."
params.pod5 = ""
params.model = ""
params.name = ""
params.demux = ""

workflow {
    pod5 = Channel.fromPath(params.pod5)
    model = Channel.fromPath(params.model)
    if (params.demux != "") demux = Channel.fromPath(params.demux)

    basecall(params.name, pod5, model)
}