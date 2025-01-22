# Need to review:
- font in html 
- 




# <span style="color:rgb(112, 48, 160)">Units</span> 

``` css
1. px

2. em
 - 1em = font-size of parent element
 - If the font size of the parent element is `20px`:
    - 1em = 20px
    - 3em = 60px

3. rem
 - 1rem = font-size of root element
 - If the root(Html) font size is `20px`:
    - 1rem = 20px
    - 3rem = 60px

1. %
 - if 100% is 100% of parent element
 - if the font of parent = 20px , 50% = 10px  , 200% = 40px

2. vw => viewport width
 - if the website width = 100  , 15vw = 15 % 

3. vh => viewport height
 - if the website height = 100  , 15vh = 15 %  
```

1. **<span style="color:rgb(112, 48, 160)">`px`</span> (Pixels)**  
   - A fixed unit that represents individual screen pixels.

2. **<span style="color:rgb(112, 48, 160)">`em`</span> (Relative to Parent)**  
   - Based on the font size of the parent element.  
   - Example:  
     - Parent font size = `20px`:  
       - `1em = 20px`  
       - `3em = 60px`

3. **<span style="color:rgb(112, 48, 160)">`rem`</span> (Relative to Root)**  
   - Based on the font size of the root element (`html`).  
   - Example:  
     - Root font size = `20px`:  
       - `1rem = 20px`  
       - `3rem = 60px`

4. **<span style="color:rgb(112, 48, 160)">`%`</span> (Percentage)**  
   - Relative to the size of the parent element.  
   - Example:  
     - Parent font size = `20px`:  
       - `50% = 10px`  
       - `200% = 40px`

5. **<span style="color:rgb(112, 48, 160)">`vw`</span> (Viewport Width)**  
   - A percentage of the browser's viewport width.  
   - Example:  
     - Viewport width = `100vw`:  
       - `15vw = 15% of viewport width`

6. **<span style="color:rgb(112, 48, 160)">`vh`</span> (Viewport Height)**  
   - A percentage of the browser's viewport height.  
   - Example:  
     - Viewport height = `100vh`:  
       - `15vh = 15% of viewport height`

# <span style="color:rgb(112, 48, 160)">Display</span>

```
            1. Display Block
            - Takes 100% width of website
            - respect margin & padding & width & height
            - respect line breakp

            2. Display Inline
            - Takes width of element only
            - don't respect width & height
            - respect padding & margin [from left & right only]
            - don't respect line break

            3. Display Inline-Block
            - Take width of element only
            - don't respect line break
            - respect margin & padding & width & height

            4. Display none
            - Removes element from HTML

            5. visabilty hidden
            - hide element from HTML 
```

![[https___dev-to-uploads.s3.amazonaws.com_uploads_articles_h0y0cf2fj9m16wpv7y2n.jpg]]

# <span style="color:rgb(112, 48, 160)">general topics</span>

==**Padding:** ==The space between the border and text
``` css
padding: 10px 20px 30px 40px; 
/*Top 10px,Right 20px,Bottom 30px,Left 40pxlike hands of a clock*/
padding: 10px 20px;
/* Top & Bottom 10px, Right & Left 20px */
padding:10px 30px 50px;
/*Top 10px,Right 30px,Bottom 50pxpx,Left == Right  */
```
- padding be like **`(top, right ,bottom ,left)`** Like the hands of a clock.
**==Margin==:** The space between the element and the browser or other elements
**==Margin auto==**
 To center an element, set `margin-left` and `margin-right` to `auto`.
 it centers the element itself, not its content.
 It only centers horizontally (row).


###### **background**
 ```
 
div {
  background-image: url("background-image.jpg");
  background-size: cover;
  cover :Resize the background image to cover the entire container
}
```







# <span style="color:rgb(112, 48, 160)">Box Sizing</span>
**==box-sizing==** property allows us to include the padding and border in an element's total width and height.like if element=300 and border 5 make all element's size =300.
```css
(box-sizing: border-box;
```

to use in all project use
```css
* {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}
```


# <span style="color:rgb(112, 48, 160)">selectors</span>

### 1. **Uniqueness**

- **`id`**:
    - An `id` should be unique within a page. It is used to identify a single, specific element.
    - Example:
        
        ```html
        <div id="header">Header</div>
        ```
        
        ```css
        #header {
            background-color: blue;
        }
        ```
        
- **`class`**:
    - A `class` can be shared by multiple elements. It is used to style multiple elements that share the same class.
    - Example:
        
        ```html
        <div class="box">Box 1</div>
        <div class="box">Box 2</div>
        ```
        
        ```css
        .box {
            background-color: red;
        }
        ```
        

### 2. **Selector Syntax**

- **`id`**: Uses a `#` in the CSS selector.
- **`class`**: Uses a `.` in the CSS selector.

### 3. **Specificity**

- **`id`**: Has higher specificity than `class`. If both `id` and `class` are applied to the same element, the styles from the `id` will override the styles from the `class`.
    - Example:
        
        ```html
        <div id="header" class="box">Content</div>
        ```
        
        ```css
        #header {
            background-color: blue;
        }
        .box {
            background-color: red;
        }
        ```
        
        The background color will be blue because the `id` selector is more specific.

### 4. **Usage Guidelines**

- **`id`**:
    - Use for unique elements that only appear once on a page (e.g., header, footer, or a specific section).
- **`class`**:
    - Use for reusable styles applied to multiple elements (e.g., buttons, cards, or lists).

### 5. **JavaScript Interaction**

- Both `id` and `class` can be used for DOM manipulation, but `id` is more commonly used for single elements.
- Example:
    
    ```javascript
    // Access an element by ID
    document.getElementById("header");
    
    // Access elements by class
    document.getElementsByClassName("box");
    ```
    

### Summary Table

|Aspect|`id`|`class`|
|---|---|---|
|**Uniqueness**|Unique within a page|Can be used on multiple elements|
|**Selector Syntax**|`#id`|`.class`|
|**Specificity**|Higher specificity|Lower specificity|
|**Use Case**|Single, unique elements|Reusable styles|
|**JavaScript**|`getElementById`|`getElementsByClassName`|

In general, use `class` for styling and `id` for unique identification when necessary. Avoid overusing `id` for styling, as it can lead to less maintainable code.
# **<span style="color:rgb(112, 48, 160)">position</span>** 

| position   | main place | Place to move                                                       | additional things                                                       |
| ---------- | ---------- | ------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `static`   | Not Fixed  | No movement                                                         | efault mode                                                             |
| `relative` | Fixed      | Moves from its original place                                       |                                                                         |
| `absolute` | Not Fixed  | 1-move in inside his father<br>2-  browser window(if father static) | width fit content<br>                                                   |
| `fixed`    | Not Fixed  | browser window                                                      | width fits content<br>Moves with scrolling<br>like nav par in scrolling |
| `sticky`   | Fixed      | Moves between its position and its container while scrolling        | Moves between its position and its container while scrolling            |
![[FgYfF87aEAASpIa.jpg]]

# <span style="color:rgb(112, 48, 160)">overflow</span>

The `overflow` property in CSS is used to manage content that exceeds the specified width or height of an element.

![[overflow-visible.webp]]

![[css-overflow-hidden.webp]]

![[css-scroll.webp]]

![[css-overflow-auto.webp]]
# <span style="color:rgb(112, 48, 160)">Transition</span>
 **==transition-duration:==**  the time of transtioning
**==transition-property: ==**   the type of Transition you want like margin-top or width 
 **==transition:==**  width , hight , duration , timing-function ,
**==transition-timing-function:==**  roperty specifies the speed curve of the transition effect. like  start fast the slow    tyeps https://www.w3schools.com/cssref/css3_pr_transition-timing-function.php


# <span style="color:rgb(112, 48, 160)"> Flexbox</span>
## <span style="color:rgb(112, 48, 160)"> 1-Flex for Parents</span>
![[css-flexbox-poster.png]]
#### <span style="color:rgb(192, 0, 0)">1.  Display Flex</span>
==**display: inline-flex==;** => to  make the width and hight of  father = width and hight  element's 
#### <span style="color:rgb(192, 0, 0)">2.  flex-direction</span>
**==flex-direction==**: row => Default Value , it dependes of the deraction of page ,(<span style="color:rgb(0, 176, 80)">row,column, row-reverse ,column-revers</span>,)
#### <span style="color:rgb(192, 0, 0)">3.  flex-wrap</span>
**==flex-wrap: ==** allows its items to wrap onto the next line when there isn’t enough space in the row.  (<span style="color:rgb(0, 176, 80)">wrap , nowrap(default) ,wrap-revers</span>,)
#### <span style="color:rgb(192, 0, 0)">4.  align-items or content</span> 
```css
if flex-direction == row
   jusitify-content => x
   align-item => y
   align-content => y


if flex-direction == column
   jusitify-content => y
   align-item => x
   align-content => x

```
align-items: stretch(fit content) => Default Value
align-content: stretch(fit content) => Default Value
stretch : the element=width and hight of father
it's the opsits of   justify-content in direction

| align-items                    | align-content                            |
| ------------------------------ | ---------------------------------------- |
| work any thing                 | should make  flex-wrap = wrap            |
| make big space bettwen content | work in all content as one,without space |

#### <span style="color:rgb(192, 0, 0)">5.   justify-content</span>
- flex-start => Default Value
-  to control the direction in  ***<span style="color:rgb(255, 255, 0)">x</span>*** (if it row), <span style="color:rgb(255, 255, 0)">y</span> (if it columns)
- (<span style="color:rgb(0, 176, 80)">start , end , center</span> )  
-  (<span style="color:rgb(0, 176, 80)">space-between ,  space - around , space-evenly</span>)
- it dependes of the deraction of page
 
#### <span style="color:rgb(192, 0, 0)"> 6. <span style="color:rgb(192, 0, 0)">flex-flow:</span></span>
**==flex-flow:==** [Flex-Direction] + [Flex-Wrap]
```css
flex-flow:column wrap;
```
 
#### <span style="color:rgb(192, 0, 0)"> 7. <span style="color:rgb(192, 0, 0)">gap:</span></span>
**==gap:==** size of the gap between the rows and between the columns in flexbox,alternative  the margin
## <span style="color:rgb(112, 48, 160)"> 2-Flex for Items</span>
#### <span style="color:rgb(192, 0, 0)">1.  align-self</span>
-  property specifies the  direction for item 
- stretch => Default
- (<span style="color:rgb(0, 176, 80)">center,flex-start,flex-end</span>)

#### <span style="color:rgb(192, 0, 0)">2.  flex-grow</span>
- flex-grow: property specifies how much the item will grow In the father's empty space
- Dafault = 0;

#### <span style="color:rgb(192, 0, 0)">3.  flex-shrink</span>
**==flex-shrink:==** property specifies how the item will shrink relative to the rest of the flexible items inside the same container,
- Default  == 1;
- to  avoid shrink by give value =0;
- biggest shrink value first emlemnt of shrink. 
#### <span style="color:rgb(192, 0, 0)">4.  flex-basis</span>
`flex-basis` 
```css
flex-direction = row
  flex-basis => y (width)
flex-direction = column
  flex-basis => x (hight)
```

| flex-basis                                                                                                 | width |
| ---------------------------------------------------------------------------------------------------------- | ----- |
| in control the width untill the flex-direction = row<br>but if flex-direction = column it control in hight |       |
#### <span style="color:rgb(192, 0, 0)">5.  order</span>
- **==order:==** it It controls the order of elements through the largest number 
- Default in all items  ==  0
- 



 





# <span style="color:rgb(112, 48, 160)">  Grid</span>
![[css-grid-poster.png]]

- should give display: grid to the parent
- fr : take all empty spce
- auto : take minmam size(fit content) . 
- Auto Fill: is a value used with the `repeat()` function in `grid-template-columns` or `grid-template-rows`. It automatically creates as many columns or rows as will fit within the container, based on the specified size, while leaving space for additional columns or rows if available.
#### <span style="color:rgb(192, 0, 0)">Parent</span>
#### 1- grid-template-columns:
```css
grid-template-columns: 100px 50px 500px;

grid-template-columns: 10% 40% 50%;

grid-template-columns: repeat(5, 100px); 

/* Repeat 6 columns, each 100px wide, with a minmax constraint */ grid-template-columns: repeat(6, 100px) minmax(100px, 300px);
```
- grid-templeate:grid-template-rows / grid-template-columns
#### 2- grid-template-rows:
```css
grid-template-rows: 100px 50px 500px;

grid-template-rows: 10% 40% 50%;

grid-template-rows: repeat(5, 100px);

/* Repeat 6 rows, each 100px high, with a minmax constraint */
grid-template-rows: repeat(6, 100px) minmax(100px, 300px);

```
- to make Auto and fr work with row should give the parent hight . 
- grid-templeate:grid-template-rows / grid-template-columns
#### 3- gap
```css
row-gap:30px;
column-gap:50px;
gap:30px 50px;/* gap: Row Gap + Column Gap */

```

#### 4- justify-content :
  -  work only in x (row)
  -  Doesn't work with `fr` units because they take all available space.
  -  (<span style="color:rgb(0, 176, 80)">start , end , center</span> )   (<span style="color:rgb(0, 176, 80)">space-between ,  space - around , space-evenly</span>)
#### 5- align-content : 
  -  work only in y (column).
  -  (<span style="color:rgb(0, 176, 80)">start , end , center</span> )   (<span style="color:rgb(0, 176, 80)">space-between ,  space - around , space-evenly</span>).
  -  Doesn't work if the parent doesn't have a height because there is no   space to distribute.

#### 5- place-content:
``` css
/* <align-content-value> <justify-content-value>; */
place-content: space-between start; 

/* <align-content-value> <justify-content-value>; */
place-content:center;
```

#### <span style="color:rgb(192, 0, 0)">Child</span>
#### grid-column: + grid-row: 
``` css
grid-column:1/6  /*(Grid-Column-Start / Grid-Column-End)*/

grid-row:1/6     /*(Grid-row-Start / Grid-row-End)*/

grid-area: 1 / 1 / 6 / 6;                                       /*(Grid-Row-Start / Grid-Column-Start / Grid-Row-End/ Grid-Column-End)  */

grid-column: 1 / -1; 
/* Starts at the first column and spans to the last column */

grid-row: 1 / -1; 
/* Starts at the first row and spans to the last row */



```

- **`-1`** represents the **end of the grid**.

#### grid-template-areas:
this a full exemple of grid-templeet-areas
https://elzero.org/css-grid-parent-complete-layout-with-template-areas/
# <span style="color:rgb(112, 48, 160)">2D Transforms</span>

real exemple https://css-tricks.com/almanac/properties/t/transform/
![[transform.png]]
####  translate
- ==**translate()**== method moves an element from its current position(x,y) as inmation <span style="color:rgb(255, 255, 0)">.it better than posation </span>
``` css

/* Moves the element 10px in both x and y directions */
transform: translate(10px, 10px); 
/* or you cany use without translate to be like*/
transform: 10px 10px;

/* Moves the element 10px to the right (x axis) */
transform: translateX(10px);

/* Moves the element 10px downward (y axis) */
transform: translateY(10px);

```
#### scale
- Scale is similar to zooming in and out.
- The default value is `scale(1)`.
``` css
/* Scales the element by 10 times in both x and y directions */ transform: scale(10);

/* or dircit write*/ 
scale:10;

/* Scales the element 10 times along the x-axis */ 
/* This method increases or decreases the width of an element. */ transform: scaleX(10);


/* Scales the element 10 times along the y-axis */ 
/* This method increases or decreases the height of  element. */ transform: scaleY(10);

```

|          | `width`                                                | `scaleX`                                              |
| -------- | ------------------------------------------------------ | ----------------------------------------------------- |
| Affects  | Only the element's width                               | The element's width and its content                   |


#### rotate
- ==**rotate()**== method rotates an element ( deg  , turn );
``` css
/* Rotates the element by a specified angle (clockwise) */
transform: rotate(45deg); 

/* or dircit write*/ 
rotate:10eg;

/* Rotates the element around the x-axis by a specified angle */
transform: rotateX(45deg); 

/* Rotates the element around the y-axis by a specified angle */
transform: rotateY(45deg); 

```

#### skew

```css
/* Skews the element by 30 degrees along the X-axis and 29 degrees along the Y-axis */
transform: skew(30deg, 29deg);

/* Skews the element by 30 degrees along the X-axis */
transform: skewX(30deg);

/* Skews the element by 30 degrees along the Y-axis */
transform: skewY(30deg);

```

#### matrix
``` CSS
transform: matrix(1, 0.5, 0.5, 1, 20, 30);
(scaleX(), skewY(), skewX(), scaleY(), translateX(), translateY())

```
- ==**matrix()**==  




# <span style="color:rgb(112, 48, 160)">3D Transforms</span>

|                    |                                                                                                |                                                        |
| ------------------ | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| transform-origin   | Allows you to change the position on transformed elements                                      | transform-origin: x, y,z \|  initial\|inherit;         |
| perspective        | Specifies the perspective on how 3D elements are viewed\|                                      | perspective:300px                                      |
| perspective origin | which position the user is looking at the 3D-positioned element. ith the perspective property! | perspective-origin: _x-axis y-axis_\|initial\|inherit; |



# <span style="color:rgb(112, 48, 160)">animation</span>

```css 
animation-name: change-colore;
animation-duration: 6s;
animation-iteration-count: infinite;
animation-timing-function: linear;
animation-duration:alternate;    /*start then  revers to start*/
animation-delay: 2s;
animation-fill-mode: forwards;  /*make it take last colore*/
animation-play-state: paused;  /*control paused start animation */
animation: coloring 3s linear 2s infinite reverse;

@keyframes change-colore {
  0% {
    background-color: red;
  }
  100% {
    background-color: gainsboro;
  }
}```

  
  

 











# <span style="color:rgb(112, 48, 160)">Selectors</span>

```css
Element + Other Element => [div + p] 
/* Element should have before and after him the Other Element  */
Element ~ Other Elements => [p ~ div]
/**/
[Attribute]
/*Selects all elements with a target attribute*/
Element[Attribute]
/*like div[title]*/
[Attribute=Value]
/*[title="s01"]*/
Element[Attribute=Value] => input[type="submit"]
[Attribute~=Value] => Contains A Word
/*Selects all elements attribute containing the split word */
[Attribute*=Value] => Contains A Atring
/* selects all  elements split sub any type of stirng*/
[Attribute^=Value] => Start With A String
/*selects all  string start with value*/
[p:first-child] [p:last-child] => child:nth-child(2)
[
] [p:nth-last-child(2)] =>/*Get from last*/

[p:last-of-type] [p:first-of-type]
[p:nth-last-of-type] [p:nth-of-type]
 
[p:only-child]
[p:not(:Selectors)]


[p::checked] [p::empty]
[p::Disabled] [p::required]
[p::focus]  

```
 

# <span style="color:rgb(112, 48, 160)">Responsive</span>
- - **`max-width: 500px`**: Applies styles to elements only when the screen size is **500px or smaller**.
- **`min-width: 1000px`**: Applies styles to elements only when the screen size is **1000px or larger**.
```css
@media (min-width: 1400px) {
  .parent > div {
    background-color: blu
    e;
  }
}

@media (min-width: 1000px) and (max-width: 1400px) {
  .parent > div {
    background-color: blue;
  }
```





























       
       




    


 











 
 
 
 
 




















    
    









