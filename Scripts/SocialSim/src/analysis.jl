"""
    computeEnergy!(data, nodes)

Compute sytem energy
"""
function computeEnergy!(data, nodes)
    E = 0
    for i in 1:length(nodes)
        data.E[end] += nodes[i].energy[]
    end
end

"""
    dE(ID,oldVal,newVal)

Computes node energy by assessing the change in preference of an inneighbor
"""
function dE(nodes, ID, oldVal, newVal)

    if newVal == nodes[ID].vote[] && oldVal == nodes[ID].vote[]
        ε = nodes[ID].energy[]
    elseif newVal == nodes[ID].vote[] && oldVal != nodes[ID].vote[]
        ε = nodes[ID].energy[] - J
    elseif newVal != nodes[ID].vote[] && oldVal == nodes[ID].vote[]
        ε = nodes[ID].energy[] + J
    else
        ε = nodes[ID].energy[]
    end

    return ε
end

function dE(nodes, ID, network)

    #Goes through inneighbors and computes Potts node energy (ε)
    options = inneighbors(network,ID)
    ε = 0
    for i in 1:length(options)
        if nodes[ID].vote[] == nodes[options[i]].vote[]
            ε += -J
        end
    end

    return ε
end

#Slower: recomputes node energy thoroughly
function dE!(nodes, ID, network)

    ε = dE(nodes, ID, network)
    #Assign node energy
    nodes[ID].energy[] = ε
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

function datacol(data, i)
    getproperty(data, Symbol("c$i"))
end

"""
    trackPreference!(data, nodes)

Count popularity of each candidate
"""
function trackPreference!(data, nodes)
    for i in 1:length(nodes)
        v = nodes[i].vote[]
        
        # data.c$v[end] += 1
        datacol(data, v)[end] += 1
    end
end

function trackPreference!(data, old, new)
    #Copy previous distribution
    for i=1:10
        datacol(data, i)[end] = datacol(data, i)[end-1]
    end

    #Remove old value
    datacol(data, old)[end] -= 1
    #Add new value
    datacol(data, new)[end] += 1
end

#Plotting
#TODO: get it from storage
function plotAnalysis(t, dir, data, nodes, network)

    #Energy evolution
    plot1=plot(1:t+1, data.E[1:t+1]#=/Data.E[1]=#, legend=false)
    xlabel!("Time")
    ylabel!("E/E_0")
    #xlims!(51000,52000)
    #ylims!(2,2.5)
    title!("Energy")
    png("Data/$dir/Energy")

    #Energy distribution
    energyDistribution=counts(-data.E)
    plot2=plot(1:length(energyDistribution), energyDistribution, legend=false)
    title!("Energy distribution")
    png("Data/$dir/EnergyDistribution")

    #Inneighbor histogram
    noInneighbors = []
    for i in 1:length(nodes)
        push!(noInneighbors, length(inneighbors(network, i)))
    end
    plot3=histogram(noInneighbors, bins = 15)
    title!("Inneighbor histogram")
    png("Data/$dir/InneighborHistogram")

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
