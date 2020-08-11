module SocialSim

using Dates
using Random
using LightGraphs
using DataFrames
using CSV
using Dates
using GraphIO
using Plots
using StatsBase

export run_sim

const J = 1

include("init.jl")
include("analysis.jl")
include("dynamics.jl")
include("storage.jl")

#Runs the simulation at a determined temperature for a determined number of steps
function run_sim(T,population,steps)
    
    Random.seed!(1234)

    #Get time of simulation
    exportTime = Dates.format(Dates.now(), "yyyy-mm-ddTHH-MM-SS")
    
    #Initializing network and data frame
    data = createDataFrame()
    network, nodes = initNetwork(data, population)

    #Executing steps
    @time for i in 1:steps
        ni = rand(1:population)
        procedure2(nodes, network, data, ID=ni, N=population, T=T)
    end

    #Export data to a new folder
    exportData(exportTime, data, network)
    plotAnalysis(steps, exportTime, data, nodes, network)
end

#Runs the simulation at T for a determined time interval (in hours)
function SetRun(temperature,nodes,duration)
    global T=temperature
    global J = 1
    
    #Get time of simulation
    exportTime = Dates.format(Dates.now(), "yyyy-mm-ddTHH-MM-SS")
    
    #Initializing network and data frame
    createDataFrame()
    initNetwork(nodes)

    timelimit = Dates.now() + Dates.Minute(duration)
    
    #Executing steps
    while Dates.now() < timelimit #&& length(Data.E) <= 2000000
        Procedure2(rand(1:nodes),nodes,0.5)
    end

    #Export data to a new folder
    exportData(exportTime)
    plotAnalysis(length(data.E)-1, exportTime)
end

end
