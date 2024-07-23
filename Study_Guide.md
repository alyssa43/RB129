<h1>RB 129 Study Guide</h1>

<h2>Classes and Objects</h2>

We use a class to create an object. The class acts as a mold and determines what behaviors and attributes an object created from that class will have. The object itself is a unique and individual item that contains it's own attributes and behaviors within itself, so that it can then be used throughout our program.

To initialize a new object you must invoke the `#new` method on the class name that you wish to instantiate from, and if applicable pass any arguments required. To see if a class requires arguments upon instantiation you can look within the class at the constructor method, which is the `#initialize` instance method. When `#new` is invoked, Ruby is triggered to invoke that classes `#initialize` method.

```ruby
class Student
  def initialize(name)
    @name = name
  end
end

alyssa = Student.new('Alyssa')
```

In the above example we have created a new `Student` object by invoking the `#new` method on the class `Student`, which takes the String `'Alyssa'` as an argument. Because the `Student#new` method invocation invoke the `Student#initialize` method, the String `'Alyssa'` is what is being passed into the `Student#initialize` method, which then assigns the `@name` instance variable to reference the String `'Alyssa'`. A new local variable called `Alyssa` is then assigned to reference this new `Student` object. This entire process of creating a new object is known as instantiation.

<h2>States and Behavior</h2>

When defining a class, we may have important data that we want an object of that class to hold. This data represents the object's state and is held within the object's instance variables. The behavior of an object, on the other hand, is determined by the methods available to that object. By defining instance methods within our class, we enable specific behaviors for instances of that class. 

```ruby
class Student
  attr_reader :name
  
  def initialize(name)
    @name = name	# state
  end
  
  def study 		 # behavior
    "#{name} is studying"
  end
end

alyssa = Student.new('Alyssa')
bob = Student.new('Robert')

alyssa.name 	# => 'Alyssa' 
alyssa.study	# => "Alyssa is studying"

bob.name			# => 'Robert'
bob.study 		# => "Robert is studying"
```

In the above example, we have instantiated two new instances of the class `Student`. One is being referenced by the local variable `alyssa` and the other is being referenced by the local variable `bob`. Both objects have the ability to `study` which is provided by the `Student#study` instance method. However, each object has their own unique state that is being held within the `@name` instance variable. `alyssa` 's `@name` instance variable references the String `'Alyssa'`, while `bob`'s `@name` instance variable references the String `'Robert'`. This example demonstrates how different objects of the same class will share behaviors but have their own unique state.

<h2>Variables</h2>

<b>Instance Variables</b>: An instance variable is a variable that holds a value specifically correlated to an individual object. It begins with the `@` symbol and is scoped at the object level. Because it is scoped at the object level, that means that each individual object will have their own unique set of instance variables. An object's collection of their instance variables is known as that object's state.

```ruby
class Student
  attr_reader :name, :age, :current_course
  
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def set_current_course(course)
    @current_course = course
  end
end

alyssa = Student.new('Alyssa', 35)

p alyssa.name # => 'Alyssa'
p alyssa.age  # => 35
p alyssa.current_course # => nil
```

In the above example we have created a new instance of the `Student` class and assigned a new local variable called `alyssa` to reference this object. When we refer to `alyssa`'s state we are referring to the instance variables within that object. Which in this case are the instance variables `@name`, `@age`, and `@current_course`. This example shows how instance variables differ from local variables because when we reference an uninitialized instance variable, in this case `@current_course`, `nil` is returned. Whereas if we tried to reference an uninitialized local variable we would receive a `NameError` exception.

<b>Class Variables:</b> A class variable is a variable that starts with `@@` and is scoped at the class level, meaning that it is shared between all instances of that class. 

```ruby
class Student
  @@total_students = 0 # initializing class variable
  
  def initialize(name)
    @name = name
    @@total_students += 1 # incrementing class variable by 1 with each new instance
  end
  
  def self.total_students
    @@total_students	# accessible within a class method
  end
  
  def total_students
    @@total_students	# accessible within an instance method
  end
end

Student.total_students	# => 0

alyssa = Student.new('Alyssa')

p alyssa.total_students	 # => 1
p Student.total_students # => 1

bob = Student.new('Robert')

p bob.total_students     # => 2
p alyssa.total_students	 # => 2
p Student.total_students # => 2
```

In the above example, the `Student` class has a class variable called `@@total_students` that is initialized on line 2 within the `Student` class definition. With each new instance of the `Student` class, the `@@total_students` variable is incremented by `1`. We can then access this class variable within class and instance methods (as long as the class variable has been initialized). This class variable is then shared by all instances of the `Student` class. Because this is a shared variable, we must be careful not to accidentally modify it. Which is why if working with inheritance, it is recommended to not use class variables. EX:

```ruby
class Guitar
  @@strings = 6
  
  def self.strings
    @@strings
  end
end

Guitar.strings # => 6

class Ukulele < Guitar
  @@strings = 4
end

Ukulele.strings # => 4
Guitar.strings  # => 4 
```

Because the `Ukulele` class subclasses the `Guitar` class, and because class variables are shared between all instances of that class and it's subclasses, when we try to create a new class variable called `@@strings` specific to the `Ukulele` class, we are actually reassigning the `@@strings` class variable within the `Guitar` class. This example demonstrates how class variables are shared within the inheritance hierarchy, which can cause undesired side effects. In most cases, instance variables are a better option when working with inheritance.

<b>Constants:</b> A constant variable is a variable that typically is in all uppercase letters, although technically they only need to have the first letter uppercased. Constant variables should never be changed, however Ruby will allow you to but it will warn you when doing so. They have a lexical scope, which means that where the constant variable is defined determines where it is available. When a reference to a constant variable is being resolved, Ruby first searches the current structure. If it is not found within that structure Ruby then travels up the inheritance hierarchy chain where the constant is being referenced. If Ruby searches the entire hierarchy chain and it is not found, Ruby then searches the top level scope.  EX:

```ruby
```



===========

Constant variables are variables that begin with an uppercase letter, although they are more commonly in all uppercase letters, and they have a lexical scope. Lexical scope means that where the constant is defined in the source code determines what it is available. They are called constants because they are a variable that should never be changed. If you do attempt to reassign a constant Ruby will warn you, but will not generate an error. When resolving a constant Ruby first searches the surrounding structure of the constant reference. If the constant is not found there, Ruby then traverses up the inheritance hierarchy of the structure that references the constant. If the constant is still not found, Ruby will then search the top level scope. EX:

```ruby
DOG_YEARS = 7

class Animal; end
class Dog < Animal
  def initialize(age)
    @age = age
  end
  
  def age
    DOG_YEARS * @age
  end
end

sparky = Dog.new(4)
puts sparky.age # => 28
```

In the above example, when ruby tries to resolve the constant reference on line 11 within the `age` instance method definition, it first searches within the `Dog` class, which remains unresolved because it is not found there. It then searches up the inheritance chain which would be the classes: `Animal`, `Object`, `Kernel`, `BasicObject`, none of which are able to resolve the constant because it is not found within those classes. Finally, it searches the top level (outer most scope of our program); which is where it is finally found and able to be resolved.

<h2>Getter & Setter Methods</h2>

Getter and setter metohds give us a way to expose and change an object's state. We can also use these methods from within the class as well. Accessor methods within a class allow us to retrieve (getter) and/or change (setter) an instance variable for an object. Without getter and setter methods, if we tried to retrieve or change an instance variable we would receive a `NoMethodError` exception. EX:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
end

sparky = GoodDog.new('Sparky')

puts sparky.name # => NoMethodError
```

To retrieve the `@name` instance variable we need to add a getter method to our `GoodDog` class:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
  
  def name # getter method
    @name
  end
end

sparky = GoodDog.new('Sparky')

puts sparky.name # => Sparky
```

And to be able to modify the `@name`instance variable we need to add a setter method to our `GoodDog` class:

```ruby 
class GoodDog
  def initialize(name)
    @name = name
  end
  
  def name # getter method
    @name
  end
  
  def name=(new_name) # setter method
    @name = new_name
  end
end

sparky = GoodDog.new('Sparky')
puts sparky.name # => Sparky 
sparky.name = 'Fido' # invoking the setter method
puts sparky.name # => Fido
```

<i>*Note: setter methods always return the value passed to it as an arugment, regardless of what happens inside the method. If the setter tried to return something other than the argument's value, it just ignores that attempt.</i>

Because accessor methods are so commonplace, Ruby has a built-in way to automatically create these getter and setter method for us, using the `attr_*` methods. To create a getter method we use `attr_reader`, and to create a setter method we use `attr_writer`. Or if we'd like to create both at the same time we can use `attr_accessor`. EX:

```ruby
class GoodDog
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end

sparky = GoodDog.new('Sparky')
puts sparky.name # => Sparky 
sparky.name = 'Fido' # invoking the setter method
puts sparky.name # => Fido
```

<h2>Instance Methods vs. Class Methods</h2>

<b>Instance Methods:</b> We are able to give our classes <i>behaviors</i> with instance methods. All objects of the same class have the same behaviors (though they contain different <i>states</i> (i.e., instance variables)).

```ruby
class Person
  def initialize(name)
    @name = name
  end
  
  def speak
    "Hello, my name is #{@name}"
  end
end

puts Person.new('Alyssa').speak #=> Hello, my name is Alyssa
```

In this example we have an instance method called `speak`. All `Person` objects will have the ability to `speak` because this instance method gives the `Person` class that behavior. 

<b>Class Methods:</b> Class methods are methods we can call directly on the class itself, without having to instantiate any objects. When defining a class method, we prepend the method name with the reserved word `self.`like this:

```ruby
class Person
  @@total_people = 0 # class variable
  
  def initialize
    @@total_people += 1
  end
  
  def self.total_people # class method
    @@total_people
  end
```

Then we can call the class method by using the class name followed by the method name, without even having to instantiate any object, like this:

```ruby
Person.total_people # => 0
```

Class methods are where we put functionality that does not pertain to individual objects. Objects contain state, and if we have a method that does not need to deal with states, then we can just use a class method, like this example.

<h2>Method Access Control</h2>

Access control is a concept that exits in a number of programming languages, including Ruby. It is generally implemented through the use of <i>access modifiers</i>. The purpose of access modifiers is to allow or restrict access to a particular thing. In Ruby, the things that we are concerned with restricting access to are the methods defined in a class. In a Ruby context, therefore, you'll commonly see this concept referred to as <b>method access control</b>. 

The way that Method Access Control is implemented in Ruby is through the use of the `public`, `private`, and `protected` access modifiers. A `public` method is a method that is available to anyone who knows either the class name or the object's name. These methods are readily available for the rest of the program to use and comprise the class's <I>interface</I> (that's how other classes and objects will interact with this class and its objects).

Sometimes you'll have methods that are doing work in the class but don't need to be available to the rest of the program. These methods can be defined as `private`. `private` methods are only accessible from other methods in the class. In other words, `private` methods are not accessible outside of the class definition at all, and are only accessible from inside the class when called without `self`.

<I>Note: As of Ruby 2.7, it is now legal to call private methods with a literal `self` as the caller. Note that this does <b>not</b> mean that we can call a private method with any other object, not even one of the same type. We can only call a private method with the current object</I>.

`public` and `private` methods are most common, but in some less common situations, we'll want an in-between approach. For this, we can use the `protected` method to create protected methods. Protected methods are similar to private methods in that they cannot be invoked outside the class. The main difference between them is that protected methods allow access between class instances, while `private` methods do not. EX:

```ruby
class Person
  def initialize(name, age, dob)
    @name = name
    @age = age
    @dob = dob
  end

  def older?(other_person)	# public method
    age > other_person.age  # calling protected method for `self` and `other_person`
  end
  
   def born_first?(other_person) # public method
    dob[2] < other_person.dob[2] # calling private method for `self` and `other_person`
  end

  def public_disclosure	# public method
    "#{@name} was born in #{dob[2]}" # calling private method
  end

  protected

  attr_reader :age	# protected method

  private 

  attr_reader :dob	# private method
end

alyssa = Person.new('Alyssa', 34, [7, 14, 1989])
rich = Person.new('Rich', 36, [3, 14, 1988])

alyssa.older?(rich) # => false => calling public method that calls protected method
rich.older?(alyssa) # => true

alyssa.age # => NoMethodError: protected method `age` called for #<Person:0x000000010108b0b8 @name="Alyssa", @age=34>

alyssa.public_disclosure # => "Alyssa was born in 1989" => calling public method that calls private method

alyssa.dob # => NoMethodError: private method `dob' called for #<Person:0x000000010621a938 @name="Alyssa", @age=34, @dob=[7, 14, 1989]>

alyssa.born_first?(rich) # => NoMethodError: private method `dob' called for #<Person:0x000000010539a7a0 @name="Rich", @age=36, @dob=[3, 14, 1988]>
```

In the above example, we can see that Ruby allows us to call `protected` and `private` methods on the current object from within a public method inside of a custom class, however if we try to call those `protected` and `private` methods from outside of the class we see a `NoMethodError` exception. We can also see that when we call a `protected` method not just on the current object, but on an instance of the same class, we are able to access that method; as in the `born_first?` Instance method definition. However, if we try to access a `private` method on another instance of the same class, like in the `born_first?` instance method, we are unable to access that information and instead see a `NoMethodError` exception.

<h2>Class Inheritance</h2>

Inheritance (a way to achieve polymorphism) in Ruby is where a class inherits the behaviors from another class, referred to as the <b>superclass</b>. This give Ruby programmers the power to define basic classes with large reusability and smaller <b>subclasses</b> for more fine-grained, detailed behaviors. We can allow a class to inherit from another class when defining the subclass we include the `<` symbol to signify that the current class will inherit from the class to the right of the `<` symbol. This means that all of the method in the `Animal` class are available to the `Dog`, `Cat`, and `Fish` classes to use. EX:

```ruby
class Animal # superclass
  def move
    "I can move!"
  end
end

class Dog < Animal; end  # Dog subclass is inheriting from Animal superclass
class Cat < Animal; end	 # Cat subclass is inheriting from Animal superclass
class Fish < Animal; end # Fish subclass is inheriting from Animal superclass

puts Dog.new.move  # => I can move
puts Cat.new.move  # => I can move
puts Fish.new.move # => I can move
```

When dealing with inheritance, it is important to remember that methods can be overridden. EX:

```ruby
class Animal # superclass
  def move
    "I can move"
  end
end

class Dog < Animal; end  # subclass
class Cat < Animal; end	 # subclass
class Fish < Animal			 # subclass
  def move
    "I can swim"
  end
end

puts Dog.new.move  # => I can move
puts Cat.new.move  # => I can move
puts Fish.new.move # => I can swim
```

Above we have defined a `move` method within the `Fish` class which will override the inherited `move` method from within the `Animal` superclass. This happens because Ruby's <b>method lookup path</b> first searches the objects current class then continues up to path until the method is found and can be resolved. Another functionality of class inheritance is the use of the `super` keyword. Ruby provides us with the `super` keyword to call methods earlier in the method lookup path. When you call `super` from within a method, it searches the method lookup path for a method with the same name, then invokes it. EX:

```ruby
class Animal # superclass
  def move
    "I can move"
  end
end

class Dog < Animal; end  # subclass
class Cat < Animal; end	 # subclass
class Fish < Animal			 # subclass
  def move
    super + " by swimming"
  end
end

puts Dog.new.move  # => I can move
puts Cat.new.move  # => I can move
puts Fish.new.move # => I can move by swimming
```

A common use of using `super` would be with the `initialize` method. 

<i>Note: when `super` is used and arguments are required, it adds a twist to how `super` is invoked. When invoked with no arguments, `super` automatically forwards the arguments that were passed to the method from which `super` is called. If the current method accepts arguments, but the `super` method does not, you must invoke `super` specifically with no arguments: `super()`. If the arguments for the `super` method invocation are different from the current method's arguments, you must specific that as well.</i>

One of the limitations of class inheritance in Ruby is that a class can only directly sub-class from one superclass. We call this <b>single inheritance</b>. When we want to allow classes to inherit from multiple classes, a funtionality known as multiple inheritance, the answer is to mix in behaviors with modules. A class can only sub-class from one parent, but it can mix in as many modules (interface inheritance) as it likes. However, it is important to remember that mixing in modules does affect the method lookup path.

A couple things to consider when evaluating whether to use class inheritance vs interface inheritance are:

* As stated above, a class can only subclass (class inheritance) from one class. You can mix in as many modules (interface inheritance) as you'd like.
* If there's an "is-a" relationship, class inheritance is usually the correct choice. If there's a "has-a" relationship, interface inheritance is generally a better choice. For example, a dog "is an" animal and it "has an" ability to swim.
* You cannot instantiate modules. In other words, objects cannot be created from modules.

<h2>Encapsulation</h2>

Encapsulation is a form of data protection where data (state) and functionality (behavior) are combined into a single unit called an "object". By containing an object's state and behavior within itself, we can then pass these objects around in our program to use as needed. We can also choose to hide certain data, or expose it as needed, which helps in orgnizing and protecting the inner workings of our code.

<h2>Polymorphism</h2>

Polymorphism ("poly" => "many", "morph" => "forms") is the ability for different types of data to respond to a common interface. For instance, if we have a method that invoke the `move` method on it's argument, we can pass the method any type of argument as long as the argument has a compatible `move` method. The object might represent a human, a cat, a jellyfish, or, conceivably, even a car or train. That is, it lets obejcts of different types respond to the same method invocation. EX:

```ruby
class Animal
  def move
    "I can move!"
  end
end

class Dog < Animal; end
class Cat < Animal; end
class Fish < Animal; end

puts Dog.new.move  # => I can move
puts Cat.new.move  # => I can move
puts Fish.new.move # => I can move
```

In the above example we use <b>inheritance</b> to allow the `Dog`, `Cat`, and `Fish` class to all use the `move` method within the `Animal` class. Another way to achieve polymorphism is to use a <b>module</b>. Ruby allows us to define a `Module` and then mix it in to classes as we choose. EX:

```ruby
module Move
  def move
    puts "I can move"
  end
end

class Dog include Move; end
class Cat include Move; end
class Fish include Move; end

puts Dog.new.move  # => I can move
puts Cat.new.move  # => I can move
puts Fish.new.move # => I can move
```

In addition to using class inheritance (and mixing modules) to implement polymorphism, we can also achieve polymorphism through <b>duck typing</b>. Duck typing occurs when objects of different <u>unrelated</u> types both respond to the same method name. With duck typing, we aren't concerned with the class or type of an object, but we do care whether an object has a particular behavior. If an object quacks like a duck, then we can treat it as a duck. Specifically, duck typing is a type of polymorphism as long as the objects involved use the same method name and take the same number of arguments, we can treat the object as belonging to a specific category of objects. EX:

```ruby
class Wedding
  attr_reader :guests, :flowers, :songs
  
  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepar_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end
  
  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding_flowers)
  end
  
  def decorate_place(flowers)
    #implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end
  
  def prepare_performance(songs)
    #implementation
  end
end
```

Though there is no inheritance in the above example, each of the preparer-type classes provides a `prepare_wedding` method. We still have polymorphism since all of the objects respond to the `prepare_wedding` method call. If we later need to add another preparer type, we can create another class an implement the `prepare_wedding` method to perform the appropriate actions.

<I>Note that merely having two different objects that have a method with the same name and compatible arguments doesn't mean that you have polymorphism. In theory, those methods might be used polymorphically, but that doesn't always make sense. Unless you're actually calling the method in a polymorphic manner, you don't have polymorphism.</I>

<h2>Modules</h2>

Modules are one way to achieve polymorphism and to keep code DRY. A module is a collection of behaviors that are usable in other classes via <b>mixins</b>. A module is "mixed in" to a class by using the `include` method invocation.

```ruby
module Swimmable
  def swim
    "I'm swimming"
  end
end

class Animal; end

class Dog < Animal
  include Swimmable
end

class Fish < Animal
  include Swimmable
end

class Cat < Animal; end

puts Dog.new.swim  # => I'm swimming
puts Fish.new.swim # => I'm swimming
puts Cat.new.swim  # => NoMethodError
```

Mixing in modules to a class is sometimes known as <b>interface inheritance</b>. The class doesn't inherit from another class, but instead inherits the interface provided by the mixin module.

A common naming convention for naming modules in Ruby is to use the "able" suffix on whatever verb describes the behavior that the module is modeling.

Another concept related to modules is <b>namespacing</b>. Namespacing is when we organize smiliar classes under a module. In other words, we can use modules to group related classes together. Some advantages of namespacing are that it makes it easy to recognize related classes in our code as well as it reduces the likelihood of our classes colliding with other similarly named classes in our codebase. EX:

```ruby
module Animal
  class Dog
    def speak(sound)
      "#{sound}"
    end
  end
  
  class Cat
    def say_name(name)
      "#{name}"
    end
  end
end

# we call classes in a module by appending the class name to the module name with two colons (::) (method/constant resolution operator)

buddy = Animal::Dog.new
kitty = Animal::Cat.new
buddy.speak('Arf!')     # => "Arf!"
kitty.say_name('Kitty') # => "Kitty"
```

Another use case for modules is using modules as a <b>container</b> for methods, called module methods, that seem out of place within your code. This involves using modules to house other methods. EX:

```ruby
module Animal
  # ... resot of code omitted for brevity
  
  def self.some_out_of_place_method(num)
    num ** 2
  end
end

value = Animal.some_out_of_place_method(4) # preferred way
# or
value = Animal::some_out_of_place_method(4)
```

<h2>Method Lookup Path</h2>

The method lookup path is the path that Ruby takes when resolving a method invocation. Ruby will follow this distint path each time a method is invoked. To see the method lookup path for an object we can invoke the `#ancestors` method on that object. EX:

```ruby
class Animal; end
class Dog < Animal; end

Animal.ancestors # => [Animal, Object, Kernel, BasicObject]
Dog.ancestors 	 # => [Dog, Animal, Object, Kernel, BasicObject]
```

This means that when a method is invoked on an object of the `Dog` class, Ruby first searches within the `Dog` class, then travels up to the `Animal` class, and so on until the method is found, or if there is no method found within the method lookup path you will receive a `NoMethodError` exception.

 It is important to remember that mixing in modules does affect the method lookup path. EX:

```ruby
module Walkable
  def walk
    "I'm walking"
  end
end

module Swimmable
  def swim
    "I'm swimming"
  end
end

module Climable
  def climb
    "I'm climbing"
  end
end

class Animal
  include Walkable
end

class Dog < Animal
  include Swimmable
  include Climbable
end

Animal.ancestors # => [Animal, Walkable, Object, Kernel, BasicObject]
Dog.ancestors # => [Dog, Climbalbe, Swimable, Animal, Walkable, Object, Kernel, BasicObject]
  
```

We can see by this example, that the order in which we `include` modules within a class is important. For our `Dog` class method lookup path, Ruby first searches the `Dog` class, then searches the `Climbable` module, and then the `Swimable` module. We can see from this that Ruby will search the current class, then any mixed in modules starting with the last module included working its way up to the first module included. We can also see by this example that Ruby then searches the superclass `Animal` and then it's mixed in module `Walkable`. This is very important to remember in case there are method's within mixed in modules that have the same method name.

<h2>Method Overriding</h2>

Because of the way Ruby's method lookup path searches when resolving a method invocation; we are given the ability to override methods in other classes. One example of this is when working with sub-classes and superclasses. If you have a sub-class that inherits a `move` method from it's parent, but you do not want to use that inherited `move` method; you can write your own `move` method from within the sub-class. EX:

```ruby
class Animal # superclass
  def move
    "I can move"
  end
end

class Dog < Animal; end  # subclass
class Cat < Animal; end	 # subclass
class Fish < Animal			 # subclass
  def move
    "I can swim"	# This method definition overrides the one in the Animal class
  end
end

puts Dog.new.move  # => I can move
puts Cat.new.move  # => I can move
puts Fish.new.move # => I can swim
```

Because every class you create inherently subclasses from the `Object` class, and the `Object` class is built into Ruby and comes with many critical methods, it's possible to accidentally override important methods that you may need and do not intend to override. For example, `send` is an instance method that all classes inherit from `Object`. If you defined a new `send` instance method in your class, all objects of your class will call your custom `send` method, instead of the one in class `Object`, which is probably the one they mean to call. (`Object#send` serves as a way to call a method by passing it a symbol or a string which represents the method you want to call.) EX:

```ruby
class Parent
  def say_hi
    "Hi from Parent"
  end
end

class Child < Parent
  def say_hi
    "Hi from Child"
  end
  
  def send
    "send from Child..."
  end
end

Parent.new.send :say_hi # => "Hi from Parent"
Child.new.send :say_hi # => wrong number of arguments (given 1, expected 0) (ArgumentError)
```

Although, accidently overriding built-in methods is important to keep in mind; we can also use this to our advantage by purposely overriding built-in methods. One very common method which is frequently overriden on purpose is the `#to_s` method. This is useful to us when we want to have a specific output when invoking `#puts` on an object that is an instance of one of our classes. Calling `#puts` automatically calls `#to_s` on it's argument. EX:

```ruby
class Dog
  def initialize(name)
    @name = name
  end
end

sparky = Dog.new('Sparky')
puts sparky # => #<Dog:0x000000010a09f9b0>
```

Here when we invoke `#puts` on our `sparky` object we see an output of a string representation of our object. If we wanted to be able to see a specific output when invoking `#puts` on an object of our class we can override the `#to_s` method by defining our own `to_s` instance method within our class. EX:

```ruby
class Dog
  def initialize(name)
    @name = name
  end
  
  def to_s
    "This dog's name is #{@name}"
  end
end

sparky = Dog.new('Sparky')
puts sparky # => This dog's name is Sparky
```

When overriding `#to_s` within a custom class, you <b>must</b> remember that Ruby expects `#to_s` to always return a string. If your custom `#to_s` method does not return a string, it will not work as expected in places where `#to_s` is implicitly invoked like `#puts` and string interpolation. Instead of printing (or inserting) the value returned by `#to_s`, Ruby will ignore the non-string value and look in the inheritance chain for another version of the `#to_s` that does return a string. In most cases, it will use the value returned by `Object#to_s` instead. EX:

```ruby
class Foo
  def to_s
    42
  end
end

foo = Foo.new
puts foo							# => #<Foo:0x000000010335fa08>
puts "foo is #{foo}"	# => foo is #<Foo:0x000000010335fa08>
```

Other custom methods to be overridden within custom classes as those within the "fake operator" group (see below). 

<h2>self</h2>

`self` can refer to different things depends on where it is used. When `self` is referenced inside a class but outside of an instance method, it refers to the class itself:

```ruby
class GoodDog
  puts self # => GoodDog
end
```

Therefore, a method definition prefixed with `self` is the same as defining the method on the class.

```ruby
class GoodDog
  def self.a_method
    # this is equivalent to ...
  end
  
  def GoodDog.a_method
    # ... this
  end
end
```

That is why it's a class method; it's actually being defined on the class.

When `self` is referenced from within an instance method inside of a class, it refers to <i>the calling object</i>. 

```ruby
class GoodDog
  def what_is_self
    self
  end
end

sparky = GoodDog.new
p sparky.what_is_self # => #<GoodDog:0x00000001125260f8>
```

In other words:

```ruby
class GoodDog
  attr_accessor :name
  
  def initialize(name)
    self.name = name # In this example self refers to the object sparky
  end
end

sparky = GoodDog.new('Sparky')
```

In this example, `self.name =` acts the same as calling `sparky.name =` from outside of the class (but since we can't call `sparky.name = ` from inside the class because of scope). This is why using `self` to call instance methods from within the class works the way it does. 

<h2>Fake Operators and Equality</h2>

`==` : At the object level (`BasicObject#==`), this method returns `true` only if the two objects being compared are the same object. This means that this implementation is the same as `BasicObject#equal?`. Because the default implementation for `BasicObject#==` is not very useful, we can override this method by defining our own `==` custom instance method within a custom class. (When you define a custom `==` instance method, you also get the `!=` method for free.)



`equal?` : Compares two variables point to the same object.



`===` : used by `case` statements. Works by asking if the object being compared 'fits' within the group. For example, if we have ` (1..50) === 25` we are asking if 25 fits within a range of 1-50. Or, if we have `String === "hello"`, `true` would be returned. 

 

`eql?` : determines if two objects contain the same value and if they're of the same class.



<h2>Collaborator Objects</h2>

Collaboration is a way of modeling relationships between different objects. There are a number of different types of relationships discussed with regard to OOP. When referring to a collaborative relationship, it is one of association, which can be thought of as a "has-a" relationship. For example, a library has books, so there is an associative relationship between objects of class Library and objects of class Book. <I>A collaborative relationship is a relationship of association - NOT inheritance.</I> 

Because an object's state is saved in an object's instance variables, and because instance variables can hold any object; we can set an object's instance variable to reference an object of a custom class that we've created. EX:

```ruby
class Bulldog; end

class Person
  attr_accessor :name, :pet
  
  def initialize(name)
    @name = name
  end
end

bob = Person.new('Robert')
bud = Bulldog.new
bob.pet = bud
bob.pet # => #<Bulldog:0x000000010373ac90>
bob.pet.class # => Bulldog
bob.pet.speak # => "Bark!"
```

Here we have set `bob`'s `@pet` instance variable to `bud`, which is a `Bulldog` object. This means that when we call `bob.pet`, it is returning a `Bulldog` object. Because `bob.pet` returns a `Bulldog` object, we can chain any `Bulldog` methods at the end as well. 

Objects that are stored as state within another object are called "collaborator objects". We call such objects collaborators because they work in conjunction (or in collaboration) with the class they are associated with. 

In the above example, `bob` has a collaborator object stored in the `@pet` variable.

When working with collaborator objects in your class, you may be working with strings, integers, arrays, hashes, or even custom objects. Collaborator objects allow you to chop up and modularize the problem down into cohesive pieces; they are at the core of OO programming and play an important role in modeling complicated problem domains.