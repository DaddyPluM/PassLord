require "button"	-- Simple GUI Library

function love.load()
	function random_seed()
		math.randomseed(os.time()^7 * math.random()* os.difftime(os.clock(), math.random()))	-- Making passwords as random as possible
	end
	random_seed()
	password_font = love.graphics.newFont(26)		-- Font size of passwords
	win_width, win_height = love.window.getMode()	-- Getting width and height of window
	password = ""	-- Password string
	password_length = 20	-- Password length in characters
	characters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m","n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z","A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",0,1,2,3,4,5,6,7,8,9,"!","#","$","%","&","*","+","-","/","=","?","@","^"}	-- Characters that can be put in the password
	generate = false

	function exit_app()	-- Close the application
	  love.event.quit()
	end
	function password_generate()	-- Generate password
		password = ""
		generate = true
	end
	
	buttons = {	-- Buttons
		Exit = button("Exit", exit_app, nil, win_width - 20, 20),
		Generate = button("Generate", password_generate, nil, win_width - 200, 20)
	}
end

function love.update()
	random_seed()
	win_width, win_height = love.window.getMode()	
	mouse_x = love.mouse.getX()	-- Get the x position of the cursor
	mouse_y = love.mouse.getY()	-- get the y position of the cursor
	
	if generate == true then
		random_seed()
		if string.len(password) < password_length then	-- If the length of the generated password is less than the maximum password length
			chr = characters[math.random(#characters)]	-- Get random character from the "characters" table
			password = password .. chr	-- Add character to password
		elseif string.len(password) == password_length then	-- If the length of the password is equal to the maximum password length
			generate = false
		end
	end
	for i, v in pairs(buttons) do	-- Mouse input checking
		function love.mousepressed(x, y, button, isTouch)
			if button == 1 then
				v:checkPressed(mouse_x, mouse_y)
			end
		end
	end
end

function love.draw()
	love.graphics.printf(os.date(),0, 0, win_width, "center")
	love.graphics.printf(password, password_font, 0, 250, win_width, "center")		-- Display password
	love.graphics.setBackgroundColor(.1, .1, .3)		-- Change background colour
	buttons.Exit:draw(10, win_height - 20)		-- Display Exit button
	buttons.Generate:draw(100, win_height/2 + 80)	-- Display Generate button
end