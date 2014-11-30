

function setUpAndArmGameOverButton()

	local widget = require( "widget" )



	-- Function to handle button events
	local function handleButtonEvent( event )
	    if ( "ended" == event.phase ) then
	        print( "Button was pressed and released" )
	          if (gameStatus == "Running") then
			        --gameOver()
			  end
			  gameStatus = "Resetting"
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