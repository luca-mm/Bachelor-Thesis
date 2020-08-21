function createDataFrame()
    DataFrame(E=[0], c1=[0], c2=[0], c3=[0], c4=[0], c5=[0], c6=[0], c7=[0], c8=[0], c9=[0], c10=[0])
end

function exportData(dir, data, network, nodes) 
    #Save log
    CSV.write("Data/$dir/data.csv", data)

    #Save nodes table
    nodes_df = DataFrame(ID = Int[], Vote = Int[], σ_1 = Int[], σ_2 = Int[], σ_3 = Int[], 
        σ_4 = Int[], σ_5 = Int[], E = Int[])
    
    for i in 1:length(nodes)
        push!(nodes_df, (nodes[i].id, nodes[i].vote[], nodes[i].values[1], nodes[i].values[2], 
            nodes[i].values[3], nodes[i].values[4], nodes[i].values[5], nodes[i].energy[]))
    end

    CSV.write("Data/$dir/nodes.csv", nodes_df)

    #Exporting the graph
    savegraph("Data/$dir/graph.net", network, "Network", GraphIO.NET.NETFormat())
end

function exportNetwork(dir, network, nodes, step)
    #Save nodes table
    nodes_df = DataFrame(ID = Int[], Vote = Int[], σ_1 = Int[], σ_2 = Int[], σ_3 = Int[], 
        σ_4 = Int[], σ_5 = Int[], E = Int[])
    
    for i in 1:length(nodes)
        push!(nodes_df, (nodes[i].id, nodes[i].vote[], nodes[i].values[1], nodes[i].values[2], 
            nodes[i].values[3], nodes[i].values[4], nodes[i].values[5], nodes[i].energy[]))
    end

    CSV.write("Data/$dir/Network/nodes_$step.csv", nodes_df)

    #Exporting the graph
    savegraph("Data/$dir/Network/graph_$step.net", network, "Network", GraphIO.NET.NETFormat())
end
