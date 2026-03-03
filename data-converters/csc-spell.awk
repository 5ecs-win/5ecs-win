# head -70 /home/tag/rpg/5etools/csc-spells/all-spell-json.txt | awk -f csc-spell.awk

BEGIN {
	splclass["Abi-Dalzim's Horrid Wilting"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Absorb Elements"] = "0,0,0,1,0,0,0,1,0,1,0,1";
	splclass["Acid Splash"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Aganazzar's Scorcher"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Aid"] = "0,1,1,0,0,0,1,1,0,0,0,0";
	splclass["Air Bubble"] = "0,0,0,1,0,0,0,1,0,1,0,1";
	splclass["Alarm"] = "0,0,0,0,0,0,0,1,0,0,0,1";
	splclass["Alter Self"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Animal Friendship"] = "0,1,0,1,0,0,0,1,0,0,0,0";
	splclass["Animal Messenger"] = "0,1,0,1,0,0,0,1,0,0,0,0";
	splclass["Animal Shapes"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Animate Dead"] = "0,0,1,0,0,0,0,0,0,0,0,1";
	splclass["Animate Objects"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Antagonize"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Antilife Shell"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Antimagic Field"] = "0,0,1,0,0,0,0,0,0,0,0,1";
	splclass["Antipathy/Sympathy"] = "0,1,0,1,0,0,0,0,0,0,0,1";
	splclass["Arboreal Curse"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Arcane Eye"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Arcane Gate"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Arcane Lock"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Armor of Agathys"] = "0,0,0,0,0,0,0,0,0,0,1,0";
	splclass["Arms of Hadar"] = "0,0,0,0,0,0,0,0,0,0,1,0";
	splclass["Ashardalon's Stride"] = "0,0,0,0,0,0,0,1,0,1,0,1";
	splclass["Astral Projection"] = "0,0,1,0,0,1,0,0,0,0,1,1";
	splclass["Augury"] = "0,0,1,1,0,0,0,0,0,0,0,1";
	splclass["Aura of Life"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Aura of Purity"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Aura of Vitality"] = "0,0,1,1,0,0,1,0,0,0,0,0";
	splclass["Awaken"] = "0,1,0,1,0,0,0,0,0,0,0,0";
	splclass["Bane"] = "0,1,1,0,0,0,0,0,0,0,0,0";
	splclass["Banishing Smite"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Banishment"] = "0,0,1,0,0,0,1,0,0,1,1,1";
	splclass["Barkskin"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Beacon of Hope"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Beast Bond"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Beast Sense"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Bestow Curse"] = "0,1,1,0,0,0,0,0,0,0,0,1";
	splclass["Bigby's Hand"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Blade Barrier"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Blade of Disaster"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Blade Ward"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Bless"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Blight"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Blinding Smite"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Blindness/Deafness"] = "0,1,1,0,0,0,0,0,0,1,0,1";
	splclass["Blink"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Blur"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Bones of the Earth"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Booming Blade"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Borrowed Knowledge"] = "0,1,1,0,0,0,0,0,0,0,1,1";
	splclass["Branding Smite"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Burning Hands"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Call Lightning"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Calm Emotions"] = "0,1,1,0,0,0,0,0,0,0,0,0";
	splclass["Catapult"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Catnap"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Cause Fear"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Ceremony"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Chain Lightning"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Chaos Bolt"] = "0,0,0,0,0,0,0,0,0,1,0,0";
	splclass["Charm Monster"] = "0,1,0,1,0,0,0,0,0,1,1,1";
	splclass["Charm Person"] = "0,1,0,1,0,0,0,0,0,1,1,1";
	splclass["Chill Touch"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Chromatic Orb"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Circle of Death"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Circle of Power"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Clairvoyance"] = "0,1,1,0,0,0,0,0,0,1,0,1";
	splclass["Clone"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Cloudkill"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Cloud of Daggers"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Color Spray"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Command"] = "0,1,1,0,0,0,1,0,0,0,0,0";
	splclass["Commune"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Commune with Nature"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Compelled Duel"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Comprehend Languages"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Compulsion"] = "0,1,0,0,0,0,0,0,0,0,0,0";
	splclass["Cone of Cold"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Confusion"] = "0,1,0,1,0,0,0,0,0,1,0,1";
	splclass["Conjure Animals"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Conjure Barrage"] = "0,0,0,0,0,0,0,1,0,0,0,0";
	splclass["Conjure Celestial"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Conjure Elemental"] = "0,0,0,1,0,0,0,0,0,0,0,1";
	splclass["Conjure Fey"] = "0,0,0,1,0,0,0,0,0,0,1,0";
	splclass["Conjure Minor Elementals"] = "0,0,0,1,0,0,0,0,0,0,0,1";
	splclass["Conjure the Deep Haze"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Conjure Volley"] = "0,0,0,0,0,0,0,1,0,0,0,0";
	splclass["Conjure Woodland Beings"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Consume Mind"] = "0,0,1,0,0,0,0,0,0,0,1,1";
	splclass["Contact Other Plane"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Contagion"] = "0,0,1,1,0,0,0,0,0,0,0,0";
	splclass["Contaminated Power"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Contamination Immunity"] = "0,1,1,1,0,0,0,0,0,1,1,1";
	splclass["Contingency"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Continual Flame"] = "0,0,1,1,0,0,0,0,0,0,0,1";
	splclass["Control Flames"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Control Water"] = "0,0,1,1,0,0,0,0,0,0,0,1";
	splclass["Control Weather"] = "0,0,1,1,0,0,0,0,0,0,0,1";
	splclass["Control Winds"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Cordon of Arrows"] = "0,0,0,0,0,0,0,1,0,0,0,0";
	splclass["Counterspell"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Create Bonfire"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Create Food and Water"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Create Homunculus"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Create Magen"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Create or Destroy Water"] = "0,0,1,1,0,0,0,0,0,0,0,0";
	splclass["Create Spelljamming Helm"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Create Undead"] = "0,0,1,0,0,0,0,0,0,0,1,1";
	splclass["Creation"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Crown of Madness"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Crown of Stars"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Crusader's Mantle"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Cure Wounds"] = "0,1,1,1,0,0,1,1,0,0,0,0";
	splclass["Dancing Lights"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Danse Macabre"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Darkness"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Darkvision"] = "0,0,0,1,0,0,0,1,0,1,0,1";
	splclass["Dawn"] = "0,0,1,0,0,0,0,0,0,0,0,1";
	splclass["Daylight"] = "0,0,1,1,0,0,1,1,0,1,0,0";
	splclass["Death Ward"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Delayed Blast Fireball"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Delerium Blast"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Delerium Orb"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Demiplane"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Destructive Wave"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Detect Evil and Good"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Detect Magic"] = "0,1,1,1,0,0,1,1,0,1,0,1";
	splclass["Detect Poison and Disease"] = "0,0,1,1,0,0,1,1,0,0,0,0";
	splclass["Detect Thoughts"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Dimension Door"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Disguise Self"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Disintegrate"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Dispel Evil and Good"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Dispel Magic"] = "0,1,1,1,0,0,1,0,0,1,1,1";
	splclass["Dissonant Whispers"] = "0,1,0,0,0,0,0,0,0,0,0,0";
	splclass["Distort Value"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Divination"] = "0,0,1,1,0,0,0,0,0,0,0,1";
	splclass["Divine Favor"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Divine Word"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Dominate Beast"] = "0,0,0,1,0,0,0,1,0,1,0,0";
	splclass["Dominate Monster"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Dominate Person"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Draconic Transformation"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Dragon's Breath"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Drawmij's Instant Summons"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Dream"] = "0,1,0,0,0,0,0,0,0,0,1,1";
	splclass["Dream of the Blue Veil"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Druidcraft"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Druid Grove"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Dust Devil"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Earthbind"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Earthquake"] = "0,0,1,1,0,0,0,0,0,1,0,0";
	splclass["Earth Tremor"] = "0,1,0,1,0,0,0,0,0,1,0,1";
	splclass["Eldritch Blast"] = "0,0,0,0,0,0,0,0,0,0,1,0";
	splclass["Elemental Bane"] = "0,0,0,1,0,0,0,0,0,0,1,1";
	splclass["Elemental Weapon"] = "0,0,0,1,0,0,1,1,0,0,0,0";
	splclass["Enemies Abound"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Enervation"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Enhance Ability"] = "0,1,1,1,0,0,0,1,0,1,0,1";
	splclass["Enlarge/Reduce"] = "0,1,0,1,0,0,0,0,0,1,0,1";
	splclass["Ensnaring Strike"] = "0,0,0,0,0,0,0,1,0,0,0,0";
	splclass["Entangle"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Enthrall"] = "0,1,0,0,0,0,0,0,0,0,1,0";
	splclass["Erupting Earth"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Etherealness"] = "0,1,1,0,0,0,0,0,0,1,1,1";
	splclass["Evard's Black Tentacles"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Expeditious Retreat"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Eyebite"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Fabricate"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Faerie Fire"] = "0,1,0,1,0,0,0,0,0,0,0,0";
	splclass["False Life"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Far Step"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Fast Friends"] = "0,1,1,0,0,0,0,0,0,0,0,1";
	splclass["Fear"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Feather Fall"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Feeblemind"] = "0,1,0,1,0,0,0,0,0,0,1,1";
	splclass["Feign Death"] = "0,1,1,1,0,0,0,0,0,0,0,1";
	splclass["Find Familiar"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Find Greater Steed"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Find Steed"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Find the Path"] = "0,1,1,1,0,0,0,0,0,0,0,0";
	splclass["Find Traps"] = "0,0,1,1,0,0,0,1,0,0,0,0";
	splclass["Finger of Death"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Fireball"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Fire Bolt"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Fire Shield"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Fire Storm"] = "0,0,1,1,0,0,0,0,0,1,0,0";
	splclass["Fizban's Platinum Shield"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Flame Arrows"] = "0,0,0,1,0,0,0,1,0,1,0,1";
	splclass["Flame Blade"] = "0,0,0,1,0,0,0,0,0,1,0,0";
	splclass["Flame Strike"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Flaming Sphere"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Flesh to Stone"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Flock of Familiars"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Fly"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Fog Cloud"] = "0,0,0,1,0,0,0,1,0,1,0,1";
	splclass["Forbiddance"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Forcecage"] = "0,1,0,0,0,0,0,0,0,0,1,1";
	splclass["Forced Evolution"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Foresight"] = "0,1,0,1,0,0,0,0,0,0,1,1";
	splclass["Freedom of Movement"] = "0,1,1,1,0,0,0,1,0,0,0,0";
	splclass["Freedom of the Waves"] = "0,0,0,1,0,0,0,1,0,1,0,0";
	splclass["Freedom of the Winds"] = "0,0,0,1,0,0,0,1,0,1,0,0";
	splclass["Friends"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Frostbite"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Frost Fingers"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Galder's Speedy Courier"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Galder's Tower"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Gaseous Form"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Gate"] = "0,0,1,0,0,0,0,0,0,1,1,1";
	splclass["Gate Seal"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Geas"] = "0,1,1,1,0,0,1,0,0,0,0,1";
	splclass["Gentle Repose"] = "0,0,1,0,0,0,1,0,0,0,0,1";
	splclass["Giant Insect"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Gift of Gab"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Glibness"] = "0,1,0,0,0,0,0,0,0,0,1,0";
	splclass["Globe of Invulnerability"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Glyph of Warding"] = "0,1,1,0,0,0,0,0,0,0,0,1";
	splclass["Goodberry"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Grasping Vine"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Grease"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Greater Invisibility"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Greater Restoration"] = "0,1,1,1,0,0,0,1,0,0,0,0";
	splclass["Green-Flame Blade"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Guardian of Faith"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Guardian of Nature"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Guards and Wards"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Guidance"] = "0,0,1,1,0,0,0,0,0,0,0,0";
	splclass["Guiding Bolt"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Gust"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Gust of Wind"] = "0,0,0,1,0,0,0,1,0,1,0,1";
	splclass["Hail of Thorns"] = "0,0,0,0,0,0,0,1,0,0,0,0";
	splclass["Hallow"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Hallucinatory Terrain"] = "0,1,0,1,0,0,0,0,0,0,1,1";
	splclass["Harm"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Haste"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Heal"] = "0,0,1,1,0,0,0,0,0,0,0,0";
	splclass["Healing Spirit"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Healing Word"] = "0,1,1,1,0,0,0,0,0,0,0,0";
	splclass["Heartseeker"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Heat Metal"] = "0,1,0,1,0,0,0,0,0,0,0,0";
	splclass["Hellish Rebuke"] = "0,0,0,0,0,0,0,0,0,0,1,0";
	splclass["Heroes' Feast"] = "0,1,1,1,0,0,0,0,0,0,0,0";
	splclass["Heroism"] = "0,1,0,0,0,0,1,0,0,0,0,0";
	splclass["Hex"] = "0,0,0,0,0,0,0,0,0,0,1,0";
	splclass["Hold Monster"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Hold Person"] = "0,1,1,1,0,0,0,0,0,1,1,1";
	splclass["Holy Aura"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Holy Weapon"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Hunger of Hadar"] = "0,0,0,0,0,0,0,0,0,0,1,0";
	splclass["Hunter Sense"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Hunter's Mark"] = "0,0,0,0,0,0,0,1,0,0,0,0";
	splclass["Hypnotic Pattern"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Ice Knife"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Ice Storm"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Identify"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Illusory Dragon"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Illusory Script"] = "0,1,0,0,0,0,0,0,0,0,1,1";
	splclass["Immolation"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Imprisonment"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Incendiary Cloud"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Incite Greed"] = "0,0,1,0,0,0,0,0,0,0,1,1";
	splclass["Infernal Calling"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Infestation"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Inflict Wounds"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Insect Plague"] = "0,0,1,1,0,0,0,0,0,1,0,0";
	splclass["Intellect Fortress"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Investiture of Flame"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Investiture of Ice"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Investiture of Stone"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Investiture of Wind"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Invisibility"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Invulnerability"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Jim's Glowing Coin"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Jim's Magic Missile"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Jump"] = "0,0,0,1,0,0,0,1,0,1,0,1";
	splclass["Kinetic Jaunt"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Knock"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Legend Lore"] = "0,1,1,0,0,0,0,0,0,0,0,1";
	splclass["Leomund's Secret Chest"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Leomund's Tiny Hut"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Lesser Restoration"] = "0,1,1,1,0,0,1,1,0,0,0,0";
	splclass["Levitate"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Life Transference"] = "0,0,1,0,0,0,0,0,0,0,0,1";
	splclass["Light"] = "0,1,1,0,0,0,0,0,0,1,0,1";
	splclass["Lightning Arrow"] = "0,0,0,0,0,0,0,1,0,0,0,0";
	splclass["Lightning Bolt"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Lightning Lure"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Linked Glyphs"] = "0,1,1,0,0,0,0,0,0,0,0,1";
	splclass["Locate Animals or Plants"] = "0,1,0,1,0,0,0,1,0,0,0,0";
	splclass["Locate Creature"] = "0,1,1,1,0,0,1,1,0,0,0,1";
	splclass["Locate Object"] = "0,1,1,1,0,0,1,1,0,0,0,1";
	splclass["Longstrider"] = "0,1,0,1,0,0,0,1,0,0,0,1";
	splclass["Maddening Darkness"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Maelstrom"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Mage Armor"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Mage Hand"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Magic Circle"] = "0,0,1,0,0,0,1,0,0,0,1,1";
	splclass["Magic Jar"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Magic Mirror"] = "0,0,0,0,0,0,0,0,0,1,0,0";
	splclass["Magic Missile"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Magic Mouth"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Magic Stone"] = "0,0,0,1,0,0,0,0,0,0,1,0";
	splclass["Magic Weapon"] = "0,0,0,0,0,0,1,1,0,1,0,1";
	splclass["Major Image"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Mass Cure Wounds"] = "0,1,1,1,0,0,0,0,0,0,0,0";
	splclass["Mass Heal"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Mass Healing Word"] = "0,1,1,0,0,0,0,0,0,0,0,0";
	splclass["Mass Polymorph"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Mass Suggestion"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Maximilian's Earthen Grasp"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Maze"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Meld into Stone"] = "0,0,1,1,0,0,0,1,0,0,0,0";
	splclass["Melf's Acid Arrow"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Melf's Minute Meteors"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Mending"] = "0,1,1,1,0,0,0,0,0,1,0,1";
	splclass["Mental Prison"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Message"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Meteor Swarm"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Mighty Fortress"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Mind Blank"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Mind Sliver"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Mind Spike"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Minor Illusion"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Mirage Arcane"] = "0,1,0,1,0,0,0,0,0,0,0,1";
	splclass["Mirror Image"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Mislead"] = "0,1,0,0,0,0,0,0,0,0,1,1";
	splclass["Misty Step"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Modify Memory"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Mold Earth"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Moonbeam"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Mordenkainen's Faithful Hound"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Mordenkainen's Magnificent Mansion"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Mordenkainen's Private Sanctum"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Mordenkainen's Sword"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Motivational Speech"] = "0,1,1,0,0,0,0,0,0,0,0,0";
	splclass["Move Earth"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Nathair's Mischief"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Negative Energy Flood"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Neutralizing Field"] = "0,1,1,1,0,0,1,1,0,1,1,1";
	splclass["Nondetection"] = "0,1,0,0,0,0,0,1,0,0,0,1";
	splclass["Nystul's Magic Aura"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Octarine Spray"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Otiluke's Freezing Sphere"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Otiluke's Resilient Sphere"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Otto's Irresistible Dance"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Passwall"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Pass without Trace"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Phantasmal Force"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Phantasmal Killer"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Phantom Steed"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Planar Ally"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Planar Binding"] = "0,1,1,1,0,0,0,0,0,0,1,1";
	splclass["Plane Shift"] = "0,0,1,1,0,0,0,0,0,1,1,1";
	splclass["Plant Growth"] = "0,1,0,1,0,0,0,1,0,0,0,0";
	splclass["Poison Spray"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Polymorph"] = "0,1,0,1,0,0,0,0,0,1,0,1";
	splclass["Power Word Heal"] = "0,1,1,0,0,0,0,0,0,0,0,0";
	splclass["Power Word Kill"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Power Word Pain"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Power Word Stun"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Prayer of Healing"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Prestidigitation"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Primal Savagery"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Primordial Ward"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Prismatic Spray"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Prismatic Wall"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Produce Flame"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Programmed Illusion"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Project Image"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Protection from Energy"] = "0,0,1,1,0,0,0,1,0,1,0,1";
	splclass["Protection from Evil and Good"] = "0,0,1,1,0,0,1,0,0,0,1,1";
	splclass["Protection from Poison"] = "0,0,1,1,0,0,1,1,0,0,0,0";
	splclass["Psychic Scream"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Purge Contamination"] = "0,1,1,1,0,0,1,1,0,1,1,1";
	splclass["Purify Food and Drink"] = "0,0,1,1,0,0,1,0,0,0,0,0";
	splclass["Pyrotechnics"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Raise Dead"] = "0,1,1,0,0,0,1,0,0,0,0,0";
	splclass["Rary's Telepathic Bond"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Raulothim's Psychic Lance"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Ray of Contamination"] = "0,0,0,1,0,0,0,0,0,1,1,1";
	splclass["Ray of Enfeeblement"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Ray of Frost"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Ray of Sickness"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Regenerate"] = "0,1,1,1,0,0,0,0,0,0,0,0";
	splclass["Reincarnate"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Remove Curse"] = "0,0,1,0,0,0,1,0,0,0,1,1";
	splclass["Resistance"] = "0,0,1,1,0,0,0,0,0,0,0,0";
	splclass["Resurrection"] = "0,1,1,0,0,0,0,0,0,0,0,0";
	splclass["Reverse Gravity"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Revivify"] = "0,0,1,1,0,0,1,1,0,0,0,0";
	splclass["Ride the Rifts"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Rime's Binding Ice"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Rope Trick"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Sacrament of the Falling Fire"] = "0,1,1,1,0,0,0,0,0,0,1,0";
	splclass["Sacred Flame"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Sanctuary"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Scatter"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Scorching Ray"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Scrying"] = "0,1,1,1,0,0,0,0,0,0,1,1";
	splclass["Searing Smite"] = "0,0,0,0,0,0,1,1,0,0,0,0";
	splclass["See Invisibility"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Seeming"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Sending"] = "0,1,1,0,0,0,0,0,0,0,0,1";
	splclass["Sequester"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Shadow Blade"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Shadow of Moil"] = "0,0,0,0,0,0,0,0,0,0,1,0";
	splclass["Shapechange"] = "0,0,0,1,0,0,0,0,0,0,0,1";
	splclass["Shape Water"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Shatter"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Shield"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Shield of Faith"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Shillelagh"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Shocking Grasp"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Sickening Radiance"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Silence"] = "0,1,1,0,0,0,0,1,0,0,0,0";
	splclass["Silent Image"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Silvery Barbs"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Simulacrum"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Siphon Contamination"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Skill Empowerment"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Skywrite"] = "0,1,0,1,0,0,0,0,0,0,0,1";
	splclass["Sleep"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Sleet Storm"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Slow"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Snare"] = "0,0,0,1,0,0,0,1,0,0,0,1";
	splclass["Snilloc's Snowball Swarm"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Soul Cage"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Spare the Dying"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Speak with Animals"] = "0,1,0,1,0,0,0,1,0,0,0,0";
	splclass["Speak with Dead"] = "0,1,1,0,0,0,0,0,0,0,0,1";
	splclass["Speak with Plants"] = "0,1,0,1,0,0,0,1,0,0,0,0";
	splclass["Spider Climb"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Spike Growth"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Spirit Guardians"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Spirit of Death"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Spirit Shroud"] = "0,0,1,0,0,0,1,0,0,0,1,1";
	splclass["Spiritual Weapon"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Spray of Cards"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Staggering Smite"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Steel Wind Strike"] = "0,0,0,0,0,0,0,1,0,0,0,1";
	splclass["Stinking Cloud"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Stone Shape"] = "0,0,1,1,0,0,0,0,0,0,0,1";
	splclass["Stoneskin"] = "0,0,0,1,0,0,0,1,0,1,0,1";
	splclass["Storm of Vengeance"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Storm Sphere"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Suffocate"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Suggestion"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Summon Aberration"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Summon Beast"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Summon Celestial"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Summon Construct"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Summon Draconic Spirit"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Summon Elemental"] = "0,0,0,1,0,0,0,1,0,0,0,1";
	splclass["Summon Fey"] = "0,0,0,1,0,0,0,1,0,0,1,1";
	splclass["Summon Fiend"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Summon Greater Demon"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Summon Lesser Demons"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Summon Shadowspawn"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Summon Undead"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Sunbeam"] = "0,0,1,1,0,0,0,0,0,1,0,1";
	splclass["Sunburst"] = "0,0,1,1,0,0,0,0,0,1,0,1";
	splclass["Swift Quiver"] = "0,0,0,0,0,0,0,1,0,0,0,0";
	splclass["Sword Burst"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Symbol"] = "0,1,1,1,0,0,0,0,0,0,0,1";
	splclass["Synaptic Static"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Tasha's Caustic Brew"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Tasha's Hideous Laughter"] = "0,1,0,0,0,0,0,0,0,0,0,1";
	splclass["Tasha's Mind Whip"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Tasha's Otherworldly Guise"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Telekinesis"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Telepathy"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Teleport"] = "0,1,0,0,0,0,0,0,0,1,0,1";
	splclass["Teleportation Circle"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Temple of the Gods"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Tenser's Floating Disk"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Tenser's Transformation"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Thaumaturgy"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Thorn Whip"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Thunderclap"] = "0,1,0,1,0,0,0,0,0,1,1,1";
	splclass["Thunderous Smite"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Thunder Step"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Thunderwave"] = "0,1,0,1,0,0,0,0,0,1,0,1";
	splclass["Tidal Wave"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Time Stop"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Tiny Servant"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Toll the Dead"] = "0,0,1,0,0,0,0,0,0,0,1,1";
	splclass["Tongues"] = "0,1,1,0,0,0,0,0,0,1,1,1";
	splclass["Transmute Rock"] = "0,0,0,1,0,0,0,0,0,0,0,1";
	splclass["Transport via Plants"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Tree Stride"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["True Polymorph"] = "0,1,0,0,0,0,0,0,0,0,1,1";
	splclass["True Resurrection"] = "0,0,1,1,0,0,0,0,0,0,0,0";
	splclass["True Seeing"] = "0,1,1,0,0,0,0,0,0,1,1,1";
	splclass["True Strike"] = "0,1,0,0,0,0,0,0,0,1,1,1";
	splclass["Tsunami"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Unseen Servant"] = "0,1,0,0,0,0,0,0,0,0,1,1";
	splclass["Vampiric Touch"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Vicious Mockery"] = "0,1,0,0,0,0,0,0,0,0,0,0";
	splclass["Vitriolic Sphere"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Vortex Warp"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Wall of Fire"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Wall of Force"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Wall of Ice"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Wall of Light"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Wall of Sand"] = "0,0,0,0,0,0,0,0,0,0,0,1";
	splclass["Wall of Stone"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Wall of Thorns"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Wall of Water"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Warding Bond"] = "0,0,1,0,0,0,1,0,0,0,0,0";
	splclass["Warding Wind"] = "0,1,0,1,0,0,0,0,0,1,0,1";
	splclass["Warp Bolt"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Warp Sense"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Water Breathing"] = "0,0,0,1,0,0,0,1,0,1,0,1";
	splclass["Water Walk"] = "0,0,1,1,0,0,0,1,0,1,0,0";
	splclass["Watery Sphere"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Web"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Weird"] = "0,0,0,0,0,0,0,0,0,0,1,1";
	splclass["Whirlwind"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Wind Walk"] = "0,0,0,1,0,0,0,0,0,0,0,0";
	splclass["Wind Wall"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Wish"] = "0,0,0,0,0,0,0,0,0,1,0,1";
	splclass["Witch Bolt"] = "0,0,0,0,0,0,0,0,0,1,1,1";
	splclass["Wither and Bloom"] = "0,0,0,1,0,0,0,0,0,1,0,1";
	splclass["Word of Radiance"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Word of Recall"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Wrack"] = "0,0,1,0,0,0,0,0,0,0,0,0";
	splclass["Wrathful Smite"] = "0,0,0,0,0,0,1,0,0,0,0,0";
	splclass["Wrath of Nature"] = "0,0,0,1,0,0,0,1,0,0,0,0";
	splclass["Zephyr Strike"] = "0,0,0,0,0,0,0,1,0,0,0,0";
	splclass["Zone of Truth"] = "0,1,1,0,0,0,1,0,0,0,0,0";

	FS=":";
	spellname = "";
	spt[1] =	2; spt[2] =	3; spt[3] =	5; spt[4] =	6; spt[5] =	7; spt[6] =	9; spt[7] =	10; spt[8] = 11; spt[9] = 13;

	spellidx = -1;
}

{
	switch ($1) {
		case "abilityCheck.0":
			break;
		case "abilityCheck.1":
			break;
		case "additionalSources.0.page":
			break;
		case "additionalSources.0.source":
			break;
		case "affectsCreatureType.0":
		case "affectsCreatureType.1":
		case "affectsCreatureType.10":
		case "affectsCreatureType.11":
		case "affectsCreatureType.12":
		case "affectsCreatureType.13":
		case "affectsCreatureType.2":
		case "affectsCreatureType.3":
		case "affectsCreatureType.4":
		case "affectsCreatureType.5":
		case "affectsCreatureType.6":
		case "affectsCreatureType.7":
		case "affectsCreatureType.8":
		case "affectsCreatureType.9":
			break;
		case "areaTags.0":
		case "areaTags.1":
			break;
		case "basicRules":
			break;
		case "components.m.consume":
			break;
		case "components.m.cost":
			break;
		case "components.m.text":
			comp = sprintf("%s M", components); components = comp;
			gsub("\"", "", $2);
			compm = $2;
			break;
		case "components.m":
			comp = sprintf("%s M", components); components = comp;
			if (length($2) > 5) { gsub("\"", "", $2); compm = $2; }
			break;
		case "components.r":
			comp = sprintf("%s S", components); components = comp;
			break;
		case "components.s":
			comp = sprintf("%s S", components); components = comp;
			break;
		case "components.v":
			comp = sprintf("%s V", components); components = comp;
			break;
		case "conditionImmune.0":
			break;
		case "conditionImmune.1":
			break;
		case "conditionInflict.0":
		case "conditionInflict.1":
		case "conditionInflict.2":
		case "conditionInflict.3":
			break;
		case "damageImmune.0":
		case "damageImmune.1":
		case "damageImmune.10":
		case "damageImmune.11":
		case "damageImmune.12":
		case "damageImmune.2":
		case "damageImmune.3":
		case "damageImmune.4":
		case "damageImmune.5":
		case "damageImmune.6":
		case "damageImmune.7":
		case "damageImmune.8":
		case "damageImmune.9":
			break;
		case "damageInflict.0":
		case "damageInflict.1":
		case "damageInflict.2":
		case "damageInflict.3":
		case "damageInflict.4":
		case "damageInflict.5":
		case "damageInflict.6":
		case "damageInflict.7":
			break;
		case "damageResist.0":
		case "damageResist.1":
		case "damageResist.10":
		case "damageResist.11":
		case "damageResist.12":
		case "damageResist.2":
		case "damageResist.3":
		case "damageResist.4":
		case "damageResist.5":
		case "damageResist.6":
		case "damageResist.7":
		case "damageResist.8":
		case "damageResist.9":
			break;
		case "damageVulnerable.0":
		case "damageVulnerable.1":
		case "damageVulnerable.2":
		case "damageVulnerable.3":
		case "damageVulnerable.4":
		case "damageVulnerable.5":
		case "damageVulnerable.6":
		case "damageVulnerable.7":
		case "damageVulnerable.8":
		case "damageVulnerable.9":
			break;
		case "duration.0.concentration":
			concentration = 1;
			break;
		case "duration.0.duration.amount":
		case "duration.1.duration.amount":
			gsub("\"", "", $2);
			duration = sprintf("%s %s", $2, dtype);
			break;
		case "duration.0.duration.type":
		case "duration.1.duration.type":
			gsub("\"", "", $2);
			dtype = $2;
			break;
		case "duration.0.duration.upTo":
			break;
		case "duration.0.ends.0":
			break;
		case "duration.0.ends.1":
			break;
		case "duration.0.type":
			break;
		case "duration.1.type":
			break;
		case "freeRules2024":
			break;
		case "hasFluff":
			break;
		case "hasFluffImages":
			break;
		case "level":
			gsub(" ", "", $2);
			spelllevel = $2;
			break;
		case "meta.ritual":
			ritual = 1;
			break;
		case "miscTags.0":
		case "miscTags.1":
		case "miscTags.2":
		case "miscTags.3":
		case "miscTags.4":
			break;
		case "name":
			if (spellidx != -1) {

				gsub("\"", "", spelldetails); gsub("[|]phb", "", spelldetails);
				gsub("[|]", " ", spelldetails); gsub("}", "", spelldetails);
# char *range, *duration, *components, *material, *castingtime
				printf "{%d, %d, |%s|, {%s}, |%s|, |%s|, |%s|, |%s|, |%s|, %d, %d, |%s|},\n", spellidx, spelllevel, spellname, splclass[spellname], range, duration, components, compm, castingtime, ritual, concentration, spelldetails;
			}
			gsub("/", " or ", $2);
			gsub("\"", "", $2); gsub("^ ", "", $2);
			#gsub(" ", "_", $2); gsub("^_", "", $2); gsub("'", "", $2);
			spellname = $2;
			concentration = ritual = 0;
			spelldetails = compm = components = duration = ""
			spellidx++;
			break;
		case "otherSources.0.page":
		case "otherSources.1.page":
		case "otherSources.2.page":
			break;
		case "otherSources.0.source":
		case "otherSources.1.source":
		case "otherSources.2.source":
			break;
		case "page":
			break;
		case "range.distance.amount":
			range = sprintf("%s %s", $2, rtype);
			break;
		case "range.distance.type":
			gsub("\"", "", $2); gsub(" ", "", $2);
			rtype = $2;
			break;
		case "range.type":
			break;
		case "reprintedAs.0":
			break;
		case "savingThrow.0":
		case "savingThrow.1":
		case "savingThrow.2":
		case "savingThrow.3":
			break;
		case "scalingLevelDice.0.label":
			break;
		case "scalingLevelDice.0.scaling.1":
			break;
		case "scalingLevelDice.0.scaling.11":
			break;
		case "scalingLevelDice.0.scaling.17":
			break;
		case "scalingLevelDice.0.scaling.5":
			break;
		case "scalingLevelDice.1.label":
			break;
		case "scalingLevelDice.1.scaling.1":
			break;
		case "scalingLevelDice.1.scaling.11":
			break;
		case "scalingLevelDice.1.scaling.17":
			break;
		case "scalingLevelDice.1.scaling.5":
			break;
		case "scalingLevelDice.label":
			break;
		case "scalingLevelDice.scaling.1":
			break;
		case "scalingLevelDice.scaling.11":
			break;
		case "scalingLevelDice.scaling.17":
			break;
		case "scalingLevelDice.scaling.5":
			break;
		case "school":
			break;
		case "source":
			gsub("\"", "", $2);
			source = $2;
			break;
		case "spellAttack.0":
			break;
		case "srd":
			break;
		case "subschools.0":
			break;
		case "time.0.condition":
			gsub("\"", "", $2);
			castingtime = sprintf("%s (%s)", castingtime, $2);
			break;
		case "time.0.note":
			break;
		case "time.0.number":
			ctime = $2;
			break;
		case "time.0.unit":
			gsub("\"", "", $2);
			castingtime = sprintf("%s %s", ctime, $2);
			break;
		case "time.1.note":
			break;
		case "time.1.number":
			break;
		case "time.1.unit":
			break;
		case "entries.0":
		case "entries.1":
		case "entries.11":
		case "entries.13":
		case "entries.14":
		case "entries.2":
		case "entries.3":
		case "entries.4":
		case "entries.5":
		case "entries.6":
		case "entries.7":
		case "entries.8":
		case "entries.9":
			gsub("\"", "", $2);
			temp = sprintf("%s %s", spelldetails, $2); spelldetails = sprintf("%s", temp);
			break;
		case "entries.0.by":
			break;
		case "entries.1.caption":
		case "entries.2.caption":
		case "entries.3.caption":
		case "entries.4.caption":
		case "entries.5.caption":
			break;
		case "entries.1.colLabels.0":
		case "entries.2.colLabels.0":
		case "entries.3.colLabels.0":
		case "entries.4.colLabels.0":
		case "entries.5.colLabels.0":
		case "entries.1.colLabels.1":
		case "entries.2.colLabels.1":
		case "entries.3.colLabels.1":
		case "entries.4.colLabels.1":
		case "entries.5.colLabels.1":
		case "entries.2.colLabels.2":
		case "entries.2.colLabels.3":
		case "entries.2.colLabels.4":
		case "entries.2.colLabels.5":
			break;
		case "entries.1.colStyles.0":
		case "entries.2.colStyles.0":
		case "entries.3.colStyles.0":
		case "entries.4.colStyles.0":
		case "entries.5.colStyles.0":
		case "entries.1.colStyles.1":
		case "entries.2.colStyles.1":
		case "entries.3.colStyles.1":
		case "entries.4.colStyles.1":
		case "entries.5.colStyles.1":
		case "entries.2.colStyles.2":
		case "entries.2.colStyles.3":
		case "entries.2.colStyles.4":
		case "entries.2.colStyles.5":
			break;
		case "entries.0.entries.0":
		case "entries.10.entries.0":
		case "entries.11.entries.0":
		case "entries.12.entries.0":
		case "entries.1.entries.0":
		case "entries.2.entries.0":
		case "entries.3.entries.0":
		case "entries.4.entries.0":
		case "entries.5.entries.0":
		case "entries.6.entries.0":
		case "entries.7.entries.0":
		case "entries.8.entries.0":
		case "entries.9.entries.0":
			break;
		case "entriesHigherLevel.0.entries.0":
			gsub("\"", "", $2);
			temp = sprintf("%s %s", spelldetails, $2); spelldetails = sprintf("%s", temp);
			break;
		case "entries.1.entries.1":
		case "entries.2.entries.1":
		case "entries.3.entries.1":
		case "entries.4.entries.1":
		case "entries.5.entries.1":
		case "entries.9.entries.1":
			break;
		case "entries.2.entries.1.items.0.entries.0":
			break;
		case "entries.2.entries.1.items.0.name":
			break;
		case "entries.2.entries.1.items.0.type":
			break;
		case "entries.2.entries.1.items.1.entries.0":
			break;
		case "entries.2.entries.1.items.1.name":
			break;
		case "entries.2.entries.1.items.1.type":
			break;
		case "entries.2.entries.1.items.2.entries.0":
			break;
		case "entries.2.entries.1.items.2.name":
			break;
		case "entries.2.entries.1.items.2.type":
			break;
		case "entries.2.entries.1.items.3.entries.0":
			break;
		case "entries.2.entries.1.items.3.name":
			break;
		case "entries.2.entries.1.items.3.type":
			break;
		case "entries.2.entries.1.items.4.entries.0":
			break;
		case "entries.2.entries.1.items.4.name":
			break;
		case "entries.2.entries.1.items.4.type":
			break;
		case "entries.2.entries.1.items.5.entries.0":
			break;
		case "entries.2.entries.1.items.5.name":
			break;
		case "entries.2.entries.1.items.5.type":
			break;
		case "entries.2.entries.1.items.6.entries.0":
			break;
		case "entries.2.entries.1.items.6.name":
			break;
		case "entries.2.entries.1.items.6.type":
			break;
		case "entries.2.entries.1.items.7.entries.0":
			break;
		case "entries.2.entries.1.items.7.name":
			break;
		case "entries.2.entries.1.items.7.type":
			break;
		case "entries.2.entries.1.items.8.entries.0":
			break;
		case "entries.2.entries.1.items.8.name":
			break;
		case "entries.2.entries.1.items.8.type":
			break;
		case "entries.2.entries.1.items.9.entries.0":
			break;
		case "entries.2.entries.1.items.9.name":
			break;
		case "entries.2.entries.1.items.9.type":
			break;
		case "entries.3.entries.1.items.0":
		case "entries.3.entries.1.items.1":
		case "entries.3.entries.1.items.2":
		case "entries.3.entries.1.items.3":
		case "entries.3.entries.1.items.4":
		case "entries.3.entries.1.items.5":
		case "entries.6.entries.1.items.0":
		case "entries.6.entries.1.items.1":
		case "entries.6.entries.1.items.2":
		case "entries.6.entries.1.items.3":
		case "entries.6.entries.1.items.4":
			break;
		case "entries.2.entries.1.style":
			break;
		case "entries.2.entries.1.type":
		case "entries.3.entries.1.type":
		case "entries.6.entries.1.type":
			break;
		case "entries.1.entries.2":
		case "entries.2.entries.2":
		case "entries.3.entries.2":
		case "entries.4.entries.2":
		case "entries.2.entries.3":
			break;
		case "entries.1.items.0":
		case "entries.2.items.0":
		case "entries.4.items.0":
		case "entries.7.items.0":
			break;
		case "entries.1.items.0.entries.0":
		case "entries.2.items.0.entries.0":
		case "entries.3.items.0.entries.0":
			break;
		case "entries.1.items.0.name":
		case "entries.2.items.0.name":
		case "entries.3.items.0.name":
			break;
		case "entries.1.items.0.type":
		case "entries.2.items.0.type":
		case "entries.3.items.0.type":
			break;
		case "entries.1.items.1":
		case "entries.2.items.1":
		case "entries.4.items.1":
		case "entries.7.items.1":
			break;
		case "entries.1.items.1.entries.0":
		case "entries.2.items.1.entries.0":
		case "entries.3.items.1.entries.0":
			break;
		case "entries.1.items.1.name":
		case "entries.2.items.1.name":
		case "entries.3.items.1.name":
			break;
		case "entries.1.items.1.type":
		case "entries.2.items.1.type":
		case "entries.3.items.1.type":
			break;
		case "entries.1.items.2":
		case "entries.2.items.2":
		case "entries.4.items.2":
		case "entries.7.items.2":
			break;
		case "entries.1.items.2.entries.0":
		case "entries.2.items.2.entries.0":
		case "entries.3.items.2.entries.0":
			break;
		case "entries.1.items.2.name":
		case "entries.2.items.2.name":
		case "entries.3.items.2.name":
			break;
		case "entries.1.items.2.type":
		case "entries.2.items.2.type":
		case "entries.3.items.2.type":
			break;
		case "entries.1.items.3":
		case "entries.2.items.3":
		case "entries.4.items.3":
			break;
		case "entries.1.items.3.entries.0":
		case "entries.2.items.3.entries.0":
		case "entries.3.items.3.entries.0":
			break;
		case "entries.1.items.3.name":
		case "entries.2.items.3.name":
		case "entries.3.items.3.name":
			break;
		case "entries.1.items.3.type":
		case "entries.2.items.3.type":
		case "entries.3.items.3.type":
			break;
		case "entries.1.items.4":
		case "entries.2.items.4":
			break;
		case "entries.1.items.4.entries.0":
		case "entries.2.items.4.entries.0":
		case "entries.3.items.4.entries.0":
			break;
		case "entries.1.items.4.name":
		case "entries.2.items.4.name":
		case "entries.3.items.4.name":
			break;
		case "entries.1.items.4.type":
		case "entries.2.items.4.type":
		case "entries.3.items.4.type":
			break;
		case "entries.1.items.5":
		case "entries.2.items.5":
			break;
		case "entries.3.items.5.entries.0":
			break;
		case "entries.3.items.5.name":
			break;
		case "entries.3.items.5.type":
			break;
		case "entries.1.items.6":
			break;
		case "entries.3.items.6.entries.0":
			break;
		case "entries.3.items.6.name":
			break;
		case "entries.3.items.6.type":
			break;
		case "entries.10.name":
		case "entries.11.name":
		case "entries.12.name":
		case "entries.1.name":
		case "entries.2.name":
		case "entries.3.name":
		case "entries.4.name":
		case "entries.5.name":
		case "entries.6.name":
		case "entries.7.name":
		case "entries.8.name":
		case "entries.9.name":
			break;
		case "entriesHigherLevel.0.name":
			break;
		case "entries.5.page":
			break;
		case "entries.1.rows.0.0":
			break;
		case "entries.1.rows.0.0.roll.exact":
			break;
		case "entries.1.rows.0.0.roll.max":
			break;
		case "entries.1.rows.0.0.roll.min":
			break;
		case "entries.1.rows.0.0.type":
			break;
		case "entries.2.rows.0.0":
			break;
		case "entries.2.rows.0.0.roll.exact":
			break;
		case "entries.2.rows.0.0.roll.max":
			break;
		case "entries.2.rows.0.0.roll.min":
			break;
		case "entries.2.rows.0.0.roll.pad":
			break;
		case "entries.2.rows.0.0.type":
			break;
		case "entries.3.rows.0.0":
		case "entries.4.rows.0.0":
		case "entries.5.rows.0.0":
		case "entries.1.rows.0.1":
		case "entries.2.rows.0.1":
		case "entries.3.rows.0.1":
		case "entries.4.rows.0.1":
		case "entries.5.rows.0.1":
		case "entries.2.rows.0.2":
		case "entries.2.rows.0.3":
		case "entries.2.rows.0.4":
		case "entries.2.rows.0.5":
		case "entries.1.rows.1.0":
			break;
		case "entries.1.rows.1.0.roll.exact":
			break;
		case "entries.1.rows.1.0.roll.max":
			break;
		case "entries.1.rows.1.0.roll.min":
			break;
		case "entries.1.rows.1.0.type":
			break;
		case "entries.2.rows.1.0":
			break;
		case "entries.2.rows.1.0.roll.max":
			break;
		case "entries.2.rows.1.0.roll.min":
			break;
		case "entries.2.rows.1.0.roll.pad":
			break;
		case "entries.2.rows.1.0.type":
			break;
		case "entries.3.rows.1.0":
		case "entries.4.rows.1.0":
		case "entries.5.rows.1.0":
			break;
		case "entries.2.rows.10.0.roll.max":
			break;
		case "entries.2.rows.10.0.roll.min":
			break;
		case "entries.2.rows.10.0.type":
			break;
		case "entries.2.rows.10.1":
		case "entries.1.rows.1.1":
		case "entries.2.rows.1.1":
		case "entries.3.rows.1.1":
		case "entries.4.rows.1.1":
		case "entries.5.rows.1.1":
			break;
		case "entries.2.rows.11.0.roll.max":
			break;
		case "entries.2.rows.11.0.roll.min":
			break;
		case "entries.2.rows.11.0.type":
			break;
		case "entries.2.rows.11.1":
			break;
		case "entries.2.rows.1.2":
			break;
		case "entries.2.rows.12.0.roll.max":
			break;
		case "entries.2.rows.12.0.roll.min":
			break;
		case "entries.2.rows.12.0.type":
			break;
		case "entries.2.rows.12.1":
			break;
		case "entries.2.rows.1.3":
			break;
		case "entries.2.rows.13.0.roll.max":
			break;
		case "entries.2.rows.13.0.roll.min":
			break;
		case "entries.2.rows.13.0.roll.pad":
			break;
		case "entries.2.rows.13.0.type":
			break;
		case "entries.2.rows.13.1":
		case "entries.2.rows.1.4":
		case "entries.2.rows.1.5":
		case "entries.1.rows.2.0":
			break;
		case "entries.1.rows.2.0.roll.exact":
			break;
		case "entries.1.rows.2.0.roll.max":
			break;
		case "entries.1.rows.2.0.roll.min":
			break;
		case "entries.1.rows.2.0.type":
			break;
		case "entries.2.rows.2.0":
			break;
		case "entries.2.rows.2.0.roll.max":
			break;
		case "entries.2.rows.2.0.roll.min":
			break;
		case "entries.2.rows.2.0.type":
			break;
		case "entries.3.rows.2.0":
		case "entries.4.rows.2.0":
		case "entries.5.rows.2.0":
		case "entries.1.rows.2.1":
		case "entries.2.rows.2.1":
		case "entries.3.rows.2.1":
		case "entries.4.rows.2.1":
		case "entries.5.rows.2.1":
		case "entries.2.rows.2.2":
		case "entries.2.rows.2.3":
		case "entries.2.rows.2.4":
		case "entries.2.rows.2.5":
		case "entries.1.rows.3.0":
			break;
		case "entries.1.rows.3.0.roll.exact":
			break;
		case "entries.1.rows.3.0.type":
			break;
		case "entries.2.rows.3.0":
			break;
		case "entries.2.rows.3.0.roll.max":
			break;
		case "entries.2.rows.3.0.roll.min":
			break;
		case "entries.2.rows.3.0.type":
			break;
		case "entries.3.rows.3.0":
		case "entries.4.rows.3.0":
		case "entries.5.rows.3.0":
		case "entries.1.rows.3.1":
		case "entries.2.rows.3.1":
		case "entries.3.rows.3.1":
		case "entries.4.rows.3.1":
		case "entries.5.rows.3.1":
		case "entries.2.rows.3.2":
		case "entries.2.rows.3.3":
		case "entries.2.rows.3.4":
		case "entries.2.rows.3.5":
		case "entries.1.rows.4.0":
			break;
		case "entries.1.rows.4.0.roll.exact":
			break;
		case "entries.1.rows.4.0.type":
			break;
		case "entries.2.rows.4.0":
			break;
		case "entries.2.rows.4.0.roll.max":
			break;
		case "entries.2.rows.4.0.roll.min":
			break;
		case "entries.2.rows.4.0.type":
			break;
		case "entries.3.rows.4.0":
		case "entries.4.rows.4.0":
		case "entries.5.rows.4.0":
		case "entries.1.rows.4.1":
		case "entries.2.rows.4.1":
		case "entries.3.rows.4.1":
		case "entries.4.rows.4.1":
		case "entries.5.rows.4.1":
		case "entries.2.rows.4.2":
		case "entries.2.rows.4.3":
		case "entries.2.rows.4.4":
		case "entries.2.rows.4.5":
		case "entries.1.rows.5.0":
			break;
		case "entries.1.rows.5.0.roll.exact":
			break;
		case "entries.1.rows.5.0.type":
			break;
		case "entries.2.rows.5.0":
			break;
		case "entries.2.rows.5.0.roll.max":
			break;
		case "entries.2.rows.5.0.roll.min":
			break;
		case "entries.2.rows.5.0.type":
			break;
		case "entries.4.rows.5.0":
		case "entries.1.rows.5.1":
		case "entries.2.rows.5.1":
		case "entries.4.rows.5.1":
		case "entries.2.rows.5.2":
		case "entries.2.rows.5.3":
		case "entries.2.rows.5.4":
		case "entries.1.rows.6.0":
			break;
		case "entries.1.rows.6.0.roll.exact":
			break;
		case "entries.1.rows.6.0.type":
			break;
		case "entries.2.rows.6.0":
			break;
		case "entries.2.rows.6.0.roll.max":
			break;
		case "entries.2.rows.6.0.roll.min":
			break;
		case "entries.2.rows.6.0.type":
			break;
		case "entries.4.rows.6.0":
		case "entries.1.rows.6.1":
		case "entries.2.rows.6.1":
		case "entries.4.rows.6.1":
		case "entries.2.rows.6.2":
		case "entries.2.rows.6.3":
		case "entries.2.rows.6.4":
		case "entries.1.rows.7.0":
			break;
		case "entries.1.rows.7.0.roll.exact":
			break;
		case "entries.1.rows.7.0.type":
			break;
		case "entries.2.rows.7.0.roll.max":
			break;
		case "entries.2.rows.7.0.roll.min":
			break;
		case "entries.2.rows.7.0.type":
			break;
		case "entries.1.rows.7.1":
		case "entries.2.rows.7.1":
		case "entries.1.rows.8.0":
			break;
		case "entries.2.rows.8.0.roll.max":
			break;
		case "entries.2.rows.8.0.roll.min":
			break;
		case "entries.2.rows.8.0.type":
			break;
		case "entries.1.rows.8.1":
		case "entries.2.rows.8.1":
		case "entries.1.rows.9.0":
			break;
		case "entries.2.rows.9.0.roll.max":
			break;
		case "entries.2.rows.9.0.roll.min":
			break;
		case "entries.2.rows.9.0.type":
			break;
		case "entries.1.rows.9.1":
			break;
		case "entries.2.rows.9.1":
			break;
		case "entries.5.source":
			break;
		case "entries.1.style":
		case "entries.2.style":
		case "entries.3.style":
			break;
		case "entries.0.type":
		case "entries.10.type":
		case "entries.11.type":
		case "entries.12.type":
		case "entries.1.type":
		case "entries.2.type":
		case "entries.3.type":
		case "entries.4.type":
		case "entries.5.type":
		case "entries.6.type":
		case "entries.7.type":
		case "entries.8.type":
		case "entries.9.type":
			break;
		case "entriesHigherLevel.0.type":
			break;
	}
}
