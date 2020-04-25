include("storage.jl")

function Resume()
    #Loads a prior run and continues where it left of
end

function Save()
    #Saves progress to a certain dataframe/CSV
end

function Step()
    #Select unconnected node, connect with probabilty w
    #Select edge, disconnect with probabilty w^-1
    #w=1/F sum(f=1:N, sig.f(i),sig.f(j))
    #Select neighbour, copy vote with probability p
    #Optional: change core opinions
end