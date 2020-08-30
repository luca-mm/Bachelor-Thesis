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
using ProgressMeter

export run_sim
export sweep_temp

const J = 1

include("init.jl")
include("analysis.jl")
include("dynamics.jl")
include("storage.jl")

#Runs the simulation at a determined temperature for a determined number of steps
function run_sim(T,population,steps; exports_number=10)
    
    #Random.seed!(1234)

    #Get time of simulation and prepare folders
    exportTime = Dates.format(Dates.now(), "yyyy-mm-ddTHH-MM-SS")
    mkdir("Data/$exportTime")
    mkdir("Data/$exportTime/Network")

    
    #Initializing network and data frame
    data = createDataFrame()
    network, nodes = initNetwork(data, population)

    #Export network at each nx steps
    nx = div(steps, exports_number) 

    #Executing steps
    @showprogress 5 "Computing..." for i in 1:steps
        ni = rand(1:population)
        procedure2(nodes, network, data, ID=ni, N=population, T=T)

        if mod(i, nx) == 0
            exportNetwork(exportTime, network, nodes, i)
        end
    end

    #Export data to a new folder
    exportData(exportTime, data, network, nodes)
    plotAnalysis(steps, exportTime, data, nodes, network)
end

function sweep_temp(T_f,T_step,population)
    
    #Random.seed!(1234)

    #Get time of simulation and prepare folders
    exportTime = Dates.format(Dates.now(), "yyyy-mm-ddTHH-MM-SS")
    mkdir("Data/$exportTime")
    
    #Initializing network and data frame
    data = createDataFrame()
    network, nodes = initNetwork(data, population)

    #Sweep temp
    equilibriumTime = []
    @showprogress 5 "Computing..." for T in 1:T_step:T_f
        counter = 0    
        mkdir("Data/$exportTime/T=$T")
        mkdir("Data/$exportTime/T=$T/Network")

        while checkEquilibrium(data) == false
            ni = rand(1:population)
            procedure2(nodes, network, data, ID=ni, N=population, T=T)
            counter += 1
        end

        #Export data to a new folder
        exportData("$exportTime/T=$T", data, network, nodes)
        exportNetwork("$exportTime/T=$T", network, nodes, i)
        plotAnalysis(steps, "$exportTime/T=$T", data, nodes, network)

        push!(equilibriumTime, counter)
        println("Simulation for T=$T done")
    end

    #Export equilibriumTime
    exportEquilibriumLog(T_step, equilibriumTime, exportTime)
    plotEquilibriumTime=plot(1:T_step:T_f, equilibriumTime, legend=false, size(1200,800))
    xlabel!("Temperature")
    ylabel!("Equilibrium Time")
    png("Data/$dir/Equilibrium_time")
end

#Runs the simulation at T for a determined time interval (in hours)
#=function set_run(T,population,duration; exports_number=10)
    
    #Get time of simulation and prepare folders
    exportTime = Dates.format(Dates.now(), "yyyy-mm-ddTHH-MM-SS")
    mkdir("Data/$exportTime")
    mkdir("Data/$exportTime/Network")
    
    #Initializing network and data frame
    data = createDataFrame()
    network, nodes = initNetwork(data, population)

    #Export network at each nx steps
    nx = div(steps, exports_number) 

    timelimit = Dates.now() + Dates.Minute(duration)
    
    #Executing steps
    while Dates.now() < timelimit #&& length(Data.E) <= 2000000
        ni = rand(1:population)
        procedure2(nodes, network, data, ID=ni, N=population, T=T)

        if mod(i, nx) == 0
            exportNetwork(exportTime, network, nodes, i)
        end
    end

    #Export data to a new folder
    exportData(exportTime)
    plotAnalysis(length(data.E)-1, exportTime)
end=#

end
