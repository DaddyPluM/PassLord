require "button"	-- Simple GUI Library

local timer = 0
local password_copied = false
local password_font = love.graphics.newFont(26)		-- Font size of passwords
local win_width, win_height = love.window.getMode()	-- Getting width and height of window
local password = ""	-- Password string
local password_length = 21	-- Password length in characters
local characters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m","n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z","A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",0,1,2,3,4,5,6,7,8,9,"!","#","$","%","&","*","+","-","/","=","?","@","^"}	-- Characters that can be put in the password
local generate = false
local buttons = {}
local mouse_x, mouse_y

function love.load()
	function random_seed()
		math.randomseed(os.time()^7 * math.random()* os.difftime(os.clock(), math.random()))	-- Making passwords as random as possible
	end
	
	function exit_app()	-- Close the application
	  love.event.quit()
	end
	function increase()
		password_length = password_length + 1
	end
	function decrease()
		password_length = password_length - 1
	end
	function password_generate()	-- Generate password
		password = ""
		generate = true
	end
	function password_copy()		-- Copy password
		if string.len(password) == password_length then
			password_copied = true
			love.system.setClipboardText(password)
		end
	end
	buttons.Exit = button("Exit", exit_app, nil, win_width - 20, 20)
	buttons.Generate = button("Generate", password_generate, nil, win_width - 200, 20)
	buttons.Copy = button("Copy", password_copy, nil, win_width - 500, 20)
	buttons.Increase = button("Increase", increase, nil, win_width - 500, 20)
	buttons.Decrease = button("Decrease", decrease, nil, win_width - 500, 20)
end

function love.update(dt)
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
	
	if password_copied == true then
		timer = timer + dt
		if timer > 1 then
			password_copied = false
			timer = 0
		end
	end
	
	function love.mousepressed(x, y, button, isTouch)	-- Input chencking
		if button == 1 then
			for i,v in pairs(buttons) do
			v:checkPressed(mouse_x, mouse_y)
			end
		end
	end
end

function love.draw()
	love.graphics.printf(os.date(),0, 0, win_width, "center")
	love.graphics.printf("Your password is " .. password_length .. " characters long",0, 100, win_width, "center")
	if password_copied == true then
		love.graphics.printf("COPIED",0, 20, win_width, "center")
	end
	love.graphics.printf(password, password_font, 0, 250, win_width, "center")		-- Display password
	love.graphics.setBackgroundColor(.1, .1, .3)		-- Change background colour
	buttons.Exit:draw(10, win_height - 20)		-- Display Exit button
	buttons.Generate:draw(100, win_height/2 + 80)	-- Display Generate button
	buttons.Copy:draw(250, win_height/2 + 120)	-- Display Copy button
	buttons.Increase:draw(250, win_height/2 + 160)	-- Display increase button
	buttons.Decrease:draw(250, win_height/2 + 200)	-- Display decrease button
end