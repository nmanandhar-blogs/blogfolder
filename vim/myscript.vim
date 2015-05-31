"myscript.vim : Example script to show how a script is structured
"Version :1.0
"Maintainer: Nirmal Manandhar 
"Last Modified : Thu 05/21/2015 

" check if script is already loaded
if exists("loaded_myscript")
  finish "stop loading the script"
endif
let loaded_myscript=1


let s:global_cpo = &cpo "store compatibible-mode in local variable 
set cpo&vim "go into nocompatible mode


" ############ CONFIGURATION ############
" variable myscript_path
if !exists("myscript_path")
  let s:vimhomepath = split(&runtimepath,',')
  let s:myscript_path = s:vimhomepath[0]."/plugin/myscript.vim"
else
  let s:myscript_path = myscript_path
  unlet myscript_path
endif

" variable myscript_indent
if !exists("myscript_indent")
  let s:myscript_indent = 4
else
  let s:myscript_indent = myscript_indent
  unlet myscript_indent
endif



" ############ FUNCTIONS ############
" this is our local function with a mapping
function s:MyFunctionA()
  echo "Thisi s the script-scope function MyFunctionA speaking"
endfunction

function MyglobalfunctionB()
  echo "Hello from the global-scope function MyglobalfunctionB"
endfunction

function MyglobalfunctionC()
  echo "Hello from the global-scope function MyglobalfunctionC now calling locally"
  call <SID>MyFunctionA()
endfunction

" return to the users own compatibible-mode settings
:let &cpo = s:global_cpo
