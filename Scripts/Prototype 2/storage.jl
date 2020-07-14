using CSV
using DataFrames
using Dates
using LightGraphs
using GraphPlot, Compose

function createDataFrame()
    global Data = DataFrame(E=[0], c1=[0], c2=[0], c3=[0], c4=[0], c5=[0], c6=[0], c7=[0], c8=[0], c9=[0], c10=[0])
end

function exportData(dir) 
    #Save data frame
    mkdir(string("Data/",dir))
    CSV.write(string("Data/",dir,"/","data.csv"), Data)
    
    #Exporting the graph doesn't work for some reason:
    #draw(PNG(string("Data\\",exportTime,"\\","graph.png")), gplot(Network))
end