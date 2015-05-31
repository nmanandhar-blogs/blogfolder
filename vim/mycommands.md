#Vim

##New Tricks
  ###Executing shell Commands
  :! command
  :r !{program} execute {program} and read its output
  :w !{program} execute {program} and send text to its input
  :[range]!{program} filter text through {program}
  :shell start a new shell
  Note:
    <Leader> b has been mapped to unite buffer
    <Leader> m has been mapped to unite mru
    <Leader> db has been mapped to delete buffer

##Getting Help
: help display help
: help topic display help on topic
: h[elp] ie help can be abbreviated

      WHAT			PREPEND    EXAMPLE	~
  Normal mode command      (nothing)   :help x
  Visual mode command	  v_	   :help v_u
  Insert mode command	  i_	   :help i_<Esc>
  Command-line command	  :	   :help :quit

:h patt ctrl-d to list all topics that contain patt
:h patt tab to scroll through topics that start with "patt"

##Commands to Remember
    vim -O3 [optionalfiles] opens vim with 3 windows vertically
    b# or <c^> or <c6> Switch to previously edited buffer
    vs.. vertically split a new window
    :ls list the buffers
    :b name/number open the buffer
    :b <tab> will cycle through buffers
    Ctrl-w s Split horizontally or :sp . The window will contain same buffer
    Ctrl-w v Split vertically or :vsp
    Ctrl-w [Ctrl-]w Cycle through windows
    :on[ly] Close all windows except this one
    :windo lcd {path}
    :map key will display the mapping for the key

    ##ks
##Commands to find out
* Turn line number on and off
    Note the vim Airline plugin displays line number and character position
    so it is not strictuly required.

##Basic Commands
  ###Display Lines

    Move across display line : gj gk g0 g$ <br/>


  ###Folding
    zR recursively opens all folds
    zo opens folder
    zO opens all folds under the cursor

###Movement
    w move cursor to the beginning of next word, moves down line if required
    e move cursor to end of current word

##Window Management 

  ###Horizontal Spliting
      :new
      ctrl w n : create a new window horizontally
      ctrlw s/S/ctrl S split current window horizontally in two. Results in two viewport on the same file
      :sp[lit] [file] If file is not spvecified the current buffer is loaded in the window

  ###Vertical Spliting
      :vne[w] Like :new but split vertically
      ctrl w v : split vertically. Current buffer loaded into window
      :vs[plit] [file] same as :split but splits vertically

  ###Closing Window
    ctrl-w q  or :q[uit]
    Quit current window. When quitting the last window exit Vim. Note that 
    quitting a window either through :q or ctrlw q will not close the buffer
    A window is just a viewport and Closing a viewport will not close the 
    underlying buffer

    A window is a viewport onto a buffer.  You can use multiple windows on one
    buffer, or several windows on different buffers.

    A buffer is a file loaded into memory for editing.  The original file remains
    unchanged until you write the buffer to the file.

    A buffer can be in one of three states:

                                                            *active-buffer*
    active:   The buffer is displayed in a window.  If there is a file for this
              buffer, it has been read into the buffer.  The buffer may have been
              modified since then and thus be different from the file.
                                                            *hidden-buffer*
    hidden:   The buffer is not displayed.  If there is a file for this buffer, it
              has been read into the buffer.  Otherwise it's the same as an active
              buffer, you just can't see it.
                                                            *inactive-buffer*
    inactive: The buffer is not displayed and does not contain anything.  Options
              for the buffer are remembered if the file was once loaded.  It can
              contain marks from the |viminfo| file.  But the buffer doesn't
              contain text.

    The main Vim window can hold several split windows. By default Vim starts
    with only one window. 
    vim -o App.java Point.java opens vim with both files horizontally
    vim -O App.java Point.java opens vim with both files vertically
    vim -o3

##Buffer Management
 * When a file is loaded into memory for editing, a new buffer is created to hold it
 * A buffer is active if it is shown in a window and hidden if not shown
 * Each buffer is given a unique number when it is first created. It keeps this number for the duration of the session
 * The name of a buffer is the name of the file that has been loaded into it
 * When a window is closed, if there are other windows, the buffer is not closed.


###Listing Buffers
    :buffers or :ls or :files
### Switching Buffers
:buffer / :b / :bu / :buf number or name
When giving a name, you don't have to provide the entire name, just enough to match. The match can be in the middle eg directory.
If more than one match occurs the buffer wont be switched
Buffer can also be switched by number.
To switch to alternate buffer you can use ctrl-^ or Ctrl-6 or :b#

When you have modifed the buffer, vim does not let you switch to another buffers. You can
* Append ! to force
* :set hidden to enable buffer to be hidden withoug saving 
* :set confirm to allow vim to ask you 
* :set autowrite to save any changes made to buffer before it is hidden

### Closing Buffers
    :bdelete
    :3,5bdelete deletes buffers 3 4 and 5

    To tell if a buffer is modified, you can look at its name, if it contains a
    + character it is modifed
    To prevent modification to a buffer :set nomodifiable

* How to close inactive buffers

## Tab Management
In vim a tab is just a collection of windows.
Suppose we're working on a project with our workspace divided into a few
split widnows. Out of blue some urgent work comes up. Rather than opening
new files in current tab messing up our workspace we can create a new tab
page and do the work there.

:lcd {path} command lets us set the working directory locally for the
current window. The lcd command applies to the current window and not to
the current tab page. If we have a tab page containign two or more split
windows we could set the working directory for all of them by running
:windo lcd {path}
##Plugins
* Vim Surround
* Vim Airline
* NerdTree Has been replaced by Unit
* Unite Can replace mru 

##Important Remapped Keys
* F5
  * :nnoremap <F5> :buffers<CR>:buffer<Space> Show buffers and allow choosing by number
* Ctrl j /k 
  * Move up and down Display lines
##My Vimrc




