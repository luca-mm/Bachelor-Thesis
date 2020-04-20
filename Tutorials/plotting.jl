using Plots

x = -3:0.1:3
f(x)=x^2
y=f.(x)

plotlyjs()
#plot(x,y,label="line")
#scatter!(x,y,label="points")

globaltemperatures = [14.4,14.5,14.8,15.2,15.5,15.8]
numpirates = [45000,20000,15000,5000,400,17]

plot(numpirates,globaltemperatures,legend=false)
scatter!(numpirates,globaltemperatures,legend=false)
xflip!()

xlabel!("Number of pirates")
ylabel!("Global Temperature (C)")
title!("Influence of pirate population on global warming")
