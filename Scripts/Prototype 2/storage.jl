using CSV
using DataFrames
using Dates
using LightGraphs
using GraphPlot, Compose

function createDataFrame()
    global Data = DataFrame(E=[0], c1=[0], c2=[0], c3=[0], c4=[0], c5=[0], c6=[0], c7=[0], c8=[0], c9=[0], c10=[0])
    
    #Get time of simulation
    global exportTime = Dates.format(Dates.now(), "yyyy-mm-ddTHH-MM-SS")
    mkdir(string("Data\\",exportTime))

end

function exportData() 
    #Save data frame
    CSV.write(string("Data\\",exportTime,"\\","data.csv"), logs)
    #draw(PNG(string("Data\\",exportTime,"\\","graph.png")), gplot(Network))
end