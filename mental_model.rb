# Choose something familiar to model after (sports team, restaurant, etc.)

# create checklist of concepts to include
  # class inheritance
  # interface inheritance
  # duck typing
  # encapsulation
  # polymorphism
  # collaborator objects
  # public, private, and protected methods
  # accessor methods
  # namespacing
  # class variables - class variables are useful for storing common state tied to the class rather than specific instances

# provide code snippets using model to demonstrate concept

# refine snippets

# practice - quiz yourself by writing code from scratch to illustrate different concepts

# leave lots of notes as you go to improve understanding

# some things to consdier reflecting on and annotating:
  # when would I use this concept? - What is a classic use case?
  # does the real world situation im modeling here feel like it would be better modeled with a different structure? (when illustrating polymorphism, you may come to realize the nouns you are using to illustrate duck typing would make more sense in a common class inheritance structure, or vice versa)

# For each concept make sure to understand 3 key points:
  # definition
  # implementation
  # benefits

# Interview assessment (2 parts)
  # explain OOP concepts out-loud while providing YOUR OWN code snippets to demonstrate concept
  # given code examples, explain what will be output. Also will be asked how to fix the code so that it works properly.

# Go over quizzes and re-format questions to re-quiz yourself

class Person
  attr_reader :name

  def initialize(name, age, dob)
    @name = name
    @age = age
    @dob = dob
  end

  def older_than?(other_person)
    age > other_person.age
  end

  def birthyear
    dob.strftime('%Y')
  end

  protected

  attr_reader :age

  private

  attr_reader :dob
end

class Car
  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  protected

  def age
    Time.now.year - @year
  end
end

bob = Person.new('Robert', 24, Time.new(2000, 1, 15))
joe = Person.new('Joesph', 40, Time.new(1984, 3, 1))

car = Car.new('Chevy', 'Suburban', 2015)

p bob.name # => "Robert"
# p bob.age # => NoMethodError because `age` is protected it cannot be referenced outside of class
# p bob.dob # => NoMethodError because `dob` is private it cannot be referenced outside of class
p bob.older_than?(joe) # => false -> because both `bob` and `joe` are instances of the `Person` class we can invoke both objects `age` getter methods from within the `Person` class even though the `age` getter methods are protected. This only works because they are instances of the same class and the protected method invocation is being called within the same class. If we tried to compare the age of somehting else, say a car that also has a protected `age` instance method we would get a NoMethodError exception:
# p joe.older_than?(car) # => NoMethodError because the Car class' `age` instance method is protected

p bob.birthyear # => "2000"
