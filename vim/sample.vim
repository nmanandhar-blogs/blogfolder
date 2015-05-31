" sample.vim :Example script
" version    :1.0
" Maintainer : nmanandhar@gmail.com 
" Last modified: 2015
" License      : This script is released under the vim License

:let s:global_cpo = &cpo " store current compatibible-mode 
:set cpo&vim             " go into nocompatible-mode
":let &cpo =s:global_cpo " at the end of the script
"
"
"Configuration
"Put Configuration at the top .
"A user of the script might want to change the settings in his 
"vimrc file. You should therefore make sure that you do not 
"overwrite his or her settings. This can be done by checking that 
"the setting does not already exist and only setting it if it 
"doesn't 

" variable myscript_path
" Check to see if variable exist . If not set default value, else 
" use the value and remove with unlet, so it does not float around
" in global scope with no purpose. Configuration is only needed in 
" script and not in global scope
if !exists("myscript_path")
  let s:vimhomepath = split(&runtimepath,',')
  let s:myscript_path = s:vimhomepath[0]."/plugin/myscript.vim"
else
  let s:myscript_path = myscript_path
  unlet myscript_path
endif 

"Mappings 
" time to add mappings if any 
" As with configuration variables, mappings is an area where the user might
" not want the same settings like you- or maybe some other script has already
" made the same mapping that you want.

" Check to see if some mapping is already made to the unique
" function identifier <Plug>MyscriptMyfunctionA. If a map does not exist 
" then <Leader>a is mapped to the identifier- unless <Leader> a is already
" used and Vim gives an error
if(!hasmapto('<Plug>MyscriptMyfunctionA')
  map <unique> <Leader>a <Plug>MyscriptMyfunctionA
endif

" hasmapto() Function to check if a mapping to your function exists
" <unique>   Tells vim to give an error if a similar map exists
" <Leader>   Let the user decide which map leader to use 
" <Plug>     This is a way to make a unique global identifier for a function 
"           such that it will not clash with other functions in global scope 
"

"Get from <Plug>MyscriptMyfunctionA to the actual function MyFunctionA() in
"the script.
noremap <unique> <script> <Plug>MyscriptMyfunctionA <SID>MyFunctionA
noremap <SID>MyFunctionA : call <SID>MyFunctionA()<CR>
"The first mapping maps our unique <Plug>MyscriptMyfunctionA identifier to 
"<SID>MyFunctionA. We use <SID> here, because this little tag is exchanged
"with Vim's own unique Id for the current script, and this is needed if we want
"to make a global mapping to a function that is only available in script scope
"(eg s:MyFunctionA)
"
"The second mapping binds the actual function <SID>MyFunctionA() which is
"s:MyFunctionA() to the global mapping <SID>MyFunctionA. So what actually
"happens is that when you press \a, then the first mapping translates This
"into <Plug>MyscriptMyfunctionA. This is defined in the script and hense 
"the <SID> now has the right value. Therefore <Plug>MyscriptMyfunctionA is 
"again translated further into <SID>MyFunctionA which is funally mapped into
"the actual call of the local function s:MyFnctionA()

"Functions
"
"this is our local function with a mapping
function s:MyFunctionA()
  echo "this is the script scope function MyFunctionA speaking"
endfunctionA

"this is a global function which can be called by anyone
function MyglobalfunctionB()
  echo "hello from the global-scope function MyglobalfunctionB"
endfunction

function MyglobalfunctionC()
  echo "hello from the global-scope function MyglobalfunctionC() now calling locally:"
  call <SID>MyFunctionA()
endfunction

"-----------------------------------------------------
" The first function is a  private function, which is only available in the
" script scope while the two others are both available in the global scope.
" Notice however how it is possible for one of the global functions to call
" the local function because it knows the correct <SID> for the current script
"
