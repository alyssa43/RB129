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

In the above example we have created a new `Student` object by invoking the `#new` method on the class `Student`, which takes the String `'Alyssa'` as an argument. Because the `Student#new` method invocation invokes the `Student#initialize` method, the String `'Alyssa'` is what is being passed into the `Student#initialize` method, which then assigns the `@name` instance variable to reference the String `'Alyssa'`. A new local variable called `alyssa` is then assigned to reference this new `Student` object. This entire process of creating a new object is known as instantiation.

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

<b>Class Variables:</b> A class variable is a variable that starts with `@@` and is scoped at the class level, meaning that it is shared between all instances of that class (and it's subclasses). 

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

<b>Constants:</b> A constant variable is a variable that is typically in all uppercase letters, although technically only the first letter must be uppercased. Constant variables should never be changed, however Ruby will allow you to modify it, but it will warn you when doing so. They have a lexical scope, which means that where the constant variable is defined determines where it is available. When a reference to a constant variable is being resolved, Ruby first searches the current class or module. If it is not found within that structure Ruby then travels up the inheritance hierarchy chain where the constant is being referenced. If Ruby searches the entire hierarchy chain and it is not found, Ruby then searches the top level scope.  EX:

```ruby
PLANET = 'Earth' # Line 1

class Being
  def initialize(name)
    @name = name
  end
end

class Person < Being
  def to_s
    "Hello, my name is #{@name} and I live on #{PLANET}." # Line 11
  end
end

class Alien < Being
  PLANET = 'Mars' # Line 16
  
  def to_s
    "Hello, my name is #{@name} and I live on #{PLANET}."	# Line 19
  end
end

alyssa = Person.new('Alyssa')
puts alyssa # => Hello, my name is Alyssa and I live on Earth.

zim = Alien.new('Zim')
puts zim # => Hello, my name is Zim and I live on Mars.

Alien::PLANET  # => "Mars"
Person::PLANET # => NoMethodError - uninitialized constant called `PLANET` within `Person` class
```

In the above example, we have two different constants - both named `PLANET`. Because they are defined within different scopes, that is how we can know they are in fact different constant variables.

* The first `PLANET` constant variable to be initialized is on line 1 at the top level of our program, where it is assigned to reference the String `'Earth'`.
* The second `PLANET` constant variable to be initialized is on line 16 within the `Alien` class definition, where it is assigned to reference the String `'Mars'`.

When we invoke `puts alyssa`, we in turn invoke the `Person#to_s` method on our `Person` object `alyssa`, which outputs an interpolated String that references the constant `PLANET`. When Ruby tries to resolve this constant it:

- First searches the current class, which is the `Person` class, where it is not found.

- Then travels up the inheritance hierarchy, looking within the classes `Being`, `Object`, `Kernel`, and `BasicObject`, but still is not found.

- Finally, it searches the top level of our program, where it find the `PLANET` constant and returns the String `Earth`.

When we invoke `puts zim,` we in turn invoke the `Alien#to_s` method on our `Alien` object `zim`, which outputs an interpolated String that references the constant `PLANET`. When Ruby tries to resolve this constant it:

* First searches the `Alien` class, where it find the `PLANET` constant and returns the value it references which is the String `'Mars'`.

Finally, on the last two lines of code we use the scope resolution operator (`::`) to try and access the constants within the `Alien` and `Person` classes:

*  When we invoke `Alien::PLANET`, we are telling Ruby that we want to return the value referenced by the `PLANET` constant located within the `Alien` class, which returns the String `'Mars'`. 
* When we invoke `Person::PLANET,` we are telling Ruby that we want to return the value referenced by the `PLANET` constant located within the `Person` class. However, there is not a `PLANET` constant within the `Person` class definition, which is why we see a `NoMethodError` exception.

<h2>Getter & Setter Methods</h2>

Getter and setter methods are types of accessor methods. An accessor method is an instance method within a class that allows access to an instance variable within that class. It is used to retrieve and/or modify the data referenced by an instance variable.

* Getter methods are instance methods that (typically) return the value being referenced by an instance variable. Although, you are able to define your own custom getter methods that can return some variation of the value referenced by the instance variable if needed.
* Setter methods are instance method that allow you to modify the value of an instance variable. The value passed in as the argument upon invocation of a setter method will become the new value being referenced by the instance variable.

You can create your own accessor methods by defining them yourself, or you can use the shortcuts Ruby provides by using `attr_reader` for getter methods, `attr_writer` for setter methods, or `attr_accessor` for both a getter and a setter method.

```ruby
class Person
  attr_accessor :name # creates a getter & setter method for the `@name` instance variable

  def initialize(name, age)
    @name = name
    @age = age
  end

  def age # getter method for the `@age` instance variable
    @age
  end

  def age=(new_age) # setter method for the `@age` instance variable
    @age = new_age
  end
end

alyssa = Person.new('Alyssa', 34)

# returns value referenced by `@name`
p alyssa.name # => 'Alyssa'

# returns value referenced by `@age`
p alyssa.age # => 34

alyssa.name = 'Aly' # modifies value referenced by `@name`
alyssa.age = 35 # modifies value referenced by `@age`

# returns value referenced by `@name`
p alyssa.name # => 'Aly'

# returns value referenced by `@age`
p alyssa.age # => 35
```

If you try to access an instance variable that does not have an accessor method, you will receive a `NoMethodError` exception for trying to access an undefined method. EX:

```ruby
class Person
  def initialize(name)
    @name = name
  end
end

alyssa = Person.new('Alyssa')
alyssa.name # => NoMethodError: undefined method `name` for `Person` object
```

<i>*Note: setter methods always return the value passed to it as an arugment, regardless of what happens inside the method. If the setter tried to return something other than the argument's value, it just ignores that attempt.</i>

<h2>Instance Methods vs. Class Methods</h2>

<b>Instance Methods:</b> An instance method is a method defined within a class, that provides behaviors to objects created from that class. Instances of a class can invoke instance methods defined within the class' definition, as long as the instance method is `public`. 

```ruby
class Student 
  def initialize(name, course)
    @name = name
    @course = course
  end

  def study
    "#{@name} is studying for #{@course}."
  end

  def take_exam
    "#{@name} is taking an exam for #{@course}."
  end

  def eat_lunch
    "#{@name} is eating lunch."
  end
end

alyssa = Student.new('Alyssa', 'RB 129')

alyssa.study 		 # => "Alyssa is studying for RB 129."
alyssa.take_exam # => "Alyssa is taking an exam for RB 129."
alyssa.eat_lunch # => "Alyssa is eating lunch."
```

In the above example, we have defined a `Student` class that has three public instance methods: `study`, `take_exam`, and `eat_lunch`. Which means that any instance of the `Student` class will have the ability to invoke these methods, in turn giving them these behaviors/functionality. By instantiating a new instance of the `Student` class called `alyssa`, it demonstrates how `alyssa` is able to invoke these instance methods, giving that object the ability to study, take exams, and eat lunch. 

<b>Class Methods:</b> Class methods are methods that are scoped at the class level. They are defined within a class definition and prefixed with `self.`. Since class methods are scoped at the class level, they must be invoked directly on the class itself. Because class methods are scoped at the class level, objects instantiated from that class cannot invoke these methods. They are used more for functionality that pertains to the class itself, and not any specific object instantiated from the class. EX:

```ruby
class Student 
  @@total_students = 0

  def initialize
    @@total_students += 1
  end

  def self.total_students
    @@total_students
  end
end

Student.total_students # => 0

student1 = Student.new
Student.total_students # => 1

student2 = Student.new
Student.total_students # => 2

student3 = Student.new
Student.total_students # => 3
```

In the above example we have a class method called `total_students` within the `Student` class that returns the value of a class variable called `@@total_students`. With each new instance created from the `Student` class the `@@total_students` class variable gets incremented by 1, keeping count of the number of `Student` objects. So, when we invoke `Student.total_students` , we are invoking it straight on the `Student` class which tells Ruby to invoke the `self.total_students` class method within the `Student` class definition. Which will then return the value referenced by `@@total_students`, which starts at `0` and then increments by `1` up until the final line which returns `3`.

<h2>Method Access Control</h2>

Method access control is how Ruby allows us to either grant or restrict access to methods within classes. We can do this by defining our methods as `public`, `private`, or `protected`. 

* Public: public methods are methods that are available to any object of that class, to be invoked from outside of the class. Creating public methods is how we give objects behaviors. Without a public method, an object would not have any sort of functionality.
* Private: private methods are methods that are not accessible to be invoked outside of the class. They must be invoked from another method within the same class, and they can only be invoked on the calling object. Creating private methods is how we are able to limit access to sensitive information that we may not want accessible.
* Protected: protected methods are similar to private methods. These methods are also not accessible to be invoked outside of the class, and must be invoked from another method within the same class. They are different in that they allow us to invoke protected methods on other instances of the same class. Creating protected methods allows us to limit access to sensitive information, while still allowing interaction between objects of the same class.

```ruby
class Person
  attr_reader :name # public getter method for `@name`
  
  def initialize(name, age, dob)
    @name = name
    @age = age
    @dob = dob
  end
  
  def older_than?(other_person) # public method
    age > other_person.age # invoking protected `age` method on calling object and `other_person`
  end
  
  def birthyear # public method
    dob.strftime('%Y') # invoking private `dob` method on calling object
  end
  
  protected
  
  attr_reader :age # protected getter method for `@age`
  
  private
  
  attr_reader :dob # private getter method for `@dob`
end

bob = Person.new('Robert', 24, Time.new(2000, 1, 15))
joe = Person.new('Joseph', 40, Time.new(1984, 3, 1))

bob.name # => "Robert"

bob.age # => NoMethodError: protected method `age` called for #<Person>
bob.dob # => NoMethodError: private method `dob` called for #<Person>

bob.older_than?(joe) # => false

# if we create a new class that also has a protected `age` method and try to pass it as the argument into the `Person#older_than?` method:

class Dog
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  protected
  
  attr_reader :age # protected getter method for `@age`
end

fido = Dog.new('Fido', 4)

bob.older_than?(fido) # => NoMethodError: protected method `age` called for #<Dog>
```

In the above example we have a class called `Person` that has:

* Three public methods:  `name`, `older_than?`, and `birthyear`. All three of these methods can be invoked by an instance of the `Person` class from outside of the class.
* One protected method:  `age`, which is a getter method for the instance variable `@age`. When we try to invoke this method on an instance of the `Person` class from outside of the class we get a `NoMethodError` exception because protected methods cannot be invoked from outside of the class. However, when we invoke the protected `age` method from within the `Person#older_than?` method and pass in another `Person` instance as the argument, we are able to invoke the `age` method on both objects, which in turn will return the value their `@age` instance variables are referencing. Which then evaluates if the values represented by the calling object's `@age` is greater than the arguments `@age`, then returning either `true` or `false`. 
* One private method: `dob` which is a getter method for the instance variable `@dob`. When we try to invoke this method on an instance of the `Person` class from outside of the class we get a `NoMethodError` exception because private methods cannot be invoked from outside of the class. However, within the `Person#birthyear` method, we are able to invoke the `dob` method on the calling object, which in this case will return the instances birthyear in String format.

Finally, to demonstrate how protected methods cannot invoke an instance of another classes protected method with the same name, we have a new class called `Dog` that also has a protected `age` instance method. When we pass in an instance of the `Dog` class as an argument to the `Person#older_than?` method invocation, we get a `NoMethodError` exception because we are trying to invoke a protected method `age` for the `Dog` object.

<h2>Class Inheritance</h2>

Class inheritance in OOP and Ruby is the mechanism that allows a class to inherit behaviors and attributes from another class. The class that passes on its behaviors is called the "superclass", and the class that inherits those behaviors is called the "subclass". When defining a class to subclass another, the subclass will have access to the superclass' methods and attributes. This creates a hierarchical relationship between classes, where the subclass can also have additional behaviors and attributes, or override existing ones from the superclass. Class inheritance is a way to achieve polymorphism as well as keep from repeating code throughtout our program.

When using class inheritance, there are some factors to consider:

* A class can only subclass from one superclass (single inheritance).
* When a superclass contains a class variable, that class variable is shared amongst the class and all of its subclasses. This means it could easily be modified without meaning to.
* When resolving a method invocation, Ruby searches the current class first and then will travel up the method lookup path if the method is not found within the current class. This means that if a method is invoked on a subclass, Ruby first searches the subclass before searching the superclass for the method. It's important to know a class' method lookup path to prevent accidental method invocation. To find a class' method lookup path you can invoke `#ancestors` directly on the class in question.
* To invoke a superclass' method within the subclass, you can use the `super` keyword within the method definition of a method of the same name. If that superclass' method is invoked with arguments they either need to be the same as the method defined within the subclass, or specified when invoking.
* If there's an "is-a" relationship, class inheritance is usually the correct choice. If there's a "has-a" relationship, interface inheritance is generally a better choice. For example, a truck "is a" vehicle and it "has an" ability to drive.

```ruby
class MusicalInstrument
  @@instrument_count = 0
  attr_reader :type, :brand
  
  def initialize(brand)
    @type = self.class.to_s.downcase
    @brand = brand
    @@instrument_count += 1
  end
  
  def play
    "Now playing a #{@brand} #{@type}."
  end
  
  def self.total_number_of_instruments
    @@instrument_count
  end
end

class Guitar < MusicalInstrument
  STRINGS = 6
end

class Ukulele < Guitar
  STRINGS = 4
end

class Musician
  def initialize(name)
    @name = name
  end
  
  def play(instrument)
    "#{@name} is playing a #{instrument.brand} #{instrument.type}."
  end
end

MusicalInstrument.total_number_of_instruments # => 0

guitar = Guitar.new('Fender')

MusicalInstrument.total_number_of_instruments # => 1

ukulele = Ukulele.new('Kamaka')

MusicalInstrument.total_number_of_instruments # => 2
Ukulele.total_number_of_instruments # => 2

Guitar::STRINGS # => 6
Ukulele::STRINGS # => 4

bono = Musician.new('Bono')

guitar.play # => "Now playing a Fender guitar."
ukulele.play # => "Now playing a Kamaka ukulele."

bono.play(guitar) # => "Bono is playing a Fender guitar."
bono.play(ukulele)# => "Bono is playing a Kamaka ukulele."

Ukulele.ancestors # => [Ukulele, Guitar, MusicalInstrument...]
Guitar.ancestors # => [Guitar, MusicalInstrument, Object...]
MusicalInstrument.ancestors # => [MusicalInstrument, Object...]
```

In the above example we have four classes:

* `MusicalInstrument` : The `MusicalInstrument` class is the superclass of the `Guitar` class. It contains a class variable called `@@instrument_count` that will be shared between it's own class as well as any subclasses. This class has a `play` instance method that returns a String object describing what brand and type of instrument is currently playing. The `MusicalInstrument#play` method is inherited by subclasses `Guitar` and `Ukulele`.
* `Guitar` : The `Guitar` class is the subclass of the `MusicalInstrument` class, and the superclass of the `Ukulele` class. Which means that the `Guitar` class will inherit the behaviors and attributes of the `MusicalInstrument` class, and pass along these and it's own behaviors and attributes on to the `Ukulele` class. Within the `Guitar` class definition we have a constant variable called `STRINGS` that references the Integer `6`. 
* `Ukulele` : The `Ukulele` class is the subclass of the `Guitar` class, which inherits from the `MusicalInstrument` class. This means the `Ukulele` class' inheritance hierarchy is : `Ukulele`, `Guitar`, `MusicalInstrument`, `Object`, and so on. This means the `Ukulele` class will inherit the behaviors and attributes of the `Guitar` and `MusicalInstrument` class. Because of this, we have created a constant called `STRINGS` within the `Ukulele` class that references the Integer `4`, so that if the `Ukulele` class references the constant `STRINGS` it will return `4` instead of `6`.
* `Musician` : The `Musician` class is a class unrelated to the others so it is not part of the other class' inheritance hierarchy. This class also has a `play` instance method that, like the `MusicalInstrument` class, returns a String object describing what brand and type of instrument is being play, as well as who is playing it. Although the `Musician` class is unrelated in an inheritance hierarchy manner, the object passed into the `Musician#play` instance method, referenced by the `instrument` method variable, is considered a collaborator object.

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