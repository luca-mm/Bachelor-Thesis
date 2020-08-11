function createDataFrame()
    DataFrame(E=[0], c1=[0], c2=[0], c3=[0], c4=[0], c5=[0], c6=[0], c7=[0], c8=[0], c9=[0], c10=[0])
end

function exportData(dir, data, network) 
    #Save data frame
    mkdir("Data/$dir")
    CSV.write("Data/$dir/data.csv", data)
    
    #Exporting the graph
    savegraph("Data/$dir/graph.net", network, "Network", GraphIO.NET.NETFormat())
end