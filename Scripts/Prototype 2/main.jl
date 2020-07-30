using Dates

include("init.jl")
include("dynamics.jl")
include("analysis.jl")

#Runs the simulation at a determined temperature for a determined number of steps
function Run(temperature,nodes,steps,P)
    global T=temperature
    global J = 1
    
    #Get time of simulation
    exportTime = Dates.format(Dates.now(), "yyyy-mm-ddTHH-MM-SS")
    
    #Initializing network and data frame
    createDataFrame()
    initNetwork(nodes)

    #Executing steps
    for i in 1:steps
        Procedure2(rand(1:nodes),nodes,P)

        if mod(steps, 100) == 0
            println(div(i*100,steps),"% done (",i,")")
        end
    end

    #Export data to a new folder
    exportData(exportTime)
    plotAnalysis(steps, exportTime)
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
    plotAnalysis(length(Data.E)-1, exportTime)
end

#Runs n determined length simulation with populations increasing 100 agents at a time up to a determined size
function SweepPopulations(temperature,maxNodes,steps)
    global T=temperature
    global J = 1
    
    #Get time of simulation
    #exportTime = Dates.format(Dates.now(), "yyyy-mm-ddTHH-MM-SS")
    
    for i in 100:100:maxNodes
        #Initializing network and data frame
        createDataFrame()
        initNetwork(i)

        #Executing steps
        for j in 1:steps
            Procedure2(rand(1:nodes),nodes,P)
        end

        #Export data to a new folder
        exportData(string("Population Sweep: ",i))
        plotAnalysis(steps, string("Population Sweep: ",i))
    end
end

#Run successive simulations in increments of 100 steps
function SweepTime(temperature,nodes,maxSteps)
    global T=temperature
    global J = 1
    
    #Get time of simulation
    #exportTime = Dates.format(Dates.now(), "yyyy-mm-ddTHH-MM-SS")
    
    for i in 100:100:maxSteps
        #Initializing network and data frame
        createDataFrame()
        initNetwork(nodes)

        #Executing steps
        for j in 1:i
            Procedure2(rand(1:nodes),nodes,0.5)
        end

        #Export data to a new folder
        exportData(string("Time Sweep: ",i))
        plotAnalysis(i, string("Time Sweep: ",i))
    end
end

#Runs multiple simulation at incremental temperatures
function SweepTemperature(T_min,T_max,nodes,steps,P)

end