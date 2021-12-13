### __Changelog__

> Stable release 1.0
  - lib:CreateGui function
    - use: lib:CreateGui((optional)\<string\> gui name)
    - returns: New Gui with name {gui name} or default name 'GUI'
  - Gui:CreateSection function
    - use: Gui:CreateSection((optional)\<string\> section name)
    - returns: New Section with name {section name} or default name 'section'  
  - Dragging of Sections
  - Section:TextButton function
    - use: Section:TextButton((optional)\<string\> button name, (optional)\<function\> click callback aka function called when button is clicked)
    - returns: New TextButton with name {button name} or default name 'button'. When this button is clicked, if click callback is provided, the click callback is ran
  - Section:TextLabel function
    - use: Section:TextLabel((optional)\<string\> label name, (optional)\<string\> text)
    - returns: New TextLabel with name {label name} or default name 'label' and text {text} or default text ({label name} or default name 'label')
  - Hovering detection for all Objects
  - click event for TextButtons
  - hoverenter and hoverleave events for all Objects

> Stable release 1.1
  - SetProperty and GetProperty functions for all objects

> BugFix release 1.1.1
  - Fixed bug where closing one section breaks all others

> Stable release 1.2
  - Section:TextBox function
    - use: Section:TextBox((optional)\<string\> box name, (optional)\<string\> placeholdertext)
    - returns: New TextBox with name {box name} or default name 'box' and placeholdertext {placeholdertext} or default text ({box name} or defualt name 'box')
    - :warning: current bugs :warning: : use of the "/" key will still open the chat.
    - note: there is no selecting text nor holding of key support. this means you cannot hold a key down (such as "backspace" or "a") and have that key function multiple times. support for these features will (hopefully) be added in a later update.

> Stable release 1.2.1
  - Dragging sections are now smoother. They used to be very jittery. If you moved your mouse too fast it would stop the dragging. Now the dragging is better and only stops when you let go of the mouse.

> Stable release 1.2.2
  - Converted all user input detection to UserInputService rather than Mouse, greatly improving input detection.
