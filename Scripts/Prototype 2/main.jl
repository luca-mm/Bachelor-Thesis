include("init.jl")
include("dynamics.jl")
include("analysis.jl")

function Run(temperature,nodes,steps,P)
    global T=temperature
    initNetwork(nodes)
    
    for i in 1:steps
        Procedure2(rand(1:nodes),nodes,P)
    end

    plotAnalysis(steps)
end

