Lua Class Generator  
command line tool which generates teh skeleton of a class in lua. saves class to a file inside of ./classes/

# options
- -c [className] 
  - name of class.
- -p [parentClass]
  - name of parent class, if any.
- -v [vars]
  - comma separated list of vars used in constructor of class.
- -s [vars]
  - comma seperated list of vars to pass to parent class, if any. 
- -m [methods]
  - comma seperated list of class methods.
- -f [functions]
  - comma seperated list of static functions.

# examples
- create a class named MyClass. no vars,functions,methods nor parent class are included
  - ``main.lua -C MyClass``
- create class named MyClass which inherents from a parent class MyParent
  - ``main.lua -c MyClass -p MyParent``
- create class named MyClass which has constructor parameters 'a,b,c'
  - ``main.lua -c MyClass -v a,b,c``
- create class named MyClass which has parent class MyParent which has parent parameters 'x,y,z'
  - ``main.lua -c MyClass -p MyParent -s x,y,z``
- create class named MyClass which has constructor parameters 'a,b,c' and has parent class MyParent which has parent parameters 'x,y,z'
    - ``main.lua -c MyClass -v a,b,c -p MyParent -s x,y,z``
- create class named MyClass which has methods 'toString, toHash, and compare'
  - ``main.lua -c MyClass -m toString,toHash,compare ``


# license 
licensed under AGPL version 3 only. 
