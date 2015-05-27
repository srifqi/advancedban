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

function advancedban.unban(name)
	local found = false
	if file_exists(minetest.get_worldpath()..DIR_DELIM..FILE_NAME) == true then
		local list = io.open(minetest.get_worldpath()..DIR_DELIM..FILE_NAME, "r")
		local text = ""
		for username in list:lines() do
				if name == username then
					found = true
				else
					text = text .. username .. "\n"
				end
			end
		list:close()
		local list = io.open(minetest.get_worldpath()..DIR_DELIM..FILE_NAME, "w")
		list:write(text)
		list:close()
	end
	if found == true then
		minetest.log("action", name.." has been removed from advancedban list.") -- print debug
	end
	return found
end

minetest.register_chatcommand("aban", {
	params = "<player name>",
	description = "Ban name of player",
	privs = {ban = true},
	func = function(name, param)
		advancedban.ban(param)
		minetest.chat_send_player(name, param.." has been added to advancedban list.")
	end,
})

minetest.register_chatcommand("abankick", {
	params = "<player name>",
	description = "Ban and kick name of player",
	privs = {ban = true, kick = true},
	func = function(name, param)
		advancedban.ban(param)
		text = "and kicked"
		if not minetest.kick_player(param) then
			text = "but failed to kick player"
		end
		minetest.chat_send_player(name, param.." has been added to advancedban list "..text..".")
	end,
})

minetest.register_chatcommand("aban+", {
	params = "<player name>",
	description = "Ban name and IP of player",
	privs = {ban = true},
	func = function(name, param)
		advancedban.ban(param)
		text = " and successfully ban IP of player"
		if not minetest.ban_player(param) then
			text = " but failed to ban IP of player"
		end
		minetest.chat_send_player(name, param.." has been added to advancedban list"..text..".")
	end,
})

minetest.register_chatcommand("unaban", {
	params = "<player name>",
	description = "Remove name of player ban",
	privs = {ban = true},
	func = function(name, param)
		local removed = advancedban.unban(param)
		if removed == true then
			minetest.chat_send_player(name, param.." has been removed from advancedban list.")
		else
			minetest.chat_send_player(name, param.." is not found in advancedban list.")
		end
	end,
})

minetest.register_chatcommand("unaban+", {
	params = "<player name>",
	description = "Remove name and IP of player ban",
	privs = {ban = true},
	func = function(name, param)
		local removed = advancedban.unban(param)
		local unbanned = minetest.unban_player_or_ip(param)
		if removed == true then
			text = " and IP of player unbanned"
			if not unbanned then
				text = " but failed to unban IP of player"
			end
			minetest.chat_send_player(name, param.." has been removed from advancedban list"..text..".")
		else
			text = " but IP of player unbanned"
			if not unbanned then
				text = " and failed to unban IP of player"
			end
			minetest.chat_send_player(name, param.." is not found in advancedban list.")
		end
	end,
})

-- prevent advancedbanned player to join
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
