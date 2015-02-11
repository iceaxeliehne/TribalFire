--[[    {TribalFire}
    Copyright (C) {2015}  {Isaac Lynnah}

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]--

function setUpAndArmGameOverButton()

	local widget = require( "widget" )



	-- Function to handle button events
	local function handleButtonEvent( event )
	    if ( "ended" == event.phase ) then
			  gameStatus = "Resetting"
        print( gameStatus )
	    end
	end

	-- Create the widget
	local button1 = widget.newButton
	{
	    left = 100,
	    top = 200,
	    id = "button1",
	    label = "Test",
	    onEvent = handleButtonEvent
	}

	-- Center the button
button1.x = display.contentCenterX -230
button1.y = display.contentCenterY -80

-- Change the button's label text
button1:setLabel( "Restart" )

end