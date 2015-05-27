advancedban
===========
This mod will ban ONLY username, not the ip address.

# Usage

	advancedban.ban(player_name)
	advancedban.unban(player_name)

or using chat commands:
(require privileges: ban)

	/aban <player name>
	/unaban <player name>

This will adds/removes player to/from advancedban list.
This does NOT kick the player!

Use this to add to list AND kick the player.
(require privileges: ban, kick)

	/abankick <player name>

### Shortcut to ban/unban the IP

	TL;DR just add "+" after command (except /abankick)

(require privileges: ban)

	/aban+ <player name>
	/unban+ <player name>

This will adds/removes player to/from advancedban list AND ban/unban it's IP.

## Parameter
- FILE_NAME = the name of file that contains list of banned player.
- BAN_MESSAGE = the message that will be sent to the banned player each time the player log-in.
