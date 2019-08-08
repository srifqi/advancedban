-- Advanced Ban [advancedban] by srifqi
advancedban = {}

-- parameter
local FILE_NAME = "bannedplayerlist.txt"
local BAN_MESSAGE = "Your username is banned."

function advancedban.is_banned(name)
	if not file_exists(minetest.get_worldpath() .. DIR_DELIM .. FILE_NAME) then
		return false
	end
	local list = io.open(minetest.get_worldpath() .. DIR_DELIM .. FILE_NAME, "r")
	for username in list:lines() do
		if name == username then
			list:close()
			return true
		end
	end
	list:close()
	return false
end

function advancedban.ban(name)
	if advancedban.is_banned(name) then
		-- minetest.log("info", name .. " is already in advancedban list.") -- print debug
		return false
	else
		local list = io.open(minetest.get_worldpath() .. DIR_DELIM .. FILE_NAME, "a")
		list:write(name .. "\n")
		list:close()
		minetest.log("action", name .. " has been added to advancedban list.") -- print debug
		return true
	end
end

function advancedban.unban(name)
	local found = false
	if file_exists(minetest.get_worldpath() .. DIR_DELIM .. FILE_NAME) then
		local list = io.open(minetest.get_worldpath() .. DIR_DELIM .. FILE_NAME, "r")
		local text = ""
		for username in list:lines() do
			if name == username then
				found = true
			else
				text = text .. username .. "\n"
			end
		end
		list:close()
		local list = io.open(minetest.get_worldpath() .. DIR_DELIM .. FILE_NAME, "w")
		list:write(text)
		list:close()
	end
	if found then
		minetest.log("action", name .. " has been removed from advancedban list.") -- print debug
	end
	return found
end

minetest.register_chatcommand("aban", {
	params = "<player name>",
	description = "Ban a player with given name",
	privs = {ban = true},
	func = function(name, param)
		if advancedban.ban(param) then
			minetest.chat_send_player(name, param .. " has been added to advancedban list.")
		else
			minetest.chat_send_player(name, param .. " is already in advancedban list.")
		end
	end
})

minetest.register_chatcommand("abankick", {
	params = "<player name>",
	description = "Ban and kick a player with given name",
	privs = {ban = true, kick = true},
	func = function(name, param)
		local kick = ", but failed to kick the player."
		if minetest.kick_player(param) then
			kick = " and has been kicked."
		end
		if advancedban.ban(param) then
			minetest.chat_send_player(name, param .. " has been added to advancedban list" .. kick)
		else
			minetest.chat_send_player(name, param .. " is already in advancedban list" .. kick)
		end
	end
})

minetest.register_chatcommand("aban+", {
	params = "<player name>",
	description = "Ban a player and its IP with given name",
	privs = {ban = true},
	func = function(name, param)
		local IP = ", but failed to ban IP of the player."
		if minetest.ban_player(param) then
			IP = " and IP of the player is banned."
		end
		if advancedban.ban(param) then
			minetest.chat_send_player(name, param .. " has been added to advancedban list" .. IP)
		else
			minetest.chat_send_player(name, param .. " is already in advancedban list" .. IP)
		end
	end
})

minetest.register_chatcommand("unaban", {
	params = "<player name>",
	description = "Remove player ban with given name",
	privs = {ban = true},
	func = function(name, param)
		if advancedban.unban(param) then
			minetest.chat_send_player(name, param .. " has been removed from advancedban list.")
		else
			minetest.chat_send_player(name, param .. " is not found in advancedban list.")
		end
	end
})

minetest.register_chatcommand("unaban+", {
	params = "<player name>",
	description = "Remove player ban and its IP with given name",
	privs = {ban = true},
	func = function(name, param)
		local IP = ", but failed to unban IP of the player"
		if minetest.unban_player_or_ip(param) then
			IP = " and IP of the player is unbanned."
		end
		if advancedban.unban(param) then
			minetest.chat_send_player(name, param .. " has been removed from advancedban list" .. IP)
		else
			minetest.chat_send_player(name, param .. " is not found in advancedban list" .. IP)
		end
	end
})

-- prevent advancedbanned player to join
minetest.register_on_prejoinplayer(function(name)
	if advancedban.is_banned(name) then
		return BAN_MESSAGE
	end
end)

-- Minetest library - misc_helpers.lua
function file_exists(filename)local f=io.open(filename,"r");if f==nil then return false else f:close() return true end end
