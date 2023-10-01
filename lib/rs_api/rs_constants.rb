# frozen_string_literal:true

# Default Runescape-related constants
module RsApi
  module RsConstants
    MAX = 13_034_431 # Xp needed to lv 99 in any skill,
    # useless now BUT could be useful in future.

    # Mapping of received info from rs_api's uri.
    SKILL_ID_CONST = {
      0 => 'Overall',
      1 => 'Attack',
      2 => 'Defence',
      3 => 'Strength',
      4 => 'Constitution',
      5 => 'Ranged',
      6 => 'Prayer',
      7 => 'Magic',
      8 => 'Cooking',
      9 => 'Woodcutting',
      10 => 'Fletching',
      11 => 'Fishing',
      12 => 'Firemaking',
      13 => 'Crafting',
      14 => 'Smithing',
      15 => 'Mining',
      16 => 'Herblore',
      17 => 'Agility',
      18 => 'Thieving',
      19 => 'Slayer',
      20 => 'Farming',
      21 => 'Runecrafting',
      22 => 'Hunter',
      23 => 'Construction',
      24 => 'Summoning',
      25 => 'Dungeoneering',
      26 => 'Divination',
      27 => 'Invention',
      28 => 'Archaeology',
      29 => 'Necromancy'
    }.freeze
  end
end
