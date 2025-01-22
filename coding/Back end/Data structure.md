## **<span style="color:rgb(112, 48, 160)">1. Linked Lists And Array</span>** 



```c#
using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Create a LinkedList of integers
        LinkedList<int> linkedList = new LinkedList<int>();

        // Adding elements
        linkedList.AddLast(10); // Add at the end
        linkedList.AddLast(20);
        linkedList.AddFirst(5); // Add at the beginning
        linkedList.AddAfter(linkedList.First, 15); // Add after the first node

        // Display elements
        Console.WriteLine("LinkedList elements:");
        foreach (int value in linkedList)
        {
            Console.WriteLine(value);
        }

        // Remove an element
        linkedList.Remove(15); // Remove a specific value
        Console.WriteLine("\nAfter removing 15:");
        foreach (int value in linkedList)
        {
            Console.WriteLine(value);
        }

        // Accessing elements
        Console.WriteLine($"\nFirst Element: {linkedList.First.Value}");
        Console.WriteLine($"Last Element: {linkedList.Last.Value}");
    }
}

```
Output:
```
LinkedList elements:
5
15
10
20

After removing 15:
5
10
20

First Element: 5
Last Element: 20

```


```c# 
//Using `object` allows you to mix types but requires casting when retrieving items, which can lead to runtime errors if not handled carefully


LinkedList<object> linkedList = new LinkedList<object>();

linkedList.AddLast(10);         // Store an int
linkedList.AddLast("Ashraf");   // Store a string

foreach (var item in linkedList)
    Console.WriteLine(item);    // Output: 10, Ashraf

```



---

## **<span style="color:rgb(112, 48, 160)">2. Stacks and Queues</span>**
#### Stacks vs Queues

| **Stack**                                                                                   | **Queue**                                                                                     |
| ------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| **LIFO **                                                                                   | **FIFO الملكه فيفي عبده**                                                                     |
| Like a gun (last bullet shot first)                                                         | Like a queue (people waiting in line)                                                         |
| implemented using a linked list or array                                                    | implemented using a linked list or array                                                      |
| Used for operations like reversing arrays or do and  redo in browsers.                      | Used for request management, like rate limiting                                               |
| `Push` (add), `Pop` (remove),`Peek` (element at the top of the stack), `Display` (show all) | `Enqueue` (add), `Dequeue` (remove), `Peek` (next element at the front), `Display` (show all) |
| `Top` (start of stack), `Bottom` (end of stack)                                             | `Front` (start of queue), `Rear` (end of queue),                                              |
|                                                                                             |                                                                                               |

#### Queue Type

| **Queue Type**               | **Description**                                                                               | Namespace                           |
| ---------------------------- | --------------------------------------------------------------------------------------------- | ----------------------------------- |
| **`Queue<T>` (Generic)**     | specific  Data type.                                                                          | `Collections.Generic`               |
| **`Queue` (Non-Generic)**    | holds any Data type.                                                                          | `System.Collections`                |
| **`ConcurrentQueue<T>`**     | A thread-safe, FIFO queue used for handling data in multi-threaded applications.              | `System.Collections.<br>Concurrent` |
| **`PriorityQueue<T, TKey>`** | A queue used for priority-based processing, similar to an emergency case queue in a hospital. | `Collections.Generic                |

##### `Queue<T>` (Generic Queue)
``` c#
using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Create a queue of integers
        Queue<int> queue = new Queue<int>();

        // Enqueue (add) items to the queue
        queue.Enqueue(10);
        queue.Enqueue(20);
        queue.Enqueue(30);

        // Dequeue (remove) items from the queue
        Console.WriteLine("Dequeue: " + queue.Dequeue());  // Outputs 10
        Console.WriteLine("Dequeue: " + queue.Dequeue());  // Outputs 20

        // Peek (view) the front item without removing it
        Console.WriteLine("Peek: " + queue.Peek());  // Outputs 30

        // Check if the queue contains an item
        Console.WriteLine("Contains 20: " + queue.Contains(20));  // Outputs False

        // Print remaining items in the queue
        Console.WriteLine("Items in queue:");
        foreach (var item in queue)
        {
            Console.WriteLine(item);  // Outputs 30
        }
    }
}

```
##### `Queue` (Non-Generic Queue)
``` c#
using System;
using System.Collections;

class Program
{
    static void Main()
    {
        Queue queue = new Queue();

        // Enqueue items
        queue.Enqueue(10);
        queue.Enqueue("Hello");
        queue.Enqueue(30.5);

        // Dequeue items
        Console.WriteLine(queue.Dequeue()); // 10
        Console.WriteLine(queue.Dequeue()); // "Hello"
        Console.WriteLine(queue.Dequeue()); // 30.5
    }
}

```
##### `ConcurrentQueue`
```c# 
using System;
using System.Collections.Concurrent;
using System.Threading;

class Program
{
    static void Main()
    {
        // Create a new ConcurrentQueue
        ConcurrentQueue<int> queue = new ConcurrentQueue<int>();

        // Simulate multiple threads adding items to the queue
        Thread t1 = new Thread(() =>
        {
            for (int i = 0; i < 5; i++)
            {
                queue.Enqueue(i);
                Console.WriteLine($"Thread 1 enqueued {i}");
                Thread.Sleep(100); // Simulate some work
            }
        });

        Thread t2 = new Thread(() =>
        {
            for (int i = 5; i < 10; i++)
            {
                queue.Enqueue(i);
                Console.WriteLine($"Thread 2 enqueued {i}");
                Thread.Sleep(100); // Simulate some work
            }
        });

        // Start both threads
        t1.Start();
        t2.Start();

        // Wait for threads to finish enqueuing
        t1.Join();
        t2.Join();

        // Dequeue items from the queue
        int result;
        while (queue.TryDequeue(out result))
        {
            Console.WriteLine($"Dequeued {result}");
        }
    }
}


```

---







##### `PriorityQueue<T, TKey>`
``` c#
using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Create a PriorityQueue where T is string and TKey is int (priority)
        PriorityQueue<string, int> queue = new PriorityQueue<string, int>();

        // Enqueue items with priorities (lower priority numbers mean higher priority)
        queue.Enqueue("Low priority", 3);
        queue.Enqueue("High priority", 1);
        queue.Enqueue("Medium priority", 2);

        // Dequeue items (they will be dequeued in order of priority)
        Console.WriteLine(queue.Dequeue());  // "High priority"
        Console.WriteLine(queue.Dequeue());  // "Medium priority"
        Console.WriteLine(queue.Dequeue());  // "Low priority"
    }
}

```

## **<span style="color:rgb(112, 48, 160)">3. Trees</span>**
#### Tree Terminology (Symbols)
![[Screenshot 2024-02-12 171912.png]]
**`Leaf Node`**: A node that has no children.
**`Parent Node`**:A node that has one or more children.
**`Child Node`**:A node that is a descendant of another node (it has a parent).
`Subtree`:tree formed from a node and its descendants (part of the main tree).
`Siblings`:nodes that are at the same level in the tree structure and share the same parent=brothers.
`Ancestor` of a Node: Any predecessor nodes on the path of the root to that node are called Ancestors of that node. {A,B} are the ancestor nodes of the node {E}. 
`Descendant: ` all the nodes that can be reached by following paths downward from a specific node, including its children, grandchildren, and further generations down the tree. {E,I,M,N} are the descendants of the node {B}.
`Internal` Nodes: Nodes with at least one child are called internal nodes.

#### Tree Type
| **Feature**        | **General Tree**                                 | **Binary Tree**                                            |
| ------------------ | ------------------------------------------------ | ---------------------------------------------------------- |
| **Child Count**    | Unlimited number of children per node.           | At most mixmam two children per node (`Left` and `Right`). |
| **Traversal**      | Custom traversal required for variable children. | Standard traversals: Inorder, Preorder, Postorder.         |
| **Usage**          | Folders and subfolders systems, HTML (DOM).      | Binary Search Trees, Decision Trees(true or false), Heaps. |
| **Implementation** | Node class includes a `List` for children.       | Node class has `Left` and `Right` references.              |
| Find               | Uses recursive function O(n)                     | Uses recursive or iterative function, O(n)O(n)O(n)         |
### General Tree
#### Exemple
``` c#
class Program
{
    static void Main(string[] args)
    {
        var companyTree = new Tree<string>("CEO");
        var finance = new TreeNode<string>("CFO");
        var tech = new TreeNode<string>("CTO");
        var marketing = new TreeNode<string>("CMO");


        companyTree.Root.AddChild(finance);
        companyTree.Root.AddChild(tech);
        companyTree.Root.AddChild(marketing);


        finance.AddChild(new TreeNode<string>("Accountant"));
        tech.AddChild(new TreeNode<string>("Developer"));
        tech.AddChild(new TreeNode<string>("UX Designer"));
        marketing.AddChild(new TreeNode<string>("Social Media Manager"));


        PrintTree(companyTree.Root);
        Console.ReadKey();
    }


    public static void PrintTree<T>(TreeNode<T> node, string indent = "")
    {
        Console.WriteLine(indent + node.Value);
        foreach (var child in node.Children)
        {
            PrintTree(child, indent + "  ");
        }
    }
}
//out put
CEO
  CFO
    Accountant
  CTO
    Developer
    UX Designer
  CMO
    Social Media Manager
```


### Binary Tree
#### Binary Tree Type
![[1_CMGFtehu01ZEBgzHG71sMg.png]]
- **Full Binary Tree**: A binary tree in which every node has either 0 or 2 children.
- **Complete Binary Tree**: A binary tree where all levels are fully filled, except possibly the last level. The last level should be filled from left to right.
- **Degenerate (or Pathological) Binary Tree**: A binary tree in which every internal node has only one child, making it essentially a linked list.
- **Perfect Binary Tree**: A binary tree in which all levels are completely filled, and all leaf nodes are at the same level.
- **Balanced Binary Tree**: A binary tree where the height difference between the left and right subtrees of every node is at most 1. This ensures efficient operations like search, insert, and delete.






####  tree traversals types:

| **Traversal Type**      | **Description**                                                                                      | **Order**                        | **Use Cases**                                          |
| ----------------------- | ---------------------------------------------------------------------------------------------------- | -------------------------------- | ------------------------------------------------------ |
| **Preorder**            | Visit the root, then the left subtree, followed by the right subtree.                                | Root → Left → Right              | Expression trees: Used to copy or recreate trees.      |
| **Postorder**           | Visit the left subtree, the right subtree, and then the root.                                        | Left → Right → Root              | Used to delete trees or evaluate postfix expressions.  |
| **Inorder**             | Visit the left subtree, the root, and then the right subtree.                                        | Left → Root → Right              | Binary Search Trees: Retrieves values in sorted order. |
| **Level Order (BFS)**   | Visit nodes level by level from left to right.                                                       | Level by Level (Left → Right)    | Shortest path in an unweighted graph/tree.             |
| **Reverse Level Order** | Visit nodes level by level, but from the bottom-most level to the root, left to right at each level. | Reverse Level (Left → Right)     | Used in bottom-up traversals or printing hierarchy.    |
| **Depth-First Search**  | Explores as far as possible along a branch before backtracking.                                      | Preorder/Postorder/Inorder forms | General use for pathfinding and tree analysis.         |

## **<span style="color:rgb(112, 48, 160)">4.  Generic Collections</span>
##### notes
-  `Capacity` is the number of elements the List can store before resizing.
- all generic collections in C# are dynamic in size
- both `FirstOrDefault` and `Find` methods are same
- Exists()[`System.Collections.Generic`] Works `List<T>` only , Any () [System.Linq]
- Any don't  **Have Index** you can loop by foreach

##### why Generics is better then  Non-Generics for most cases like?
1. safety(allow only the specified type of data to be added).
2. performance (by avoiding boxing/unboxing operations).
3. Readability (make code easier to read and maintain by specifying the expected type)


##### Generic Collections difference 

| **Collection**                       | **Implemented By**           | **Complexity - Search Algorithm**                           | **Have Index** | **Size** |
| ------------------------------------ | ---------------------------- | ----------------------------------------------------------- | -------------- | -------- |
| `List<T>`                            | **Array**                    | **Access:** O(1), **Search:** O(n), **Insert/Delete:** O(n) | Yes            | Variable |
| `Dictionary<TKey, TValue>`           | **Hash Table**               | **Access:** O(1), **Insert/Delete:** O(1) (on average)      | No             | Variable |
|                                      |                              |                                                             |                |          |
| `HashSet<T>`                         | **Hash Table**               | **Add/Search/Delete:** O(1) (on average)                    | No             | Variable |
| `SortedList<TKey, TValue>`           | **Array**                    | **Access:** O(log n), **Insert/Delete:** O(log n)           | Yes            | Variable |
| `Queue<T>`                           | **Circular Array**           | **Enqueue/Dequeue:** O(1)                                   | No             | Variable |
| `Stack<T>`                           | **Array** or **Linked List** | **Push/Pop:** O(1)                                          | No             | Variable |
| `LinkedList<T>`                      | **Doubly Linked List**       | **Access/Search:** O(n), **Insert/Delete:** O(1)            | No             | Variable |
| `SortedDictionary<TKey, TValue>`     | **Binary Search Tree**       | **Access:** O(log n), **Insert/Delete:** O(log n)           | No             | Variable |
| `ObservableCollection<T>`            | **Array**                    | Similar to `List<T>`, depends on operations                 | Yes            | Variable |
| `ConcurrentDictionary<TKey, TValue>` | **Hash Table**               | **Access:** O(1), **Insert/Delete:** O(1)                   | No             | Variable |














### 1. list
``` c#
// Using a lambda expression Looping
 numbers.ForEach(number => Console.WriteLine(number));
```
###### list vs array

| **Feature**         | **List<T>**                                                   | **Array**                                                                |
| ------------------- | ------------------------------------------------------------- | ------------------------------------------------------------------------ |
| **Definition**      | dynamic size.                                                 | fixed size.                                                              |
| **Size Management** | Automatically resizes when elements are added.                | Fixed size; cannot be changed after creation.                            |
| **Performance**     | Slightly slower due to resizing and extra features.           | Faster due to minimal overhead.                                          |
| **Flexibility**     | Supports adding, removing, or inserting elements dynamically. | Requires manual resizing by copying elements.                            |
| **Initialization**  | No size specification required during initialization.         | Requires size specification at initialization.                           |
| **Access Syntax**   | Indexed access, e.g., `myList[i]`.                            | Indexed access, e.g., `myArray[i]`.                                      |
| **Thread Safety**   | Not thread-safe.                                              | Not thread-safe.                                                         |
| **Type Safety**     | Generic, ensures type safety with `List<T>`.                  | Type-safe when declared explicitly.                                      |
| **Use Cases**       | Suitable for dynamic or frequently changing collections.      | Ideal for fixed-size collections with known size for better performance. |


###### `List<T>` Methods
 All methods in 
 https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1?view=net-9.0

```c#
 List<int> numbers = new List<int>();
 // Adding elements to the list
numbers.Add(1); // Add 1 to the list
```




























### 2. Dictionary<TKey, TValue>
##### Hashtable vs Dictionary<TKey, TValue>

| **Feature**             | **`Hashtable`**                                                  | **`Dictionary<TKey, TValue>`**                                                  |
| ----------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| **Namespace**           | `System.Collections`                                             | `System.Collections.Generic`                                                    |
| **Type of Collect ion** | Non-generic                                                      | Generic (type-safe)                                                             |
| **Key-Value Pair Type** | take any type                                                    | take specified value (strongly typed)                                           |
| **Performance**         | Slower due to boxing/unboxing                                    | Faster and more efficient due to type safety and no boxing/unboxing             |
| **Null Values**         | Allows `null` for both keys and values (if key type is `object`) | Allows `null` values, but the key cannot be `null` (except for reference types) |
| **Thread-Safety**       | Not thread-safe (use `Hashtable.Synchronized` for thread safety) | Not thread-safe by default (use `ConcurrentDictionary` for thread safety)       |
| **Hashing**             | Uses a hash table with `object`-based hashing                    | Uses a generic hashing algorithm specific to `TKey`                             |
| **Iteration**           | Iteration through `Hashtable` returns `DictionaryEntry`          | Iteration returns `KeyValuePair<TKey, TValue>`                                  |
| **Usage**               | Legacy collection, generally replaced by `Dictionary`            | Preferred choice in modern C# code for better type safety and performance       |

























##### Exemple
``` c#
using System;
using System.Collections.Generic;


class Program
{
    static void Main()
    {
        // Creating the dictionary
        Dictionary<string, int> fruitBasket = new Dictionary<string, int>();


        // Adding elements
        fruitBasket.Add("Apple", 5);
        fruitBasket.Add("Banana", 2);
        //the following commented line will casue an error because they key is repeated.
        //fruitBasket.Add("Banana", 5);
        fruitBasket.Add("Orange", 12);


        // Accessing and updating elements
        fruitBasket["Apple"] = 10;


        Console.WriteLine("\nDictionary Content:");
        // Iterating through the dictionary
        foreach (KeyValuePair<string, int> item in fruitBasket)
        {
            Console.WriteLine($"Fruit: {item.Key}, Quantity: {item.Value}");
        }


        // Removing an element
        fruitBasket.Remove("Banana");

        Console.WriteLine("\nDictionary Content after removing Banana:");
        // Iterating through the dictionary after removing Banana
        foreach (KeyValuePair<string, int> item in fruitBasket)
        {
            Console.WriteLine($"Fruit: {item.Key}, Quantity: {item.Value}");
        }

        Console.ReadKey();
    }
}
```

























##### Best practice to Get Value
``` c#
using System;
using System.Collections.Generic;


class Program
{
    static void Main()
    {
        // Creating and initializing the dictionary
        Dictionary<string, int> fruitBasket = new Dictionary<string, int>
        {
            { "Apple", 5 },
            { "Banana", 2 }
        };


        // Using TryGetValue
        if (fruitBasket.TryGetValue("Apple", out int                        appleQuantity))
        {
            Console.WriteLine($"Apple quantity: {appleQuantity}");
        }
        else
        {
            Console.WriteLine("Apple not found in the basket.");
        }


        //the following line will make exception error because              orange is not there.
        Console.WriteLine($"Orange quantity:      {fruitBasket["Orange"]}");                  


        // Using TryGetValue
        if (fruitBasket.TryGetValue("Orange", out int OrangeQuantity))
        {
            Console.WriteLine($"Orange quantity: {OrangeQuantity}");
        }
        else
        {
            Console.WriteLine("Orange not found in the basket.");
        }

        Console.ReadKey();
    }
}
```


### 3. HashSet
#### note
- not allow duplicates elements,so you can use if student can take the exam only once.
- Using HashSet to Remove Duplicates In any collctions
- it not have indexing

#### Example
``` c#
// C# program to illustrate how to
// create hashset
using System;
using System.Collections.Generic;

class GFG {

	// Main Method
	static public void Main()
	{

		// Creating HashSet
		// Using HashSet class
		HashSet<string> myhash1 = new HashSet<string>();

		// Add the elements in HashSet
		// Using Add method
		myhash1.Add("C");
		myhash1.Add("C++");
		myhash1.Add("C#");
		myhash1.Add("Java");
		myhash1.Add("Ruby");
		Console.WriteLine("Elements of myhash1:");

		// Accessing elements of HashSet
		// Using foreach loop
		foreach(var val in myhash1)
		{
			Console.WriteLine(val);
		}

		// Creating another HashSet
		// using collection initializer
		// to initialize HashSet
		HashSet<int> myhash2 = new HashSet<int>() {10,
							100,1000,10000,100000};
				
		// Display elements of myhash2
		Console.WriteLine("Elements of myhash2:");
		foreach(var value in myhash2)
		{
			Console.WriteLine(value);
		}
	}
}

```



### 4. SortedList<TKey, TValue>
#### Note

- **SortedList** is available in both generic and non-generic forms.
- It is similar to a **Dictionary**, but the items are **sorted by key**.
- It is **slower** than a **Dictionary** because it **sorts the items every time you add an element**.
#### Hashtable vs Dictionary<> vs SortedList<>

## **<span style="color:rgb(112, 48, 160)">5.  Non-Generic Collections</span>

##### Note
- ll **non-generic collections** in **`System.Collections`** have **dynamic sizes**

##### Non-Generic Collections difference 

| **Collection** | **Implemented By**           | **Complexity - Search Algorithm**                                                                             | **Have Index** |
| -------------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------- | -------------- |
| **ArrayList**  | **Array**                    | **Access**: O(1), **Search**: O(n), **Insert/Delete**: O(n)                                                   | Yes            |
| **Hashtable**  | **Hash Table (Array-based)** | **Access**: O(1), **Search**: O(1) (average) / O(n) (worst), **Insert/Delete**: O(1) (average) / O(n) (worst) | No             |
| **Queue**      | **Array or Linked List**     | **Access**: O(1), **Search**: O(n), **Insert/Delete**: O(1)                                                   | No             |
| **Stack**      | **Array or Linked List**     | **Access**: O(1), **Search**: O(n), **Insert/Delete**: O(1)                                                   | No             |
| **SortedList** | **Array (Sorted)**           | **Access**: O(log n), **Search**: O(log n), **Insert/Delete**: O(n)                                           | Yes            |
| **Dictionary** | **Hash Table (Array-based)** | **Access**: O(1), **Search**: O(1) (average) / O(n) (worst), **Insert/Delete**: O(1) (average) / O(n) (worst) | Yes            |
| **LinkedList** | **Linked List**              | **Access**: O(n), **Search**: O(n), **Insert/Delete**: O(1) (at the beginning/end)                            | Yes            |

### 1. Hashtable

- we just use Hashtable  only if we need to store data as `object` types.
#### Hashtable vs Dictionary<TKey, TValue>

| **Feature**             | **`Hashtable`**                                                  | **`Dictionary<TKey, TValue>`**                                                  |
| ----------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| **Namespace**           | `System.Collections`                                             | `System.Collections.Generic`                                                    |
| **Type of Collection**  | Non-generic                                                      | Generic (type-safe)                                                             |
| **Key-Value Pair Type** | take any type                                                    | take specified value (strongly typed)                                           |
| **Performance**         | Slower due to boxing/unboxing                                    | Faster and more efficient due to type safety and no boxing/unboxing             |
| **Null Values**         | Allows `null` for both keys and values (if key type is `object`) | Allows `null` values, but the key cannot be `null` (except for reference types) |
| **Thread-Safety**       | Not thread-safe (use `Hashtable.Synchronized` for thread safety) | Not thread-safe by default (use `ConcurrentDictionary` for thread safety)       |
| **Hashing**             | Uses a hash table with `object`-based hashing                    | Uses a generic hashing algorithm specific to `TKey`                             |
| **Iteration**           | Iteration through `Hashtable` returns `DictionaryEntry`          | Iteration returns `KeyValuePair<TKey, TValue>`                                  |
| **Usage**               | Legacy collection, generally replaced by `Dictionary`            | Preferred choice in modern C# code for better type safety and performance       |

####  Example
``` c#
using System;
using System.Collections;


class Program
{
    static void Main()
    {
        // Initialization
        Hashtable myHashtable = new Hashtable();
        myHashtable.Add("key1", "value1");
        myHashtable.Add("key2", "value2");
        myHashtable.Add("key3", "value3");




        // Accessing an element
        Console.WriteLine($"Accessing key1: {myHashtable["key1"]}");


        // Modifying an element
        myHashtable["key1"] = "newValue1";


        // Removing an element
        myHashtable.Remove("key2");


        // Iterating over elements
        Console.WriteLine("\nCurrent Hashtable contents:");
        foreach (DictionaryEntry entry in myHashtable)
        {
            Console.WriteLine($"Key: {entry.Key}, Value: {entry.Value}");
        }
        Console.ReadKey();

    }
}
```























## <span style="color:rgb(112, 48, 160)">5. ObservableCollection</span>
### note 
-  A dynamic collection in the `System.Collections.ObjectModel` .
- collection Automatically notifies about any changes made to the collection, like additions, deletions, or refreshes,so you can use in ui  if any thing changes.
### Exemple
``` c#
using System;
using System.Collections.ObjectModel;


class Program
{
    static void Main(string[] args)
    {
        // Creating an ObservableCollection
        ObservableCollection<string> Items = new ObservableCollection<string>();
        // Subscribing to the CollectionChanged event
        Items.CollectionChanged += Items_CollectionChanged;


        // Modifying the ObservableCollection
        Items.Add("Item 1");
        Items.Add("Item 2");
        Items.Add("Item 3");


        Items.RemoveAt(1);
        Items.Insert(0, "New Item");
        Items[1] = "Replaced Item"; // Replace action
        Items.Move(0, 2); // Move action


        // Printing the Final Collection
        Console.WriteLine("\nFinal Collection:");
        foreach (var item in Items)
        {
            Console.WriteLine(item);
        }
        Console.ReadKey();
    }


    // CollectionChanged Event Handler
    static void Items_CollectionChanged(object sender, System.Collections.Specialized.NotifyCollectionChangedEventArgs e)
    {
        Console.WriteLine("\nCollection Changed:");


        // Handling Collection Changes
        switch (e.Action)
        {
            case System.Collections.Specialized.NotifyCollectionChangedAction.Add:
                Console.WriteLine("Added:");
                foreach (var newItem in e.NewItems)
                {
                    Console.WriteLine("- " + newItem);
                }
                break;


            case System.Collections.Specialized.NotifyCollectionChangedAction.Remove:
                Console.WriteLine("Removed:");
                foreach (var oldItem in e.OldItems)
                {
                    Console.WriteLine("- " + oldItem);
                }
                break;


            case System.Collections.Specialized.NotifyCollectionChangedAction.Replace:
                Console.WriteLine("Replaced:");
                foreach (var oldItem in e.OldItems)
                {
                    Console.WriteLine("- " + oldItem);
                }
                Console.WriteLine("With:");
                foreach (var newItem in e.NewItems)
                {
                    Console.WriteLine("- " + newItem);
                }
                break;


            case System.Collections.Specialized.NotifyCollectionChangedAction.Move:
                Console.WriteLine("Moved:");
                Console.WriteLine($"- From index {e.OldStartingIndex} to index {e.NewStartingIndex}");
                break;
        }
    }
}
```





## <span style="color:rgb(112, 48, 160)">6. BitArray</span>
- `System.Collections.BitArray`
- Collections to Working with binary data such as encoding, decoding, or bitwise operations.
### Exemple
``` c#
using System;
using System.Collections;

class Program
{
    static string BitArrayToString(BitArray bitArray)
    {
        char[] chars = new char[bitArray.Length];
        for (int i = 0; i < bitArray.Length; i++)
        {
            chars[i] = bitArray[i] ? '1' : '0';
        }
        return new string(chars);
    }

    static void Main()
    {
        // Create a BitArray with 10 bits, all initialized to false
        BitArray bits1 = new BitArray(10);
        Console.WriteLine("\nbits1 content: " + BitArrayToString(bits1));
      
        for (int i = 0; i < bits1.Count; i++)
        {
            bool bitVal = bits1[i];
            Console.WriteLine($"Bit at index {i}: {bitVal}");
        }

        // Create a BitArray from an array of booleans
        bool[] initialValues = { true, false, true, true, false };
        BitArray bits2 = new BitArray(initialValues);

        Console.WriteLine("\nbits2 content: " + BitArrayToString(bits2));
        for (int i = 0; i < bits2.Count; i++)
        {
            bool bitVal = bits1[i];
            Console.WriteLine($"Bit at index {i}: {bitVal}");
        }

        // Create a BitArray from a byte array
        byte[] byteArray = { 0xAA, 0x55 }; // 10101010, 01010101
        BitArray bits3 = new BitArray(byteArray);

        Console.WriteLine("\nbits3 content: " + BitArrayToString(bits3));
        for (int i = 0; i < bits3.Count; i++)
        {
            bool bitVal = bits3[i];
            Console.WriteLine($"Bit at index {i}: {bitVal}");
        }

        // Basic Operations
        BitArray bits4 = new BitArray(8); // 00000000
        bits4.Set(2, true); // Set the bit at index 2 to true
        bits4.Set(5, true); // Set the bit at index 5 to true
        bits4[7] = true;    // Set the bit at index 7 to true
        bits4[3] = false;   // Set the bit at index 3 to false


        Console.WriteLine("\nbits4 content: " + BitArrayToString(bits4));
        for (int i = 0; i < bits4.Count; i++)
        {
            bool bitVal = bits4[i];
            Console.WriteLine($"Bit at index {i}: {bitVal}");
        }

        bits4.SetAll(true); // Set all bits to true
        Console.WriteLine("\nbits4 content after setting all to true: " + BitArrayToString(bits4));
        for (int i = 0; i < bits4.Count; i++)
        {
            bool bitVal = bits4[i];
            Console.WriteLine($"Bit at index {i}: {bitVal}");
        }

        bits4.SetAll(false); // Set all bits to false
        Console.WriteLine("\nbits4 content after setting all to false:" + BitArrayToString(bits4));
        for (int i = 0; i < bits4.Count; i++)
        {
            bool bitVal = bits4[i];
            Console.WriteLine($"Bit at index {i}: {bitVal}");
        }

        bool bitValue = bits4[3]; // Get the value of the bit at index 3
        int length = bits4.Length; // Get the number of bits in the BitArray

        // Iterating Through a BitArray
        BitArray bits5 = new BitArray(8);
        bits5.SetAll(true);

        Console.WriteLine("\nbits5 content: " + BitArrayToString(bits5));
        for (int i = 0; i < bits5.Count; i++)
        {
            bool bitVal = bits5[i];
            Console.WriteLine($"Bit at index {i}: {bitVal}");
        }
        Console.ReadKey();
    }
}
```












## <span style="color:rgb(112, 48, 160)">7.  Graph</span>







# need to search
- if  list is dynamic how it implmited by array
	
# Collection Interfaces

| **Interface** | **Inherits From** | **Description**                                                                                       |
| ------------- | ----------------- | ----------------------------------------------------------------------------------------------------- |
| `IEnumerable` | None              | Enables iteration over a collection.                                                                  |
| `ICollection` | `IEnumerable`     | Adds methods like `Add`, `Clear`, `Contains`, `Remove`, `CopyTo`, and provides a `Count` property.    |
| `IList`       | `ICollection`     | Adds methods to access  `indexes`.                                                                    |
| `IDictionary` | `IList`           | Adds methods  work with `key-value pairs`.                                                            |
| `ISet`        | `IDictionary`     | `no duplicate` elements in the collection.                                                            |
| `IComparable` | None              | Enables `comparing` objects to support `sorting or ordering`.                                         |
| `IQueryable`  | `IEnumerable`     | Enables LINQ queries, supports deferred execution, and allows query construction and execution later. |
-![[zRryk.png]]
## 1. IEnumerable
### note 
- Enables iteration over a collection
- 

## 2. ICollection
## 3. IList
## 4. IDictionary
## 5. ISet
## 6. IComparable
## 7. IQueryable 
- IQueryable is also like IEnumerable and is use to iterate sql query collection
   from data. It is under SYSTEM.LINQ namespace
- go to the database, filter the data in Db then return value








