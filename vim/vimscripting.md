#Vim Scripting

##Types
* String 
  * Single Quoted -> Everything is literal. ie \excapes do not work
  * Double Quoted "Excapes and vim keyword like \<ESC> work"
* Numbers
  * Decimal
  * Hexadecimal
  * Octal

##Variables
  * String
  * Numbers
  * List
  * Dictionary
  * Funcref
    * A reference to a function


      Variables name are mostly similar to Java. However you need to make the 
      variable name unique across script. eg by prepending your initials
      All variables are defined with :let command 
      eg :let myvar = VALUE
         echo myvar

         The type of the variable depends on how we use it
         :let stringNumber="23"
         :let mynumber=stringNumber + 0 //Automatic conversion:e

         "123" -10 ."hits" "113 hits"

          :let mylist=[1,2,"three"]
          :let myMap={1:"one",2:"two"} //keys are converted to string

          //funcref Types
          :let MyfuncrefVar = function("Myfunction")

          All user-defined function names in Vim need to have capital first
          letter and hense all variables that can be executed as functions
          should have the same restriction
          :echo MyfuncrefVar()
          :call MyfuncrefVar()


<br/>

        Scopes:
        Variables can be in function scope or global scope. As a script developer
        you have to mark the variable yourself to tell Vim in which scope the Variables
        should be available.

        If you define a variable in Vim without specificying which scope it
        belongs to , then it belongs as default to global scope- unless it is 
        defined in a function which causes it to be available int he function

        Following 8 scopes are available
        v: vim predefined global scope
        g: global scope 
        b: buffer scope - only available in the buffer where it was defined
        t: Tab scope - only available in the Vim tab where it was defined 
        w: Window scope - only available to current Vim window 
        l: Function scope local to the function it is defned in 
        s: Sourced file scope - local to a Vim script loaded using :source 
        a: Argument scope - used in arguments to functions

        let g:sum=0
        function SumNumbers(num1,num2)
            let l:sum = a:num1 + a:num2
            if(g:sum < l:sum)
              let g:sum = l:sum
            endif
        endfunction
        "test code
        call SumNumbers(3,4)
        "this should return 7
        echo g:sum

<br/>
Conditions
  if condition 
    code to execute
  else 
    some other code
  endif 

