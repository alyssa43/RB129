<h2>LS 120 Questions</h2>

1. <b>What is OOP and why is it important?</b> OOP stands for "object oriented programming". It is a programming paradigm that allows for more organized and flexible code. By creating objects that contain both state (data) and behavior (functionality) it allows us to have a self-contained component of our program that can be changed or manipulated without affecting our entire program. By breaking down our code into smaller, more manageable parts, it makes our code more organized and easier to read and modify when needed. It is important because without OOP our program would be very fragile and likely to have a ripple effect throughout the entire program from just one error.

2. <b>What is encapsulation?</b> Encapsulation is a form of data protection where data (state) and functionality (behavior) are combined into a single unit called an "object". By containing both state and behavior within itself, encapsulation allows us to pass objects around in our program. We can choose to hide certain data or expose it as needed, which helps in organizing and protecting the inner working of our code.

3. <b>How does encapsulation relate to the public interface of a class?</b> Because encapsulation bundles data and functionality together into a singular object, it allows us to hide this data and functionality from the rest of our code. The way in which we define a class' attributes and methods determines whether those attributes and methods are accessible to objects instantiated from that class outside of the class. For instance, if we define a public instance method within a class, any objects instantiated from that class can access that method from outside of the class. The public interface of a class acts as a layer of abstraction that allows objects of that class to interact with it's public attributes and methods without needing to be aware of the internal details.

4. What is an object? An object can be thought of as an individual and unique container that holds information. The information an object contains will be determined by the class it was created from. Even when multiple objects are created from one class, they will still be their own unique object. EX:

   ```ruby
   class Person
     def initialize(name)
       @name = name
     end
   end
   
   bob = Person.new('Robert')
   joe = Person.new('Joesph')
   ```

   In this example we have instantiated two new `Person` objects, `bob` and `Joe`, both of with have their own unique attributes.

5. What is a class?

6. What is instantiation?

7. <b>What is polymorphism?</b>

8. <b>Explain two different ways to implement polymorphism.</b>

9. How does polymorphism work in relation to the public interface?

10. <b>What is duck typing? How does it relate to polymorphism - what problem does is solve?</b>

11. What is inheritance?

12. What is the difference between a superclass and a subclass?

13. What is a module?

14. What is a mixin?

15. When is it good to use inheritance?

16. <b>In inheritance, when would it be good to override a method?</b>

17. <b>What is the method lookup path?</b>

18. <b>When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?</b>

19. How do you initialize a new object?

20. What is a constructor method?

21. What is an instance variable, and how is it related to an object?

22. What is an instance method?

23. <b>How do objects encapsulate state?</b>

24. What is the difference between classes and objects?

25. How can we expose information about the state of the object using instance methods?

26. <b>What is a collaborator object, and what is the purpose of using collaborator objects in OOP?</b>

27. <b>What is an accessor method?</b>

28. What is a getter method?

29. What is a sett method?

30. What is attractive_accessor?

31. <b>How do you decide whether to reference an instance variable or a getter method?</b>

32. <b>Why does the `#change_info` method not work as expected here?</b>

    ```ruby
    class GoodDog
      attr_accessor :name, :height, :weight
      
      def initialize(n, h, w)
        @name = n
        @height = h
        @weight = w
      end
      
      def speak
        "#{name} says arf!"
      end
      
      def change_info(n, h, w)
        name = n
        height = h
        weight = w
      end
      
      def info
        "#{name} weighs #{weight} and is #{height} tall."
      end
    end
    
    sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
    sparky.change_info('Spartacus', '24 inches', '45 lbs')
    puts sparky.info # => Sparky weighs 10 lbs and is 12 inches tall.
    ```

33. When would you call a method with self?

34. What are class methods?

35. What is the purpose of a class variable?

36. What is a constant variable?

37. What is the default `to_s` method that comes with Ruby, and how do you override this?

38. What are some important attributes of the `to_s` method?

39. From within a class, when an instance method uses `self`, what does it reference?

40. What happens when you use `self` inside a class but outside of an instance method?

41. Why do you need to use `self` when calling private setter methods?

42. <b>Why use `self`, and how does `self` change depending on the scope it is used in?</b>

43. What is inheritance, and why do we use it?

44. Give an example of how to use class inheritance.

45. Given an example of overriding. What would you use it?

46. Give an example of using the `super` method. When would we use it?

47. Give an example of using the `super` method with an argument.

48. When creating a hierarchical structure, under what circumstances would a module be useful?

49. What is interface inheritance, and under what circumstances would it be useful in comparison to class inheritance?

50. How is the method lookup path affected by module mixins and class inheritance?

51. What is namespacing?

52. How does Ruby provide the functionality of multiple inheritance?

53. Describe the use of modules as containers.

54. Why should a class have as few public methods as possible?

55. What is the `private` method call used for?

56. What is the `protected` keyword used for?

57. What are two rules of `protected` methods?

58. Why is it generally a bad idea to override methods from the Object class, and which method is commonly overridden?

59. What is the relationship between a class and an object?

60. Explain the idea that a class groups behaviors.

61. Objects do not share state between other objects, but do share behaviors