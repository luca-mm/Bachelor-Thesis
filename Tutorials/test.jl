println("Test de print")
global x=12*100
println(x)

s1="I am a string."
s2="""Another string"""
"$s1$s2"

contacte=Dict("Luca"=>111,"Filip"=>"222");
contacte["Luca"]=112;
contacte["Luca"]
pop!(contacte,"Filip")

xTuple=("ter","mer","ser")
xTuple[2]

fibonacci=[1,1,2,3,5,8,13]
fibonacci[3]=0
push!(fibonacci,21)
pop!(fibonacci)


#Multidimensional
numbers=[[1,1,1],[2,2,2],[3,3,3]]
rand(4,3,2)

#Loops
#a = 0
while x > 1100
    global x
    x = x-1
    println(x)
end

for n = 1:10
    println(n)
end

myfriends = ["Ted","Robyn","Barney","Lily"]
for friend in myfriends
    println("Hi $friend")
end

#Un loop mai interesant
p,q=5,5
A=zeros(p,q)

for i in 1:p
    for j in 1:q
        A[i,j]=i+j
    end
end
A

#echivalent>
B=zeros(p,q)
for i in 1:p, j in 1:q
    B[i,j]=i+j
end
B

#Comprehension:
C = [i+j for i in 1:p, j in 1:q]

for n in 1:10
    D = [i+j for i in 1:n, j in 1:n]
    display(D)
end

#Conditionals
α=3
β=90

if α>β
    println("$α is larger than $β")
elseif α<β
    println("$β is larger than $α")
else
    println("$β and $α are equal")
end

#Nifty>
(α>β) ? α : β
(α<β) && println("Nice")
