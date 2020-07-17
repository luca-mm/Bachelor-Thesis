using LightGraphs
using Plots
using StatsBase
using DataFrames

function computeEnergy()
    global Network
    global nodes
    global Data

    #Compute sytem energy
    E = 0
    for i in 1:length(nodes)
        Data.E[end] += nodes[i].energy
    end
end

function dE(ID)
    global Network
    global nodes
    global T
    global J

    #Goes through inneighbors and computes Potts node energy (ε)
    options = inneighbors(Network,ID)
    ε = 0
    for i in 1:length(options)
        if nodes[ID].vote == nodes[options[i]].vote
            ε += -J
        end
    end

    #Assign node energy
    return ε
end

#=Like dE(), but returns energy difference instead of assigning it automatically: 
function ΔE(ID,newVal)
    global Network
    global nodes
    global T
    global J

    #Goes through inneighbors and computes Potts node energy (ε)
    options = inneighbors(Network,ID)
    ε = 0
    for i in 1:length(options)
        if nodes[ID].vote == nodes[options[i]].vote
            ε += -J
        end
    end

    #Assign node energy
    nodes[ID].energy = ε 
end=#

#=(Not ready yet)
function generateEnergyDistribution()
    #Determine maximum energy
    E_max = findmax(Data.E)[1]
    global distrib = zeros(E_max+1)

    #Count energy levels
    for i in 1:length(Data.E)
        distrib()
    end

    #Normalize?

    return 0
end
=#

function Entropy()

end

function stateVariable()

end

function trackPreference()
    global nodes
    global Data
    
    #Count popularity of each candidate
    for i in 1:length(nodes)
        #Unrolled loop for each candidate 
        #(unfortunately it makes it difficult to change candidate number)
        if nodes[i].vote == 1
            Data.c1[end] += 1
        elseif nodes[i].vote == 2
            Data.c2[end] += 1
        elseif nodes[i].vote == 3
            Data.c3[end] += 1
        elseif nodes[i].vote == 4
            Data.c4[end] += 1
        elseif nodes[i].vote == 5
            Data.c5[end] += 1
        elseif nodes[i].vote == 6
            Data.c6[end] += 1
        elseif nodes[i].vote == 7
            Data.c7[end] += 1
        elseif nodes[i].vote == 8
            Data.c8[end] += 1
        elseif nodes[i].vote == 9
            Data.c9[end] += 1
        elseif nodes[i].vote == 10
            Data.c10[end] += 1
        end
    end
end

function trackPreference(old, new)
    global nodes
    global Data
    #Copy previous distribution
    Data.c1[end] = Data.c1[end-1]
    Data.c2[end] = Data.c2[end-1]
    Data.c3[end] = Data.c3[end-1]
    Data.c4[end] = Data.c4[end-1]
    Data.c5[end] = Data.c5[end-1]
    Data.c6[end] = Data.c6[end-1]
    Data.c7[end] = Data.c7[end-1]
    Data.c8[end] = Data.c8[end-1]
    Data.c9[end] = Data.c9[end-1]
    Data.c10[end] = Data.c10[end-1]

    #Remove old value
    if old == 1
        Data.c1[end] -= 1
    elseif old == 2
        Data.c2[end] -= 1
    elseif old == 3
        Data.c3[end] -= 1
    elseif old == 4
        Data.c4[end] -= 1
    elseif old == 5
        Data.c5[end] -= 1
    elseif old == 6
        Data.c6[end] -= 1
    elseif old == 7
        Data.c7[end] -= 1
    elseif old == 8
        Data.c8[end] -= 1
    elseif old == 9
        Data.c9[end] -= 1
    elseif old == 10
        Data.c10[end] -= 1
    end
    
    #Add new value
    if new == 1
        Data.c1[end] +=1
    elseif new == 2
        Data.c2[end] +=1
    elseif new == 3
        Data.c3[end] +=1
    elseif new == 4
        Data.c4[end] +=1
    elseif new == 5
        Data.c5[end] +=1
    elseif new == 6
        Data.c6[end] +=1
    elseif new == 7
        Data.c7[end] +=1
    elseif new == 8
        Data.c8[end] +=1
    elseif new == 9
        Data.c9[end] +=1
    elseif new == 10
        Data.c10[end] +=1
    end
end

#Plotting
#TODO: get it from storage
function plotAnalysis(t,dir)
    global Data
    global nodes
    global Network

    #Energy evolution
    plot1=plot(1:t+1, Data.E[1:t+1]#=/Data.E[1]=#, legend=false)
    xlabel!("Time")
    ylabel!("E/E_0")
    #xlims!(51000,52000)
    #ylims!(2,2.5)
    title!("Energy")
    png(string("Data/",dir,"/","Energy"))

    #Energy distribution
    energyDistribution=counts(-Data.E)
    plot2=plot(1:length(energyDistribution), energyDistribution, legend=false)
    title!("Energy distribution")
    png(string("Data/",dir,"/","EnergyDistribution"))

    #Inneighbor histogram
    noInneighbors = []
    for i in 1:length(nodes)
        push!(noInneighbors, length(inneighbors(Network, i)))
    end
    plot3=histogram(noInneighbors, bins = 15)
    title!("Inneighbor histogram")
    png(string("Data/",dir,"/","InneighborHistogram"))

    #Preference evolution
    #=UNDER CONSTRUCTION
    plot3=plot(1:t+1,Preference,legend=true)
    xlabel!("Time")
    ylabel!("E/E_0")
    #xlims!(51000,52000)
    #ylims!(2,2.5)
    title!("Energy")
    png("Data\\Energy")
    =#
end