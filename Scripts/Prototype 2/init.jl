using Random
using LightGraphs 

mutable struct Agent
    id::Int32
    values::AbstractArray
    vote::Int8
    energy::Float32
end

function initNetwork(N)
    #Initialize agents
    global nodes = []
    for i in 1:N
        push!(nodes,Agent(i,rand(0:10,(5)),rand(1:10),0))
    end
    
    #=
    #Generate graph with N
    A = bitrand((N,N)) #Adjacency matrix #TODO:Make sparse
    for i in 1:N
        A[i,i] = 0 #Make sure nodes are not be connected to themselves
    end
    global Network = DiGraph(A) #Generate graph
    A = nothing #Clear A

    #We are now implementing a Barabasi-Albert graph, instead of a random one
    =#

    #Generate Barabasi graph with N nodes, 3 conntections each, 10 initial nodes
    global Network = barabasi_albert(N, 10, 3, is_directed=true)
    #global Network = erdos_renyi(N, 4, is_directed=true)
    
    #Initialize energy
    for i in 1:N
        dE(i)
    end
    computeEnergy()

    #Count initial preferences
    trackPreference()
end
