# Comments in CoffeeScript are prepended with a # sign

# Variable declaration

someVariable = "someValue"

# Objects

myObject = 
  myFirstKey: "someValue"
  mySecondKey: "someOtherValue"

# Function declaration
  square(x) -> x * x # Produces the same results if done in multiple lines, with proper indentation

  # Function call
  square(2)
