
### API for Runescape and Runescape Wiki.

---

#### `PlayerExperience`
gathers hiscore information for any player.
```ruby
user = RsApi::PlayerExperience.new('player name')
```

The `#display` method gets and prints player experience data. It returns an instance of `Text::Table`.

Note that it returns _formatted_ data, specifically the rank and experience data are delimited with commas.
```ruby
user.display

+---------------+---------+-------+-------------+
|  player name  |  Rank   | Level | Experience  |
+---------------+---------+-------+-------------+
| Overall       | 358,414 | 2128  | 129,404,911 |
| Attack        | 190,252 | 99    | 14,637,581  |
| Defence       | 262,758 | 99    | 13,400,345  |
| Strength      | 179,651 | 99    | 15,445,830  |
| Constitution  | 275,505 | 99    | 17,082,774  |
| Ranged        | 327,044 | 93    | 7,332,187   |
| Prayer        | 354,999 | 88    | 4,449,154   |
| Magic         | 393,710 | 90    | 5,722,743   |
| Cooking       | 366,639 | 82    | 2,516,542   |
| Woodcutting   | 368,137 | 85    | 3,368,027   |
| Fletching     | 354,764 | 84    | 3,013,023   |
| Fishing       | 409,164 | 77    | 1,603,700   |
| Firemaking    | 408,399 | 80    | 2,145,506   |
| Crafting      | 461,252 | 75    | 1,295,024   |
| Smithing      | 467,203 | 76    | 1,390,842   |
| Mining        | 392,336 | 80    | 2,062,659   |
| Herblore      | 404,326 | 75    | 1,298,037   |
| Agility       | 380,323 | 76    | 1,370,041   |
| Thieving      | 276,721 | 81    | 2,400,337   |
| Slayer        | 267,993 | 94    | 7,981,771   |
| Farming       | 315,828 | 75    | 1,280,257   |
| Runecrafting  | 311,611 | 75    | 1,334,881   |
| Hunter        | 271,038 | 83    | 2,724,478   |
| Construction  | 376,069 | 75    | 1,254,608   |
| Summoning     | 277,108 | 90    | 5,441,178   |
| Dungeoneering | 220,979 | 95    | 8,853,321   |
| Divination    | -1      | 1     | -1          |
| Invention     | -1      | 0     | -1          |
| Archaeology   | -1      | 1     | -1          |
| Necromancy    | -1      | 1     | -1          |
+---------------+---------+-------+-------------+
 => #<Text::Table:0xfaf0>
```
An alternative for reciving raw player data is the `#loaded_xp` method.  

---

#### `PlayerCompare`
class is able to compare two existing players and pit their skills against each other.
```ruby
service = RsApi::PlayerCompare.new('player one', 'player two')

service.display
...
... # table here
...
 => #<Text::Table:0x39b5c>
```

It contains the same `#display` method, but raw data is `#raw_data`.  

---

#### `MonthlyXp`
class is able to grab the last 12 months of player xp data for every skill.

---

### To Install Gem:
1. Clone Repo
2. Navigate into repo
3. gem install `rs_api-1.1.3.gem`

---

### Additional Content
Included is a simple script to search Runescape Wiki.
The script exists under `rs_scripts` folder. The file `rsw.sh` could be moved into local `~/bin` for ease of use.
