BEGIN {
}

# 01 name
# 02 school
# 03 subschool
# 04 descriptor
# 05 spell_level
# 06 casting_time
# 07 components
# 08 costly_components
# 09 range
# 10 area
# 11 effect
# 12 targets
# 13 duration
# 14 dismissible
# 15 shapeable
# 16 saving_throw
# 17 spell_resistence
# 18 description
# 19 description_formated
# 20 source
# 21 full_text
# 22 verbal
# 23 somatic
# 24 material
# 25 focus
# 26 divine_focus
# 27 sor
# 28 wiz
# 29 cleric
# 30 druid
# 31 ranger
# 32 bard
# 33 paladin
# 34 alchemist
# 35 summoner
# 36 witch
# 37 inquisitor
# 38 oracle
# 39 antipaladin
# 40 magus
# 41 adept
# 42 deity
# 43 SLA_Level
# 44 domain
# 45 short_description
# 46 acid
# 47 air
# 48 chaotic
# 49 cold
# 50 curse
# 51 darkness
# 52 death
# 53 disease
# 54 earth
# 55 electricity
# 56 emotion
# 57 evil
# 58 fear
# 59 fire
# 60 force
# 61 good
# 62 language_dependent
# 63 lawful
# 64 light
# 65 mind_affecting
# 66 pain
# 67 poison
# 68 shadow
# 69 sonic
# 70 water
# 71 linktext
# 72 id
# 73 material_costs
# 74 bloodline
# 75 patron
# 76 mythic_text
# 77 augmented
# 78 mythic
# 79 bloodrager
# 80 shaman
# 81 psychic
# 82 medium
# 83 mesmerist
# 84 occultist
# 85 spiritualist
# 86 skald
# 87 investigator
# 88 hunter
# 89 haunt_statistics
# 90 ruse
# 91 draconic
# 92 meditative
# 93 summoner_unchained

echo "{ gsub("[ /]", "_", $1); gsub("[,']", "", $1); fn = sprintf("/tmp/tmp/%s.html", $1); printf "%s\n", $2 > fn; }" > /tmp/a.awk
cut -f1,21 -d"|" spell_full_-_updated_30marov2019.tsv | awk -F"|" -f /tmp/a.awk


cut -f1,21 spell_full_-_updated_30marov2019.tsv | awk -F"|" '{ gsub("[ /]", "_", $1); fn = sprintf("/tmp/tmp/%s.html", $1); printf "%s\n", $2 > fn; }'

{
}
