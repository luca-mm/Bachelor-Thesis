#Functions

function sayhi(name)
    println("Hi $name")
end

sayhi("R2-D2")

f(x)=x^2
f(12)

#Same for previous, e.g.
sayhello(name) = println("Hello $name")
sayhello("Dudu")

saygreetings = name -> println("Greetings $name")
saygreetings("General")

#Mutating
v = [3,5,2]
sort(v)
display(v)
sort!(v)
display(v)

#Broadcasting
A = [i+3*j for j in 0:2, i in 1:3]
display(A)
f(A) #Inmultire de matrici
f.(A) #Inmultire de elemente
