using LightGraphs
using DataFrames
using Random

struct Agent(id=N+1, values=random((q)), vote=random(1:10))
    id::Int32
    values::AbstractArray
    vote::Int8
end

#Alternatively:
function initAgents(N)
    #Generate data frame:
    # Agent | Cultural vector | Opinion (vector of thresholds?)
end

function initNetwork()
    #LightGraphs
    #Generate graph with N
end
    