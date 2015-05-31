Variables

        Using registers as Variables
        eg let @+="This text will be copied to the clipboard"

        Setting options with :let
        :let &textwidth=80

        Setting local options
        eg :let &l:number =1


When we see a vim variable with a letter and a : Remember that it is a scoped Variables

        Name              | Prefix: | Scope
        ------------------|---------|------
        buffer-variable   | b:      | Local to the current buffer.
        window-variable   | w:      | Local to the current window.
        tabpage-variable  | t:      | Local to the current tab page.
        global-variable   | g:      | Global.
        local-variable    | l:      | Local to a function.
        script-variable   | s:      | Local to a :source'ed Vim script.
        function-argument | a:      | Function argument (only inside a function).
        vim-variable      | v:      | Global, predefined by Vim.


<br/> 
Multiple Line Statements
:echom "foo" | echom "bar"
Vim treats the above command as two Separate command. If you want to manually
run a command but don't want to bother typing in newlines and colons,
feel free to put it all on one line seperated by pi:

    if "hello" | echom "world" | endif
    >> nop

    if "234" | echom "two hunderd thiry four" | endif
    >> "234"

    echom "hello" + 10
    >>10
    echom "10hello" +10
    >>20
    echom "hello10" +10
    >>10

##Conclusions
* Vim will try to coerce variables when neccasary. when 10 + 20foo is evaluated
    vim will convert "20foo" to integer resulting in 20
* Strings that start with a number are coerced to a number otherwise they are
    coerced to 0
* Vime will execute the body of an if statement when its condition evaluates to
    a non-zero integer after all coercion takes place


**The behavior of == is depends on a user's Setting **

    eg
    set noignorecase
    if "foo" == "FOO" | echom "vim is case insensitive"  |  elseif "foo" == "foo"| echom "vim is case sensitive " | endif
    >>vim is case sensitive

    set ignorecase
    if "foo" == "FOO" | echom "vim is case insensitive"  |  elseif "foo" == "foo"| echom "vim is case sensitive " | endif
    >> vim is case insensitive

<br/> 

##Functions
** Vimscript functions must start with a capital letter if they are unscoped!**

    :function Meow()
    : echom "Meow"
    :endfunction

    :call Meow()

    :function GetMeow()
    : return "Meow String"
    : endfunction
    :echom GetMeow()
    :let @+=GetMeow()

<br/> 
** If a vim function doesn't return a value, it implicitly returns 0**

    function TextwidthIsTooWide()
     if(&l:textwidth >=80)
          return 1
       endif
    endfunction

function TextwidthIsTooWide() | if(&l:textwidth >=80) | return 1 | endif | endfunction

    function DisplayName(name)
      echom "Hello My name is "
      echom a:name
    endfunction

    Note if we use just name without prepending with a: vim complains that
    there is no such variable. So when you write a Vimscript function that takes
    argument you always need to prefix those arguments with a: when  you use
    them to tell Vim that they're in the argument scope

Varagrs
function Varg2(foo,...)
    echom a:foo
    echom a:0
    echom a:1
    echo a:000 
endfunction
:h function-argument

#Strings
echom "Hello"
echom "Hello" + "World!"  
>>0
echom "3 mice " + "2 cats" 
>> 5
echom 10 + "10.10" 
>>20

echom "Hello, " . " world"

echo "hello\tWorld"
:help i_Ctrl-V
echo "hello<c-v><tab>world"

LiteralString are in single quotes ''. Special characters need not be escaped
except that '' represents a single qoute

##String Functions
strlen/len.->When used with strings they are the same
eg echom strlen("foo")

eg 
echo split("one two three")
   ['one','two','three']

eg 
echo split("one,two,three",",")
   ['one','two','three']

Joining
echo join(["foo","bar"],"?")
foo?bar

Split and join can be put to great effect
echo join (split("foo bar"),";")

**vim case sensitive and insensitive comparision**
"hello"==#"Hello" //always false
'hello"==?"Hello" //case insensitive comparision always true
"hello"=="Hello"  //depends on user settings eg ignorecase. Don't use this


##Execute
The `execute` command is used to evaluate a string as if it were a Vimscript
command.a eg nnoremap <cr> yy:execute @0<cr>
echo "rightbelow vsplit " .bufname("#")
execute "leftabove vsplit " .bufname("#")
leftabove {cmd} executes the cmd. If it contains a command to split, the new
window will be placed left( for vertical split) or above( for horizontal split)

#Normal Mode Command
:normal G
If the user has mapped G to something else eg dd, then this will delete the
current line. Since we don't know what our users have mapped their keys to , we
will never reliably be able to use it. We need something similar to nnoremap
.Vim has a normal! commmand that does exactly this.

`When writing Vim scripts you should always use normal! and never use the plain
old normal. You can't trust what keys your users will have mapped in their
~/.vimrc file.`

//Doesn't work
:normal! /foo<cr>
The problem is that normal! doesn't parse specifal character sequence like <cr>

##Execute Normal!
**Common Vimscript Idiom**
`execute "normal! gg0/foo\<cr>dd"`
`execute "normal! gg0/foo\rdd"`
This will move to top of file, search for the first occurence of foo, and delete
the line that contains it
Previously we tried to use normal! with a search command but couln't enter the
return needed to actually perform the search. Combining `normal!` with `execute`
fixes the problem. Execute lets you build commands programatically so that you
can use Vim's normal string escape sequence to generate the non-printing
characters you need.

:execute "normal! mqA;\<esc>`q"
append semicolons at the end of the line maintaining cursor position

`For escape sequence read help expr-quote`
\r return<cr>
\t tab <Tab>
\\ backslash 
\" double quotes
\<xxx> Special key named "xxx" eg \<C-W> for Ctrl-W


##Vim Regular Expression
        Always use \v magic search 
        In very magic all characters except [0-9a-zA-Z_] have special meanings
        {1,4}
        ?  + *
      
        {-n,m} //lazy versions
        < > for word boundaries
        %2l second Line
        %2c second column
        %2v in virtual column 2

        \s whitespace characters Space Tab
        \S non-whitespace
        \d digits
        \D non digits
        \w word characters
        \W non-word characters
        \a alphabetic
        \A non-alphabetic
        \l lowercase
        \L non-lowercase
        \u uppercase
        \U non-uppercase

        \1 string matched by first ()
        \2 string matched by second ()

        \c \C ignorecase | dont ignorecase

        \zs ->Start the match 
        \ze ->End of match 
              eg cat\zech matches cat in catch but not cat


Vim's regexes are most similar to Perl's, in terms of what you can do.  The
difference between them is mostly just notation;  here's a summary of where
they differ:

Capability			in Vimspeak	in Perlspeak ~
----------------------------------------------------------------
force case insensitivity	\c		(?i)
force case sensitivity		\C		(?-i)
backref-less grouping		\%(atom\)	(?:atom)
conservative quantifiers	\{-n,m}		*?, +?, ??, {}?
0-width match			atom\@=		(?=atom)
0-width non-match		atom\@!		(?!atom)
0-width preceding match		atom\@<=	(?<=atom)
0-width preceding non-match	atom\@<!	(?<!atom)
match without retry		atom\@>		(?>atom)
atomatom
Vim and Perl handle newline characters inside a string a bit differently:

In Perl, ^ and $ only match at the very beginning and end of the text,
by default, but you can set the 'm' flag, which lets them match at
embedded newlines as well.  You can also set the 's' flag, which causes
a . to match newlines as well.  (Both these flags can be changed inside
a pattern using the same syntax used for the i flag above, BTW.)

On the other hand, Vim's ^ and $ always match at embedded newlines, and
you get two separate atoms, \%^ and \%$, which only match at the very
start and end of the text, respectively.  Vim solves the second problem
by giving you the \_ "modifier":  put it in front of a . or a character
class, and they will match newlines as well.

...these are unique to Vim:
- changing the magic-ness of a pattern:  \v \V \m \M
   (very useful for avoiding backslashitis)
- sequence of optionally matching atoms:  \%[atoms]
- \& (which is to \| what "and" is to "or";  it forces several branches
   to match at one spot)
- matching lines/columns by number:  \%5l \%5c \%5v
- setting the start and end of the match:  \zs \ze

##Quick Fix

Vim has a special mode to speedup the edit-compile-edit cycle.The idea is to
save the error messages from compiler in a file and use Vim to jump to the
errors one by one.You can examine each problem and fix it , without having to
remember all the error messages. 

In vim , the quickfix commands are used more generally to find a list of
positions in a files. eg :vimgrep 
`:copen` Open the quickfix windows. There will only be one quick fix window,
with the special buffer type "quickfix"
`ccl[ose]` Close the quickfix window

In the quickfix window, each line is one error. The line number is equal to the
error number.The line number is equal tot he error number. You can use Ctrl-W
<Enter> to open a new window and jump to the error there


