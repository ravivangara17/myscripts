
object, class, and method which will be used quite frequently from then on
 Arrays and Hashes, which are data structure

how objects and classes relate to each other, how methods can be called on objects, and explores a number of different methods

Writing Methods

While variables give names to things, methods give names to behaviour. Methods are like the swiss-army knife of programming. We’ll have a look at the anatomy of a method, and learn how we can define our own ones.
6. Writing Classes

Blocks

*** Blocks are a super powerful feature in Ruby. We love them, and use them everywhere. Many built-in methods use them, too. So it’s good to introduce them now.
Blocks are like methods that don’t have a name, and they are passed when calling actual method

“ideas” are called classes. And actual “things” are called objects.
where Idea =  human being
	object =  tom, harry, john, jane

*** Classes are like ideas, objects are concrete things, manifestations of their ideas.

 Ruby has classes for numbers, strings (text), and other useful things. 

*** 
Methods are an object’s behaviour
E.g. "hello".upcase calls the method upcase on the String "hello".
methods that belong to (are defined on) objects can be used (called) by adding a dot, and then the method name, like so:
object.method
 name.upcase
 name.downcase
 name.length
Most methods are questions, and return a relevant value.
Some methods are commands, and change the object, or the system (e.g. by saving a file).



*** A name on the left side of the assignment operator = is assigned to the object on the right side.
number = 1

*** Ruby evaluates the expression on the right first. 
number = 2 + 3 * 4
puts number


*** data types:
Numbers
Strings (texts)
True, False, and Nil
Symbols
Arrays
Hashes

*** Strings can be defined by enclosing any text with single or double quotes.

> "hello".upcase
=> "HELLO"

> "hello".capitalize
=> "Hello"

> "hello".length
=> 5

> "hello".reverse
=> "olleh"

*** A symbol is created by adding a colon in front of a word.
:something


*** An Array is an object that stores other objects.
words = ["one", "two", "three"]
puts words[1]

*** Arrays start with the index 0, not 1.

*** appending an element to array
words << "four"
or
*** setting an element to a position
words[3] = "four"

*** Nested Array
[
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [0]
]

*** add two arrays
$ irb
> [1, 2] + [3, 4]
=> [1, 2, 3, 4]


*** Intersection of array
irb
> [1, 2, 3] & [2, 3, 4]
=> [2, 3]


***
first and last are alternative ways to retrieve the first and last element:
$ irb
> [1, 2, 3].first
1
> [1, 2, 3].last
3


[1, 2, 3].length
=> 3

> [3, 1, 2].sort
=> [1, 2, 3]

> [1, nil, 2, 3, nil].compact
=> [1, 2, 3]

> [1, 2, 3].index(3)
=> 2

> [1, 2, 3, 4].rotate(2)
=> [3, 4, 1, 2]

> [[1, 2, 3], [4, 5, 6], [7, 8, 9]].transpose
=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]


***A Hash is created by listing key/value pairs, separated by hash rockets, and enclosed by curly braces.
dictionary = { "one" => "eins", "two" => "zwei", "three" => "drei" }
dictionary["zero"] = "null"
puts dictionary["zero"]


