advancedban
===========
This mod will ban ONLY username, not the ip address.

##Usage
```lua
advancedban.ban(player_name)
```
or using chat commands:
(require privileges: ban)
```
/aban <player>
```
This will add player to advancedban list.
This does NOT kick the player!

Use this to add to list AND kick the player.
(require privileges: ban, kick)
```
/abankick <player>
```

###Parameter
- `FILE_NAME` = the name of file that contains list of banned player.
- `BAN_MESSAGE` = the message that will be sent to the banned player each time the player log-in.
