 

``` c#
 [Fact]
 public async Task  CalculateArea_WithZeroWidth_ThrowsArgumentException()
// MethodName _Condition_ExpectedOutcome
 {

 // Arrange  = preper
// 1. Setup necessary dependencies (mocks, test data, etc.)
var width = 0; var height = 10;


// Act   = execut
// 2. Call the method under test
Action action = () => CalculateArea(width, height);


 //Assert  = check
// 3. Verify the outcome
Assert.Throws<ArgumentException>(action);
 
 }

 private int CalculateArea(int width, int height) 
 {
  if (width <= 0 || height <= 0)
   {
    throw new ArgumentException("Width and height must be   positive.");
    }
     return width * height; 
     }
```

# Code Coverage
It's the percentage of the code you are testing and methods.

# Loose Vs. Tight Coupling
![[‏‏لقطة الشاشة (13).png]]


### What are Mocking Frameworks?
I tools **make** objects (mocks) that **are used as** real objects.


# steps
``` c#
package
FakeItEasy //Fake methods
Microsoft.EntityFrameworkCore.InMemory // from Db

```