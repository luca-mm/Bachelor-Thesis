function rewire!(network, nodes, ID, options; remove=false)
    isempty(options) && return

    target = rand(options)
        
    # number of values
    val_range = axes(nodes[ID].values, 1)
    val_norm = 1 / (val_range[end] * 10)
    p = val_norm * sum(
        i->abs(nodes[ID].values[i]-nodes[target].values[i]),
        val_range)
    if !remove
        p = 1 - p
    end

    # p=1-(((abs(nodes[ID].values[1]-nodes[target].values[1]))
    #     +(abs(nodes[ID].values[2]-nodes[target].values[2]))
    #     +(abs(nodes[ID].values[3]-nodes[target].values[3]))
    #     +(abs(nodes[ID].values[4]-nodes[target].values[4]))
    #     +(abs(nodes[ID].values[5]-nodes[target].values[5])))
    #     /50)
    if rand() ≤ p
        #Add pr remove edge
        if remove
            rem_edge!(network, target, ID)
        else
            add_edge!(network, target, ID)
        end

        #Adjust energy
        if nodes[target].vote[] == nodes[ID].vote[]
            j = remove ? J : -J
            nodes[ID].energy[] += j
        end
    end
end

function procedure2(nodes, network, data; ID, N, T)   

    #Add new row to data frame
    push!(data, zeros(10+1))

    #Select unconnected node, connect with probability w
    options = Int[]
    for i in 1:N
        if has_edge(network, i, ID) == false
            push!(options, i)
        end
    end

    rewire!(network, nodes, ID, options, remove=false)
    
    #Select edge, disconnect with probabilty w^-1
    options = inneighbors(network, ID)

    rewire!(network, nodes, ID, options, remove=true)

    # if options != []
    #     target = options[rand(1:end)] #Choose a random in-neighbor
    #     p=(((abs(nodes[ID].values[1]-nodes[target].values[1]))
    #     +(abs(nodes[ID].values[2]-nodes[target].values[2]))
    #     +(abs(nodes[ID].values[3]-nodes[target].values[3]))
    #     +(abs(nodes[ID].values[4]-nodes[target].values[4]))
    #     +(abs(nodes[ID].values[5]-nodes[target].values[5])))
    #     /50)
    #     if rand(0.0:1.0)<=p
    #         #Remove edge
    #         rem_edge!(Network,target,ID)

    #         #Adjust energy
    #         if nodes[target].vote == nodes[ID].vote
    #             nodes[ID].energy += J
    #         end
    #     end
    # end

    #Select new random preference & track preference change
    oldVal = nodes[ID].vote[]
    newVal = rand(1:10)
    nodes[ID].vote[] = newVal

    #Substract current node energy from former node energy
    ΔE = dE(nodes, ID, network) - nodes[ID].energy[]
    
    p = -(ΔE)/T

    #If ΔE<0 apply it:
    if ΔE < 0
        nodes[ID].energy[] += ΔE    
        for i in outneighbors(network, ID)
            nodes[i].energy[] = dE(nodes, i, oldVal, newVal)
        end
    #If ΔE>0 apply it with following probability:
    elseif rand() < exp(p)
        nodes[ID].energy[] += ΔE
        for i in outneighbors(network, ID)
            nodes[i].energy[] = dE(nodes, i, oldVal, newVal)
        end
    else
        nodes[ID].vote[] = oldVal
    end

    #Log preferences
    trackPreference!(data, oldVal, nodes[ID].vote[])

    #Compute system energy
    computeEnergy!(data, nodes)


    #Optional: change core opinions
end
