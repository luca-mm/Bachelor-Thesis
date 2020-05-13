include("init.jl")
include("dynamics.jl")
include("analysis.jl")

function Run(temperature,nodes,steps,P)
    global T=temperature
    #Will become obsolete:
    #global E = []
    #global Preference = []
    global J = 1
    
    #Initializing network and data frame
    createDataFrame()
    initNetwork(nodes)

    #Executing steps
    for i in 1:steps
        Procedure2(rand(1:nodes),nodes,P)
    end

    #Export data to a new folder
    exportData()
end

