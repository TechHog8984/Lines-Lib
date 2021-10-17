Hello! I am TechHog and this is a UI library I made called Lines Lib. 
Lines Lib is a UI library for roblox made mostly using the Drawing library. The Drawing library this is built off of, as far as I know, is not in Roblox, but in exploits
like Synapse, Sentinel, Protosmasher.
If you want to suggest anything or if you have any questions, you can contact me through my discord at TechHog#8984 (402264559509045258).

### __Changelog__

> Stable release 1.0
  - lib:CreateGui function
    -use: lib:CreateGui((optional)<string> gui name)
    -returns: New Gui with name {gui name} or default name 'GUI'
  - Gui:CreateSection function
    -use: Gui:CreateSection((optional)<string> section name)
    -returns: New Section with name {section name} or default name 'section'  
  - Dragging of Sections
  - Section:TextButton function
    - use: Section:TextButton((optional)<string> button name, (optional)<function> click callback aka function called when button is clicked)
    - returns: New TextButton with name {button name} or default name 'button'. When this button is clicked, if click callback is provided, the click callback is ran
  - Section:TextLabel function
    - use: Section:TextLabel((optional)<string> label name, (optional)<string> text)
    -returns: New TextLabel with name {label name} or default name 'label' and text {text} or default text {label name} or default name 'label'
  - > (COMING SOON) TextBox
  - Hovering detection for all Objects
  - click event for TextButtons
  - selected event for (COMING SOON) TextBoxes
  - unselected event for (COMING SOON) TextBoxes
  - hoverenter and hoverleave events for all Objects

> Stable release 1.1
  - SetProperty and GetProperty functions for all objects
