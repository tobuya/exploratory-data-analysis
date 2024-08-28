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
