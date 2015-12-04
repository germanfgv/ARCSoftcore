.begin
x:10
y:15

addcc %r1 , 5 , %r3
addcc %r1 , [x] , %r3

book:11
var:1
pez:3

ld [book] , %r10

be y
bneg y


ba y
bcs y
bvs y
.end