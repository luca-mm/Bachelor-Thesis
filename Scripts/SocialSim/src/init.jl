struct Agent{T,E}
    id::Int
    values::Vector{T}
    vote::Ref{Int}
    energy::Ref{E}
end

function initNetwork(data, N)
    #Generate Barabasi graph with N nodes, 3 conntections each, 10 initial nodes
    network = barabasi_albert(N, 10, 3, seed=1, is_directed=true)
    #global Network = erdos_renyi(N, 4, is_directed=true)
    
    #Initialize agents
    nodes = Agent{Int,Int}[]
    for i in 1:N
        push!(nodes, Agent(i, rand(0:10, 5), Ref(rand(1:10)), Ref(0)))
    end
    
    #Initialize energy
    for i in 1:N
        dE!(nodes, i, network)
    end
    computeEnergy!(data, nodes)

    #Count initial preferences
    trackPreference!(data, nodes)

    return network, nodes
end
