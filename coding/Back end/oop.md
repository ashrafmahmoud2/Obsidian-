







-  Destructor:destroy objects of class when the scope of an object ends. It has the same name as the class and starts with a tilde `~`,It is managed automatically by the garbage collector.

- Composition: to make a object in your class from another class

- **Assembly**: An assembly is a compiled code library used for deployment, versioning, and security in .NET applications or is some class in class library in contener class (dll)  (in opp c# .NET Class Library)


# <span style="color:rgb(112, 48, 160)">Access Modifiers</span>
- **public**: Allows access from anywhere or **same project or a nother project**
- **private**: .
- **protected**: Allows access by derived types.
- **internal**: Allows access within the same project only.
- **protected internal**: Allows access within the same assembly or by derived types.
- **private protected**: Allows access within the same assembly by derived types (C# 7.2 and later).

| **Access Modifier** | Description                                                                                               | Scope                                         | Usage                                                                                                            |
| ------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **public**          | The member is accessible from any other code in the same assembly or another assembly that references it. | Entire project and other referenced projects. | Use when you want the member to be accessible from anywhere, both within the same assembly and other assemblies. |
| **internal**        | The member is accessible only within the same assembly, but not from another assembly.                    | Entire assembly where it's defined.           | Use when you want the member to be accessible only within the same assembly, but not from other assemblies.      |





# <span style="color:rgb(112, 48, 160)">concepts of oop</span>
### **<span style="color:rgb(0, 176, 240)">Encapsulation</span>
to put the (variables) and methods (functions) into a single class
### <span style="color:rgb(0, 176, 240)">abstraction</span>
make only equired information(mathods , varibles) is visible to the user .
### <span style="color:rgb(0, 176, 240)">polymorphism</span>
polymorphism the ability of an object to take on multiple forms.

types:
1- compile-time polymorphism (also known as method **overloading**) : Method overloading allows multiple methods to have the same name, but with different parameters. The compiler selects the appropriate method to call based on the number, types, and order of the parameters.

 2- Runtime polymorphism (also known as method **overriding**): Method overriding allows a subclass to provide a specific implementation of a method that is already provided by its parent class. The method in the subclass must have the same signature (name, return type, and parameters) as the method in the parent class

3-**inheritance** is also a form of polymorphism known as "subtyping" or "subtype polymorphism".


### <span style="color:rgb(0, 176, 240)">inheritance</span>
,,

# <span style="color:rgb(112, 48, 160)">Inheritance - Overriding</span>
### <span style="color:rgb(0, 176, 240)">Overriding</span>
  **==overriding==** provides a new version of a method inherited from a parent class.
``` c#
using System;

namespace MyFirstProgram
{
    class Program
    {
        static void Main(string[] args)
        {
            // Method overriding provides a new version of a                    method inherited from a parent class.
            // The inherited method must be: abstract, virtual,                  or already overridden.
            // Used with ToString(), polymorphism.
            
            Dog dog = new Dog();
            Cat cat = new Cat();
            
            dog.Speak(); // Output: The dog goes *woof*
            cat.Speak(); // Output: The animal goes *brrr*

            Console.ReadKey();
        }
    }

    class Animal
    {
         // This is a virtual method, which means it can be                overridden in a derived class.
        public virtual void Speak()
        {
            Console.WriteLine("The animal goes *brrr*");
        }
    }

    class Dog : Animal
    {
        // This overrides the Speak() method in the Animal class.
        public override void Speak()
        {
            Console.WriteLine("The dog goes *woof*");
        }
    }

    class Cat : Animal
    {
        // The Cat class inherits the Speak() method from the Animal class.
        // It does not override the method, so it will use the base implementation.
    }
}

```



### <span style="color:rgb(0, 176, 240)">Types Of Inheritance</span>
![[Types Of Inheritance.jpg]]





# <span style="color:rgb(112, 48, 160)">Abstract</span>
### <span style="color:rgb(0, 176, 240)">Abstract class</span>
==**Abstract class:**== is a restricted class that cannot be used to create objects (to access it, it must be inherited from another class) like if i have persone , employee i can make perosne object only use employee object.
 

``` c#
using System;

public abstract class Person
{
    public string FirstName { get; set; }
    public string LastName { get; set; }

    public abstract void Introduce();

    public void SayGoodbye()
    {
        Console.WriteLine("Goodbye!");
    }
}

public class Employee : Person
{
    public int EmployeeId { get; set; }

    public override void Introduce()
    {
    //here is the fill of abstract mathods
        Console.WriteLine($"Hi, my name is {FirstName} {LastName}, and my employee ID is {EmployeeId}.");
    }
}


public class Program
{
    public static void Main()
    {
        //You cannot create an object of an abstract class, you            can only inherit it.
      //  Person Person1= new Person();

        Employee employee = new Employee();
        employee.FirstName = "Mohammed";
        employee.LastName = "Abu-Hadhoud";
        employee.EmployeeId = 123;
        employee.Introduce(); // Output: "Hi, my name is John Doe, and my employee ID is 123."
        employee.SayGoodbye(); // Output: "Goodbye!"

        Console.ReadKey();
    }
}
```



### <span style="color:rgb(0, 176, 240)">Abstract method</span>
**==Abstract method:==** is a method that is declared in an abstract class without any implementation. Abstract methods must be overridden in non-abstract derived classes, providing a specific implementation for the method. Abstract methods are used when you want to ensure that a derived class provides an implementation for a method..

``` c#
using System;

namespace MyFirstProgram
{
    // Abstract class with an abstract method
    public abstract class Animal
    {
        // Abstract method (no implementation)
        public abstract void Speak();

        // Non-abstract method (with implementation)
        public void Eat()
        {
            Console.WriteLine("The animal is eating.");
        }
    }
}

```

``` c#
namespace MyFirstProgram
{
    // Derived class that implements the abstract method
    public class Cat : Animal
    {
        // Provide implementation for the abstract method
        public override void Speak()
        {
            Console.WriteLine("The cat goes *meow*");
        }
    }
}

```

``` c#
namespace MyFirstProgram
{
    // Derived class that implements the abstract method
    public class Dog : Animal
    {
        // Provide implementation for the abstract method
        public override void Speak()
        {
            Console.WriteLine("The dog goes *woof*");
        }
    }
}

```

``` c#
using System;

namespace MyFirstProgram
{
    class Program
    {
        static void Main(string[] args)
        {
            // Instantiate the derived classes
            Dog dog = new Dog();
            Cat cat = new Cat();
            
            // Call the overridden methods
            dog.Speak(); // Output: The dog goes *woof*
            cat.Speak(); // Output: The cat goes *meow*
            
            // Call the non-abstract method
            dog.Eat(); // Output: The animal is eating.
            cat.Eat(); // Output: The animal is eating.

            Console.ReadKey();
        }
    }
}

```


# <span style="color:rgb(112, 48, 160)">Interface</span> 
##### <span style="color:rgb(0, 176, 240)">normall interface</span>
**==interface==** is a completely "**abstract class**", which can only contain abstract methods and properties (**<span style="color:rgb(0, 176, 80)">with empty bodies</span>**).
``` c#

// this exemple interface with abstract
using System;

public interface IPerson
{
    string FirstName { get; set; }
    string LastName { get; set; }

    void Introduce();
    void Print();

    string To_String();
}


public abstract class Person : IPerson
{
    public string FirstName { get; set; }
    public string LastName { get; set; }


    public abstract void Introduce();

    public void SayGoodbye()
    {
        Console.WriteLine("Goodbye!");
    }

    public void Print()
    {
        Console.WriteLine("Hi I'm the print method");
    }

    public string To_String()
    {
        return "Hi this is the complete string....";
    }


    public void SedEmail()
    {
        Console.WriteLine("Email Sent :-)");
    }

}


public class Employee : Person
{
    public int EmployeeId { get; set; }

    public override void Introduce()
    {
        Console.WriteLine($"Hi, my name is {FirstName}                   {LastName}, and my employee ID is {EmployeeId}.");
    }
}

public class Program
{
    public static void Main()
    {
        //You cannot create an object of an Interface, you can              only Implement it.
       // IPerson Person1 = new IPerson();

        Employee employee = new Employee();
        employee.FirstName = "Mohammed";
        employee.LastName = "Abu-Hadhoud";
        employee.EmployeeId = 123;
        employee.Introduce(); // Output: "Hi, my name is John             Doe, and my employee ID is 123."
        employee.SayGoodbye(); // Output: "Goodbye!"
        employee.Print();
        employee.SedEmail();
        Console.ReadKey();
    }
}
```

##### <span style="color:rgb(0, 176, 240)">Multiple Interfaces</span>
**<span style="font-weight:bold; font-style:italic; color:rgb(192, 0, 0)"> example</span> to make 2 interface 
``` c#
public abst
ract class Person : IPerson, ICommunicate
```

``` c#
using System;

public interface IPerson
{
    string FirstName { get; set; }
    string LastName { get; set; }

    void Introduce();

    void Print();

    string To_String();
}


public interface ICommunicate
{
   
    void CallPhone();

    void SendEmail(string Title, string Body);

    void SendSMS(string Title, string Body);

    void SendFax(string Title, string Body);

}


public abstract class Person : IPerson, ICommunicate

{

    public string FirstName { get; set; }
    public string LastName { get; set; }
    public abstract void Introduce();


    public void SayGoodbye()
    {
        Console.WriteLine("Goodbye!");
    }


    public void Print()
    {
        Console.WriteLine("Hi I'm the print method");
    }

    public string To_String()
    {
        return "Hi this is the complete string....";
    }

    public void CallPhone()
    {
        Console.WriteLine("Calling Phone... :-)");
    }

    public void SendEmail(string Title, string Body)
    {
        Console.WriteLine("Email Sent :-)");
    }

    public void SendSMS(string Title, string Body)
    {
        Console.WriteLine("SMS Sent :-)");
    }

    public void SendFax(string Title, string Body)
    {
        Console.WriteLine("Fax Sent :-)");
    }
}


public class Employee : Person
{
    public int EmployeeId { get; set; }

    public override void Introduce()
    {
        Console.WriteLine($"Hi, my name is {FirstName} {LastName}, and my employee ID is {EmployeeId}.");
    }
}


public class Program
{
    public static void Main()
    {
        //You cannot create an object of an Interface, you can only Implement it.
       // IPerson Person1 = new IPerson();

        Employee employee = new Employee();
        employee.FirstName = "Mohammed";
        employee.LastName = "Abu-Hadhoud";
        employee.EmployeeId = 123;
        employee.Introduce(); // Output: "Hi, my name is John Doe, and my employee ID is 123."
        employee.SayGoodbye(); // Output: "Goodbye!"
        employee.Print();
        employee.CallPhone();
        employee.SendEmail("hi","Body");
        employee.SendSMS("hi", "Body");
        employee.SendFax("hi", "Body");

        Console.ReadKey();


    }
}
```





# <span style="color:rgb(112, 48, 160)">Sealed</span>

 **==Sealed:==** don't make a class inherited by another class.
### <span style="color:rgb(0, 176, 240)">Sealed class</span>
``` c#
using System;

    sealed  class clsA
    {


    }

    // trying to inherit sealed class
    // Error Code
    class clsB : clsA
    {


    }

    class Program
    {
        static void Main(string[] args)
        {

            // create an object of B class
            clsB B1 = new clsB();

            Console.ReadKey();
        }
    }
```

### <span style="color:rgb(0, 176, 240)">sealed mathod</span>
```c# 
using System;


public class Person
{
    public virtual void Greet()
    {
        Console.WriteLine("The person says hello.");
    }
}


public class Employee : Person
{
    public sealed override void Greet()
    {
        Console.WriteLine("The employee greets you.");
    }
}

public class Manager : Employee
{
    //This will produce a compile-time error because the Greet method in Employee is
    //sealed and cannot be overridden.
    //public override void Greet()
    //{
    //    Console.WriteLine("The manager greets you warmly.");
    //}
}


public class Program
{
    public static void Main(string[] args)
    {
        Person person = new Person();
        person.Greet(); // outputs "The person says hello."

        Employee employee = new Employee();
        employee.Greet(); // outputs "The employee greets you."

        Manager manager = new Manager();
        manager.Greet(); // outputs "The employee greets you."

        Console.ReadKey();

    }
}
```

# <span style="color:rgb(112, 48, 160)">Partial</span> 
**Partial**: It's a keyword to use if you have a big class and you want to split it into parts.
### <span style="color:rgb(0, 176, 240)">Partial class</span>  
  ``` c#
  //clss part 1
  // File MyClass1.cs
using System;

public partial class MyClass
{
    public void Method1()
    {
        Console.WriteLine("Method 1 is called.");
    }
}
```
  ```c#
  //class part 2
  // File MyClass2.cs
using System;

public partial class MyClass
{
    public void Method2()
    {
        Console.WriteLine("Method 2 is called.");
    }
}
```
```c# 
// File: Program.cs
using System;


class Program
{
    static void Main()
    {
        //the code of MyClass is seperated in 2 files class1.cs and class2.cs
        MyClass obj = new MyClass();
        obj.Method1();
        obj.Method2();

        Console.ReadKey();
        
    }
}
```

### <span style="color:rgb(0, 176, 240)">Partial methods</span>
**Partial Methods**: Partial methods allow you to define a method signature in one part of a partial class and provide the implementation in another part. They can only be used within partial classes. A partial method declaration consists of the method signature without the implementation, and it's optional to provide the implementation. If no implementation is provided, the compiler removes the method call at compile time, making it as if the method never exist


- you can use in code gen name the mathod and implement in a nother class after finish


``` c#
namespace MyFirstProgram
{
    public partial class Animal
    {
        // Declaration of a partial method
        partial void OnSpeak();
        
        public void Speak()
        {
            Console.WriteLine("The animal goes *brrr*");
            // Call the partial method
            OnSpeak();
        }
    }
}

```

``` c#
namespace MyFirstProgram
{
    public partial class Animal
    {
        // Implementation of the partial method
        partial void OnSpeak()
        {
            Console.WriteLine("This is a partial method implementation.");
        }
    }
}

```

```c#
using System;

namespace MyFirstProgram
{
    class Program
    {
        static void Main(string[] args)
        {
            Dog dog = new Dog();
            Cat cat = new Cat();
            
            dog.Speak(); // Output: The dog goes *woof* \n This              is a partial method implementation.
            cat.Speak(); // Output: The animal goes *brrr* \n                 This is a partial method implementation.
            cat.Eat();   // Output: The animal is eating.

            Console.ReadKey();
        }
    }

    public class Dog : Animal
    {
        public override void Speak()
        {
            Console.WriteLine("The dog goes *woof*");
            // Call the base class Speak method
            base.Speak();
        }
    }

    public class Cat : Animal
    {
        // Inherits the Speak method from Animal
    }
}

```


# Need to review 

 - Access Modifiers 
 - Static
- class in Data type and data struture
- name space
-  internal ,private protected,**protected internal**:
- Abstract vs Overriding