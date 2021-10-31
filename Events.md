### This is a list of all the Events featured in Lines-Lib.

## TextButton
> hoverenter
  - description: Fired whenever the mouse starts hovering over the button
  - parameters / args: None
  - usage: TextButton:GetEvent('hoverenter'):Connect(callback)
> hoverleave
  - description: Fired whenever the mouse stops hoevering over the button
  - parameters / args: None
  - usage: TextButton:GetEvent('hoverleave'):Connect(callback)
> click
  - description: Fired whenever the mouse clicks the button
  - parameters / args: None
  - usage: TextButton:GetEvent('click'):Connect(callback)
> changed
  - description: Fired whenever a property of the button is changed
  - parameters / args: \<string\> name of the property being changed
  - usage: TextButton:GetEvent('changed'):Connect(callback)

## TextLabel
> hoverenter
  - description: Fired whenever the mouse starts hovering over the label
  - parameters / args: None
  - usage: TextLabel:GetEvent('hoverenter'):Connect(callback)
> hoverleave
  - description: Fired whenever the mouse stops hoevering over the label
  - parameters / args: None
  - usage: TextLabel:GetEvent('hoverleave'):Connect(callback)
> changed
  - description: Fired whenever a property of the label is changed
  - parameters / args: \<string\> name of the property being changed
  - usage: TextLabel:GetEvent('changed'):Connect(callback)

## TextBox
> hoverenter
  - description: Fired whenever the mouse starts hovering over the box
  - parameters / args: None
  - usage: TextBox:GetEvent('hoverenter'):Connect(callback)
> hoverleave
  - description: Fired whenever the mouse stops hoevering over the box
  - parameters / args: None
  - usage: TextBox:GetEvent('hoverleave'):Connect(callback)
> selected
  - description: Fired whenever the box is selected (when you click on the box and it starts accepting text)
  - parameters / args: None
  - usage: TextBox:GetEvent('selected'):Connect(callback)
> unselected
  - description: Fired whenever the box is unselected (when you click off the box or press return and it stops accepting text)
  - parameters / args: None
  - usage: TextBox:GetEvent('unselected'):Connect(callback)
> changed
  - description: Fired whenever a property of the box is changed
  - parameters / args: \<string\> name of the property being changed
  - usage: TextBox:GetEvent('changed'):Connect(callback)
