
### First Part
- Q 53. WHAT IS AN ASSEMBLY? WHAT ARE THE DIFFERENT TYPES OF
   ASSEMBLY IN .NET?
   R:Mitgitor
- Q 61. MultyTHREAD
- Q 71. Trigger in sql
- Q 81-85 .Index type
- Q 86-87 . stored prosudure vs function
- Q 88 .Cursor in sql
### secend part
- Q 6. VIRTUAL 
- Q 7. DESTRUCTOR
- Q 16-19 . delegetion

### out off pdf 
- Exeptions in .net
- Event and delegetion
- Big o in data structure
- lazay loding and edageloding in ef core
- sql profiler
- middleware vs fillter
- abstraction class
- encapsouation in opp why use
- 


### Do
- Leet code 30M
- sql in Mitgitor affter 50 leetcode
- Docker 1H
- see DSE 1H
- solid princeple



###### If you have a class in C# and you don't want anyone to create an instance (object) of that class?
- Private Constructor
- Static Class
- Abstract Class
- signiltor pattern


###### put vs PATCH

|**Aspect**|**PUT**|**PATCH**|**UPDATE**|
|---|---|---|---|
|**Purpose**|Replaces the entire resource with the provided data.|Partially modifies the resource with the provided data.|Typically not a separate HTTP method; handled via PUT or PATCH.|
|**Idempotency**|Idempotent – sending the same request multiple times results in the same outcome.|Idempotent (in theory) but may vary based on implementation.|Varies depending on method used (PUT/PATCH).|
|**Data Sent**|Requires the complete representation of the resource.|Requires only the fields to be updated.|Depends on whether PUT or PATCH is used.|
|**Usage Scenario**|When replacing or updating the entire resource is necessary.|When updating specific fields or parts of a resource.|Often refers generically to modifying data (PUT/PATCH).|
|**Request Example**|`PUT /books/1` with the entire book details.|`PATCH /books/1` with only the fields to modify (e.g., title or author).|Context-dependent (PUT or PATCH).|



1. **PUT**:
    
    ``` c$
    PUT /books/1
    {
      "title": "New Title",
      "author": "Author Name",
      "publisher": "Publisher Name"
    }
//    Replaces the entire book with the new data.
    ```

2. **PATCH**:
``` c#
 PATCH /books/1
    {
      "title": "New Title"
    }
 //  Updates only the `title` field of the book.
    ```
    
3. **UPDATE**:
    
//This term isn't an official HTTP method but is commonly used to describe **modifying resources**, typically implemented with **PUT** or **PATCH**.




###### 