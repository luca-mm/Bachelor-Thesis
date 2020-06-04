include("init.jl")
include("dynamics.jl")
include("analysis.jl")

#Runs the simulation at a determined temperature for a determined number of steps
function Run(temperature,nodes,steps,P)
    global T=temperature
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
    plotAnalysis(steps)
end

#Runs the simulation at T for a determined time interval (in hours)
function SetRun(temperature,nodes,duration)
    global T=temperature
    global J = 1
    
    #Initializing network and data frame
    createDataFrame()
    initNetwork(nodes)

    timelimit = Dates.now() + Dates.Minute(duration)
    
    #Executing steps
    while Dates.now() < timelimit && length(Data.E) <= 2000000
        Procedure2(rand(1:nodes),nodes,0.5)
    end

    #Export data to a new folder
    exportData()
    plotAnalysis(length(Data.E)-1)
end

#Runs multiple simulation at incremental temperatures
function SweepTemperature(T_min,T_max,nodes,steps,P)

end