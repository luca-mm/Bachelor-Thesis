using Random
using LightGraphs
using DataFrames

include("storage.jl")
include("analysis.jl")

function Resume()
    #Loads a prior run and continues where it left of
end

function Save()
    #Saves progress to a certain dataframe/CSV
end

function Procedure1(ID)
    #TODO: Implement prototype 1
end

function Procedure2(ID,N,P)   
    global Network
    global nodes
    global Data
    global T

    #Add new row to data frame
    push!(Data, (0,0,0,0,0,0,0,0,0,0,0))

    if length(Data.E)%1 == 0
        #Select unconnected node, connect with probability w
        options = [i for i in 1:N]
        for i in 1:length(inneighbors(Network,ID))
            #deleteat!(options,inneighbors(Network,ID)[i])
            #deleteat!(options, findin(options, inneighbors(Network,ID)[i]))
            filter!(e->e≠inneighbors(Network,ID)[i],options)
        end
        if options != []
            target=options[rand(1:end)]
            
            #= This should become unnecessary:
            while has_edge(Network,target,ID)==true 
                #Pick random vertices until an unconnected one is found
                candidates = rand(1:N)
            end =#
            p=1-(((abs(nodes[ID].values[1]-nodes[target].values[1]))
                +(abs(nodes[ID].values[2]-nodes[target].values[2]))
                +(abs(nodes[ID].values[3]-nodes[target].values[3]))
                +(abs(nodes[ID].values[4]-nodes[target].values[4]))
                +(abs(nodes[ID].values[5]-nodes[target].values[5])))
                /50)
            if rand(0.0:1.0)<=p
                #Add edge
                add_edge!(Network,target,ID)

                #Adjust energy
                if nodes[target].vote == nodes[ID].vote
                    nodes[ID].energy -= J
                end
            end
        end
        
        #Select edge, disconnect with probabilty w^-1
        options = inneighbors(Network,ID)
        if options != []
            target = options[rand(1:end)] #Choose a random in-neighbor
            p=(((abs(nodes[ID].values[1]-nodes[target].values[1]))
            +(abs(nodes[ID].values[2]-nodes[target].values[2]))
            +(abs(nodes[ID].values[3]-nodes[target].values[3]))
            +(abs(nodes[ID].values[4]-nodes[target].values[4]))
            +(abs(nodes[ID].values[5]-nodes[target].values[5])))
            /50)
            if rand(0.0:1.0)<=p
                #Remove edge
                rem_edge!(Network,target,ID)

                #Adjust energy
                if nodes[target].vote == nodes[ID].vote
                    nodes[ID].energy += J
                end
            end
        end
    end

    #Select new random preference & track preference change
    oldVal = nodes[ID].vote
    newVal = rand(1:10)
    nodes[ID].vote = newVal

    #Substract current node energy from former node energy
    ΔE = dE(ID) - nodes[ID].energy
    
    p = -(ΔE)/T

    #If ΔE<0 apply it:
    if ΔE<0
        nodes[ID].energy += ΔE    
        for i in outneighbors(Network,ID)
            nodes[i].energy = dE(i,oldVal,newVal)
        end
    #If ΔE>0 apply it with following probability:
    elseif rand()<exp(p)
        nodes[ID].energy += ΔE    
        for i in outneighbors(Network,ID)
            nodes[i].energy = dE(i,oldVal,newVal)
        end
    else
        nodes[ID].vote = oldVal
    end
    
    #=DEPRECATED
    if rand(0.0:1.0)<=P
        oldVal = nodes[ID].vote
        nodes[ID].vote = findmax(weight)[2] #Support the most popular candidate
    end
    =#

    #Log preferences
    trackPreference(oldVal, nodes[ID].vote)

    #=Compute energy contribution
    nodes[ID].energy = dE(ID)
    for i in outneighbors(Network,ID)
        nodes[i].energy = dE(i)
    end=#

    #Compute system energy
    computeEnergy()


    #Optional: change core opinions
end