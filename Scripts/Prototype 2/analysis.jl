using LightGraphs
using Plots
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

    #Goes through inneighbors and computes node energy (ε)
    options = inneighbors(Network,ID)
    ε = 0
    for i in 1:length(options)
        if nodes[ID].vote == nodes[options[i]].vote
            ε += J
        else
            ε += -J
        end
    end

    #Assign node energy
    nodes[ID].energy = ε
end

function Entropy()

end

function stateVariable()

end

function trackPreference(ID)
    global Network
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

#Plotting
#TODO: get it from storage
function plotAnalysis(t)
    #Energy evolution
    plot1=plot(2:t+1,E[2:t+1]/E[1],legend=false)
    xlabel!("Time")
    ylabel!("E/E_0")
    #xlims!(51000,52000)
    #ylims!(2,2.5)
    title!("Energy")
    png("Data\\Energy")

    #Energy histogram
    plot2=histogram(E)
    title!("Energy distribution")
    png("Data\\EnergyDistribution")

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
