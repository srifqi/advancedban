-- Advanced Ban [advancedban] by srifqi
advancedban = {}

-- parameter
local FILE_NAME = "bannedplayerlist.txt"
local BAN_MESSAGE = "Your username is banned."

function advancedban.ban(name)
	local list = io.open(minetest.get_worldpath()..DIR_DELIM..FILE_NAME, "w")
	list:write(name.."\n")
	list:close()
	minetest.log("action", name.." has been added to advancedban list.") -- print debug
end

minetest.register_chatcommand("aban", {
	privs = {ban = true},
	func = function(name, param)
		advancedban.ban(param)
		minetest.chat_send_player(name, param.." has been added to advancedban list.")
	end,
})

minetest.register_chatcommand("abankick", {
	privs = {ban = true, kick = true},
	func = function(name, param)
		advancedban.ban(param)
		minetest.kick_player("singleplayer", BAN_MESSAGE)
		minetest.chat_send_player(name, param.." has been added to advancedban list and kicked.")
	end,
})

minetest.register_on_prejoinplayer(function(name)
	if file_exists(minetest.get_worldpath()..DIR_DELIM..FILE_NAME) == true then
		local list = io.open(minetest.get_worldpath()..DIR_DELIM..FILE_NAME, "r")
		for username in list:lines() do
				if name == username then
					return BAN_MESSAGE
				end
			end
		list:close()
	end
end)

-- Minetest library - misc_helpers.lua
function file_exists(filename)local f=io.open(filename, "r");if f==nil then return false else f:close() return true	end end
