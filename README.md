Advanced Ban [advancedban]
===========

This mod will ban player based on its username, not its IP address.

# License
MIT License (see LICENSE file)

# Usage
## Parameter
- `FILE_NAME`: name of the file that contains list of banned player
- `BAN_MESSAGE`: a message that will be sent to the banned player each time it connects

## Chat commands
### Check ban for a player
```
/abancheck <player name>
```
### Simple ban/unban
(requires `ban` privilege)
```
/aban <player name>
/unaban <player name>
```

### Ban with kick
(requires `ban` and `kick` privileges)
```
/abankick <player name>
```

### Ban/unban with its IP
(requires `ban` privilege)
```
/aban+ <player name>
/unban+ <player name>
```

## API
```lua
advancedban.is_banned(player_name)
-- true if the player is banned, false if not

advancedban.ban(player_name)
-- true if OK, false if the player has been banned before

advancedban.unban(player_name)
-- true if OK, false if the player hasn't been banned before
```
