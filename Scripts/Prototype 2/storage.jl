using CSV
using DataFrames
using Dates
using LightGraphs
using GraphIO

function createDataFrame()
    global Data = DataFrame(E=[0], c1=[0], c2=[0], c3=[0], c4=[0], c5=[0], c6=[0], c7=[0], c8=[0], c9=[0], c10=[0])
end

function exportData(dir) 
    #Save data frame
    mkdir(string("Data/",dir))
    CSV.write(string("Data/",dir,"/","data.csv"), Data)
    
    #Exporting the graph
    global Network
    savegraph(string("Data/",dir,"/","graph.net"), Network, "Network", GraphIO.NET.NETFormat())
end