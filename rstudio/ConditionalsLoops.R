fb <- 16
li <- 8

# If..Else Statement
if(fb > li){
  print("Fb is greater than Li")
}else if(fb < li) {
  print("Fb is less than Li")
}else {
  print("Fb is equal to Li")
}

# While loop
while(li <= fb) {
  print(paste("Current Li value is:", li))
  li <- li + 2
}

ctr <- 2
while(ctr <= 7) {
  if(ctr %% 5 == 0) {
    break
  }
  print(paste("Current ctrl value is:", ctr))
  ctr <- ctr + 1
}

speed <- 64
while(speed >30){
  print(paste("The current speed is:", speed))
  if(speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  }else {
    print("Slow down")
    speed <- speed - 6
  }
}

# For loop
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
for(linked in linkedin) {
  print(paste("Current linkedin view is:", linked))
}

for(i in 1:length(linkedin)) {
  print(paste("Current linkedin view is:", linkedin[i]))
}

for (i in 1:nrow(ttt)) {
  for (j in 1:ncol(ttt)) {
    print(paste("On row", i, "and column", j, "the board contains", ttt[i,j]))
  }
}

for(li in linkedin) {
  if(li > 10) {
    print("You are popular!")
  }else {
    print("Be more visible.")
  }
  
  if(li > 16) {
    print("You are a rockstar!")
    break
  }
  
  if(li < 4) {
    print("You need to be more active!")
    next
  }
  
  print(li)
}
