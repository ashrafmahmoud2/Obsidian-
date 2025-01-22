





Here's the text with the spacing adjusted:

Miscellaneous notes:
- **new in <span style="color:blue">string=new string</span>** makes the connection with the heap. Without concatenation, the value will be <span style="color:red">null;</span>.
- **<span style="color:red">null:</span>** means there is no value in the heap.
- **<span style="color:green">Nullable:</span>** (marked by (?)) shortcuts of Nullable. We make null because some servers get data null.
- **<span style="color:orange">Dynamic:</span>** Data type you can change, like object and var.
- **<span style="color:blue">Switch</span>** is better than **<span style="color:green">else if</span>**, but **<span style="color:green">else</span>** is better for making complex conditions.
- Any update in a string creates a new string in memory.
- **<span style="color:blue">foreach:</span>** Designed to work with collections of data.
- **<span style="color:blue">Data Structure:</span>** The thing that saves data in memory.
- **Method Overloading:** Allows defining multiple methods with the same name but different parameter types or count.
- Organize in an array as addresses, not as values.



| Aspect                                                            | `var`                                                                   | `object`                                                                    |
| ----------------------------------------------------------------- | ----------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| Can be Sent as a Parameter to a Method                             | No                                                                      | Yes                                                                         |
| Ability to Change Data Type                                       | No                                                                      | Yes                                                                         |
| Remains in Scope when Data Type Changes                            | Yes                                                                     | N/A (Data type is determined at runtime)                                    |
| Anonymous Objects Example                                          | `var` myVar = new { Name = "Ashrf", Age = 21, ID = 3 };                | `object` obj = new Object();                                                |
| Access to Properties                                                | `MessageBox.Show(myVar.Name, myVar.Age)` - It is read-only.            | N/A                                                                         |


| **Value-Types**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | **Reference-Types**                                                                                                                                                                                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <span style="color:red">`byte`</span>, <span style="color:red">`char`</span>, <span style="color:red">`decimal`</span>, <span style="color:red">`double`</span>, <span style="color:red">`enum`</span>, <span style="color:red">`float`</span>, <span style="color:red">`int`</span>, <span style="color:red">`long`</span>, <span style="color:red">`sbyte`</span>, <span style="color:red">`short`</span>, <span style="color:red">`struct`</span>, <span style="color:red">`uint`</span>, <span style="color:red">`ulong`</span>,'' <span style="color:red">`ushort`</span> | <span style="color:skyblue">`String`</span>, <span style="color:skyblue">`Arrays`</span> (even if their elements are value types), <span style="color:skyblue">`Class`</span>, <span style="color:skyblue">`Delegate` objects</span>                    \|<br>\| The value and name resid |
| The value and name reside in the stack.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | the name and Adress in steak but the value in heap                                                                                                                                                                                                                                        |
| After Finesh scope the Value-Type will Deleted Form the Steak                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | **garbage collector** Delete the Reference-Type from heap                                                                                                                                                                                                                                 |
| "When a value type is passed with 'ref' in methods, changes within the method directly affect the original value."                                                                                                                                                                                                                                                                                                                                                                                                                                                             | "When a reference type is passed to a method, by default, it's copied from the main value. Changes in the method don't affect the original value unless passed by reference with 'ref'." if I need to make update in main value but ref after parameter                                   |
| Generally faster due to stack allocation and copying.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Slightly slower due to heap allocation and indirection.                                                                                                                                                                                                                                   |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |                                                                                                                                                                                                                                                                                           |



| Steak                                                         | Heap                                                            |
| ------------------------------------------------------------- | --------------------------------------------------------------- |
| small                                                         | big                                                             |
| First in last out                                             | Rondem                                                          |
| Value-Type→like int<br><br>the value and Name in Steak        | Reference-Type →like string                                     |
| After Finesh scope the Value-Type will Deleted Form the Steak | <br>**garbage collector** Delete the Reference-Type from heap\| |
![[stack , heap.png]]![[memory.png]]


| **<span style="color:blue">Object</span>**                                                                  | **<span style="color:green">Dynamic</span>**                                                  |
| ----------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| <span style="color:blue">Object</span> has better performance than <span style="color:green">Dynamic</span> | <span style="color:green">Dynamic</span> allows for ignoring the data type during compilation |
| The Data type is determined at runtime                                                                      |                                                                                               |


| **Method**                                                     | **Description**                                                                                                                                                                                                                                                                    |
| -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **<span style="color:blue">stroing.Contains("Ashraf")</span>** | Checks if the text "Ashraf" is present in the string.                                                                                                                                                                                                                              |
| **<span style="color:blue">string.EndsWith("es")</span>**      | Checks if the string ends with the specified suffix "es".                                                                                                                                                                                                                          |
| **<span style="color:blue">string.Substring(from, to)</span>** | Returns a new string that is a substring of the current string, starting from the specified index "from" up to "to".For example, <span style="color:blue">string a = "Hello"; string b = a.Substring(2);</span> will result in <span style="color:blue">b</span> containing "llo". |

| **String array**                                                                        | **StringBuilder**                                          |
| --------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| Faster<br><br>fiexid size<br><br>bad in momery<br><br>best case: in no updats in string | Slower<br><br>best case : in more update in string<br><br> |

 **Pointer in c++**

- **Pointer:**Varuble save the address of athoer variable or function Address only
![[pointer.png]]


| **<span style="color:blue">Type</span>**                   | **<span style="color:green">Details</span>**            |
| ---------------------------------------------------------- | ------------------------------------------------------- |
| **<span style="color:blue">Jagged Array</span>**           | **<span style="color:green">Can change size</span>**    |
| **<span style="color:blue">Multidimensional Array</span>** | **<span style="color:green">Cannot change size</span>** |

|                   | **Convert.ToInt32**           | **int.Parse**                                | **int.TryParse()**                                              |
| ----------------- | ----------------------------- | -------------------------------------------- | --------------------------------------------------------------- |
| accepts           | `object`                      | `string`                                     | all                                                             |
| handle            | handle null values gracefully | not handle null values                       | If there any erro than don’t make any exsptions                 |
| notes             | -                             | -                                            | can return bool value<br>isConvert=int.tryparse(string,outnnum) |
| spead             | -                             | It is faster than `Convert.ToInt32`          | -                                                               |
| **Best Use Case** | convert from an object        | when  string is a valid number and not null. | Best to use when the input might not be a valid integer.        |





# need to review

- steak and heap
- Use string mathod in code gen stringName.Contains-StringName.EndsWith("es")-SubString( )
- byts of data type 
-  Multidimensional Array   + Jugged Array try to use like list
- in permission is better to user Db or make split string  mathod to one columns(1,0,1,0,1)
-  in delete first way by stirng mathods




