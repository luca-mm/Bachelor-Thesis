using Random
using LinearAlgebra
using Plots
using Statistics

#Step 1: Initialization
n=1000 #Impact limit
N=50 #Number of nodes
t=200000
P=60
I = [rand(1:n) for i in 1:N] #Node impact vector
Imean=[sum(I)/N]
display(I)
popularity=[]
TopConnections=0

HighestImpact=[(findmax(I))[1]]

C = bitrand((N,N)) #Network matrix
display(C)
Connections=[sum(C)]

#plotlyjs()
function StateReport(stage)

    plot0=scatter(I,[sum(C[i,:]) for i in 1:N],legend=false)
    xlims!(0,1000)
    xlabel!("Impact")
    ylims!(0,N)
    ylabel!("Connectivity")
    title!(string("State",string(stage)))
    display(plot0)
    png(string(stage))
end

#Energy
E=[]
Enode = zeros(N,t)
function computeE()
    #println("Computing E")
    for i in 1:N
        B=0
        for k in 1:N
            if C[i,k] == 1
                B += I[k]
            end
        end

        Enode[i] = I[i]*B
    end
    push!(E,sum(Enode))
end

#Step 2: Network dynamics
p=0.2 #Event probability
#Remove lowest impact connection
#gaseste rand((1,N))
#loop and find lowest
function Step(i)
    minVal=n
    min=0
    candidates=[]
    #println("Node ",i)
    Execute1=rand(1:100)
    Execute2=rand(1:100)

    for j in 1:N
        if (C[i,j]==1) && (minVal>I[j])
            minVal=I[j]
            min=j
        end
    end

    if min!=0 && Execute1>P
        C[i,min]=0
        #C.data[min,i]=0
        #println("   Removed ",min," of impact ",minVal)
    end

    for j in 1:N
        if I[j]>minVal && C[i,j]==0 #! Se pot deconecta de ei insisi?
            push!(candidates,j)
        end
    end

    if length(candidates)>0 && Execute2>P
        j=rand(1:length(candidates))
        C[i,j]=1
        #C.data[j,i]=1
        #println("   Added ",j," of impact ",I[j])
    end

    #Hai sa nu se deconexcteze de ei insisi
    ##O fi bine aici??
    for i in 1:N
        C[i,i]=1
    end

    I[(findmin(I))[2]]=rand(1:n)
    #println("I[",absMin[2],"] cu val ",absMin[1]," inlocuit de ",I[absMin[2]])

    #Ar putea fi și în afara funcției
    #absMax=[(findmax(I))[2]]
    global TopConnections=0
    global Connections
    global HighestImpact
    for i in 1:N
        if I[i]==(findmax(I))[1]
            #push!(absMax,(findmax(I))[2])
            global TopConnections+=sum(C[:,i])
        end
    end
    #global Connections=sum(C[(findmax(I))[2],:])
    global popularity
    push!(popularity,TopConnections#=/length(absMax)=#)

    computeE()
    push!(Imean,sum(I)/N)
    push!(Connections,sum(C))
    push!(HighestImpact,(findmax(I))[1])

end

computeE()
E0=pop!(E)
StateReport(0)

for i in 1:t
    Step(rand((1:N)))
    if mod(i,1000)==0
        println("t=",i)
    end
end


plot1=plot(1:t,E/E0,legend=false)
xlabel!("Time")
ylabel!("E/E0")
title!("Energy")
display(plot1)
png("plot1")

plot2=plot(1:(t+1),Imean,legend=false)
xlabel!("Time")
ylabel!("Mean impact")
title!("Mean Impact over Time")
display(plot2)
png("plot2")

plot3=plot(1:t,popularity,legend=false)
xlabel!("Time")
ylabel!("# connections for max. impact agents")
title!("Top impact popularity")
display(plot3)
png("plot3")

plot4=plot(1:(t+1),Connections,legend=false)
xlabel!("Time")
ylabel!("Total connections")
title!("Total connections")
display(plot4)
png("plot4")

plot5=plot(1:(t+1),HighestImpact,legend=false)
xlabel!("Time")
ylabel!("Highest impact")
title!("Highest impact over time")
display(plot5)
png("plot5")

#########################
###Degree distribution###
#########################
DegreeArray=[sum(C[i,:]) for i in 1:N]
plot6=histogram(DegreeArray, nbins = 30)
title!("Degree distribution")
display(plot6)
png("plot6")

####################
###Hurst Exponent###
####################
#=

#1. Calculate the mean
m=mean(popularity)
#2. Create a mean adjusted series
Y=[popularity[i]-m for i in 1:t]
#display(Y)
#3. Calculate the cumulative deviate series Z
Z=[sum(Y[1:i]) for i in 1:t]
#display(Z)
#4. Compute the range R
R=[maximum(Z[1:i])-minimum(Z[1:i]) for i in 1:t]
#display(R)
#5. Compute the standard deviation S
S=[std(popularity[1:i]) for i in 1:t]
#display(S)
#6. plotting log[R(n)/S(n)] as a function of log n
RescaledRange=[]
for i in 1:t
    global RescaledRange
    push!(RescaledRange, [R[i]/S[i]])
end
#display(RescaledRange[1000:t])
plot7=scatter(1000:t,RescaledRange[1000:t],legend=false)
xaxis!(log)
yaxis!(log)
xlabel!("log n")
ylabel!("log[R(n)/S(n)]")
title!("Hurst exponent")
display(plot7)
png("plot7")=#
