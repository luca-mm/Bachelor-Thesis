using LightGraphs
using Plots

#X=X(t)
E = []
Preference = []

function computeEnergy()
    global Network
    global nodes
    global E

    #Compute sytem energy and log it at time point
    push!(E,0)
    for i in 1:length(nodes)
        E[end] += nodes[i].energy
    end

    #TODO: implement storage    
end

function dE(ID)
    global Network
    global nodes
    global T

    #Goes through inneighbors and computes fitness (η)
    options = inneighbors(Network,ID)
    η=0
    for i in 1:length(options)
        η += 1- (((abs(nodes[ID].values[1]-nodes[options[i]].values[1]))
             +(abs(nodes[ID].values[2]-nodes[options[i]].values[2]))
             +(abs(nodes[ID].values[3]-nodes[options[i]].values[3]))
             +(abs(nodes[ID].values[4]-nodes[options[i]].values[4]))
             +(abs(nodes[ID].values[5]-nodes[options[i]].values[5])))
             /50)
    end

    #Computes node energy
    nodes[ID].energy = -T*η
end

function Entropy()

end

function stateVariable()

end

function trackPreference(ID)
    global Network
    global nodes
    global Preference
    
    #Count popularity of each candidate
    tracker = zeros(10)
    for i in 1:length(inneighbors(Network,ID))
        for j in 1:10
            if nodes[i].vote == j
                tracker[j] += 1
            end
        end
    end

    #Log the preferences at time point
    push!(Preference,tracker)
end

#Plotting
#TODO: get it from storage
function plotAnalysis(t)
    #Energy evolution
    plot1=plot(1:t+1,E,legend=false)
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
