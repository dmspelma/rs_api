# frozen_string_literal:true

# Default Runescape-related constants
module RsApi
  module RsConstants
    MAX = 13_034_431 # Xp needed to lv 99 in any skill,
    # useless now BUT could be useful in future.

    # Mapping of received info from rs_api's uri.
    SKILL_ID_CONST = {
      0 => :overall,
      1 => :attack,
      2 => :defence,
      3 => :strength,
      4 => :constitution,
      5 => :ranged,
      6 => :prayer,
      7 => :magic,
      8 => :cooking,
      9 => :woodcutting,
      10 => :fletching,
      11 => :fishing,
      12 => :firemaking,
      13 => :crafting,
      14 => :smithing,
      15 => :mining,
      16 => :herblore,
      17 => :agility,
      18 => :thieving,
      19 => :slayer,
      20 => :farming,
      21 => :runecrafting,
      22 => :hunter,
      23 => :construction,
      24 => :summoning,
      25 => :dungeoneering,
      26 => :divination,
      27 => :invention,
      28 => :archaeology,
      29 => :necromancy
    }.freeze
  end
end
