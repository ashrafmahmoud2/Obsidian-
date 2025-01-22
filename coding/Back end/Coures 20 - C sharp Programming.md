
#  <span style="color:rgb(112, 48, 160)">Common Language Runtime (CLR) IN .Net</span>

![[swimlane-architecture-framework.svg]]

==**Common Language Runtime (CLR):**== Translator software that converts high-level language (source code) into low-level language (object code), while providing services such as memory management, type safety, security, exception handling, thread management, and garbage collection. The CLR acts as a bridge between .NET code and the underlying operating system.


**==Common Intermediate Language (CIL)  (IL) (MSIL):==** ????

![[MSIL.png]]




### <span style="color:rgb(0, 176, 240)">1-common type system (CTS)</span>
**==Common Type System (CTS):==** A component of the .NET framework that defines how types are declared, used, and managed in the runtime, ensuring interoperability between languages. It specifies rules for type definitions and type behavior, providing a standard framework for cross-language integration and execution.

**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)">For example</span>**, VB.NET has an integer data type, and C# has an int data type for managing integers. After compilation, Int32 is used by both data types


### <span style="color:rgb(0, 176, 240)">2-Common language speciation (CLS)</span>
**==Common Language Specification (CLS):==**   ensures different languages can work together smoothly. It sets essential rules and features all .NET languages must follow, enabling developers to write code in multiple languages that can interact seamlessly within the .NET framework.

- Ensures that code written in one .NET language can be used by other .NET languages, promoting cross-language compatibility.
- **Ease of Integration**: Developers can create libraries in one language that can be easily used in another, enhancing collaboration and reuse.

### <span style="color:rgb(0, 176, 240)">3-Garbage Collector (GC)</span>
....
### <span style="color:rgb(0, 176, 240)">4-Just in Time Compiler (JIT)</span>
It converts the<span style="color:rgb(0, 176, 80)"> (MSIL , IL , CIL)</span> code into native code

| types of JIT | Pre JIT                      | Econo JIT                                               | Normal JIT (Default)         |
| ------------ | ---------------------------- | ------------------------------------------------------- | ---------------------------- |
| Work         | Executes all methods at once | Executes called methods and re-executes if called again | Executes called methods only |
| Memory       | High usage                   | Low usage                                               | Moderate usage               |
| Speed        | Slow                         | Faster                                                  | Fast                         |







### <span style="color:rgb(0, 176, 240)">5-Metadata(Manifest) and Assemblie</span>  
##### **<span style="color:rgb(215, 29, 166)">Assembly</span>**: 
A single unit in .NET containing compiled code, classes, libraries, and resources in one file, used for deployment, versioning, and security.
type
files (.exe)
files (.dll)

##### <span style="color:rgb(215, 29, 166)">Metadata(Manifest)</span>
**Metadata**: Information about an assembly, including details about its creator, contained classes, libraries, and other code.
















































 ### **<span style="font-weight:bold; color:rgb(0, 176, 240)">Managed and Unmanaged Code in .NET:</span>**

| Feature               | Managed Code                                                        | Unmanaged Code                                                                             |
| --------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| Execution Environment | Runs under the control of the Common Language Runtime (CLR).        | Runs directly on the native operating system without CLR.                                  |
| Memory Management     | Automatic garbage collection by the CLR.                            | Manual memory management required by the developer.                                        |
| Type Safety           | Strongly typed and checked for type safety by the CLR.              | No inherent type checking, potential for type-related errors.                              |
| Performance           | Generally slower due to CLR overhead and JIT compilation.           | Potentially faster due to direct interaction with hardware, but depends on implementation. |
| Platform Independence | Platform-independent due to CLR's intermediate language (CIL/MSIL). | Platform-dependent as it interacts directly with the operating system.                     |
| Security              | Managed by CLR, which provides code access security and sandboxing. | Security measures must be implemented manually by the developer.                           |
| Interoperability      | Supports seamless interoperability among different .NET languages.  | Limited interoperability with other programming languages without additional effort.       |
|                       | C# , Vb                                                             | C++                                                                                        |








# Serialization / Deserialization

### Serialization
**Serialization** is the process of converting an object into a byte stream or a specific format (JSON, XML, binary, etc.) that can be saved to a file, sent over a network, or stored in a database.

In C#, serialization is commonly done using built-in libraries such as:

- **JSON (via `System.Text.Json` or `Newtonsoft.Json`)**
- **XML (via `System.Xml.Serialization`)**
- **Binary (via `System.Runtime.Serialization`)**


### Deserialization 
is the process of converting data from a serialized format (such as JSON, XML, or binary) back into an object. 


# Reflection
**Reflection** is a feature that allows you to inspect the content of an object at runtime, including its **methods**, **fields**, **properties**, and other **members**. It enables dynamic examination and manipulation of types, methods, properties, and other members of objects during the execution of a program. This capability is particularly useful when the structure of the objects or the types is not known at compile time.

#### Practical uses of reflection:
- Inspecting Methods and Properties in IDEs
- get methods in unit testing frameworks
- Object Mapping
- Reflection is used in ORM frameworks to map database tables and columns to C# classes and properties dynamically

#### type class
The `Type` class is a central class in reflection, representing a type in C#. You can use it to get information about a type, such as its methods, properties, fields, and events.
``` c#
using System;

class Program
{
    static void Main()
    {
        Type myType = typeof(string);


        Console.WriteLine("Type Information:");
        Console.WriteLine($"Name: {myType.Name}");
        Console.WriteLine($"Full Name: {myType.FullName}");
        Console.WriteLine($"Is Class: {myType.IsClass}");


        Console.ReadLine();
    }
}
```



#### Example:  Get String Library Using Reflection methods
``` C# 
using System;
using System.Linq;
using System.Reflection;


class Program
{
    static void Main()
    {
        // Get the assembly containing the System.String type
        Assembly mscorlib = typeof(string).Assembly;


        // Get the System.String type
        Type stringType = mscorlib.GetType("System.String");


        if (stringType != null)
        {
            Console.WriteLine($"Methods of the System.String class:\n");


            // Get all public methods of the System.String class
            var stringMethods = stringType.GetMethods(BindingFlags.Public  | BindingFlags.Instance)
                .OrderBy(method => method.Name);


            foreach (var method in stringMethods)
            {
                Console.WriteLine($"\t{method.ReturnType} {method.Name}({GetParameterList(method.GetParameters())})");
            }
        }
        else
        {
            Console.WriteLine("System.String type not found.");
        }


        Console.ReadKey();


    }


    static string GetParameterList(ParameterInfo[] parameters)
    {
        return string.Join(", ", parameters.Select(parameter => $"{parameter.ParameterType} {parameter.Name}"));
    }
}
```









# Mutable and Immutable Types
#### Mutable
types are types whose instances `can be `modified after they are created.
**Exemples:**
- Class(if not read only)
- **Lists:** `List<T>`
- **Dictionaries:** `Dictionary<TKey, TValue>`
- **Arrays:** `int[]`
#### Immutable(Read only)
types are types whose instances `cannot be `modified after they are created.
**Exemples:** 
- **Strings:** `string` (but if you modified he will make new instances in Ram )
- **Record Types (introduced in C# 9):** Immutable by default



# Multithreading
#### Multithreading vs Asynchronous

| **Feature**              | **Multithreading**                              | **Asynchronous Programming**                  |
| ------------------------ | ----------------------------------------------- | --------------------------------------------- |
| **Purpose**              | Run tasks in parallel using threads.            | Handle non-blocking, I/O-bound tasks.         |
| **Focus**                | CPU-bound operations.                           | I/O-bound operations.                         |
| **Threads Used**         | Creates multiple threads.                       | Uses a single thread (or thread pool).        |
| **Resource Utilization** | Higher memory and CPU usage.                    | Optimized for responsiveness.                 |
| **Synchronization**      | Requires locks or semaphores to prevent issues. | Not needed unless mixed with threading.       |
| **Keywords**             | `Thread`, `Task`, `ThreadPool`.                 | `async`, `await`.                             |
| **Best Use Case**        | Heavy computations, parallel processing tasks.  | Network calls, file operations, API requests. |
#### When to Use:

1. **Multithreading:**  
    Ideal for parallel processing tasks, such as:
    
    - Image processing
    - Data analysis or crunching
    - Real-time simulations
2. **Asynchronous Programming:**  
    Best for tasks with significant waiting periods, such as:
    
    - File I/O operations
    - API or network requests
    - Database queries


















# Delegates
A delegate is a reference type in C# that acts as a pointer to a method. It allows methods to be passed as parameters, enabling dynamic invocation of methods at runtime.

- perdicate : a delegate returen bool.

## **`Func`** and **`Expression<Func>`**
- the vido in https://www.linkedin.com/posts/mahmoud-sami71_%D8%A7%D9%84%D9%86%D8%A7%D8%B3-%D8%A7%D9%84%D9%8A-%D9%84%D8%B3%D8%A7-%D8%A8%D8%AA%D8%AA%D9%84%D8%AE%D8%A8%D8%B7-%D9%85%D8%A7-%D8%A8%D9%8A%D9%86-%D8%A7%D9%84%D9%80-func-expression-activity-7248295005511925760-6xQf?utm_source=share&utm_medium=member_desktop

| Func<T, TResult> | Expression<Func<T, TResult>> |
| ---------------- | ---------------------------- |
|                  |                              |


## Exemple
``` c#
using System;

public class HelloWorld
{
  //delegate-MethodReturnType - delegateName - (parameterType)
    delegate void MyDelegate(string name);
    
    static void Welcome(string name)
    {
        Console.WriteLine("Welcome " + name);
    }

    public static void Main(string[] args)
    {
        // Create an instance of the delegate and point it to the Welcome method
        MyDelegate d1 = Welcome;
        
        d1.Invoke("Ashraf");   // Same as d1("Ashraf");
    }
}

```


# Evente
# notes
- You can use Reflection in a code generator to get the class = table name, field = column name, and property = column.


# Need to sarch 
- how is array Mutable, but if you modified he will make new instances in Ram