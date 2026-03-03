function tagcut(str, bstr, estr) {
	bi = index(str, bstr); ei = index(str, estr);

	if (ei < bi) {
		nstr = substr(str, bi); ei = index(nstr, estr) + bi;
	}

	#printf "%s - %d / %d = %s\n", str, bi + length(bstr), ei, substr(str, bi + length(bstr), ei - bi - length(bstr));

	if (bi == 0 || ei == 0) { return ""; }

	return substr(str, bi + length(bstr), ei - bi - length(bstr));
}

function stattobonus (stat) {
   if (stat == 0 || stat == 1) return -5;
   if (stat == 2 || stat == 3) return -4;
   if (stat == 4 || stat == 5) return -3;
   if (stat == 6 || stat == 7) return -2;
   if (stat == 8 || stat == 9) return -1;
   if (stat == 10 || stat == 11) return +0;
   if (stat == 12 || stat == 13) return +1;
   if (stat == 14 || stat == 15) return +2;
   if (stat == 16 || stat == 17) return +3;
   if (stat == 18 || stat == 19) return +4;
   if (stat == 20 || stat == 21) return +5;
   if (stat == 22 || stat == 23) return +6;
   if (stat == 24 || stat == 25) return +7;
   if (stat == 26 || stat == 27) return +8;
   if (stat == 28 || stat == 29) return +9;
   if (stat > 29) return +10;
}

function addnote (str) {
	if (donote != 1 && length(str) > 1) {
		printf "fputs(\"+++%d|%d|\", nof);\n", monCnt, monCnt;
		donote = 1;
	}
	printf "fputs(\"%s|\", nof);\n", str;
}

BEGIN {
	FS=":";
	monCnt = -1;

	badMon = 4098;

nameSort["Aarakocra"] = 1; 
nameSort["Aarakocra Aeromancer 2025"] = 2; nameSort["Aarakocra Simulacrum"] = 3; nameSort["Aarakocra Skirmisher 2025"] = 4; nameSort["Aarakocra Spelljammer"] = 5; nameSort["Aartuk Elder"] = 6; nameSort["Aartuk Starhorror"] = 7; nameSort["Aartuk Weedling"] = 8; nameSort["Aberrant Cultist 2025"] = 9; nameSort["Aberrant Spirit"] = 10; nameSort["Aberrant Zealot"] = 11; nameSort["Aberrant Zealot (Tentacled)"] = 12; nameSort["Abhorrent Overlord"] = 13; nameSort["Abigor"] = 14; nameSort["Abjurer"] = 15; nameSort["Abjurer Wizard"] = 16; nameSort["Aboleth"] = 17; nameSort["Aboleth 2025"] = 18; nameSort["Aboleth Spawn"] = 19; nameSort["Abominable Yeti"] = 20; nameSort["Abominable Yeti 2025"] = 21; 
nameSort["Abyssal Chicken"] = 22; nameSort["Abyssal Wretch"] = 23; nameSort["Acererak"] = 24; nameSort["Achaierai"] = 25; nameSort["Acidic Mist Apparition"] = 26; nameSort["Acolyte"] = 27; nameSort["Adult Amethyst Dragon"] = 28; nameSort["Adult Amonkhet Dragon"] = 29; nameSort["Adult Black Dragon"] = 30; nameSort["Adult Black Dragon 2025"] = 31; nameSort["Adult Blue Dracolich"] = 32; nameSort["Adult Blue Dragon"] = 33; nameSort["Adult Blue Dragon 2025"] = 34; nameSort["Adult Brass Dragon"] = 35; nameSort["Adult Brass Dragon 2025"] = 36; nameSort["Adult Bronze Dragon"] = 37; nameSort["Adult Bronze Dragon 2025"] = 38; nameSort["Adult Copper Dragon"] = 39; nameSort["Adult Copper Dragon 2025"] = 40; nameSort["Adult Crystal Dragon"] = 41; 
nameSort["Adult Deep Dragon"] = 42; nameSort["Adult Emerald Dragon"] = 43; nameSort["Adult Gold Dragon"] = 44; nameSort["Adult Gold Dragon 2025"] = 45; nameSort["Adult Green Dragon"] = 46; nameSort["Adult Green Dragon 2025"] = 47; nameSort["Adult Kruthik"] = 48; nameSort["Adult Lunar Dragon"] = 49; nameSort["Adult Moonstone Dragon"] = 50; nameSort["Adult Oblex"] = 51; nameSort["Adult Red Dracolich"] = 52; nameSort["Adult Red Dragon"] = 53; nameSort["Adult Red Dragon 2025"] = 54; nameSort["Adult Sapphire Dragon"] = 55; nameSort["Adult Silver Dragon"] = 56; nameSort["Adult Silver Dragon 2025"] = 57; nameSort["Adult Solar Dragon"] = 58; nameSort["Adult Spirit Dragon"] = 59; nameSort["Adult Time Dragon"] = 60; nameSort["Adult Topaz Dragon"] = 61; 
nameSort["Adult White Dragon"] = 62; nameSort["Adult White Dragon 2025"] = 63; nameSort["Advanced Detention Drone"] = 64; nameSort["Aegisaur"] = 65; nameSort["Aeorian Absorber"] = 66; nameSort["Aeorian Nullifier"] = 67; nameSort["Aeorian Reverser"] = 68; nameSort["Aerisi Kalinoth"] = 69; nameSort["Aerosaur"] = 70; nameSort["Aerosaur (Large)"] = 71; nameSort["Aerosaur (Small)"] = 72; nameSort["Aeshma"] = 73; nameSort["Affliction Devil (Kocrachon)"] = 74; nameSort["Afsoun Ghorbani"] = 75; nameSort["Agathe Silverspoon"] = 76; nameSort["Agdon Longscarf"] = 77; nameSort["Agony"] = 78; nameSort["Ahmaergo"] = 79; nameSort["Air Elemental"] = 80; nameSort["Air Elemental 2025"] = 81; 
nameSort["Air Elemental Myrmidon"] = 82; nameSort["Air Totem Elemental"] = 83; nameSort["Akroan Hoplite"] = 84; nameSort["Alagarthas"] = 85; nameSort["Alastrah"] = 86; nameSort["Alax Jadescales"] = 87; nameSort["Albino Dwarf Spirit Warrior"] = 88; nameSort["Albino Dwarf Warrior"] = 89; nameSort["Al'chaia"] = 90; nameSort["Aldani (Lobsterfolk)"] = 91; nameSort["Alhoon"] = 92; nameSort["Aljanor Keenblade"] = 93; nameSort["Alkilith"] = 94; nameSort["Allip"] = 95; nameSort["Allosaurus"] = 96; nameSort["Allosaurus 2025"] = 97; nameSort["Allowak Abominable Yeti"] = 98; nameSort["Allowak Yeti"] = 99; nameSort["Almiraj"] = 100; nameSort["Aloysia Telfan"] = 101; 
nameSort["Alseid"] = 102; nameSort["Altisaur"] = 103; nameSort["Alustriel Silverhand"] = 104; nameSort["Alyxian Aboleth"] = 105; nameSort["Alyxian the Absolved"] = 106; nameSort["Alyxian the Callous"] = 107; nameSort["Alyxian the Dispossessed"] = 108; nameSort["Alyxian the Hunter"] = 109; nameSort["Alyxian the Tormented"] = 110; nameSort["Amanisha Manivarshi"] = 111; nameSort["Amarith Coppervein"] = 112; nameSort["Amber Golem"] = 113; nameSort["Ambitious Assassin"] = 114; nameSort["Amble"] = 115; nameSort["Ambush Drake"] = 116; nameSort["Amelia Ghallen"] = 117; nameSort["Amethyst Dragon Wyrmling"] = 118; nameSort["Amethyst Greatwyrm"] = 119; nameSort["Ameyali"] = 120; nameSort["Amidor the Dandelion"] = 121; 
nameSort["Ammalia Cassalanter"] = 122; nameSort["Ammit"] = 123; nameSort["Amnizu"] = 124; nameSort["Amonkhet Dragon Wyrmling"] = 125; nameSort["Amonkhet Hydra"] = 126; nameSort["Amonkhet Mummy"] = 127; nameSort["Amonkhet Mummy Lord"] = 128; nameSort["Amonkhet Sphinx"] = 129; nameSort["Amphisbaena"] = 130; nameSort["Amrik Vanthampur"] = 131; nameSort["Amun Sa"] = 132; nameSort["Anacreda"] = 133; nameSort["Anagwendol"] = 134; nameSort["Anarch"] = 135; nameSort["Anastrasya Karelova"] = 136; nameSort["Anchorite of Talos"] = 137; nameSort["Ancient Amethyst Dragon"] = 138; nameSort["Ancient Amonkhet Dragon"] = 139; nameSort["Ancient Black Dragon"] = 140; nameSort["Ancient Black Dragon 2025"] = 141; 
nameSort["Ancient Blue Dragon"] = 142; nameSort["Ancient Blue Dragon 2025"] = 143; nameSort["Ancient Brass Dragon"] = 144; nameSort["Ancient Brass Dragon 2025"] = 145; nameSort["Ancient Bronze Dragon"] = 146; nameSort["Ancient Bronze Dragon 2025"] = 147; nameSort["Ancient Copper Dragon"] = 148; nameSort["Ancient Copper Dragon 2025"] = 149; nameSort["Ancient Crystal Dragon"] = 150; nameSort["Ancient Deep Crow"] = 151; nameSort["Ancient Deep Dragon"] = 152; nameSort["Ancient Dragon Turtle"] = 153; nameSort["Ancient Emerald Dragon"] = 154; nameSort["Ancient Gold Dragon"] = 155; nameSort["Ancient Gold Dragon 2025"] = 156; nameSort["Ancient Green Dragon"] = 157; nameSort["Ancient Green Dragon 2025"] = 158; nameSort["Ancient Lunar Dragon"] = 159; nameSort["Ancient Moonstone Dragon"] = 160; nameSort["Ancient Red Dragon"] = 161; 
nameSort["Ancient Red Dragon 2025"] = 162; nameSort["Ancient Sapphire Dragon"] = 163; nameSort["Ancient Sea Serpent"] = 164; nameSort["Ancient Silver Dragon"] = 165; nameSort["Ancient Silver Dragon 2025"] = 166; nameSort["Ancient Solar Dragon"] = 167; nameSort["Ancient Spirit Dragon"] = 168; nameSort["Ancient Time Dragon"] = 169; nameSort["Ancient Topaz Dragon"] = 170; nameSort["Ancient White Dragon"] = 171; nameSort["Ancient White Dragon 2025"] = 172; nameSort["Andir Valmakos"] = 173; nameSort["Andras"] = 174; nameSort["Android"] = 175; nameSort["Androsphinx"] = 176; nameSort["Angel"] = 177; nameSort["Angel of Amonkhet"] = 178; nameSort["Angry Sorrowsworn"] = 179; nameSort["Anhkolox"] = 180; nameSort["Animal Lord 2025"] = 181; 
nameSort["Animated Armor"] = 182; nameSort["Animated Armor 2025"] = 183; nameSort["Animated Armor Detention Drone"] = 184; nameSort["Animated Ballista"] = 185; nameSort["Animated Breath"] = 186; nameSort["Animated Broom"] = 187; nameSort["Animated Broom 2025"] = 188; nameSort["Animated Chained Library"] = 189; nameSort["Animated Coffin"] = 190; nameSort["Animated Drow Statue"] = 191; nameSort["Animated Flying Sword 2025"] = 192; nameSort["Animated Furniture"] = 193; nameSort["Animated Glass Statue"] = 194; nameSort["Animated Halberd"] = 195; nameSort["Animated Jade Serpent"] = 196; nameSort["Animated Knife"] = 197; nameSort["Animated Object"] = 198; nameSort["Animated Object (Huge)"] = 199; nameSort["Animated Object (Large)"] = 200; nameSort["Animated Object (Medium)"] = 201; 
nameSort["Animated Object (Small)"] = 202; nameSort["Animated Object (Tiny)"] = 203; nameSort["Animated Rug of Smothering 2025"] = 204; nameSort["Animated Staff"] = 205; nameSort["Animated Statue of Lolth"] = 206; nameSort["Animated Stove"] = 207; nameSort["Animated Table"] = 208; nameSort["Animated Tile Chimera"] = 209; nameSort["Animated Tree"] = 210; nameSort["Animated Wand"] = 211; nameSort["Animatronic Allosaurus"] = 212; nameSort["Ankheg"] = 213; nameSort["Ankheg 2025"] = 214; nameSort["Ankylosaurus"] = 215; nameSort["Ankylosaurus 2025"] = 216; nameSort["Ankylosaurus Zombie"] = 217; nameSort["Annis Hag"] = 218; nameSort["Anointed"] = 219; nameSort["Anvilwrought Raptor"] = 220; nameSort["Ape"] = 221; 
nameSort["Ape 2025"] = 222; nameSort["Aphemia"] = 223; nameSort["Apprentice"] = 224; nameSort["Apprentice Wizard"] = 225; nameSort["Aquatic Ghoul"] = 226; nameSort["Aquatic Troll"] = 227; nameSort["Arabelle"] = 228; nameSort["Aradrine the Owl"] = 229; nameSort["Aranea"] = 230; nameSort["Arasta"] = 231; nameSort["Arcanaloth"] = 232; nameSort["Arcanaloth 2025"] = 233; nameSort["Archaic"] = 234; nameSort["Archdruid"] = 235; nameSort["Archduke Zariel of Avernus"] = 236; nameSort["Archelon 2025"] = 237; nameSort["Archer"] = 238; nameSort["Archfiend of Ifnir"] = 239; nameSort["Arch-hag"] = 240; nameSort["Archmage"] = 241; 
nameSort["Archmage 2025"] = 242; nameSort["Archon of Boundaries"] = 243; nameSort["Archon of Falling Stars"] = 244; nameSort["Archon of Redemption"] = 245; nameSort["Archon of the Triumvirate"] = 246; nameSort["Archpriest 2025"] = 247; nameSort["Arclight Phoenix"] = 248; nameSort["Arcturia"] = 249; nameSort["Argentia Skywright"] = 250; nameSort["Aribeth de Tylmarande"] = 251; nameSort["Arkhan the Cruel"] = 252; nameSort["Arlo Kettletoe (Levels 1-4)"] = 253; nameSort["Arlo Kettletoe (Levels 5-8)"] = 254; nameSort["Arlo Kettletoe (Levels 9-11)"] = 255; nameSort["Armanite"] = 256; nameSort["Armasaur"] = 257; nameSort["Armored Saber-Toothed Tiger"] = 258; nameSort["Arrant Quill"] = 259; nameSort["Arrigal"] = 260; nameSort["Art Elemental Mascot"] = 261; 
nameSort["Artus Cimber"] = 262; nameSort["Aruk Thundercaller Thuunlakalaga"] = 263; nameSort["Arveiaturace"] = 264; nameSort["Ashann"] = 265; nameSort["Asharra"] = 266; nameSort["Asha Vandree"] = 267; nameSort["Ashdra"] = 268; nameSort["Ashen Animated Armor"] = 269; nameSort["Ashen Flying Sword"] = 270; nameSort["Ashen Heir Anarchist"] = 271; nameSort["Ashen Heir Assassin"] = 272; nameSort["Ashen Heir Mage"] = 273; nameSort["Ashen Heir Veteran"] = 274; nameSort["Ashen Knight"] = 275; nameSort["Ashen Rider"] = 276; nameSort["Ashen Shambling Mound"] = 277; nameSort["Ashen Veteran"] = 278; nameSort["Ashen Warhorse"] = 279; nameSort["Ashtyrranthor"] = 280; nameSort["Ash Zombie"] = 281; 
nameSort["Asmodeus"] = 282; nameSort["Aspect of Bahamut"] = 283; nameSort["Aspect of Tiamat"] = 284; nameSort["Aspirant of the Comet"] = 285; nameSort["Assassin"] = 286; nameSort["Assassin 2025"] = 287; nameSort["Assassin Bug"] = 288; nameSort["Assassin Vine"] = 289; nameSort["Asteria"] = 290; nameSort["Asteroid Spider"] = 291; nameSort["Astral Blight"] = 292; nameSort["Astral Dreadnought"] = 293; nameSort["Astral Elf Aristocrat"] = 294; nameSort["Astral Elf Commander"] = 295; nameSort["Astral Elf Honor Guard"] = 296; nameSort["Astral Elf Star Priest"] = 297; nameSort["Astral Elf Warrior"] = 298; nameSort["Atash"] = 299; nameSort["Athar Null"] = 300; nameSort["Atiba-Pa"] = 301; 
nameSort["Atropal"] = 302; nameSort["Augrek Brighthelm"] = 303; nameSort["Aunt Dellie"] = 304; nameSort["Aurak Draconian"] = 305; nameSort["Aurelia"] = 306; nameSort["Auril (First Form)"] = 307; nameSort["Auril (Second Form)"] = 308; nameSort["Auril (Third Form)"] = 309; nameSort["Aurinax"] = 310; nameSort["Aurnozci"] = 311; nameSort["Aurochs"] = 312; nameSort["Aurumach Rilmani"] = 313; nameSort["Aurumvorax"] = 314; nameSort["Aurumvorax Den Leader"] = 315; nameSort["Auspicia Dran"] = 316; nameSort["Autognome"] = 317; nameSort["Autumn Eladrin"] = 318; nameSort["Avacyn"] = 319; nameSort["Avarice"] = 320; nameSort["Avatar of Baalzebul"] = 321; 
nameSort["Avatar of Death"] = 322; nameSort["Avi"] = 323; nameSort["Avoral Guardinal"] = 324; nameSort["Awa"] = 325; nameSort["Awakened Brown Bear"] = 326; nameSort["Awakened Elk"] = 327; nameSort["Awakened Giant Wasp"] = 328; nameSort["Awakened Rat"] = 329; nameSort["Awakened Shrub"] = 330; nameSort["Awakened Shrub 2025"] = 331; nameSort["Awakened Shrub Totem Elemental"] = 332; nameSort["Awakened Tree"] = 333; nameSort["Awakened Tree 2025"] = 334; nameSort["Awakened White Moose"] = 335; nameSort["Awakened Zurkhwood"] = 336; nameSort["Awful Fisher"] = 337; nameSort["Axe Beak"] = 338; nameSort["Axe Beak 2025"] = 339; nameSort["Axe of Mirabar Soldier"] = 340; nameSort["Ayik Ur"] = 341; 
nameSort["Ayo Jabe (Tier 1)"] = 342; nameSort["Ayo Jabe (Tier 2)"] = 343; nameSort["Ayo Jabe (Tier 3)"] = 344; nameSort["Ayperobo Swarm"] = 345; nameSort["Aza Dowling"] = 346; nameSort["Azaka Stormfang"] = 347; nameSort["Azbara Jos"] = 348; nameSort["Azer"] = 349; nameSort["Azer Pyromancer 2025"] = 350; nameSort["Azer Sentinel 2025"] = 351; nameSort["Azra Nir"] = 352; nameSort["Baalzebul"] = 353; nameSort["Baaz Draconian"] = 354; nameSort["Baba Lysaga"] = 355; nameSort["Baba Lysaga's Creeping Hut"] = 356; nameSort["Babau"] = 357; nameSort["Baboon"] = 358; nameSort["Baboon 2025"] = 359; nameSort["Badger"] = 360; nameSort["Badger 2025"] = 361; 
nameSort["Bael"] = 362; nameSort["Baernaloth"] = 363; nameSort["Bag Jelly"] = 364; nameSort["Bag of Nails"] = 365; nameSort["Bakaris the Younger"] = 366; nameSort["Bakaris Uth Estide"] = 367; nameSort["Bak Mei"] = 368; nameSort["Bakunawa"] = 369; nameSort["Balhannoth"] = 370; nameSort["Balor"] = 371; nameSort["Balor 2025"] = 372; nameSort["Baloth"] = 373; nameSort["Bandagh"] = 374; nameSort["Banderhobb"] = 375; nameSort["Bandit"] = 376; nameSort["Bandit 2025"] = 377; nameSort["Bandit Captain"] = 378; nameSort["Bandit Captain 2025"] = 379; nameSort["Bandit Crime Lord 2025"] = 380; nameSort["Bandit Deceiver 2025"] = 381; 
nameSort["Banrion"] = 382; nameSort["Banshee"] = 383; nameSort["Banshee 2025"] = 384; nameSort["Baphomet"] = 385; nameSort["Barachiel"] = 386; nameSort["Barbatos"] = 387; nameSort["Barbed Devil"] = 388; nameSort["Barbed Devil 2025"] = 389; nameSort["Bard"] = 390; nameSort["Barghest"] = 391; nameSort["Bariaur Wanderer"] = 392; nameSort["Barkburr"] = 393; nameSort["Barlgura"] = 394; nameSort["Barlgura 2025"] = 395; nameSort["Barnacle Bess"] = 396; nameSort["Barnibus Blastwind"] = 397; nameSort["Baron Vargas Vallakovich"] = 398; nameSort["Barovian Commoner"] = 399; nameSort["Barovian Scout"] = 400; nameSort["Barovian Witch"] = 401; 
nameSort["Barrowghast"] = 402; nameSort["Basilisk"] = 403; nameSort["Basilisk 2025"] = 404; nameSort["Bastian Thermandar"] = 405; nameSort["Bat"] = 406; nameSort["Bat 2025"] = 407; nameSort["Battleforce Angel"] = 408; nameSort["Battlehammer Dwarf"] = 409; nameSort["Bavlorna Blightstraw"] = 410; nameSort["Beanstalk Wurm"] = 411; nameSort["Bearded Devil"] = 412; nameSort["Bearded Devil 2025"] = 413; nameSort["Beast of Malar"] = 414; nameSort["Beast of the Land"] = 415; nameSort["Beast of the Sea"] = 416; nameSort["Beast of the Sky"] = 417; nameSort["Bebilith"] = 418; nameSort["Becklin Uth Viharin"] = 419; nameSort["Behir"] = 420; nameSort["Behir 2025"] = 421; 
nameSort["Beholder"] = 422; nameSort["Beholder 2025"] = 423; nameSort["Beholder Zombie"] = 424; nameSort["Beholder Zombie 2025"] = 425; nameSort["Bel"] = 426; nameSort["Belak the Outcast"] = 427; nameSort["Belashyrra"] = 428; nameSort["Beldora"] = 429; nameSort["Beledros Witherbloom"] = 430; nameSort["Belephaion"] = 431; nameSort["Belial"] = 432; nameSort["Bepis Honeymaker"] = 433; nameSort["Berbalang"] = 434; nameSort["Berlain Shadowdusk"] = 435; nameSort["Berserker"] = 436; nameSort["Berserker 2025"] = 437; nameSort["Berserker Commander 2025"] = 438; nameSort["Bestial Spirit"] = 439; nameSort["Beucephalus"] = 440; nameSort["Bhaal, Ravager"] = 441; 
nameSort["Bhaal, Slayer"] = 442; nameSort["Bheur Hag"] = 443; nameSort["Big Momma"] = 444; nameSort["Big Water Slurpent"] = 445; nameSort["Big Xorn"] = 446; nameSort["Biha Babir"] = 447; nameSort["Billy Beaver"] = 448; nameSort["Biomancer"] = 449; nameSort["Birdsquirrel"] = 450; nameSort["Bitter Breath"] = 451; nameSort["Bjornhild Solvigsdottir"] = 452; nameSort["Black Abishai"] = 453; nameSort["Black Bear"] = 454; nameSort["Black Bear 2025"] = 455; nameSort["Black Dragon Wyrmling"] = 456; nameSort["Black Dragon Wyrmling 2025"] = 457; nameSort["Black Earth Guard"] = 458; nameSort["Black Earth Priest"] = 459; nameSort["Black Gauntlet of Bane"] = 460; nameSort["Black Greatwyrm"] = 461; 
nameSort["Blackguard"] = 462; nameSort["Black Guard Drake"] = 463; nameSort["Black Pudding"] = 464; nameSort["Black Pudding 2025"] = 465; nameSort["Black Rose Bearer"] = 466; nameSort["Blacktongue Bullywug"] = 467; nameSort["Black Viper"] = 468; nameSort["Blade Lieutenant"] = 469; nameSort["Blade Scout"] = 470; nameSort["Blagothkus"] = 471; nameSort["Blaze"] = 472; nameSort["Blazebear"] = 473; nameSort["Bleak Cabal Void Soother"] = 474; nameSort["Blight Totem Elemental"] = 475; nameSort["Blind Artist"] = 476; nameSort["Blinded Troll"] = 477; nameSort["Blindheim"] = 478; nameSort["Blink Dog"] = 479; nameSort["Blink Dog 2025"] = 480; nameSort["Blistercoil Weird"] = 481; 
nameSort["Blob of Annihilation 2025"] = 482; nameSort["Blood Drinker Vampire"] = 483; nameSort["Bloodfray Giant"] = 484; nameSort["Blood Hawk"] = 485; nameSort["Blood Hawk 2025"] = 486; nameSort["Blood Hunter"] = 487; nameSort["Blood-Toll Harpy"] = 488; nameSort["Blood Witch"] = 489; nameSort["Blue Abishai"] = 490; nameSort["Blue Dragon Wyrmling"] = 491; nameSort["Blue Dragon Wyrmling 2025"] = 492; nameSort["Blue Greatwyrm"] = 493; nameSort["Blue Guard Drake"] = 494; nameSort["Blue Slaad"] = 495; nameSort["Blue Slaad 2025"] = 496; nameSort["Blurg"] = 497; nameSort["Bluto Krogarov"] = 498; nameSort["Boar"] = 499; nameSort["Boar 2025"] = 500; nameSort["Bodak"] = 501; 
nameSort["Bodhi Irenicus"] = 502; nameSort["Bodytaker Plant"] = 503; nameSort["Boggle"] = 504; nameSort["Bol'bara"] = 505; nameSort["Boneclaw"] = 506; nameSort["Bone Devil"] = 507; nameSort["Bone Devil 2025"] = 508; nameSort["Bone Knight"] = 509; nameSort["Boneless"] = 510; nameSort["Bone Naga 2025"] = 511; nameSort["Bone Naga (Guardian)"] = 512; nameSort["Bone Naga (Spirit)"] = 513; nameSort["Bone Roc"] = 514; nameSort["Bone Whelk"] = 515; nameSort["Bonnie"] = 516; nameSort["Boontu Monkey"] = 517; nameSort["Booyahg Booyahg Booyahg"] = 518; nameSort["Booyahg Caster"] = 519; nameSort["Booyahg Slave of the Archfey"] = 520; nameSort["Booyahg Slave of the Fiend"] = 521; 
nameSort["Booyahg Slave of the Great Old One"] = 522; nameSort["Booyahg Whip"] = 523; nameSort["Booyahg Wielder"] = 524; nameSort["Borborygmos"] = 525; nameSort["Bore Worm"] = 526; nameSort["Borivik Windheim"] = 527; nameSort["Boromar Smuggler"] = 528; nameSort["Boromar Underboss"] = 529; nameSort["Borthak"] = 530; nameSort["Bosco Daggerhand"] = 531; nameSort["Boss Augustus"] = 532; nameSort["Boss Delour"] = 533; nameSort["Boulderfoot Giant"] = 534; nameSort["Bozak Draconian"] = 535; nameSort["Brackish Trudge"] = 536; nameSort["Braelen Hatherhand"] = 537; nameSort["Brahma Lutier"] = 538; nameSort["Brain Breaker"] = 539; nameSort["Brain in a Jar"] = 540; nameSort["Brain in Iron"] = 541; 
nameSort["Brass Dragon Wyrmling"] = 542; nameSort["Brass Dragon Wyrmling 2025"] = 543; nameSort["Brass Greatwyrm"] = 544; nameSort["Braxat"] = 545; nameSort["Braxow"] = 546; nameSort["Bray Martikov"] = 547; nameSort["Brazen Gorgon 2025"] = 548; nameSort["Breath Drinker"] = 549; nameSort["Bridesmaid of Zuggtmoy"] = 550; nameSort["Brigganock"] = 551; nameSort["Bristled Moorbounder"] = 552; nameSort["B'rohg"] = 553; nameSort["Broken King Antigonos"] = 554; nameSort["Brom Martikov"] = 555; nameSort["Brontodon"] = 556; nameSort["Brontosaurus"] = 557; nameSort["Bronze Dragon Wyrmling"] = 558; nameSort["Bronze Dragon Wyrmling 2025"] = 559; nameSort["Bronzefume"] = 560; nameSort["Bronze Greatwyrm"] = 561; 
nameSort["Bronze Sable"] = 562; nameSort["Bronze Scout"] = 563; nameSort["Broom of Animated Attack"] = 564; nameSort["Brother Adramalech"] = 565; nameSort["Brother Broumane"] = 566; nameSort["Brother Morax"] = 567; nameSort["Brown Bear"] = 568; nameSort["Brown Bear 2025"] = 569; nameSort["Brown Scavver"] = 570; nameSort["Bruna"] = 571; nameSort["Brusipha"] = 572; nameSort["Buer"] = 573; nameSort["Bugbear"] = 574; nameSort["Bugbear Chief"] = 575; nameSort["Bugbear Gardener"] = 576; nameSort["Bugbear Lieutenant"] = 577; nameSort["Bugbear Stalker 2025"] = 578; nameSort["Bugbear Warrior 2025"] = 579; nameSort["Bulette"] = 580; nameSort["Bulette 2025"] = 581; 
nameSort["Bulette Pup 2025"] = 582; nameSort["Bulezau"] = 583; nameSort["Bullywug"] = 584; nameSort["Bullywug Bog Sage 2025"] = 585; nameSort["Bullywug Croaker"] = 586; nameSort["Bullywug Knight"] = 587; nameSort["Bullywug Royal"] = 588; nameSort["Bullywug Warrior 2025"] = 589; nameSort["Buppido"] = 590; nameSort["Burney the Barber"] = 591; nameSort["Burnished Hart"] = 592; nameSort["Burrowshark"] = 593; nameSort["Buster the Bear"] = 594; nameSort["Cackler"] = 595; nameSort["Cadaver Collector"] = 596; nameSort["Cairnwight"] = 597; nameSort["Calcryx"] = 598; nameSort["Caldron Magen"] = 599; nameSort["Cambion"] = 600; nameSort["Cambion 2025"] = 601; 
nameSort["Camel"] = 602; nameSort["Camel 2025"] = 603; nameSort["Camlash"] = 604; nameSort["Campestri"] = 605; nameSort["Cannith Artificer"] = 606; nameSort["Canoloth"] = 607; nameSort["Canopic Golem"] = 608; nameSort["Captain Hask"] = 609; nameSort["Captain N'ghathrod"] = 610; nameSort["Captain Othelstan"] = 611; nameSort["Captain Xendros"] = 612; nameSort["Caradoc"] = 613; nameSort["Carnivorous Flower"] = 614; nameSort["Carrion Crawler"] = 615; nameSort["Carrion Crawler 2025"] = 616; nameSort["Carrionette"] = 617; nameSort["Carrion Ogre"] = 618; nameSort["Carrion Stalker"] = 619; nameSort["Cassiok Shadowdusk"] = 620; nameSort["Cat"] = 621; 
nameSort["Cat 2025"] = 622; nameSort["Category 1 Krasis"] = 623; nameSort["Category 2 Krasis"] = 624; nameSort["Category 3 Krasis"] = 625; nameSort["Catoblepas"] = 626; nameSort["Caustic Crawler"] = 627; nameSort["Cave Badger"] = 628; nameSort["Cave Bear"] = 629; nameSort["Cave Fisher"] = 630; nameSort["Cavil Zaltobar"] = 631; nameSort["Celeste"] = 632; nameSort["Celestial Spirit"] = 633; nameSort["Centaur"] = 634; nameSort["Centaur Mummy"] = 635; nameSort["Centaur Trooper 2025"] = 636; nameSort["Centaur Warden 2025"] = 637; nameSort["Ceratops"] = 638; nameSort["Cerodon"] = 639; nameSort["Chain Devil"] = 640; nameSort["Chain Devil 2025"] = 641; 
nameSort["Chamberlain of Zuggtmoy"] = 642; nameSort["Champion"] = 643; nameSort["Champion of Gorm"] = 644; nameSort["Champion of Madarua"] = 645; nameSort["Champion of Usamigaras"] = 646; nameSort["Changeling"] = 647; nameSort["Chaos Quadrapod"] = 648; nameSort["Chardalyn Berserker"] = 649; nameSort["Chardalyn Dragon"] = 650; nameSort["Charmayne Daymore"] = 651; nameSort["Chasme"] = 652; nameSort["Chasme 2025"] = 653; nameSort["Chief Guh"] = 654; nameSort["Chief Kartha-Kaya"] = 655; nameSort["Chief Nosnra"] = 656; nameSort["Chimera"] = 657; nameSort["Chimera 2025"] = 658; nameSort["Chimeric Baboon"] = 659; nameSort["Chimeric Cat"] = 660; nameSort["Chimeric Fox"] = 661; 
nameSort["Chimeric Hare"] = 662; nameSort["Chimeric Rat"] = 663; nameSort["Chimeric Weasel"] = 664; nameSort["Chishinix"] = 665; nameSort["Chishinix' Head"] = 666; nameSort["Chitine"] = 667; nameSort["Choker"] = 668; nameSort["Choldrith"] = 669; nameSort["Chukka"] = 670; nameSort["Chupacabra"] = 671; nameSort["Chuul"] = 672; nameSort["Chuul 2025"] = 673; nameSort["Chuul Spore Servant"] = 674; nameSort["Chwinga"] = 675; nameSort["Chwinga Astronaut"] = 676; nameSort["Cinderhild"] = 677; nameSort["Cinder Hulk"] = 678; nameSort["Cipolla"] = 679; nameSort["Citadel Spider"] = 680; nameSort["Clapperclaw the Scarecrow"] = 681; 
nameSort["Claugiyliamatar"] = 682; nameSort["Clawfoot"] = 683; nameSort["Clay Gladiator"] = 684; nameSort["Clay Golem"] = 685; nameSort["Clay Golem 2025"] = 686; nameSort["Cloaker"] = 687; nameSort["Cloaker 2025"] = 688; nameSort["Cloaker Mutate"] = 689; nameSort["Clockwork Behir"] = 690; nameSort["Clockwork Bronze Scout"] = 691; nameSort["Clockwork Defender"] = 692; nameSort["Clockwork Dragon"] = 693; nameSort["Clockwork Horror"] = 694; nameSort["Clockwork Iron Cobra"] = 695; nameSort["Clockwork Kraken"] = 696; nameSort["Clockwork Mule"] = 697; nameSort["Clockwork Oaken Bolter"] = 698; nameSort["Clockwork Observer"] = 699; nameSort["Clockwork Stone Defender"] = 700; nameSort["Clonk"] = 701; 
nameSort["Cloud Giant"] = 702; nameSort["Cloud Giant 2025"] = 703; nameSort["Cloud Giant Destiny Gambler"] = 704; nameSort["Cloud Giant Ghost"] = 705; nameSort["Cloud Giant Noble"] = 706; nameSort["Cloud Giant of Evil Air"] = 707; nameSort["Cloud Giant Smiling One"] = 708; nameSort["Clovin Belview"] = 709; nameSort["Clown"] = 710; nameSort["Clystran"] = 711; nameSort["Coatl"] = 712; nameSort["Cockatrice"] = 713; nameSort["Cockatrice 2025"] = 714; nameSort["Cockatrice Regent 2025"] = 715; nameSort["Cog"] = 716; nameSort["Cogwork Archivist"] = 717; nameSort["Coldlight Walker"] = 718; nameSort["Colossus 2025"] = 719; nameSort["Colossus of Akros"] = 720; nameSort["Combat Robot"] = 721; 
nameSort["Commodore Krux"] = 722; nameSort["Commoner"] = 723; nameSort["Commoner 2025"] = 724; nameSort["Conclave Dryad"] = 725; nameSort["Conjurer"] = 726; nameSort["Conjurer Wizard"] = 727; nameSort["Conservatory Student"] = 728; nameSort["Constrictor Snake"] = 729; nameSort["Constrictor Snake 2025"] = 730; nameSort["Construct (Animated Armor)"] = 731; nameSort["Constructed Commoner"] = 732; nameSort["Construct (Helmed Horror)"] = 733; nameSort["Construct (Modron)"] = 734; nameSort["Construct (Shield Guardian)"] = 735; nameSort["Construct Spirit"] = 736; nameSort["Copper Dragon Wyrmling"] = 737; nameSort["Copper Dragon Wyrmling 2025"] = 738; nameSort["Copper Greatwyrm"] = 739; nameSort["Copper Stormforge"] = 740; nameSort["Coral"] = 741; 
nameSort["Core Spawn Crawler"] = 742; nameSort["Core Spawn Emissary"] = 743; nameSort["Core Spawn Seer"] = 744; nameSort["Core Spawn Worm"] = 745; nameSort["Cornelius Watson"] = 746; nameSort["Corpse Flower"] = 747; nameSort["Corrin Delmaco"] = 748; nameSort["Corrupted Avatar of Lurue"] = 749; nameSort["Corrupted Giant Shark"] = 750; nameSort["Corrupted Rat"] = 751; nameSort["Corruption Devil (Paeliryon)"] = 752; nameSort["Cosmic Horror"] = 753; nameSort["Cosmotronic Blastseeker"] = 754; nameSort["Couatl"] = 755; nameSort["Couatl 2025"] = 756; nameSort["Counterflux Blastseeker"] = 757; nameSort["Countess Sansuri"] = 758; nameSort["Count Thullen"] = 759; nameSort["Cow"] = 760; nameSort["Crab"] = 761; 
nameSort["Crab 2025"] = 762; nameSort["Crab Folk"] = 763; nameSort["Cradle of the Cloud Scion"] = 764; nameSort["Cradle of the Fire Scion"] = 765; nameSort["Cradle of the Frost Scion"] = 766; nameSort["Cradle of the Hill Scion"] = 767; nameSort["Cradle of the Stone Scion"] = 768; nameSort["Cradle of the Storm Scion"] = 769; nameSort["Crag Cat"] = 770; nameSort["Cranium Rat"] = 771; nameSort["Cranium Rat Squeaker"] = 772; nameSort["Cranium Rat Squeaker Swarm"] = 773; nameSort["Crawling Claw"] = 774; nameSort["Crawling Claw 2025"] = 775; nameSort["Creeper"] = 776; nameSort["Creepy Doll"] = 777; nameSort["Cressaro"] = 778; nameSort["Crimson Helmed Horror"] = 779; nameSort["Criosphinx"] = 780; nameSort["Crocodile"] = 781; 
nameSort["Crocodile 2025"] = 782; nameSort["Crokek'toeck"] = 783; nameSort["Crow"] = 784; nameSort["Crunch"] = 785; nameSort["Crushing Wave Priest"] = 786; nameSort["Crushing Wave Reaver"] = 787; nameSort["Cryonax"] = 788; nameSort["Cryovain"] = 789; nameSort["Crystal Battleaxe"] = 790; nameSort["Crystal Cave Merfolk"] = 791; nameSort["Crystal Dragon Wyrmling"] = 792; nameSort["Crystal Golem"] = 793; nameSort["Crystal Greatwyrm"] = 794; nameSort["Ctenmiir the Vampire"] = 795; nameSort["Cudgel Ironsmile"] = 796; nameSort["Cult Fanatic"] = 797; nameSort["Cultist"] = 798; nameSort["Cultist 2025"] = 799; nameSort["Cultist Fanatic 2025"] = 800; nameSort["Cultist Hierophant 2025"] = 801; 
nameSort["Cultist of Bane"] = 802; nameSort["Cultist of Bhaal"] = 803; nameSort["Cultist of Demogorgon"] = 804; nameSort["Cultist of Myrkul"] = 805; nameSort["Cuprilach Rilmani"] = 806; nameSort["Curate"] = 807; nameSort["Curran Corvalin"] = 808; nameSort["Cyclops"] = 809; nameSort["Cyclops Oracle 2025"] = 810; nameSort["Cyclops Sentry 2025"] = 811; nameSort["Cyrus Belview"] = 812; nameSort["Daask Bruiser"] = 813; nameSort["Daask Raider"] = 814; nameSort["Dabus"] = 815; nameSort["Daemogoth"] = 816; nameSort["Daemogoth Titan"] = 817; nameSort["Dagdra Deepforge"] = 818; nameSort["Dagryn"] = 819; nameSort["Dalamar"] = 820; nameSort["Damaged Flesh Golem"] = 821; 
nameSort["Dancing Flame"] = 822; nameSort["Dancing Item"] = 823; nameSort["Dandylion"] = 824; nameSort["Danika Dorakova"] = 825; nameSort["Dankwood Duergar"] = 826; nameSort["Dankwood Grung"] = 827; nameSort["Dankwood Hag"] = 828; nameSort["Dao"] = 829; nameSort["Dao 2025"] = 830; nameSort["Darathra Shendrel"] = 831; nameSort["Dardew"] = 832; nameSort["Darien"] = 833; nameSort["Darkling"] = 834; nameSort["Darkling Elder"] = 835; nameSort["Darkmantle"] = 836; nameSort["Darkmantle 2025"] = 837; nameSort["Dark Tide Knight"] = 838; nameSort["Darkweaver"] = 839; nameSort["Darrett Highwater"] = 840; nameSort["Darz Helgar"] = 841; 
nameSort["Davian Martikov"] = 842; nameSort["Davil Starsong"] = 843; nameSort["Deadbark Dryad"] = 844; nameSort["Deadstone Cleft Stone Giant"] = 845; nameSort["Dead Three Scion"] = 846; nameSort["Death Cultist 2025"] = 847; nameSort["Death Dog"] = 848; nameSort["Death Dog 2025"] = 849; nameSort["Death Embrace"] = 850; nameSort["Death Giant Reaper"] = 851; nameSort["Death Giant Shrouded One"] = 852; nameSort["Death Kiss"] = 853; nameSort["Death Knight"] = 854; nameSort["Death Knight 2025"] = 855; nameSort["Death Knight Aspirant 2025"] = 856; nameSort["Deathless Rider"] = 857; nameSort["Deathlock"] = 858; nameSort["Deathlock Mastermind"] = 859; nameSort["Deathlock Wight"] = 860; nameSort["Deathpact Angel"] = 861; 
nameSort["Death's Head"] = 862; nameSort["Death's Head of Bhaal"] = 863; nameSort["Death Slaad"] = 864; nameSort["Death Slaad 2025"] = 865; nameSort["Death Tyrant"] = 866; nameSort["Death Tyrant 2025"] = 867; nameSort["Deathwolf"] = 868; nameSort["Decapus"] = 869; nameSort["Decaton Modron"] = 870; nameSort["Deck Defender"] = 871; nameSort["Deep Crow"] = 872; nameSort["Deep Dragon Wyrmling"] = 873; nameSort["Deep Gnome (Svirfneblin)"] = 874; nameSort["Deepking Horgar Steelshadow V"] = 875; nameSort["Deep Rothé"] = 876; nameSort["Deep Scion"] = 877; nameSort["Deep Spider"] = 878; nameSort["Deer"] = 879; nameSort["Deer 2025"] = 880; nameSort["Deformed Duergar"] = 881; 
nameSort["Degloth"] = 882; nameSort["Deinonychus"] = 883; nameSort["Demelin"] = 884; nameSort["Demilich"] = 885; nameSort["Demilich 2025"] = 886; nameSort["Demobat"] = 887; nameSort["Demodog"] = 888; nameSort["Demodragon"] = 889; nameSort["Demogorgon"] = 890; nameSort["Demogorgon Spawn"] = 891; nameSort["Demon"] = 892; nameSort["Demon Ichor"] = 893; nameSort["Demonlord of Ashmouth"] = 894; nameSort["Demos Magen"] = 895; nameSort["Dermot Wurder (Tier 1)"] = 896; nameSort["Dermot Wurder (Tier 2)"] = 897; nameSort["Dermot Wurder (Tier 3)"] = 898; nameSort["Derro"] = 899; nameSort["Derro Apprentice"] = 900; nameSort["Derro Raider"] = 901; 
nameSort["Derro Savant"] = 902; nameSort["Derwyth"] = 903; nameSort["Deseyna Majarra"] = 904; nameSort["Detached Shadow"] = 905; nameSort["Deva"] = 906; nameSort["Deva 2025"] = 907; nameSort["Devil Dog"] = 908; nameSort["Devkarin Lich"] = 909; nameSort["Devorastus"] = 910; nameSort["Devourer"] = 911; nameSort["Dezmyr Shadowdusk"] = 912; nameSort["Dhergoloth"] = 913; nameSort["Diatryma"] = 914; nameSort["Diderius"] = 915; nameSort["Dimetrodon"] = 916; nameSort["Dining Table Mimic"] = 917; nameSort["Dinosaur Skeleton"] = 918; nameSort["Dire Corby"] = 919; nameSort["Dire Troll"] = 920; nameSort["Dire Wolf"] = 921; 
nameSort["Dire Wolf 2025"] = 922; nameSort["Dire Worg 2025"] = 923; nameSort["Dirt-Under-Nails"] = 924; nameSort["Disciple"] = 925; nameSort["Dispater"] = 926; nameSort["Displacer Beast"] = 927; nameSort["Displacer Beast 2025"] = 928; nameSort["Displacer Beast Kitten"] = 929; nameSort["Displacer Fiend"] = 930; nameSort["Distended Corpse"] = 931; nameSort["Diva"] = 932; nameSort["Diva Luma"] = 933; nameSort["Diviner"] = 934; nameSort["Diviner Wizard"] = 935; nameSort["Djeneba"] = 936; nameSort["Djinni"] = 937; nameSort["Djinni 2025"] = 938; nameSort["Dohwar"] = 939; nameSort["Dolgaunt"] = 940; nameSort["Dolgrim"] = 941; 
nameSort["Dolphin"] = 942; nameSort["Dolphin Delighter"] = 943; nameSort["Domestic Wonder"] = 944; nameSort["Donaar Blit'zen"] = 945; nameSort["Donavich"] = 946; nameSort["Don-Jon Raskin"] = 947; nameSort["Doomguard Doom Lord"] = 948; nameSort["Doomguard Rot Blade"] = 949; nameSort["Doomwake Giant"] = 950; nameSort["Doppelganger"] = 951; nameSort["Doppelganger 2025"] = 952; nameSort["Doric"] = 953; nameSort["Doru"] = 954; nameSort["Dracohydra"] = 955; nameSort["Dracolich 2025"] = 956; nameSort["Draconian Dreadnought"] = 957; nameSort["Draconian Foot Soldier"] = 958; nameSort["Draconian Infiltrator"] = 959; nameSort["Draconian Mage"] = 960; nameSort["Draconian Mastermind"] = 961; 
nameSort["Draconic Shard"] = 962; nameSort["Draconic Spirit"] = 963; nameSort["Dracophage Subject"] = 964; nameSort["Draegloth"] = 965; nameSort["Draft Horse"] = 966; nameSort["Draft Horse 2025"] = 967; nameSort["Dragon"] = 968; nameSort["Dragon Army Dragonnel"] = 969; nameSort["Dragon Army Officer"] = 970; nameSort["Dragon Army Soldier"] = 971; nameSort["Dragonbait"] = 972; nameSort["Dragon Blessed"] = 973; nameSort["Dragonblood Ooze"] = 974; nameSort["Dragonbone Golem"] = 975; nameSort["Dragonborn of Bahamut"] = 976; nameSort["Dragonborn of Sardior"] = 977; nameSort["Dragonborn of Tiamat"] = 978; nameSort["Dragon Chosen"] = 979; nameSort["Dragonclaw"] = 980; nameSort["Dragonfang"] = 981; 
nameSort["Dragonflesh Abomination"] = 982; nameSort["Dragonflesh Grafter"] = 983; nameSort["Dragon Hunter"] = 984; nameSort["Dragonnel"] = 985; nameSort["Dragonpriest"] = 986; nameSort["Dragonsoul"] = 987; nameSort["Dragon Speaker"] = 988; nameSort["Dragon Tortoise"] = 989; nameSort["Dragon Turtle"] = 990; nameSort["Dragon Turtle 2025"] = 991; nameSort["Dragon Turtle Wyrmling"] = 992; nameSort["Dragonwing"] = 993; nameSort["Drake Companion"] = 994; nameSort["Drake (Large)"] = 995; nameSort["Drake (Small)"] = 996; nameSort["Dralmorrer Borngray"] = 997; nameSort["Drannin Splithelm"] = 998; nameSort["Dr. Cassee Dannell"] = 999; nameSort["Dread Doppelganger"] = 1000; nameSort["Dread Warrior"] = 1001; 
nameSort["Dream Eater"] = 1002; nameSort["Dreaming Dark Infiltrator"] = 1003; nameSort["Dreaming Dark Mindkiller"] = 1004; nameSort["Drelnza"] = 1005; nameSort["Dretch"] = 1006; nameSort["Dretch 2025"] = 1007; nameSort["Drevin"] = 1008; nameSort["Drider"] = 1009; nameSort["Drider 2025"] = 1010; nameSort["Drivvin Freth"] = 1011; nameSort["Droki"] = 1012; nameSort["Drow"] = 1013; nameSort["Drow Acolyte"] = 1014; nameSort["Drow Arachnomancer"] = 1015; nameSort["Drow Bandit"] = 1016; nameSort["Drow Commander"] = 1017; nameSort["Drow Commoner"] = 1018; nameSort["Drow Cultist"] = 1019; nameSort["Drow Elite Warrior"] = 1020; nameSort["Drow Elite Warrior of Lolth"] = 1021; 
nameSort["Drow Favored Consort"] = 1022; nameSort["Drow Guard"] = 1023; nameSort["Drow Gunslinger"] = 1024; nameSort["Drow House Captain"] = 1025; nameSort["Drow Inquisitor"] = 1026; nameSort["Drow Mage"] = 1027; nameSort["Drow Mage of Lolth"] = 1028; nameSort["Drow Matron Mother"] = 1029; nameSort["Drowned Ascetic"] = 1030; nameSort["Drowned Assassin"] = 1031; nameSort["Drowned Blade"] = 1032; nameSort["Drowned Master"] = 1033; nameSort["Drow Noble"] = 1034; nameSort["Drow of Lolth"] = 1035; nameSort["Drow Priestess of Lolth"] = 1036; nameSort["Drow Scout"] = 1037; nameSort["Drow Shadowblade"] = 1038; nameSort["Drow Spore Servant"] = 1039; nameSort["Drow Spy"] = 1040; nameSort["Drufi"] = 1041; 
nameSort["Druid"] = 1042; nameSort["Druid 2025"] = 1043; nameSort["Druid of the Old Ways"] = 1044; nameSort["Dryad"] = 1045; nameSort["Dryad 2025"] = 1046; nameSort["Dryad Spirit"] = 1047; nameSort["Duchess Brimskarda"] = 1048; nameSort["Duergar"] = 1049; nameSort["Duergar Alchemist"] = 1050; nameSort["Duergar Darkhaft"] = 1051; nameSort["Duergar Despot"] = 1052; nameSort["Duergar Hammerer"] = 1053; nameSort["Duergar Kavalrachni"] = 1054; nameSort["Duergar Keeper of the Flame"] = 1055; nameSort["Duergar Mind Master"] = 1056; nameSort["Duergar Screamer"] = 1057; nameSort["Duergar Soulblade"] = 1058; nameSort["Duergar Spore Servant"] = 1059; nameSort["Duergar Spy"] = 1060; nameSort["Duergar Stone Guard"] = 1061; 
nameSort["Duergar Warlord"] = 1062; nameSort["Duergar Xarrorn"] = 1063; nameSort["Duke Thalamra Vanthampur"] = 1064; nameSort["Duke Zalto"] = 1065; nameSort["Dukha Bhatiyali"] = 1066; nameSort["Dullahan"] = 1067; nameSort["Dum-Dum Goblin"] = 1068; nameSort["Dunbarrow Witch"] = 1069; nameSort["Duodrone"] = 1070; nameSort["Durnan"] = 1071; nameSort["Durnn"] = 1072; nameSort["Durstan Rial"] = 1073; nameSort["Dusk Hag"] = 1074; nameSort["Duskwalker"] = 1075; nameSort["Dust Hulk"] = 1076; nameSort["Dust Mephit"] = 1077; nameSort["Dust Mephit 2025"] = 1078; nameSort["Duvessa Shane"] = 1079; nameSort["Dwarf"] = 1080; nameSort["Dwarf Skeleton"] = 1081; 
nameSort["Dwarven Worker"] = 1082; nameSort["Dybbuk"] = 1083; nameSort["Dyrrn"] = 1084; nameSort["Dzaan"] = 1085; nameSort["Dzaan's Simulacrum"] = 1086; nameSort["Eagle"] = 1087; nameSort["Eagle 2025"] = 1088; nameSort["Earth Elemental"] = 1089; nameSort["Earth Elemental 2025"] = 1090; nameSort["Earth Elemental Myrmidon"] = 1091; nameSort["Earth Totem Elemental"] = 1092; nameSort["East Wind"] = 1093; nameSort["Eater of Hope"] = 1094; nameSort["Eater of Knowledge"] = 1095; nameSort["Eblis"] = 1096; nameSort["Ebonclaw"] = 1097; nameSort["Ebondeath"] = 1098; nameSort["Echo of Demogorgon"] = 1099; nameSort["Edgin Darvis"] = 1100; nameSort["Edwin Odesseiron"] = 1101; 
nameSort["Efreeti"] = 1102; nameSort["Efreeti 2025"] = 1103; nameSort["Egg Hunter Adult"] = 1104; nameSort["Egg Hunter Hatchling"] = 1105; nameSort["Eidolon"] = 1106; nameSort["Eigeron's Ghost"] = 1107; nameSort["Eira"] = 1108; nameSort["Ekene-Afa"] = 1109; nameSort["Ekengarik"] = 1110; nameSort["Eku"] = 1111; nameSort["Elaina Sartell"] = 1112; nameSort["Elder Black Pudding"] = 1113; nameSort["Elder Brain"] = 1114; nameSort["Elder Brain Dragon"] = 1115; nameSort["Elder Dinosaur"] = 1116; nameSort["Elder Dinosaur (Etali, Primal Storm)"] = 1117; nameSort["Elder Dinosaur (Ghalta, Primal Hunger)"] = 1118; nameSort["Elder Dinosaur (Nezahal, Primal Tide)"] = 1119; nameSort["Elder Dinosaur (Tetzimoc, Primal Death)"] = 1120; nameSort["Elder Dinosaur (Zacama, Primal Calamity)"] = 1121; 
nameSort["Elder Dinosaur (Zetalpa, Primal Dawn)"] = 1122; nameSort["Elder Giant Lizard"] = 1123; nameSort["Elder Monastery of the Distressed Body Monk"] = 1124; nameSort["Elder Oblex"] = 1125; nameSort["Elder Tempest"] = 1126; nameSort["Eldeth Feldrun"] = 1127; nameSort["Eldon Keyward"] = 1128; nameSort["Eldritch Eddy"] = 1129; nameSort["Eldritch Horror Hatchling"] = 1130; nameSort["Eldritch Lich"] = 1131; nameSort["Elemental Cataclysm 2025"] = 1132; nameSort["Elemental Cultist 2025"] = 1133; nameSort["Elemental Spirit"] = 1134; nameSort["Elephant"] = 1135; nameSort["Elephant 2025"] = 1136; nameSort["Eliphas Adulare"] = 1137; nameSort["Elise"] = 1138; nameSort["Elister"] = 1139; nameSort["Elizar Dryflagon"] = 1140; nameSort["Elk"] = 1141; 
nameSort["Elk 2025"] = 1142; nameSort["Elkhorn"] = 1143; nameSort["Elliach"] = 1144; nameSort["Elok Jaharwon"] = 1145; nameSort["Elzerina Cassalanter"] = 1146; nameSort["Ember"] = 1147; nameSort["Emberhorn Minotaur"] = 1148; nameSort["Emberosa"] = 1149; nameSort["Embric"] = 1150; nameSort["Emerald Claw Commander"] = 1151; nameSort["Emerald Claw Knight"] = 1152; nameSort["Emerald Dragon Wyrmling"] = 1153; nameSort["Emerald Enclave Scout"] = 1154; nameSort["Emerald Greatwyrm"] = 1155; nameSort["Emil Toranescu"] = 1156; nameSort["Emmek Frewn"] = 1157; nameSort["Emo"] = 1158; nameSort["Empyrean"] = 1159; nameSort["Empyrean 2025"] = 1160; nameSort["Empyrean Iota 2025"] = 1161; 
nameSort["Emrakul"] = 1162; nameSort["Encephalon Cluster"] = 1163; nameSort["Encephalon Gemmule"] = 1164; nameSort["Enchanter"] = 1165; nameSort["Enchanter Wizard"] = 1166; nameSort["Enchanting Infiltrator"] = 1167; nameSort["Endelyn Moongrave"] = 1168; nameSort["Ender Dragon"] = 1169; nameSort["Enderman"] = 1170; nameSort["Engineer"] = 1171; nameSort["Enhanced Medusa"] = 1172; nameSort["Enna Galakiir (Levels 1-4)"] = 1173; nameSort["Enna Galakiir (Levels 5-8)"] = 1174; nameSort["Enna Galakiir (Levels 9-11)"] = 1175; nameSort["Enormous Tentacle"] = 1176; nameSort["Envy"] = 1177; nameSort["Eo Ashmajiir"] = 1178; nameSort["Equinal Guardinal"] = 1179; nameSort["Eriflamme"] = 1180; nameSort["Erinyes"] = 1181; 
nameSort["Erinyes 2025"] = 1182; nameSort["Erky Timbers"] = 1183; nameSort["Ervan Soulfallen"] = 1184; nameSort["Escher"] = 1185; nameSort["Esthetic"] = 1186; nameSort["Estia"] = 1187; nameSort["Eternal"] = 1188; nameSort["Eternal Flame Guardian"] = 1189; nameSort["Eternal Flame Priest"] = 1190; nameSort["Ettercap"] = 1191; nameSort["Ettercap 2025"] = 1192; nameSort["Ettin"] = 1193; nameSort["Ettin 2025"] = 1194; nameSort["Ettin Ceremorph"] = 1195; nameSort["Euryale"] = 1196; nameSort["Evil Mage"] = 1197; nameSort["Evoker"] = 1198; nameSort["Evoker Wizard"] = 1199; nameSort["Exethanter"] = 1200; nameSort["Expeditious Messenger"] = 1201; 
nameSort["Expert"] = 1202; nameSort["Exul"] = 1203; nameSort["Eyedrake"] = 1204; nameSort["Eye Monger"] = 1205; nameSort["Eye of Fear and Flame"] = 1206; nameSort["Eyestalk of Gzemnid"] = 1207; nameSort["Ezmerelda d'Avenir"] = 1208; nameSort["Ezzat"] = 1209; nameSort["Factol Skall"] = 1210; nameSort["Faerie Borrower"] = 1211; nameSort["Faerie Dragon Adult 2025"] = 1212; nameSort["Faerie Dragon (Blue)"] = 1213; nameSort["Faerie Dragon (Green)"] = 1214; nameSort["Faerie Dragon (Indigo)"] = 1215; nameSort["Faerie Dragon (Orange)"] = 1216; nameSort["Faerie Dragon (Red)"] = 1217; nameSort["Faerie Dragon (Violet)"] = 1218; nameSort["Faerie Dragon (Yellow)"] = 1219; nameSort["Faerie Dragon Youth 2025"] = 1220; nameSort["Faerie Pathlighter"] = 1221; 
nameSort["Faerie Pest"] = 1222; nameSort["Faerl"] = 1223; nameSort["Fala Lefaliir"] = 1224; nameSort["Falcon"] = 1225; nameSort["Falcon the Hunter"] = 1226; nameSort["Faldorn"] = 1227; nameSort["False Lich"] = 1228; nameSort["Farastu Demodand"] = 1229; nameSort["Farastu Stalker"] = 1230; nameSort["Farmer"] = 1231; nameSort["Faroul"] = 1232; nameSort["Farrow"] = 1233; nameSort["Fastieth"] = 1234; nameSort["Fated Shaker"] = 1235; nameSort["Fate Hag"] = 1236; nameSort["Fathomer"] = 1237; nameSort["Fazrian"] = 1238; nameSort["Feathergale Knight"] = 1239; nameSort["Fel Ardra"] = 1240; nameSort["Felbarren Dwarf"] = 1241; 
nameSort["Felgolos"] = 1242; nameSort["Felidar"] = 1243; nameSort["Fel'rekt Lafeen"] = 1244; nameSort["Female Steeder"] = 1245; nameSort["Fennor"] = 1246; nameSort["Fensir Devourer"] = 1247; nameSort["Fensir Skirmisher"] = 1248; nameSort["Fenthaza"] = 1249; nameSort["Feonor"] = 1250; nameSort["Feral Ashenwight"] = 1251; nameSort["Fernitha"] = 1252; nameSort["Ferocidon"] = 1253; nameSort["Ferol Sal"] = 1254; nameSort["Ferrumach Rilmani"] = 1255; nameSort["Fewmaster Gholcag"] = 1256; nameSort["Feyr"] = 1257; nameSort["Fey Spirit"] = 1258; nameSort["Fhenimore"] = 1259; nameSort["Fidelio"] = 1260; nameSort["Fiend Cultist 2025"] = 1261; 
nameSort["Fiendish Auger"] = 1262; nameSort["Fiendish Flesh Golem"] = 1263; nameSort["Fiendish Formian"] = 1264; nameSort["Fiendish Giant Spider"] = 1265; nameSort["Fiendish Icon"] = 1266; nameSort["Fiendish Orc"] = 1267; nameSort["Fiendish Spirit"] = 1268; nameSort["Fierna"] = 1269; nameSort["Figaro"] = 1270; nameSort["Firbolg Primeval Warden"] = 1271; nameSort["Firbolg Wanderer"] = 1272; nameSort["Fire Elemental"] = 1273; nameSort["Fire Elemental 2025"] = 1274; nameSort["Fire Elemental Myrmidon"] = 1275; nameSort["Firefist"] = 1276; nameSort["Firegaunt"] = 1277; nameSort["Fire Giant"] = 1278; nameSort["Fire Giant 2025"] = 1279; nameSort["Fire Giant Dreadnought"] = 1280; nameSort["Fire Giant Forgecaller"] = 1281; 
nameSort["Fire Giant of Evil Fire"] = 1282; nameSort["Fire Giant Royal Headsman"] = 1283; nameSort["Fire Giant Servant"] = 1284; nameSort["Fire Guardian"] = 1285; nameSort["Fire Hellion"] = 1286; nameSort["Fire Kraken"] = 1287; nameSort["Firemane Angel"] = 1288; nameSort["Firenewt Warlock of Imix"] = 1289; nameSort["Firenewt Warrior"] = 1290; nameSort["Fire Snake"] = 1291; nameSort["First-Year Student"] = 1292; nameSort["Fish"] = 1293; nameSort["Fist of Bane"] = 1294; nameSort["Five-Armed Troll"] = 1295; nameSort["Flabbergast"] = 1296; nameSort["Flail Snail"] = 1297; nameSort["Flameskull"] = 1298; nameSort["Flameskull 2025"] = 1299; nameSort["Flamewrath"] = 1300; nameSort["Flaming Skeleton 2025"] = 1301; 
nameSort["Flapjack"] = 1302; nameSort["Flask of Wine"] = 1303; nameSort["Fleecemane Lion"] = 1304; nameSort["Flesh Colossus"] = 1305; nameSort["Flesh Golem"] = 1306; nameSort["Flesh Golem 2025"] = 1307; nameSort["Flesh Meld"] = 1308; nameSort["Flight Alabaster Angel"] = 1309; nameSort["Flight Goldnight Angel"] = 1310; nameSort["Flight of Moonsilver Angel"] = 1311; nameSort["Flimp Shagglecran"] = 1312; nameSort["Flind"] = 1313; nameSort["Flitterstep Eidolon"] = 1314; nameSort["Flizzlebin"] = 1315; nameSort["Floon Blagmaar"] = 1316; nameSort["Flumph"] = 1317; nameSort["Flumph 2025"] = 1318; nameSort["Flux Blastseeker"] = 1319; nameSort["Fluxcharger"] = 1320; nameSort["Flying Dagger"] = 1321; 
nameSort["Flying Horror"] = 1322; nameSort["Flying Monkey"] = 1323; nameSort["Flying Rocking Horse"] = 1324; nameSort["Flying Shield"] = 1325; nameSort["Flying Snake"] = 1326; nameSort["Flying Snake 2025"] = 1327; nameSort["Flying Staff"] = 1328; nameSort["Flying Sword"] = 1329; nameSort["Flying Trident"] = 1330; nameSort["Flying Wand"] = 1331; nameSort["Flying Wonder"] = 1332; nameSort["Fog Giant"] = 1333; nameSort["Foghome"] = 1334; nameSort["Fomorian"] = 1335; nameSort["Fomorian 2025"] = 1336; nameSort["Fomorian Deep Crawler"] = 1337; nameSort["Fomorian Noble"] = 1338; nameSort["Fomorian Warlock of the Dark"] = 1339; nameSort["Forest Master"] = 1340; nameSort["Foresworn"] = 1341; 
nameSort["Forge Fitzwilliam"] = 1342; nameSort["Forlarren"] = 1343; nameSort["Four-Armed Gargoyle"] = 1344; nameSort["Four-Armed Statue"] = 1345; nameSort["Four-Armed Troll"] = 1346; nameSort["Fox"] = 1347; nameSort["Fractal Mascot"] = 1348; nameSort["Fractine"] = 1349; nameSort["Fragment of Krokulmar"] = 1350; nameSort["Fraternity of Order Law Bender"] = 1351; nameSort["Fraz-Urb'luu"] = 1352; nameSort["Frilled Deathspitter"] = 1353; nameSort["Frody Dartwild"] = 1354; nameSort["Frog"] = 1355; nameSort["Frog 2025"] = 1356; nameSort["Froghemoth"] = 1357; nameSort["Froghemoth Elder"] = 1358; nameSort["Frontline Medic"] = 1359; nameSort["Frost Druid"] = 1360; nameSort["Frost Giant"] = 1361; 
nameSort["Frost Giant 2025"] = 1362; nameSort["Frost Giant Everlasting One"] = 1363; nameSort["Frost Giant Ice Shaper"] = 1364; nameSort["Frost Giant of Evil Water"] = 1365; nameSort["Frost Giant Servant"] = 1366; nameSort["Frost Giant Skeleton"] = 1367; nameSort["Frost Giant Zombie"] = 1368; nameSort["Frostmourn"] = 1369; nameSort["Frost Salamander"] = 1370; nameSort["Frost Worm"] = 1371; nameSort["Frozen Golem"] = 1372; nameSort["Frulam Mondath"] = 1373; nameSort["Fume Drake"] = 1374; nameSort["Fungal Servant"] = 1375; nameSort["Fury of Kostchtchie"] = 1376; nameSort["F'yorl"] = 1377; nameSort["Gadabout"] = 1378; nameSort["Gadof Blinsky"] = 1379; nameSort["Gaj"] = 1380; nameSort["Galazeth Prismari"] = 1381; 
nameSort["Galeb Duhr"] = 1382; nameSort["Galeb Duhr 2025"] = 1383; nameSort["Galeokaerda"] = 1384; nameSort["Gallows Speaker"] = 1385; nameSort["Galsariad Ardyth (Tier 1)"] = 1386; nameSort["Galsariad Ardyth (Tier 2)"] = 1387; nameSort["Galsariad Ardyth (Tier 3)"] = 1388; nameSort["Galvan"] = 1389; nameSort["Galvanic Blastseeker"] = 1390; nameSort["Galvanice Weird"] = 1391; nameSort["Galvan Magen"] = 1392; nameSort["Gammon Xungoon"] = 1393; nameSort["Gargantua"] = 1394; nameSort["Gargantuan Rug of Smothering"] = 1395; nameSort["Gargoyle"] = 1396; nameSort["Gargoyle 2025"] = 1397; nameSort["Garra"] = 1398; nameSort["Garret Levistusson"] = 1399; nameSort["Gar Shatterkeel"] = 1400; nameSort["Gash"] = 1401; 
nameSort["Gas Spore"] = 1402; nameSort["Gas Spore Fungus 2025"] = 1403; nameSort["Gauth"] = 1404; nameSort["Gazer"] = 1405; nameSort["Gearbox"] = 1406; nameSort["Gearkeeper Construct"] = 1407; nameSort["Geist"] = 1408; nameSort["Gelatinous Cube"] = 1409; nameSort["Gelatinous Cube 2025"] = 1410; nameSort["Gem Stalker"] = 1411; nameSort["Geonid"] = 1412; nameSort["Gertrube"] = 1413; nameSort["Gertruda"] = 1414; nameSort["Geryon"] = 1415; nameSort["Ghald"] = 1416; nameSort["Ghallanda Troubleshooter"] = 1417; nameSort["Ghast"] = 1418; nameSort["Ghast 2025"] = 1419; nameSort["Ghast Gravecaller 2025"] = 1420; nameSort["Ghazrim DuLoc"] = 1421; 
nameSort["Ghelryn Foehammer"] = 1422; nameSort["Ghost"] = 1423; nameSort["Ghost 2025"] = 1424; nameSort["Ghostblade Eidolon"] = 1425; nameSort["Ghost Dragon"] = 1426; nameSort["Ghoul"] = 1427; nameSort["Ghoul 2025"] = 1428; nameSort["Giant"] = 1429; nameSort["Giant Ape"] = 1430; nameSort["Giant Ape 2025"] = 1431; nameSort["Giant Axe Beak 2025"] = 1432; nameSort["Giant Badger"] = 1433; nameSort["Giant Badger 2025"] = 1434; nameSort["Giant Bat"] = 1435; nameSort["Giant Bat 2025"] = 1436; nameSort["Giant Boar"] = 1437; nameSort["Giant Boar 2025"] = 1438; nameSort["Giant Canary"] = 1439; nameSort["Giant Centipede"] = 1440; nameSort["Giant Centipede 2025"] = 1441; 
nameSort["Giant Child"] = 1442; nameSort["Giant Constrictor Snake"] = 1443; nameSort["Giant Constrictor Snake 2025"] = 1444; nameSort["Giant Coral Snake"] = 1445; nameSort["Giant Corrupted Rat"] = 1446; nameSort["Giant Crab"] = 1447; nameSort["Giant Crab 2025"] = 1448; nameSort["Giant Crayfish"] = 1449; nameSort["Giant Crocodile"] = 1450; nameSort["Giant Crocodile 2025"] = 1451; nameSort["Giant Dragonfly"] = 1452; nameSort["Giant Eagle"] = 1453; nameSort["Giant Eagle 2025"] = 1454; nameSort["Giant Elk"] = 1455; nameSort["Giant Elk 2025"] = 1456; nameSort["Giant Fire Beetle"] = 1457; nameSort["Giant Fire Beetle 2025"] = 1458; nameSort["Giant Fly"] = 1459; nameSort["Giant Flying Spider"] = 1460; nameSort["Giant Four-Armed Gargoyle"] = 1461; 
nameSort["Giant Frog"] = 1462; nameSort["Giant Frog 2025"] = 1463; nameSort["Giant Goat"] = 1464; nameSort["Giant Goat 2025"] = 1465; nameSort["Giant Goose"] = 1466; nameSort["Giant Hyena"] = 1467; nameSort["Giant Hyena 2025"] = 1468; nameSort["Giant Ice Toad"] = 1469; nameSort["Giant Insect"] = 1470; nameSort["Giant Lightning Eel"] = 1471; nameSort["Giant Lizard"] = 1472; nameSort["Giant Lizard 2025"] = 1473; nameSort["Giant Lynx"] = 1474; nameSort["Giant Mutated Drow"] = 1475; nameSort["Giant Octopus"] = 1476; nameSort["Giant Octopus 2025"] = 1477; nameSort["Giant Owl"] = 1478; nameSort["Giant Owl 2025"] = 1479; nameSort["Giant Ox"] = 1480; nameSort["Giant Poisonous Snake"] = 1481; 
nameSort["Giant Ram"] = 1482; nameSort["Giant Rat"] = 1483; nameSort["Giant Rat 2025"] = 1484; nameSort["Giant Raven"] = 1485; nameSort["Giant Riding Lizard"] = 1486; nameSort["Giant River Serpent"] = 1487; nameSort["Giant Rocktopus"] = 1488; nameSort["Giant Scorpion"] = 1489; nameSort["Giant Scorpion 2025"] = 1490; nameSort["Giant Sea Eel"] = 1491; nameSort["Giant Sea Horse"] = 1492; nameSort["Giant Seahorse 2025"] = 1493; nameSort["Giant Shark"] = 1494; nameSort["Giant Shark 2025"] = 1495; nameSort["Giant Shark Skeleton"] = 1496; nameSort["Giant Skeleton"] = 1497; nameSort["Giant Slug"] = 1498; nameSort["Giant Snail"] = 1499; nameSort["Giant Snapping Turtle"] = 1500; nameSort["Giant Space Hamster"] = 1501; 
nameSort["Giant Spider"] = 1502; nameSort["Giant Spider 2025"] = 1503; nameSort["Giant Squid 2025"] = 1504; nameSort["Giant Strider"] = 1505; nameSort["Giant Subterranean Lizard"] = 1506; nameSort["Giant Swan"] = 1507; nameSort["Giant Tick"] = 1508; nameSort["Giant Toad"] = 1509; nameSort["Giant Toad 2025"] = 1510; nameSort["Giant Venomous Snake 2025"] = 1511; nameSort["Giant Vulture"] = 1512; nameSort["Giant Vulture 2025"] = 1513; nameSort["Giant Walrus"] = 1514; nameSort["Giant Wasp"] = 1515; nameSort["Giant Wasp 2025"] = 1516; nameSort["Giant Weasel"] = 1517; nameSort["Giant Weasel 2025"] = 1518; nameSort["Giant Whirlwyrm"] = 1519; nameSort["Giant White Moray Eel"] = 1520; nameSort["Giant Wolf Spider"] = 1521; 
nameSort["Giant Wolf Spider 2025"] = 1522; nameSort["Giant Zombie Constrictor Snake"] = 1523; nameSort["Gibbering Mouther"] = 1524; nameSort["Gibbering Mouther 2025"] = 1525; nameSort["Gibberling"] = 1526; nameSort["Gideon Lightward"] = 1527; nameSort["Giff"] = 1528; nameSort["Giff Shipmate"] = 1529; nameSort["Giff Shock Trooper"] = 1530; nameSort["Giff Warlord"] = 1531; nameSort["Gigant"] = 1532; nameSort["Gildha Duhn"] = 1533; nameSort["Gingerbrute"] = 1534; nameSort["Gingwatzim"] = 1535; nameSort["Girallon"] = 1536; nameSort["Girallon Zombie"] = 1537; nameSort["Gisela"] = 1538; nameSort["Gishath, Sun's Avatar"] = 1539; nameSort["Githyanki Buccaneer"] = 1540; nameSort["Githyanki Dracomancer 2025"] = 1541; 
nameSort["Githyanki Gish"] = 1542; nameSort["Githyanki Kith'rak"] = 1543; nameSort["Githyanki Knight"] = 1544; nameSort["Githyanki Knight 2025"] = 1545; nameSort["Githyanki Star Seer"] = 1546; nameSort["Githyanki Supreme Commander"] = 1547; nameSort["Githyanki Warrior"] = 1548; nameSort["Githyanki Warrior 2025"] = 1549; nameSort["Githyanki Xenomancer"] = 1550; nameSort["Githzerai Anarch"] = 1551; nameSort["Githzerai Enlightened"] = 1552; nameSort["Githzerai Futurist"] = 1553; nameSort["Githzerai Monk"] = 1554; nameSort["Githzerai Monk 2025"] = 1555; nameSort["Githzerai Psion 2025"] = 1556; nameSort["Githzerai Traveler"] = 1557; nameSort["Githzerai Uniter"] = 1558; nameSort["Githzerai Zerth"] = 1559; nameSort["Githzerai Zerth 2025"] = 1560; nameSort["Glabbagool"] = 1561; 
nameSort["Glabrezu"] = 1562; nameSort["Glabrezu 2025"] = 1563; nameSort["Gladiator"] = 1564; nameSort["Gladiator 2025"] = 1565; nameSort["Glaive"] = 1566; nameSort["Glass Pegasus"] = 1567; nameSort["Glasswork Golem"] = 1568; nameSort["Glasya"] = 1569; nameSort["Gloam"] = 1570; nameSort["Gloamwing"] = 1571; nameSort["Gloine Nathair-Nathair"] = 1572; nameSort["Gloomstalker"] = 1573; nameSort["Gloom Weaver"] = 1574; nameSort["Glyphic Shroomlight"] = 1575; nameSort["Glyster"] = 1576; nameSort["Gnarlid"] = 1577; nameSort["Gnoll"] = 1578; nameSort["Gnoll Demoniac 2025"] = 1579; nameSort["Gnoll Fang of Yeenoghu"] = 1580; nameSort["Gnoll Fang of Yeenoghu 2025"] = 1581; 
nameSort["Gnoll Flesh Gnawer"] = 1582; nameSort["Gnoll Hunter"] = 1583; nameSort["Gnoll Pack Lord"] = 1584; nameSort["Gnoll Pack Lord 2025"] = 1585; nameSort["Gnoll Vampire"] = 1586; nameSort["Gnoll Warrior"] = 1587; nameSort["Gnoll Warrior 2025"] = 1588; nameSort["Gnoll Witherling"] = 1589; nameSort["Gnome Ceremorph"] = 1590; nameSort["Gnome Squidling"] = 1591; nameSort["Goat"] = 1592; nameSort["Goat 2025"] = 1593; nameSort["Goblin"] = 1594; nameSort["Goblin Boss"] = 1595; nameSort["Goblin Boss 2025"] = 1596; nameSort["Goblin Boss Archer"] = 1597; nameSort["Goblin Commoner"] = 1598; nameSort["Goblin Gang Member"] = 1599; nameSort["Goblin Hexer 2025"] = 1600; nameSort["Goblin Minion 2025"] = 1601; 
nameSort["Goblin Psi Brawler"] = 1602; nameSort["Goblin Psi Commander"] = 1603; nameSort["Goblin Warrior"] = 1604; nameSort["Goblin Warrior 2025"] = 1605; nameSort["Gold Dragon Wyrmling"] = 1606; nameSort["Gold Dragon Wyrmling 2025"] = 1607; nameSort["Golden Stag"] = 1608; nameSort["Gold-Forged Sentinel"] = 1609; nameSort["Gold Greatwyrm"] = 1610; nameSort["Golgari Shaman"] = 1611; nameSort["Goliath Giant-Kin"] = 1612; nameSort["Goliath Warrior"] = 1613; nameSort["Goliath Werebear"] = 1614; nameSort["Gomazoa"] = 1615; nameSort["Gondolo"] = 1616; nameSort["Goon"] = 1617; nameSort["Goon Balloon"] = 1618; nameSort["Goose Mother"] = 1619; nameSort["Gorgon"] = 1620; nameSort["Gorgon 2025"] = 1621; 
nameSort["Goristro"] = 1622; nameSort["Goristro 2025"] = 1623; nameSort["Gorka Tharn"] = 1624; nameSort["Gorthok the Thunder Boar"] = 1625; nameSort["Gorvan Ironheart"] = 1626; nameSort["Gorzil's Gang Troglodyte"] = 1627; nameSort["Grabstab"] = 1628; nameSort["Grandfather Oak"] = 1629; nameSort["Grandfather Zitembe"] = 1630; nameSort["Grandlejaw"] = 1631; nameSort["Grandolpha Muzgardt"] = 1632; nameSort["Granite Juggernaut"] = 1633; nameSort["Graveyard Revenant 2025"] = 1634; nameSort["Gray Ooze"] = 1635; nameSort["Gray Ooze 2025"] = 1636; nameSort["Gray Ooze Glob"] = 1637; nameSort["Gray Render"] = 1638; nameSort["Gray Scavver"] = 1639; nameSort["Gray Slaad"] = 1640; nameSort["Gray Slaad 2025"] = 1641; 
nameSort["Grazilaxx"] = 1642; nameSort["Graz'zt"] = 1643; nameSort["Great Cat"] = 1644; nameSort["Great Chief Halric Bonesnapper"] = 1645; nameSort["Greater Death Dragon"] = 1646; nameSort["Greater Shadow Horror"] = 1647; nameSort["Greater Star Spawn Emissary"] = 1648; nameSort["Greater Tyrant Shadow"] = 1649; nameSort["Greater Zombie"] = 1650; nameSort["Great Kroom, Purple Worm"] = 1651; nameSort["Great Ulfe"] = 1652; nameSort["Green Abishai"] = 1653; nameSort["Green Dragon Wyrmling"] = 1654; nameSort["Green Dragon Wyrmling 2025"] = 1655; nameSort["Green Greatwyrm"] = 1656; nameSort["Green Guard Drake"] = 1657; nameSort["Green Hag"] = 1658; nameSort["Green Hag 2025"] = 1659; nameSort["Green Slaad"] = 1660; nameSort["Green Slaad 2025"] = 1661; 
nameSort["Gregir Fendelsohn (Levels 1-4)"] = 1662; nameSort["Gregir Fendelsohn (Levels 5-8)"] = 1663; nameSort["Gregir Fendelsohn (Levels 9-11)"] = 1664; nameSort["Grell"] = 1665; nameSort["Grell 2025"] = 1666; nameSort["Grell Psychic"] = 1667; nameSort["Gremishka"] = 1668; nameSort["Gremlin"] = 1669; nameSort["Gremorly's Ghost"] = 1670; nameSort["Grenl"] = 1671; nameSort["Grick"] = 1672; nameSort["Grick 2025"] = 1673; nameSort["Grick Alpha"] = 1674; nameSort["Grick Ancient 2025"] = 1675; nameSort["Griffin"] = 1676; nameSort["Griffin (Type 1)"] = 1677; nameSort["Griffin (Type 2)"] = 1678; nameSort["Griffon"] = 1679; nameSort["Griffon 2025"] = 1680; nameSort["Griffon Cavalry Rider"] = 1681; 
nameSort["Grim Champion of Bloodshed"] = 1682; nameSort["Grim Champion of Desolation"] = 1683; nameSort["Grim Champion of Pestilence"] = 1684; nameSort["Grimlock"] = 1685; nameSort["Grimlock 2025"] = 1686; nameSort["Grimzod Gargenhale"] = 1687; nameSort["Grinda Garloth"] = 1688; nameSort["Grinning Cat"] = 1689; nameSort["Grippli Warrior"] = 1690; nameSort["Grisdelfawr"] = 1691; nameSort["Grisha"] = 1692; nameSort["Groff"] = 1693; nameSort["Grotesque Tentacle"] = 1694; nameSort["Grottenelle Stonecutter"] = 1695; nameSort["Grumink the Renegade"] = 1696; nameSort["Grum'shar"] = 1697; nameSort["Grung"] = 1698; nameSort["Grung Elite Warrior"] = 1699; nameSort["Grung Wildling"] = 1700; nameSort["Grunka"] = 1701; 
nameSort["Grutha"] = 1702; nameSort["Gryz Alakritos"] = 1703; nameSort["Guard"] = 1704; nameSort["Guard 2025"] = 1705; nameSort["Guard Captain 2025"] = 1706; nameSort["Guard Drake"] = 1707; nameSort["Guardian Giant"] = 1708; nameSort["Guardian Naga"] = 1709; nameSort["Guardian Naga 2025"] = 1710; nameSort["Guardian of Gorm"] = 1711; nameSort["Guardian Portrait"] = 1712; nameSort["Guardian Wolf"] = 1713; nameSort["Gulthias Blight 2025"] = 1714; nameSort["Gundren Rockseeker"] = 1715; nameSort["Gunvald Halraggson"] = 1716; nameSort["Guthash"] = 1717; nameSort["Gwyn Oresong"] = 1718; nameSort["Gynosphinx"] = 1719; nameSort["Hadozee Explorer"] = 1720; nameSort["Hadozee Shipmate"] = 1721; 
nameSort["Hadozee Warrior"] = 1722; nameSort["Hadrosaur"] = 1723; nameSort["Hadrosaurus"] = 1724; nameSort["Hag of the Fetid Gaze"] = 1725; nameSort["Haint"] = 1726; nameSort["Halaster Blackcloak"] = 1727; nameSort["Halaster Horror"] = 1728; nameSort["Halaster Puppet"] = 1729; nameSort["Half-Blue Dragon Gladiator"] = 1730; nameSort["Half-Dragon"] = 1731; nameSort["Half-Green Dragon Assassin"] = 1732; nameSort["Half-Ogre (Ogrillon)"] = 1733; nameSort["Half-Red Dragon Gladiator"] = 1734; nameSort["Half-Red Dragon Veteran"] = 1735; nameSort["Halog"] = 1736; nameSort["Hamadryad"] = 1737; nameSort["Hamish Hewland"] = 1738; nameSort["Hammerskull"] = 1739; nameSort["Hands of Havoc Fire Starter"] = 1740; nameSort["Hangry Otyugh"] = 1741; 
nameSort["Hanne Hallen"] = 1742; nameSort["Hare"] = 1743; nameSort["Harengon Brigand"] = 1744; nameSort["Harengon Sniper"] = 1745; nameSort["Harkina Hunt"] = 1746; nameSort["Harmonium Captain"] = 1747; nameSort["Harmonium Peacekeeper"] = 1748; nameSort["Harpy"] = 1749; nameSort["Harpy 2025"] = 1750; nameSort["Harpy Matriarch"] = 1751; nameSort["Harrow Hawk"] = 1752; nameSort["Harrow Hound"] = 1753; nameSort["Harshnag"] = 1754; nameSort["Harvester Devil"] = 1755; nameSort["Hashalaq Quori"] = 1756; nameSort["Hashutu"] = 1757; nameSort["Hastain"] = 1758; nameSort["Haungharassk"] = 1759; nameSort["Haunting Revenant 2025"] = 1760; nameSort["Hawk"] = 1761; 
nameSort["Hawk 2025"] = 1762; nameSort["Hazvongel"] = 1763; nameSort["Headless Body"] = 1764; nameSort["Headless Iron Golem"] = 1765; nameSort["Heartstabber Mosquito"] = 1766; nameSort["Hedrun Arnsfirth"] = 1767; nameSort["Helga Ruvak"] = 1768; nameSort["Hellcat (Bezekira)"] = 1769; nameSort["Hellenhild"] = 1770; nameSort["Hellenrae"] = 1771; nameSort["Hellfire Engine"] = 1772; nameSort["Hell Hound"] = 1773; nameSort["Hell Hound 2025"] = 1774; nameSort["Hellion"] = 1775; nameSort["Hellion (Huge)"] = 1776; nameSort["Hellion (Large)"] = 1777; nameSort["Hellwasp"] = 1778; nameSort["Hellwasp Grub"] = 1779; nameSort["Helmed Horror"] = 1780; nameSort["Helmed Horror 2025"] = 1781; 
nameSort["Helmed Horror Detention Drone"] = 1782; nameSort["Hengar Aesnvaard"] = 1783; nameSort["Henrik van der Voort"] = 1784; nameSort["Heralds of Dust Exorcist"] = 1785; nameSort["Heralds of Dust Remnant"] = 1786; nameSort["Hertilod"] = 1787; nameSort["Hester Barch"] = 1788; nameSort["Hew Hackinstone"] = 1789; nameSort["Hexton Modron"] = 1790; nameSort["Hezrou"] = 1791; nameSort["Hezrou 2025"] = 1792; nameSort["Hierophant Medusa"] = 1793; nameSort["Hierophant of the Comet"] = 1794; nameSort["High Fae Impostor"] = 1795; nameSort["High Fae Kindguard"] = 1796; nameSort["High Fae Mage"] = 1797; nameSort["High Fae Noble"] = 1798; nameSort["Hill Giant"] = 1799; nameSort["Hill Giant 2025"] = 1800; nameSort["Hill Giant Avalancher"] = 1801; 
nameSort["Hill Giant, Blorbo"] = 1802; nameSort["Hill Giant Sergeant"] = 1803; nameSort["Hill Giant Servant"] = 1804; nameSort["Hill Giant Subchief"] = 1805; nameSort["Hippocamp"] = 1806; nameSort["Hippogriff"] = 1807; nameSort["Hippogriff 2025"] = 1808; nameSort["Hippopotamus"] = 1809; nameSort["Hippopotamus 2025"] = 1810; nameSort["Hjoldak Hollowhelm"] = 1811; nameSort["Hlam"] = 1812; nameSort["Hoard Mimic"] = 1813; nameSort["Hoard Scarab"] = 1814; nameSort["Hobgoblin"] = 1815; nameSort["Hobgoblin Captain"] = 1816; nameSort["Hobgoblin Captain 2025"] = 1817; nameSort["Hobgoblin Devastator"] = 1818; nameSort["Hobgoblin Iron Shadow"] = 1819; nameSort["Hobgoblin Warlord"] = 1820; nameSort["Hobgoblin Warlord 2025"] = 1821; 
nameSort["Hobgoblin Warrior 2025"] = 1822; nameSort["Holga Kilgore"] = 1823; nameSort["Hollow Dragon"] = 1824; nameSort["Hollyphant"] = 1825; nameSort["Homarid"] = 1826; nameSort["Homunculus"] = 1827; nameSort["Homunculus 2025"] = 1828; nameSort["Homunculus Servant"] = 1829; nameSort["Honna"] = 1830; nameSort["Hook Horror"] = 1831; nameSort["Hook Horror 2025"] = 1832; nameSort["Hook Horror Spore Servant"] = 1833; nameSort["Horizonback Tortoise"] = 1834; nameSort["Horncaller"] = 1835; nameSort["Horned Devil"] = 1836; nameSort["Horned Devil 2025"] = 1837; nameSort["Horned Frog"] = 1838; nameSort["Horned Sister"] = 1839; nameSort["Horrid Plant"] = 1840; nameSort["Host of Herons Angel"] = 1841; 
nameSort["Hound Archon"] = 1842; nameSort["Hound of Ill Omen"] = 1843; nameSort["Howler"] = 1844; nameSort["Howling Hatred Initiate"] = 1845; nameSort["Howling Hatred Priest"] = 1846; nameSort["Hrabbaz"] = 1847; nameSort["Hrigg Roundrook"] = 1848; nameSort["Huge Giant Crab"] = 1849; nameSort["Huge Gray Ooze"] = 1850; nameSort["Huge Ochre Jelly"] = 1851; nameSort["Huge Polar Bear"] = 1852; nameSort["Huge Stone Golem"] = 1853; nameSort["Hulgaz"] = 1854; nameSort["Hulil Lutan"] = 1855; nameSort["Hulking Crab"] = 1856; nameSort["Hulking Shadow"] = 1857; nameSort["Humanoid Mutate"] = 1858; nameSort["Hundred-Handed One"] = 1859; nameSort["Hungry Sorrowsworn"] = 1860; nameSort["Hunter Shark"] = 1861; 
nameSort["Hunter Shark 2025"] = 1862; nameSort["Hurda"] = 1863; nameSort["Hurricane"] = 1864; nameSort["Husk Zombie"] = 1865; nameSort["Hutijin"] = 1866; nameSort["Hybrid Brute"] = 1867; nameSort["Hybrid Flier"] = 1868; nameSort["Hybrid Poisoner"] = 1869; nameSort["Hybrid Shocker"] = 1870; nameSort["Hybrid Spy"] = 1871; nameSort["Hydia Moonmusk"] = 1872; nameSort["Hydra"] = 1873; nameSort["Hydra 2025"] = 1874; nameSort["Hydroloth"] = 1875; nameSort["Hyena"] = 1876; nameSort["Hyena 2025"] = 1877; nameSort["Hypnos Magen"] = 1878; nameSort["Hythonia"] = 1879; nameSort["Iarno Glasstaff Albrek"] = 1880; nameSort["Iaseda"] = 1881; 
nameSort["Ice Devil"] = 1882; nameSort["Ice Devil 2025"] = 1883; nameSort["Ice Mephit"] = 1884; nameSort["Ice Mephit 2025"] = 1885; nameSort["Ice Piercer"] = 1886; nameSort["Ice Spider"] = 1887; nameSort["Ice Spider Queen"] = 1888; nameSort["Ice Toad"] = 1889; nameSort["Ice Troll"] = 1890; nameSort["Icewind Kobold"] = 1891; nameSort["Icewind Kobold Zombie"] = 1892; nameSort["Icy Simulacrum"] = 1893; nameSort["Ifan Talro'a"] = 1894; nameSort["Iggwilv the Witch Queen"] = 1895; nameSort["Ignatius Inkblot"] = 1896; nameSort["Ignia"] = 1897; nameSort["Illithilich"] = 1898; nameSort["Illusionist"] = 1899; nameSort["Illusionist Wizard"] = 1900; nameSort["Ilvara Mizzrym"] = 1901; 
nameSort["Imelda"] = 1902; nameSort["Imix"] = 1903; nameSort["Immortal Lotus Monk"] = 1904; nameSort["Imoen"] = 1905; nameSort["Imp"] = 1906; nameSort["Imp 2025"] = 1907; nameSort["Imperator Uthor"] = 1908; nameSort["Imp Trickster"] = 1909; nameSort["Incarnation of Transience"] = 1910; nameSort["Incarnation of Vibrance"] = 1911; nameSort["Incomplete Dragon Skeleton"] = 1912; nameSort["Incubus"] = 1913; nameSort["Incubus 2025"] = 1914; nameSort["Inda"] = 1915; nameSort["Indentured Spirit"] = 1916; nameSort["Indrina Lamsensettle"] = 1917; nameSort["Infant Basilisk"] = 1918; nameSort["Infant Hook Horror"] = 1919; nameSort["Infected Elder Brain"] = 1920; nameSort["Infected Townsperson"] = 1921; 
nameSort["Initiate of the Comet"] = 1922; nameSort["Inkling Mascot"] = 1923; nameSort["Inquisitor of the Mind Fire"] = 1924; nameSort["Inquisitor of the Sword"] = 1925; nameSort["Inquisitor of the Tome"] = 1926; nameSort["Insight Acuere"] = 1927; nameSort["Inspired"] = 1928; nameSort["Intellect Devourer"] = 1929; nameSort["Intellect Devourer 2025"] = 1930; nameSort["Intellect Snare"] = 1931; nameSort["Intelligent Black Pudding"] = 1932; nameSort["Invisible Stalker"] = 1933; nameSort["Invisible Stalker 2025"] = 1934; nameSort["Iona"] = 1935; nameSort["Irda Seeker"] = 1936; nameSort["Irda Veil Keeper"] = 1937; nameSort["Ireena Kolyana"] = 1938; nameSort["Iriad"] = 1939; nameSort["Irisoth"] = 1940; nameSort["Iron Cobra"] = 1941; 
nameSort["Iron Consul"] = 1942; nameSort["Iron Defender"] = 1943; nameSort["Iron Golem"] = 1944; nameSort["Iron Golem 2025"] = 1945; nameSort["Ironscale Hydra"] = 1946; nameSort["Iron Spider"] = 1947; nameSort["Irvan Wastewalker (Tier 1)"] = 1948; nameSort["Irvan Wastewalker (Tier 2)"] = 1949; nameSort["Irvan Wastewalker (Tier 3)"] = 1950; nameSort["Isabela Folcarae"] = 1951; nameSort["Isarr Kronenstrom"] = 1952; nameSort["Isendraug"] = 1953; nameSort["Ishel"] = 1954; nameSort["Ishvern"] = 1955; nameSort["Iskander"] = 1956; nameSort["Ismark Kolyanovich"] = 1957; nameSort["Isolde"] = 1958; nameSort["Isperia"] = 1959; nameSort["Istarian Drone"] = 1960; nameSort["Istrid Horn"] = 1961; 
nameSort["Ivlis"] = 1962; nameSort["Ixitxachitl"] = 1963; nameSort["Ixitxachitl Cleric"] = 1964; nameSort["Iymrith"] = 1965; nameSort["Izek Strazni"] = 1966; nameSort["Jabberwock"] = 1967; nameSort["Jackal"] = 1968; nameSort["Jackal 2025"] = 1969; nameSort["Jackalwere"] = 1970; nameSort["Jackalwere 2025"] = 1971; nameSort["Jacko"] = 1972; nameSort["Jaculi"] = 1973; nameSort["Jade Giant Spider"] = 1974; nameSort["Jade Statue"] = 1975; nameSort["Jade Tigress"] = 1976; nameSort["Jaheira"] = 1977; nameSort["Jalester Silvermane"] = 1978; nameSort["Jalynvyr Nir'Thinn"] = 1979; nameSort["James Cryon"] = 1980; nameSort["Jamil A'alithiya"] = 1981; 
nameSort["Jammer Leech"] = 1982; nameSort["Jamna Gleamsilver"] = 1983; nameSort["Jandar Chergoba"] = 1984; nameSort["Jarad Vod Savo"] = 1985; nameSort["Jarazoun"] = 1986; nameSort["Jarlaxle Baenre"] = 1987; nameSort["Jarl Grugnur"] = 1988; nameSort["Jarl Storvald"] = 1989; nameSort["Jarund Elkhardt"] = 1990; nameSort["Jasper Dimmerchasm"] = 1991; nameSort["Jelayne"] = 1992; nameSort["Jenevere"] = 1993; nameSort["Jenks"] = 1994; nameSort["Jermlaine"] = 1995; nameSort["Jerot Galgin"] = 1996; nameSort["Jessamine"] = 1997; nameSort["Jeyev Veldrews"] = 1998; nameSort["Jiangshi"] = 1999; nameSort["Jijibisha Manivarshi"] = 2000; nameSort["Jim Darkmagic"] = 2001; 
nameSort["Jimjar"] = 2002; nameSort["Jingle Jangle"] = 2003; nameSort["Jobal"] = 2004; nameSort["Jon Irenicus"] = 2005; nameSort["Jorasco Medic"] = 2006; nameSort["Josbert Plum"] = 2007; nameSort["Joster Mareet"] = 2008; nameSort["Jot"] = 2009; nameSort["Juiblex"] = 2010; nameSort["Juliana"] = 2011; nameSort["Junior Drow Priestess of Lolth"] = 2012; nameSort["Juvenile Eldritch Horror"] = 2013; nameSort["Juvenile Hook Horror"] = 2014; nameSort["Juvenile Kraken"] = 2015; nameSort["Juvenile Mimic"] = 2016; nameSort["Juvenile Shadow Dragon 2025"] = 2017; nameSort["Kaaltar"] = 2018; nameSort["Kaarghaz"] = 2019; nameSort["Kadroth"] = 2020; nameSort["Kaevja Cynavern"] = 2021; 
nameSort["Kagain"] = 2022; nameSort["Kakkuu Spyder-Fiend"] = 2023; nameSort["Kalain"] = 2024; nameSort["Kala Mabarin"] = 2025; nameSort["Kalaman Soldier"] = 2026; nameSort["Kalaraq Quori"] = 2027; nameSort["Kalashtar"] = 2028; nameSort["Kalka-Kylla"] = 2029; nameSort["Kal the Crisp"] = 2030; nameSort["Kamadan"] = 2031; nameSort["Kansaldi Fire-Eyes"] = 2032; nameSort["Kapak Draconian"] = 2033; nameSort["Karas Chembryl"] = 2034; nameSort["Karavarix"] = 2035; nameSort["Karkethzerethzerus, the Sable Despoiler"] = 2036; nameSort["Karrnathi Undead Soldier"] = 2037; nameSort["Kasem Aroon"] = 2038; nameSort["Kasimir Velikov"] = 2039; nameSort["Kas the Betrayer"] = 2040; nameSort["Kavil"] = 2041; 
nameSort["Kavoda"] = 2042; nameSort["Kavu Predator"] = 2043; nameSort["Kaylan Renaudon"] = 2044; nameSort["Kedjou Kamal"] = 2045; nameSort["Keeper of the Feather"] = 2046; nameSort["Keg Robot"] = 2047; nameSort["Kelek"] = 2048; nameSort["Kella Darkhope"] = 2049; nameSort["Kellikilli"] = 2050; nameSort["Kelpie"] = 2051; nameSort["Kelson Darktreader"] = 2052; nameSort["Kelubar Consul"] = 2053; nameSort["Kelubar Demodand"] = 2054; nameSort["Kender Skirmisher"] = 2055; nameSort["Kenku"] = 2056; nameSort["Kenku 2025"] = 2057; nameSort["Ker-arach"] = 2058; nameSort["Keresta Delvingstone"] = 2059; nameSort["Kettlesteam the Kenku"] = 2060; nameSort["Kevetta Dolindar"] = 2061; 
nameSort["Khai Kiroth"] = 2062; nameSort["Khalessa Draga"] = 2063; nameSort["Kharbek"] = 2064; nameSort["Khargra"] = 2065; nameSort["Khaspere Drylund"] = 2066; nameSort["Kianna"] = 2067; nameSort["Kiddywidget"] = 2068; nameSort["Kieren"] = 2069; nameSort["Killer Whale"] = 2070; nameSort["Killer Whale 2025"] = 2071; nameSort["Killmoulis"] = 2072; nameSort["Kindori"] = 2073; nameSort["King Hekaton"] = 2074; nameSort["King Jhaeros"] = 2075; nameSort["King of Feathers"] = 2076; nameSort["King Robbit the Slimy"] = 2077; nameSort["King Snurre"] = 2078; nameSort["Kingsport"] = 2079; nameSort["Kinyel Druu'giir"] = 2080; nameSort["Kiril Stoyanovich"] = 2081; 
nameSort["Ki-rin"] = 2082; nameSort["Kivan"] = 2083; nameSort["Klauth"] = 2084; nameSort["Knight"] = 2085; nameSort["Knight 2025"] = 2086; nameSort["Knight of Eldraine"] = 2087; nameSort["Knight of the Black Sword"] = 2088; nameSort["Knight of the Mithral Shield"] = 2089; nameSort["Knight of the Order"] = 2090; nameSort["Knucklehead Trout"] = 2091; nameSort["Koalinth"] = 2092; nameSort["Koalinth Sergeant"] = 2093; nameSort["Kobold"] = 2094; nameSort["Kobold Commoner"] = 2095; nameSort["Kobold Dragonshield"] = 2096; nameSort["Kobold Elite"] = 2097; nameSort["Kobold Inventor"] = 2098; nameSort["Kobold Scale Sorcerer"] = 2099; nameSort["Kobold Tinkerer"] = 2100; nameSort["Kobold Underling"] = 2101; 
nameSort["Kobold Vampire Spawn"] = 2102; nameSort["Kobold Warrior 2025"] = 2103; nameSort["Koh Tam"] = 2104; nameSort["Koi Prawn"] = 2105; nameSort["Kol'daan"] = 2106; nameSort["Kolyarut"] = 2107; nameSort["Kopoha"] = 2108; nameSort["Korex"] = 2109; nameSort["Koris"] = 2110; nameSort["Korred"] = 2111; nameSort["Kostchtchie"] = 2112; nameSort["Kozilek"] = 2113; nameSort["Kraken"] = 2114; nameSort["Kraken 2025"] = 2115; nameSort["Kraken Priest"] = 2116; nameSort["Kraul Death Priest"] = 2117; nameSort["Kraul Warrior"] = 2118; nameSort["Krebbyg Masq'il'yr"] = 2119; nameSort["Krell Grohlg"] = 2120; nameSort["Krenko"] = 2121; 
nameSort["Krull"] = 2122; nameSort["Kruthik Hive Lord"] = 2123; nameSort["K'thriss Drow'b"] = 2124; nameSort["K'Tulah"] = 2125; nameSort["Kun Ahn-Jun"] = 2126; nameSort["Kundarak Warden"] = 2127; nameSort["Kuo-toa"] = 2128; nameSort["Kuo-toa Archpriest"] = 2129; nameSort["Kuo-toa Heretic"] = 2130; nameSort["Kuo-toa Marauder"] = 2131; nameSort["Kuo-toa Monitor"] = 2132; nameSort["Kuo-toa Whip"] = 2133; nameSort["Kupalué"] = 2134; nameSort["Kurr"] = 2135; nameSort["Kusa Xungoon"] = 2136; nameSort["Kwayothé"] = 2137; nameSort["Kyrilla, Accursed Gorgon"] = 2138; nameSort["Kysh"] = 2139; nameSort["Lacedon"] = 2140; nameSort["Lacedon Ghoul 2025"] = 2141; 
nameSort["Lady Dre"] = 2142; nameSort["Lady Fiona Wachter"] = 2143; nameSort["Lady Gondafrey"] = 2144; nameSort["Lady Illmarrow"] = 2145; nameSort["Lady Lydia Petrovna"] = 2146; nameSort["Laeral Silverhand"] = 2147; nameSort["Lahnis"] = 2148; nameSort["Laiba Nana Rosse"] = 2149; nameSort["Laleh Ghorbani"] = 2150; nameSort["Lamai Tyenmo"] = 2151; nameSort["Lamia"] = 2152; nameSort["Lamia 2025"] = 2153; nameSort["Lampad"] = 2154; nameSort["Langdedrosa Cyanwrath"] = 2155; nameSort["Lantern Archon"] = 2156; nameSort["Large Drake"] = 2157; nameSort["Large Mimic"] = 2158; nameSort["Larva"] = 2159; nameSort["Larva 2025"] = 2160; nameSort["Laskilar"] = 2161; 
nameSort["Laurin Ophidas"] = 2162; nameSort["Lava Child"] = 2163; nameSort["Lawmage"] = 2164; nameSort["Layla the Lizard"] = 2165; nameSort["Laysa Matulin"] = 2166; nameSort["Lazav"] = 2167; nameSort["Leedara"] = 2168; nameSort["Left Hand of Manshoon"] = 2169; nameSort["Lemure"] = 2170; nameSort["Lemure 2025"] = 2171; nameSort["Leonin Iconoclast"] = 2172; nameSort["Leosin Erlanthar"] = 2173; nameSort["Leprechaun"] = 2174; nameSort["Lesser Death Dragon"] = 2175; nameSort["Lesser Mummy Lord"] = 2176; nameSort["Lesser Star Spawn Emissary"] = 2177; nameSort["Lesser Tyrant Shadow"] = 2178; nameSort["Leucrotta"] = 2179; nameSort["Leviathan"] = 2180; nameSort["Levistus"] = 2181; 
nameSort["Levna Drakehorn"] = 2182; nameSort["Lhammaruntosz"] = 2183; nameSort["Liara Portyr"] = 2184; nameSort["Lich"] = 2185; nameSort["Lich 2025"] = 2186; nameSort["Lichen Lich"] = 2187; nameSort["Lief Lipsiege"] = 2188; nameSort["Lifecraft Elephant"] = 2189; nameSort["Lifferlas"] = 2190; nameSort["Light Devourer"] = 2191; nameSort["Lightning Golem"] = 2192; nameSort["Lightning Hulk"] = 2193; nameSort["Linan Swift"] = 2194; nameSort["Linvala"] = 2195; nameSort["Lion"] = 2196; nameSort["Lion 2025"] = 2197; nameSort["Liondrake"] = 2198; nameSort["Living Bigby's Hand"] = 2199; nameSort["Living Blade of Disaster"] = 2200; nameSort["Living Burning Hands"] = 2201; 
nameSort["Living Cloudkill"] = 2202; nameSort["Living Demiplane"] = 2203; nameSort["Living Doll"] = 2204; nameSort["Living Iron Statue"] = 2205; nameSort["Living Lightning Bolt"] = 2206; nameSort["Living Portent"] = 2207; nameSort["Living Unseen Servant"] = 2208; nameSort["Lizard"] = 2209; nameSort["Lizard 2025"] = 2210; nameSort["Lizardfolk"] = 2211; nameSort["Lizardfolk Commoner"] = 2212; nameSort["Lizardfolk Geomancer 2025"] = 2213; nameSort["Lizardfolk Render"] = 2214; nameSort["Lizardfolk Scaleshield"] = 2215; nameSort["Lizardfolk Shaman"] = 2216; nameSort["Lizardfolk Sovereign 2025"] = 2217; nameSort["Lizardfolk Subchief"] = 2218; nameSort["Lizardfolk Warden"] = 2219; nameSort["Lizard King"] = 2220; nameSort["Lizard Queen"] = 2221; 
nameSort["Loading Rig"] = 2222; nameSort["Locathah"] = 2223; nameSort["Locathah Hunter"] = 2224; nameSort["Lohezet"] = 2225; nameSort["Lonely Sorrowsworn"] = 2226; nameSort["Lonelywood Banshee"] = 2227; nameSort["Lords' Alliance Guard"] = 2228; nameSort["Lords' Alliance Spy"] = 2229; nameSort["Lord Soth"] = 2230; nameSort["Lorehold Apprentice"] = 2231; nameSort["Lorehold Pledgemage"] = 2232; nameSort["Lorehold Professor of Chaos"] = 2233; nameSort["Lorehold Professor of Order"] = 2234; nameSort["Lorry Wanwillow"] = 2235; nameSort["Lorthuun"] = 2236; nameSort["Lorwyn Giant"] = 2237; nameSort["Losser Mirklav"] = 2238; nameSort["Lost Sorrowsworn"] = 2239; nameSort["Lothar"] = 2240; nameSort["Loup Garou"] = 2241; 
nameSort["Lowarnizel"] = 2242; nameSort["Ludmilla Vilisevic"] = 2243; nameSort["Lulu"] = 2244; nameSort["Lumalia"] = 2245; nameSort["Lunar Dragon Wyrmling"] = 2246; nameSort["Lungtian"] = 2247; nameSort["Luvash"] = 2248; nameSort["Lu Zhong Yin"] = 2249; nameSort["Lycanthropickle"] = 2250; nameSort["Lynx Creatlach"] = 2251; nameSort["Lyra"] = 2252; nameSort["Lyrandar Scion"] = 2253; nameSort["Lysan"] = 2254; nameSort["Lyzandra Lyzzie Calderos"] = 2255; nameSort["Macaw"] = 2256; nameSort["Maccath the Crimson"] = 2257; nameSort["Madam Eva"] = 2258; nameSort["Madam Kulp"] = 2259; nameSort["Maddgoth's Homunculus"] = 2260; nameSort["Mad Golem"] = 2261; 
nameSort["Mad Maggie"] = 2262; nameSort["Mad Mary"] = 2263; nameSort["Maegera the Dawn Titan"] = 2264; nameSort["Maegla Tarnlar"] = 2265; nameSort["Maelephant"] = 2266; nameSort["Maelephant Nomad"] = 2267; nameSort["Mage"] = 2268; nameSort["Mage 2025"] = 2269; nameSort["Mage Apprentice 2025"] = 2270; nameSort["Mage Hunter"] = 2271; nameSort["Mage of Usamigaras"] = 2272; nameSort["Magewright"] = 2273; nameSort["Maggie Keeneyes (Tier 1)"] = 2274; nameSort["Maggie Keeneyes (Tier 2)"] = 2275; nameSort["Maggie Keeneyes (Tier 3)"] = 2276; nameSort["Magister Umbero Zastro"] = 2277; nameSort["Magma Mephit"] = 2278; nameSort["Magma Mephit 2025"] = 2279; nameSort["Magmin"] = 2280; nameSort["Magmin 2025"] = 2281; 
nameSort["Magnifico"] = 2282; nameSort["Mahadi the Rakshasa"] = 2283; nameSort["Majesto"] = 2284; nameSort["Malaina van Talstiv"] = 2285; nameSort["Malaxxix"] = 2286; nameSort["Male Steeder"] = 2287; nameSort["Malformed Kraken"] = 2288; nameSort["Malinia"] = 2289; nameSort["Malivar"] = 2290; nameSort["Mammon"] = 2291; nameSort["Mammoth"] = 2292; nameSort["Mammoth 2025"] = 2293; nameSort["Manafret Cherryport"] = 2294; nameSort["Manes"] = 2295; nameSort["Manes 2025"] = 2296; nameSort["Manes Vaporspawn 2025"] = 2297; nameSort["Manshoon"] = 2298; nameSort["Manshoon Simulacrum"] = 2299; nameSort["Manticore"] = 2300; nameSort["Manticore 2025"] = 2301; 
nameSort["Manticore, Heart-Piercer"] = 2302; nameSort["Mantrap"] = 2303; nameSort["Marfulb"] = 2304; nameSort["Marid"] = 2305; nameSort["Marid 2025"] = 2306; nameSort["Marilith"] = 2307; nameSort["Marilith 2025"] = 2308; nameSort["Marisa"] = 2309; nameSort["Markham Southwell"] = 2310; nameSort["Markos Delphi"] = 2311; nameSort["Marlos Urnrayle"] = 2312; nameSort["Marta Moonshadow"] = 2313; nameSort["Martial Arts Adept"] = 2314; nameSort["Marut"] = 2315; nameSort["Mary Greymalkin"] = 2316; nameSort["Marzena Belview"] = 2317; nameSort["Maschin-i-Bozorg"] = 2318; nameSort["Master of Cruelties"] = 2319; nameSort["Master of Souls"] = 2320; nameSort["Master Refrum"] = 2321; 
nameSort["Master Sage"] = 2322; nameSort["Master Thief"] = 2323; nameSort["Mastiff"] = 2324; nameSort["Mastiff 2025"] = 2325; nameSort["Mattrim Threestrings Mereg"] = 2326; nameSort["Maude"] = 2327; nameSort["Maurezhi"] = 2328; nameSort["Maw Demon"] = 2329; nameSort["Maw of Sekolah"] = 2330; nameSort["Maw of Yeenoghu"] = 2331; nameSort["Maxeene"] = 2332; nameSort["Meazel"] = 2333; nameSort["Mechachimera"] = 2334; nameSort["Mechanical Bird"] = 2335; nameSort["Medani Inquisitive"] = 2336; nameSort["Medusa"] = 2337; nameSort["Medusa 2025"] = 2338; nameSort["Meenlock"] = 2339; nameSort["Meera Raheer"] = 2340; nameSort["Meeseeks"] = 2341; 
nameSort["Megapede"] = 2342; nameSort["Melannor Fellbranch"] = 2343; nameSort["Meletian Hoplite"] = 2344; nameSort["Melissara Shadowdusk"] = 2345; nameSort["Meloon Wardragon"] = 2346; nameSort["Memory Web"] = 2347; nameSort["Mend-nets"] = 2348; nameSort["Mennek Ariz"] = 2349; nameSort["Mephistopheles"] = 2350; nameSort["Mercane"] = 2351; nameSort["Mercenary Envoy"] = 2352; nameSort["Mercion"] = 2353; nameSort["Mercykiller Bloodhound"] = 2354; nameSort["Merfolk"] = 2355; nameSort["Merfolk Salvager"] = 2356; nameSort["Merfolk Scout"] = 2357; nameSort["Merfolk Skirmisher 2025"] = 2358; nameSort["Merfolk Wavebender 2025"] = 2359; nameSort["Meri"] = 2360; nameSort["Merregon"] = 2361; 
nameSort["Merrenoloth"] = 2362; nameSort["Merrow"] = 2363; nameSort["Merrow 2025"] = 2364; nameSort["Merrow Doublespeaker"] = 2365; nameSort["Merrow Extortionist"] = 2366; nameSort["Merrow Haranguer"] = 2367; nameSort["Merrow Shallowpriest"] = 2368; nameSort["Metallic Peacekeeper"] = 2369; nameSort["Metallic Warbler"] = 2370; nameSort["Metal Wasp"] = 2371; nameSort["Mev Flintknapper"] = 2372; nameSort["Mezzoloth"] = 2373; nameSort["Mezzoloth 2025"] = 2374; nameSort["Miasmorne"] = 2375; nameSort["Mighty Servant of Leuk-o"] = 2376; nameSort["Miirym"] = 2377; nameSort["Milivoj"] = 2378; nameSort["Mimic"] = 2379; nameSort["Mimic 2025"] = 2380; nameSort["Mimic Chair"] = 2381; 
nameSort["Mind Drinker Vampire"] = 2382; nameSort["Mind Flayer"] = 2383; nameSort["Mind Flayer 2025"] = 2384; nameSort["Mind Flayer Arcanist"] = 2385; nameSort["Mind Flayer Arcanist 2025"] = 2386; nameSort["Mind Flayer Clairvoyant"] = 2387; nameSort["Mind Flayer Nothic"] = 2388; nameSort["Mind Flayer Prophet"] = 2389; nameSort["Mind Flayer Psion"] = 2390; nameSort["Mind Mage"] = 2391; nameSort["Mind's Eye Matter Smith"] = 2392; nameSort["Mindwitness"] = 2393; nameSort["Minotaur"] = 2394; nameSort["Minotaur Archaeologist"] = 2395; nameSort["Minotaur Infiltrator"] = 2396; nameSort["Minotaur Living Crystal Statue"] = 2397; nameSort["Minotaur of Baphomet 2025"] = 2398; nameSort["Minotaur Skeleton"] = 2399; nameSort["Minotaur Skeleton 2025"] = 2400; nameSort["Minsc and Boo!"] = 2401; 
nameSort["Miraj Vizann"] = 2402; nameSort["Miros Xelbrin"] = 2403; nameSort["Mirran"] = 2404; nameSort["Mirror Shade"] = 2405; nameSort["Mirt"] = 2406; nameSort["Mishka Belview"] = 2407; nameSort["Miska the Wolf-Spider"] = 2408; nameSort["Mister Light"] = 2409; nameSort["Mister Threadneedle"] = 2410; nameSort["Mister Witch"] = 2411; nameSort["Mist Hulk"] = 2412; nameSort["Mite"] = 2413; nameSort["Mjenir"] = 2414; nameSort["Mobar"] = 2415; nameSort["Modron Duodrone 2025"] = 2416; nameSort["Modron Monodrone 2025"] = 2417; nameSort["Modron Pentadrone 2025"] = 2418; nameSort["Modron Planar Incarnate"] = 2419; nameSort["Modron Quadrone 2025"] = 2420; nameSort["Modron Tridrone 2025"] = 2421; 
nameSort["Moghadam"] = 2422; nameSort["Molliver"] = 2423; nameSort["Moloch"] = 2424; nameSort["Molten Magma Roper"] = 2425; nameSort["Molydeus"] = 2426; nameSort["Monastery of the Distressed Body Grand Master"] = 2427; nameSort["Monastery of the Distressed Body Monk"] = 2428; nameSort["Monastic High Curator"] = 2429; nameSort["Monastic Infiltrator"] = 2430; nameSort["Monastic Operative"] = 2431; nameSort["Mongrelfolk"] = 2432; nameSort["Monodrone"] = 2433; nameSort["Monstrous Peryton"] = 2434; nameSort["Montaron and the Laughing Skull"] = 2435; nameSort["Moonlight Guardian"] = 2436; nameSort["Moonshark"] = 2437; nameSort["Moonstone Dragon Wyrmling"] = 2438; nameSort["Moorbounder"] = 2439; nameSort["Morak Ur'gray"] = 2440; nameSort["Mordakhesh"] = 2441; 
nameSort["Môrgæn"] = 2442; nameSort["Morgantha"] = 2443; nameSort["Morkoth"] = 2444; nameSort["Mormesk the Wraith"] = 2445; nameSort["Morte"] = 2446; nameSort["Mortlock Vanthampur"] = 2447; nameSort["Morwena Veilmist"] = 2448; nameSort["Mossback Steward"] = 2449; nameSort["Mountain Goat"] = 2450; nameSort["Mouth of Grolantor"] = 2451; nameSort["Mr. Dory"] = 2452; nameSort["Mr. Greystone"] = 2453; nameSort["Mr. Honeycutt"] = 2454; nameSort["Mud Hulk"] = 2455; nameSort["Mud Mephit"] = 2456; nameSort["Mud Mephit 2025"] = 2457; nameSort["Muiral"] = 2458; nameSort["Mule"] = 2459; nameSort["Mule 2025"] = 2460; nameSort["Mummy"] = 2461; 
nameSort["Mummy 2025"] = 2462; nameSort["Mummy Lord"] = 2463; nameSort["Mummy Lord 2025"] = 2464; nameSort["Murder Comet"] = 2465; nameSort["Murgaxor"] = 2466; nameSort["Musharib"] = 2467; nameSort["Musteval Guardinal"] = 2468; nameSort["Mwaxanaré"] = 2469; nameSort["Myconid Adult"] = 2470; nameSort["Myconid Adult 2025"] = 2471; nameSort["Myconid Sovereign"] = 2472; nameSort["Myconid Sovereign 2025"] = 2473; nameSort["Myconid Spore Servant 2025"] = 2474; nameSort["Myconid Sprout"] = 2475; nameSort["Myconid Sprout 2025"] = 2476; nameSort["Myla"] = 2477; nameSort["Myx Nargis Ruba"] = 2478; nameSort["Na"] = 2479; nameSort["Nabassu"] = 2480; nameSort["Naergoth Bladelord"] = 2481; 
nameSort["Naes Inuus"] = 2482; nameSort["Naevys Tharesso"] = 2483; nameSort["Nafas"] = 2484; nameSort["Nafik"] = 2485; nameSort["Nagpa"] = 2486; nameSort["Nahual"] = 2487; nameSort["Naiad"] = 2488; nameSort["Nalfeshnee"] = 2489; nameSort["Nalfeshnee 2025"] = 2490; nameSort["Nanny Pu'pu"] = 2491; nameSort["Narbeck Horn"] = 2492; nameSort["Nar'l Xibrindas"] = 2493; nameSort["Narrak"] = 2494; nameSort["Narth Tezrin"] = 2495; nameSort["Narthus"] = 2496; nameSort["Narzugon"] = 2497; nameSort["Nass Lantomir's Ghost"] = 2498; nameSort["Nat"] = 2499; nameSort["Nauk"] = 2500; nameSort["Navid"] = 2501; 
nameSort["Naxa"] = 2502; nameSort["Naxene Drathkala"] = 2503; nameSort["Necrichor"] = 2504; nameSort["Necro-Alchemist"] = 2505; nameSort["Necromancer"] = 2506; nameSort["Necromancer Wizard"] = 2507; nameSort["Necromite of Myrkul"] = 2508; nameSort["Necrotic Centipede"] = 2509; nameSort["Nedylene"] = 2510; nameSort["Needle Blight"] = 2511; nameSort["Needle Blight 2025"] = 2512; nameSort["Needle Lord"] = 2513; nameSort["Needle Spawn"] = 2514; nameSort["Neh-thalggu"] = 2515; nameSort["Nellik"] = 2516; nameSort["Nene"] = 2517; nameSort["Neogi"] = 2518; nameSort["Neogi Hatchling"] = 2519; nameSort["Neogi Hatchling Swarm"] = 2520; nameSort["Neogi Master"] = 2521; 
nameSort["Neogi Pirate"] = 2522; nameSort["Neogi Void Hunter"] = 2523; nameSort["Neo-Otyugh"] = 2524; nameSort["Neothelid"] = 2525; nameSort["Nepartak"] = 2526; nameSort["Nereid"] = 2527; nameSort["Nergaliid"] = 2528; nameSort["Neronvain"] = 2529; nameSort["Nerozar the Defeated"] = 2530; nameSort["Nester"] = 2531; nameSort["Nevermind Gnome Inventor"] = 2532; nameSort["Nevermind Gnome Mastermind"] = 2533; nameSort["Nezznar the Black Spider"] = 2534; nameSort["Nezznar the Spider"] = 2535; nameSort["Night Blade"] = 2536; nameSort["Night Hag"] = 2537; nameSort["Night Hag 2025"] = 2538; nameSort["Nightmare"] = 2539; nameSort["Nightmare 2025"] = 2540; nameSort["Nightmare Beast"] = 2541; 
nameSort["Nightmare Haunt"] = 2542; nameSort["Nightmare Shepherd"] = 2543; nameSort["Night Scavver"] = 2544; nameSort["Nightsea Chil-liren"] = 2545; nameSort["Nightveil Specter"] = 2546; nameSort["Nightwalker"] = 2547; nameSort["Nihiloor"] = 2548; nameSort["Nikolai Wachter"] = 2549; nameSort["Nilbog"] = 2550; nameSort["Niles Breakbone"] = 2551; nameSort["Nimblewright"] = 2552; nameSort["Nimblewright Guard"] = 2553; nameSort["Nimblewright Hulk"] = 2554; nameSort["Nimblewright Steed"] = 2555; nameSort["Nimir"] = 2556; nameSort["Nimira"] = 2557; nameSort["Nimuel"] = 2558; nameSort["Nine-Fingers Keene"] = 2559; nameSort["Nintra Siotta"] = 2560; nameSort["Nivix Cyclops"] = 2561; 
nameSort["Niv-Mizzet"] = 2562; nameSort["Nixylanna Vidorant"] = 2563; nameSort["Noble"] = 2564; nameSort["Noble 2025"] = 2565; nameSort["Noble Prodigy 2025"] = 2566; nameSort["Noggle Ransacker"] = 2567; nameSort["Noggle Wild Mage"] = 2568; nameSort["Nonaton Modron"] = 2569; nameSort["Noori"] = 2570; nameSort["Norker"] = 2571; nameSort["Norker War Leader"] = 2572; nameSort["Nosferatu"] = 2573; nameSort["Noska Ur'gray"] = 2574; nameSort["Nothic"] = 2575; nameSort["Nothic 2025"] = 2576; nameSort["Nundro Rockseeker"] = 2577; nameSort["Nupperibo"] = 2578; nameSort["Nurvureem, The Dark Lady"] = 2579; nameSort["Nycaloth"] = 2580; nameSort["Nycaloth 2025"] = 2581; 
nameSort["Nym"] = 2582; nameSort["Nyssa Otellion"] = 2583; nameSort["Nythalyn Henlifel"] = 2584; nameSort["Nyx-Fleece Ram"] = 2585; nameSort["Oaken Bolter"] = 2586; nameSort["Oak Truestrike"] = 2587; nameSort["Obaya Uday"] = 2588; nameSort["Oblex Spawn"] = 2589; nameSort["Obliteros"] = 2590; nameSort["Obmi"] = 2591; nameSort["Obzedat Ghost"] = 2592; nameSort["Occult Extollant"] = 2593; nameSort["Occult Initiate"] = 2594; nameSort["Occult Silvertongue"] = 2595; nameSort["Oceanus"] = 2596; nameSort["Ochre Jelly"] = 2597; nameSort["Ochre Jelly 2025"] = 2598; nameSort["Octon Modron"] = 2599; nameSort["Octopus"] = 2600; nameSort["Octopus 2025"] = 2601; 
nameSort["Oculorb"] = 2602; nameSort["Oddlewin"] = 2603; nameSort["Ogre"] = 2604; nameSort["Ogre 2025"] = 2605; nameSort["Ogre Battering Ram"] = 2606; nameSort["Ogre Bolt Launcher"] = 2607; nameSort["Ogre Chain Brute"] = 2608; nameSort["Ogre Channeler"] = 2609; nameSort["Ogre Chitterlord"] = 2610; nameSort["Ogre Goblin Hucker"] = 2611; nameSort["Ogre Howdah"] = 2612; nameSort["Ogre Lord Buhfal II"] = 2613; nameSort["Ogrémoch"] = 2614; nameSort["Ogre Skeleton"] = 2615; nameSort["Ogre Zombie"] = 2616; nameSort["Ogre Zombie 2025"] = 2617; nameSort["Ogrillon Ogre 2025"] = 2618; nameSort["Oinoloth"] = 2619; nameSort["Olara"] = 2620; nameSort["Old Croaker"] = 2621; 
nameSort["Old Troglodyte"] = 2622; nameSort["Olhydra"] = 2623; nameSort["Ollin"] = 2624; nameSort["Omin Dran"] = 2625; nameSort["One-Eyed Shiver"] = 2626; nameSort["Oneirovore"] = 2627; nameSort["Oni"] = 2628; nameSort["Oni 2025"] = 2629; nameSort["Ontharr Frume"] = 2630; nameSort["Ontharyx"] = 2631; nameSort["Onyx"] = 2632; nameSort["Ooze-Folk"] = 2633; nameSort["Ooze Master"] = 2634; nameSort["Ophelia"] = 2635; nameSort["Oracle"] = 2636; nameSort["Oracle of Strixhaven"] = 2637; nameSort["Oracs the Enduring"] = 2638; nameSort["Orc"] = 2639; nameSort["Orc Blade of Ilneval"] = 2640; nameSort["Orc Claw of Luthic"] = 2641; 
nameSort["Orc Commoner"] = 2642; nameSort["Orc Eye of Gruumsh"] = 2643; nameSort["Orc Hand of Yurtrus"] = 2644; nameSort["Orc Nurtured One of Yurtrus"] = 2645; nameSort["Orc Red Fang of Shargaas"] = 2646; nameSort["Orcus"] = 2647; nameSort["Orc War Chief"] = 2648; nameSort["Oread"] = 2649; nameSort["Oreioth"] = 2650; nameSort["Oren Yogilvy"] = 2651; nameSort["Orien Enforcer"] = 2652; nameSort["Orinix"] = 2653; nameSort["Oriq Blood Mage"] = 2654; nameSort["Oriq Recruiter"] = 2655; nameSort["Orlando"] = 2656; nameSort["Orlekto"] = 2657; nameSort["Orog"] = 2658; nameSort["Orok"] = 2659; nameSort["Orond Gralhund"] = 2660; nameSort["Orthon"] = 2661; 
nameSort["Ortimay Swift and Dark"] = 2662; nameSort["Orvex Ocrammas"] = 2663; nameSort["Orzhov Giant"] = 2664; nameSort["Oshundo the Alhoon"] = 2665; nameSort["Osvaldo Cassalanter"] = 2666; nameSort["Otherworldly Corrupter"] = 2667; nameSort["Otherworldly Steed"] = 2668; nameSort["Othokent"] = 2669; nameSort["Othovir"] = 2670; nameSort["Otto"] = 2671; nameSort["Otto Belview"] = 2672; nameSort["Ott Steeltoes"] = 2673; nameSort["Otyugh"] = 2674; nameSort["Otyugh 2025"] = 2675; nameSort["Otyugh Mutate"] = 2676; nameSort["Ougalop"] = 2677; nameSort["Oussa"] = 2678; nameSort["Owl"] = 2679; nameSort["Owl 2025"] = 2680; nameSort["Owlbear"] = 2681; 
nameSort["Owlbear 2025"] = 2682; nameSort["Ox"] = 2683; nameSort["Oxen"] = 2684; nameSort["Padraich"] = 2685; nameSort["Pain Devil (Excruciarch)"] = 2686; nameSort["Paloma"] = 2687; nameSort["Panopticus Wizard"] = 2688; nameSort["Panther"] = 2689; nameSort["Panther 2025"] = 2690; nameSort["Paolo Maykapal"] = 2691; nameSort["Paper Bird"] = 2692; nameSort["Paper Whirlwind"] = 2693; nameSort["Parasite-infested Behir"] = 2694; nameSort["Pari"] = 2695; nameSort["Parriwimple"] = 2696; nameSort["Parrot"] = 2697; nameSort["Parson Pellinost"] = 2698; nameSort["Parvaz"] = 2699; nameSort["Patrina Velikovna"] = 2700; nameSort["Pazrodine"] = 2701; 
nameSort["Pazuzu"] = 2702; nameSort["Peacock"] = 2703; nameSort["Pech"] = 2704; nameSort["Peebles"] = 2705; nameSort["Pegasus"] = 2706; nameSort["Pegasus 2025"] = 2707; nameSort["Pelyious Avhoste"] = 2708; nameSort["Pendragon Beestinger"] = 2709; nameSort["Pentadrone"] = 2710; nameSort["Performer 2025"] = 2711; nameSort["Performer Legend 2025"] = 2712; nameSort["Performer Maestro 2025"] = 2713; nameSort["Perigee"] = 2714; nameSort["Peryton"] = 2715; nameSort["Peryton 2025"] = 2716; nameSort["Pestilence Demon"] = 2717; nameSort["Pest Mascot"] = 2718; nameSort["Phaerimm"] = 2719; nameSort["Phaerimm Agent"] = 2720; nameSort["Phaerimm Elder"] = 2721; 
nameSort["Phaerimm Hatchling"] = 2722; nameSort["Phaerimm Scout"] = 2723; nameSort["Phaia"] = 2724; nameSort["Phantom Warrior"] = 2725; nameSort["Phantom Warrior (Archer)"] = 2726; nameSort["Pharblex Spattergoo"] = 2727; nameSort["Phase Spider"] = 2728; nameSort["Phase Spider 2025"] = 2729; nameSort["Phisarazu Spyder-Fiend"] = 2730; nameSort["Phoenix"] = 2731; nameSort["Phoenix Anvil"] = 2732; nameSort["Phylaskia"] = 2733; nameSort["Piccolo"] = 2734; nameSort["Pidlwick II"] = 2735; nameSort["Piercer"] = 2736; nameSort["Piercer 2025"] = 2737; nameSort["Pig"] = 2738; nameSort["Piggy Wiggle Butt"] = 2739; nameSort["Piranha"] = 2740; nameSort["Piranha 2025"] = 2741; 
nameSort["Pirate 2025"] = 2742; nameSort["Pirate Admiral 2025"] = 2743; nameSort["Pirate Bosun"] = 2744; nameSort["Pirate Captain"] = 2745; nameSort["Pirate Captain 2025"] = 2746; nameSort["Pirate Deck Wizard"] = 2747; nameSort["Pirate First Mate"] = 2748; nameSort["Pit Fiend"] = 2749; nameSort["Pit Fiend 2025"] = 2750; nameSort["Pixie"] = 2751; nameSort["Pixie 2025"] = 2752; nameSort["Pixie Wonderbringer 2025"] = 2753; nameSort["Piyarz"] = 2754; nameSort["Planar Incarnate"] = 2755; nameSort["Planetar"] = 2756; nameSort["Planetar 2025"] = 2757; nameSort["Plasmoid Boss"] = 2758; nameSort["Plasmoid Explorer"] = 2759; nameSort["Plasmoid Warrior"] = 2760; nameSort["Play-by-Play Generator"] = 2761; 
nameSort["Plesiosaurus"] = 2762; nameSort["Plesiosaurus 2025"] = 2763; nameSort["Podling"] = 2764; nameSort["Poisonous Snake"] = 2765; nameSort["Poison Weird"] = 2766; nameSort["Polar Bear"] = 2767; nameSort["Polar Bear 2025"] = 2768; nameSort["Polar Serpent"] = 2769; nameSort["Pollenella the Honeybee"] = 2770; nameSort["Poltergeist"] = 2771; nameSort["Poltergeist 2025"] = 2772; nameSort["Polukranos"] = 2773; nameSort["Pony"] = 2774; nameSort["Pony 2025"] = 2775; nameSort["Porro"] = 2776; nameSort["Portentia Dran"] = 2777; nameSort["Portia Dzuth"] = 2778; nameSort["Pow Ming"] = 2779; nameSort["Pral"] = 2780; nameSort["Precognitive Mage"] = 2781; 
nameSort["Preeta Kreepa"] = 2782; nameSort["Priest"] = 2783; nameSort["Priest 2025"] = 2784; nameSort["Priest Acolyte 2025"] = 2785; nameSort["Priest of Osybus"] = 2786; nameSort["Primeval Owlbear 2025"] = 2787; nameSort["Prince Derendil"] = 2788; nameSort["Prince Kirina"] = 2789; nameSort["Princeps Kovik"] = 2790; nameSort["Prince Simbon"] = 2791; nameSort["Princess Ebonmire"] = 2792; nameSort["Princess Serissa"] = 2793; nameSort["Princess Xedalli"] = 2794; nameSort["Prince Xeleth"] = 2795; nameSort["Prismari Apprentice"] = 2796; nameSort["Prismari Pledgemage"] = 2797; nameSort["Prismari Professor of Expression"] = 2798; nameSort["Prismari Professor of Perfection"] = 2799; nameSort["Prisoner 13"] = 2800; nameSort["Prisoner 237"] = 2801; 
nameSort["Prolix Yusaf"] = 2802; nameSort["Prophetess Dran"] = 2803; nameSort["Pseudodragon"] = 2804; nameSort["Pseudodragon 2025"] = 2805; nameSort["Psionic Ashenwight"] = 2806; nameSort["Psionic Shambling Mound"] = 2807; nameSort["Psurlon"] = 2808; nameSort["Psurlon Leader"] = 2809; nameSort["Psurlon Ringer"] = 2810; nameSort["Psychic Gray Ooze 2025"] = 2811; nameSort["Pterafolk"] = 2812; nameSort["Pteranodon"] = 2813; nameSort["Pteranodon 2025"] = 2814; nameSort["Puppeteer Parasite"] = 2815; nameSort["Purple Worm"] = 2816; nameSort["Purple Worm 2025"] = 2817; nameSort["Purple Wormling"] = 2818; nameSort["Qawasha"] = 2819; nameSort["Quadrone"] = 2820; nameSort["Quadrone Detention Drone"] = 2821; 
nameSort["Quaggoth"] = 2822; nameSort["Quaggoth 2025"] = 2823; nameSort["Quaggoth Spore Servant"] = 2824; nameSort["Quaggoth Thonot"] = 2825; nameSort["Quaggoth Thonot 2025"] = 2826; nameSort["Quandrix Apprentice"] = 2827; nameSort["Quandrix Pledgemage"] = 2828; nameSort["Quandrix Professor of Substance"] = 2829; nameSort["Quandrix Professor of Theory"] = 2830; nameSort["Quasit"] = 2831; nameSort["Quasit 2025"] = 2832; nameSort["Quavilithku Spyder-Fiend"] = 2833; nameSort["Queen Forfallen"] = 2834; nameSort["Queen Zanobis"] = 2835; nameSort["Quenthel Baenre"] = 2836; nameSort["Questing Knight 2025"] = 2837; nameSort["Quetzalcoatlus"] = 2838; nameSort["Quickling"] = 2839; nameSort["Quipper"] = 2840; nameSort["Qunbraxel"] = 2841; 
nameSort["R04M"] = 2842; nameSort["Rabbithead"] = 2843; nameSort["Rack"] = 2844; nameSort["Radiant Idol"] = 2845; nameSort["Raegrin Mau"] = 2846; nameSort["Raezil"] = 2847; nameSort["Raggadragga"] = 2848; nameSort["Raggnar Redtooth"] = 2849; nameSort["Rahadin"] = 2850; nameSort["Rain"] = 2851; nameSort["Rakdos"] = 2852; nameSort["Rakdos Lampooner"] = 2853; nameSort["Rakdos Performer, Blade Juggler"] = 2854; nameSort["Rakdos Performer, Fire Eater"] = 2855; nameSort["Rakdos Performer, High-Wire Acrobat"] = 2856; nameSort["Raklupis Spyder-Fiend"] = 2857; nameSort["Rakshasa"] = 2858; nameSort["Rakshasa 2025"] = 2859; nameSort["Rak Tulkhesh"] = 2860; nameSort["Ramius"] = 2861; 
nameSort["Ram Sugar"] = 2862; nameSort["Ras Nsi"] = 2863; nameSort["Rat"] = 2864; nameSort["Rat 2025"] = 2865; nameSort["Rath Modar"] = 2866; nameSort["Raven"] = 2867; nameSort["Raven 2025"] = 2868; nameSort["Raven Uth Vogler"] = 2869; nameSort["Razerblast"] = 2870; nameSort["Razorvine Blight"] = 2871; nameSort["Reaper of Bhaal"] = 2872; nameSort["Reaper Spirit"] = 2873; nameSort["Reckoner"] = 2874; nameSort["Red Abishai"] = 2875; nameSort["Redbrand Ruffian"] = 2876; nameSort["Redbud"] = 2877; nameSort["Redcap"] = 2878; nameSort["Red Dragon Wyrmling"] = 2879; nameSort["Red Dragon Wyrmling 2025"] = 2880; nameSort["Red Greatwyrm"] = 2881; 
nameSort["Red Guard Drake"] = 2882; nameSort["Red Ruin"] = 2883; nameSort["Red Slaad"] = 2884; nameSort["Red Slaad 2025"] = 2885; nameSort["Redtooth Werefox"] = 2886; nameSort["Reduced-Threat Aboleth"] = 2887; nameSort["Reduced-Threat Basilisk"] = 2888; nameSort["Reduced-Threat Behir"] = 2889; nameSort["Reduced-Threat Beholder"] = 2890; nameSort["Reduced-Threat Black Pudding"] = 2891; nameSort["Reduced-Threat Carrion Crawler"] = 2892; nameSort["Reduced-Threat Clay Golem"] = 2893; nameSort["Reduced-Threat Darkmantle"] = 2894; nameSort["Reduced-Threat Displacer Beast"] = 2895; nameSort["Reduced-Threat Dragon Turtle"] = 2896; nameSort["Reduced-Threat Ettercap"] = 2897; nameSort["Reduced-Threat Flesh Golem"] = 2898; nameSort["Reduced-Threat Glabrezu"] = 2899; nameSort["Reduced-Threat Gray Ooze"] = 2900; nameSort["Reduced-Threat Helmed Horror"] = 2901; 
nameSort["Reduced-Threat Hezrou"] = 2902; nameSort["Reduced-Threat Hook Horror"] = 2903; nameSort["Reduced-Threat Ochre Jelly"] = 2904; nameSort["Reduced-Threat Otyugh"] = 2905; nameSort["Reduced-Threat Owlbear"] = 2906; nameSort["Reduced-Threat Peryton"] = 2907; nameSort["Reduced-Threat Remorhaz"] = 2908; nameSort["Reduced-Threat Stone Golem"] = 2909; nameSort["Reduced-Threat Vrock"] = 2910; nameSort["Reduced-Threat Wight"] = 2911; nameSort["Reduced-Threat Wyvern"] = 2912; nameSort["Red Wizard"] = 2913; nameSort["Reef Shark"] = 2914; nameSort["Reef Shark 2025"] = 2915; nameSort["Reflection"] = 2916; nameSort["Refraction of Ilvaash"] = 2917; nameSort["Regenerating Black Pudding"] = 2918; nameSort["Reghed Chieftain"] = 2919; nameSort["Reghed Great Warrior"] = 2920; nameSort["Reghed Shaman"] = 2921; 
nameSort["Reghed Warrior"] = 2922; nameSort["Regisaur"] = 2923; nameSort["Regular Orthoclath"] = 2924; nameSort["Reigar"] = 2925; nameSort["Reindeer"] = 2926; nameSort["Relentless Impaler"] = 2927; nameSort["Relentless Juggernaut"] = 2928; nameSort["Relentless Slasher"] = 2929; nameSort["Relic Sloth"] = 2930; nameSort["Remallia Haventree"] = 2931; nameSort["Remorhaz"] = 2932; nameSort["Remorhaz 2025"] = 2933; nameSort["Renaer Neverember"] = 2934; nameSort["Renwick"] = 2935; nameSort["Replica Duodrone"] = 2936; nameSort["Replica Monodrone"] = 2937; nameSort["Replica Pentadrone"] = 2938; nameSort["Replica Quadrone"] = 2939; nameSort["Replica Tridrone"] = 2940; nameSort["Rerak"] = 2941; 
nameSort["Retriever"] = 2942; nameSort["Returned Drifter"] = 2943; nameSort["Returned Kakomantis"] = 2944; nameSort["Returned Palamnite"] = 2945; nameSort["Returned Sentry"] = 2946; nameSort["Revenant"] = 2947; nameSort["Revenant 2025"] = 2948; nameSort["Rezmir"] = 2949; nameSort["Rezran Snake Eyes Agrodro"] = 2950; nameSort["Rhinoceros"] = 2951; nameSort["Rhinoceros 2025"] = 2952; nameSort["Rhundorth"] = 2953; nameSort["Rictavio"] = 2954; nameSort["Riding Horse"] = 2955; nameSort["Riding Horse 2025"] = 2956; nameSort["Riffel"] = 2957; nameSort["Riffler"] = 2958; nameSort["Rihuud"] = 2959; nameSort["Rilago"] = 2960; nameSort["Rilly June"] = 2961; 
nameSort["Rilsa Rael"] = 2962; nameSort["Rime Hulk"] = 2963; nameSort["Rimmon"] = 2964; nameSort["Ringlerun"] = 2965; nameSort["Rip Tide Priest"] = 2966; nameSort["Rishaal the Page-Turner"] = 2967; nameSort["Riverine"] = 2968; nameSort["River Mist"] = 2969; nameSort["River Serpent"] = 2970; nameSort["Rivibiddel"] = 2971; nameSort["Roc"] = 2972; nameSort["Roc 2025"] = 2973; nameSort["Rock Gnome Recluse"] = 2974; nameSort["Ront"] = 2975; nameSort["Rool"] = 2976; nameSort["Rooster"] = 2977; nameSort["Roper"] = 2978; nameSort["Roper 2025"] = 2979; nameSort["Rosavalda Rose Durst"] = 2980; nameSort["Rosie Beestinger"] = 2981; 
nameSort["Rothé"] = 2982; nameSort["Rotter"] = 2983; nameSort["Rot Troll"] = 2984; nameSort["Rowboat Mimic"] = 2985; nameSort["Rubblebelt Stalker"] = 2986; nameSort["Rug of Smothering"] = 2987; nameSort["Ruidium Elephant"] = 2988; nameSort["Ruin Grinder"] = 2989; nameSort["Ruin Spider"] = 2990; nameSort["Rumpadump"] = 2991; nameSort["Runara"] = 2992; nameSort["Runed Behir"] = 2993; nameSort["Runic Colossus"] = 2994; nameSort["Rusted Behemoth"] = 2995; nameSort["Rusted Berserker"] = 2996; nameSort["Rusted Wyrm"] = 2997; nameSort["Rust Monster"] = 2998; nameSort["Rust Monster 2025"] = 2999; nameSort["Rutterkin"] = 3000; nameSort["Ruxithid the Chosen"] = 3001; 
nameSort["Rystia Zav"] = 3002; nameSort["Saber-Toothed Tiger"] = 3003; nameSort["Sabrina Kilgore (Levels 1-4)"] = 3004; nameSort["Sabrina Kilgore (Levels 5-8)"] = 3005; nameSort["Sabrina Kilgore (Levels 9-11)"] = 3006; nameSort["Sacred Statue"] = 3007; nameSort["Sacred Stone Monk"] = 3008; nameSort["Saemon Havarian"] = 3009; nameSort["Saeth Cromley"] = 3010; nameSort["Sage"] = 3011; nameSort["Sahuagin"] = 3012; nameSort["Sahuagin Baron"] = 3013; nameSort["Sahuagin Baron 2025"] = 3014; nameSort["Sahuagin Blademaster"] = 3015; nameSort["Sahuagin Champion"] = 3016; nameSort["Sahuagin Coral Smasher"] = 3017; nameSort["Sahuagin Deep Diver"] = 3018; nameSort["Sahuagin Hatchling Swarm"] = 3019; nameSort["Sahuagin High Priestess"] = 3020; nameSort["Sahuagin Priest 2025"] = 3021; 
nameSort["Sahuagin Priestess"] = 3022; nameSort["Sahuagin Warlock of Uk'otoa"] = 3023; nameSort["Sahuagin Warrior 2025"] = 3024; nameSort["Sahuagin Wave Shaper"] = 3025; nameSort["Sailback"] = 3026; nameSort["Salamander"] = 3027; nameSort["Salamander 2025"] = 3028; nameSort["Salamander Fire Snake 2025"] = 3029; nameSort["Salamander Inferno Master 2025"] = 3030; nameSort["Saleeth the Couatl"] = 3031; nameSort["Salida"] = 3032; nameSort["Samara Strongbones"] = 3033; nameSort["Samira Arah"] = 3034; nameSort["Sammaster (Dracolich Form)"] = 3035; nameSort["Sammaster (Lich Form)"] = 3036; nameSort["Sanbalet"] = 3037; nameSort["Sandesyl Morgia"] = 3038; nameSort["Sandwurm"] = 3039; nameSort["Sangora"] = 3040; nameSort["Sangzor"] = 3041; 
nameSort["Sapphire Dragon Wyrmling"] = 3042; nameSort["Sapphire Greatwyrm"] = 3043; nameSort["Sapphire Sentinel"] = 3044; nameSort["Sarcelle Malinosh"] = 3045; nameSort["Sarevok"] = 3046; nameSort["Sarith Kzekarit"] = 3047; nameSort["Sarlamir"] = 3048; nameSort["Sarusanda Allester"] = 3049; nameSort["Satyr"] = 3050; nameSort["Satyr 2025"] = 3051; nameSort["Satyr Reveler"] = 3052; nameSort["Satyr Revelmaster 2025"] = 3053; nameSort["Satyr Thornbearer"] = 3054; nameSort["Sauriv"] = 3055; nameSort["Savid"] = 3056; nameSort["Scaladar"] = 3057; nameSort["Scarecrow"] = 3058; nameSort["Scarecrow 2025"] = 3059; nameSort["Scarlet Sentinel"] = 3060; nameSort["Scholarly Agent"] = 3061; 
nameSort["Scholarly Excavator"] = 3062; nameSort["Scholarly Mastermind"] = 3063; nameSort["Scion of Grolantor"] = 3064; nameSort["Scion of Memnor"] = 3065; nameSort["Scion of Skoraeus"] = 3066; nameSort["Scion of Stronmaus"] = 3067; nameSort["Scion of Surtur"] = 3068; nameSort["Scion of Thrym"] = 3069; nameSort["Scorchbringer Guard"] = 3070; nameSort["Scorpion"] = 3071; nameSort["Scorpion 2025"] = 3072; nameSort["Scout"] = 3073; nameSort["Scout 2025"] = 3074; nameSort["Scout Captain 2025"] = 3075; nameSort["Scrag"] = 3076; nameSort["Scrapper"] = 3077; nameSort["Screaming Devilkin"] = 3078; nameSort["Scribble"] = 3079; nameSort["Scufflecup Teacup"] = 3080; nameSort["Scuttling Serpentmaw"] = 3081; 
nameSort["Sea Elf"] = 3082; nameSort["Sea Elf Scout"] = 3083; nameSort["Sea Fury"] = 3084; nameSort["Sea Hag"] = 3085; nameSort["Sea Hag 2025"] = 3086; nameSort["Sea Horse"] = 3087; nameSort["Seahorse 2025"] = 3088; nameSort["Seal"] = 3089; nameSort["Sea Lion"] = 3090; nameSort["Sea Spawn"] = 3091; nameSort["Sekelok"] = 3092; nameSort["Selenelion Twin"] = 3093; nameSort["Sentient Gray Ooze"] = 3094; nameSort["Sentient Ochre Jelly"] = 3095; nameSort["Sentinel Marshal"] = 3096; nameSort["Seodra"] = 3097; nameSort["Sephek Kaltro"] = 3098; nameSort["Septon Modron"] = 3099; nameSort["Serapio"] = 3100; nameSort["Sergeant"] = 3101; 
nameSort["Serpopard"] = 3102; nameSort["Serra Angel"] = 3103; nameSort["Servitor Thrull"] = 3104; nameSort["Servo"] = 3105; nameSort["Setessan Hoplite"] = 3106; nameSort["Seth the Shapeshifting Dragon"] = 3107; nameSort["Severin"] = 3108; nameSort["Sewer King"] = 3109; nameSort["Shadar-kai Gloom Weaver"] = 3110; nameSort["Shadar-kai Shadow Dancer"] = 3111; nameSort["Shadar-kai Soul Monger"] = 3112; nameSort["Shade"] = 3113; nameSort["Shadow"] = 3114; nameSort["Shadow 2025"] = 3115; nameSort["Shadow Assassin"] = 3116; nameSort["Shadow Dancer"] = 3117; nameSort["Shadow Demon"] = 3118; nameSort["Shadow Demon 2025"] = 3119; nameSort["Shadow Dragon 2025"] = 3120; nameSort["Shadowghast"] = 3121; 
nameSort["Shadow Horror"] = 3122; nameSort["Shadow-Marked Agent"] = 3123; nameSort["Shadow Mastiff"] = 3124; nameSort["Shadow Mastiff Alpha"] = 3125; nameSort["Shadowmoor Giant"] = 3126; nameSort["Shadow Spirit"] = 3127; nameSort["Shadrix Silverquill"] = 3128; nameSort["Shago"] = 3129; nameSort["Shalai"] = 3130; nameSort["Shaldoor"] = 3131; nameSort["Shalendra Floshin"] = 3132; nameSort["Shalfey"] = 3133; nameSort["Shalfi Lewin"] = 3134; nameSort["Shalvus Martholio"] = 3135; nameSort["Shambling Mound"] = 3136; nameSort["Shambling Mound 2025"] = 3137; nameSort["Shambling Mound Totem Elemental"] = 3138; nameSort["Shanzezim"] = 3139; nameSort["Shapechanged Roper"] = 3140; nameSort["Sharda"] = 3141; 
nameSort["Shard Shunner"] = 3142; nameSort["Shariel"] = 3143; nameSort["Sharkbody Abomination"] = 3144; nameSort["Sharwyn Hucrele"] = 3145; nameSort["Shator Demodand"] = 3146; nameSort["Shator Warden"] = 3147; nameSort["Shatterskull Giant"] = 3148; nameSort["Shedrak of the Eyes"] = 3149; nameSort["Sheep"] = 3150; nameSort["Sheldon the Blueberry Dragon"] = 3151; nameSort["Shell Shark"] = 3152; nameSort["Shemeshka"] = 3153; nameSort["Shemshime"] = 3154; nameSort["Shield Dwarf Guard"] = 3155; nameSort["Shield Dwarf Noble"] = 3156; nameSort["Shield Guardian"] = 3157; nameSort["Shield Guardian 2025"] = 3158; nameSort["Shifter"] = 3159; nameSort["Shira"] = 3160; nameSort["Shoalar Quanderil"] = 3161; 
nameSort["Shoal Serpent"] = 3162; nameSort["Shockerstomper"] = 3163; nameSort["Sholeh"] = 3164; nameSort["Shoosuva"] = 3165; nameSort["Shredwing"] = 3166; nameSort["Shrieker"] = 3167; nameSort["Shrieker Fungus"] = 3168; nameSort["Shrieker Fungus 2025"] = 3169; nameSort["Shunn Shurreth"] = 3170; nameSort["Shuushar the Awakened"] = 3171; nameSort["Sibriex"] = 3172; nameSort["Sigarda"] = 3173; nameSort["Sildar Hallwinter"] = 3174; nameSort["Silver Dragon Wyrmling"] = 3175; nameSort["Silver Dragon Wyrmling 2025"] = 3176; nameSort["Silver Greatwyrm"] = 3177; nameSort["Silverlily"] = 3178; nameSort["Silverquill Apprentice"] = 3179; nameSort["Silverquill Pledgemage"] = 3180; nameSort["Silverquill Professor of Radiance"] = 3181; 
nameSort["Silverquill Professor of Shadow"] = 3182; nameSort["Simic Merfolk"] = 3183; nameSort["Simon Aumar"] = 3184; nameSort["Sinensa"] = 3185; nameSort["Sing-Along"] = 3186; nameSort["Sion"] = 3187; nameSort["Sirac of Suzail"] = 3188; nameSort["Sir Baric Nylef"] = 3189; nameSort["Sir Braford"] = 3190; nameSort["Siren"] = 3191; nameSort["Sirene"] = 3192; nameSort["Sire of Insanity"] = 3193; nameSort["Sir Godfrey Gwilym"] = 3194; nameSort["Sir Jared"] = 3195; nameSort["Sir Talavar"] = 3196; nameSort["Sir Ursas"] = 3197; nameSort["Sivak Draconian"] = 3198; nameSort["Sivis Scribe"] = 3199; nameSort["Skaab"] = 3200; nameSort["Skabatha Nightshade"] = 3201; 
nameSort["Skeemo Weirdbottle"] = 3202; nameSort["Skeletal Alchemist"] = 3203; nameSort["Skeletal Bloodfin"] = 3204; nameSort["Skeletal Giant Owl"] = 3205; nameSort["Skeletal Horror"] = 3206; nameSort["Skeletal Juggernaut"] = 3207; nameSort["Skeletal Knight"] = 3208; nameSort["Skeletal Owlbear"] = 3209; nameSort["Skeletal Polar Bear"] = 3210; nameSort["Skeletal Rats"] = 3211; nameSort["Skeletal Riding Horse"] = 3212; nameSort["Skeletal Swarm"] = 3213; nameSort["Skeletal Two-Headed Owlbear"] = 3214; nameSort["Skeleton"] = 3215; nameSort["Skeleton 2025"] = 3216; nameSort["Skeleton Key"] = 3217; nameSort["Skeleton Lord"] = 3218; nameSort["Skeleton Warrior"] = 3219; nameSort["Sken Zabriss"] = 3220; nameSort["Skittering Horror"] = 3221; 
nameSort["Skitterwidget"] = 3222; nameSort["Skr'a S'orsk"] = 3223; nameSort["Skriss"] = 3224; nameSort["Skulk"] = 3225; nameSort["Skull Flier"] = 3226; nameSort["Skull Lasher of Myrkul"] = 3227; nameSort["Skull Lord"] = 3228; nameSort["Skum"] = 3229; nameSort["Skyjek Roc"] = 3230; nameSort["Sky Leviathan"] = 3231; nameSort["Skylla"] = 3232; nameSort["Skyswimmer"] = 3233; nameSort["Skyweaver"] = 3234; nameSort["Sky Whale"] = 3235; nameSort["Slaad Tadpole"] = 3236; nameSort["Slaad Tadpole 2025"] = 3237; nameSort["Sladis Vadir"] = 3238; nameSort["Slarkrethel"] = 3239; nameSort["Slayer"] = 3240; nameSort["Sled Dog"] = 3241; 
nameSort["Slithering Bloodfin"] = 3242; nameSort["Slithering Tracker"] = 3243; nameSort["Sloopidoop"] = 3244; nameSort["Sludge Hag"] = 3245; nameSort["Slurmy"] = 3246; nameSort["Small Drake"] = 3247; nameSort["Smiler the Defiler"] = 3248; nameSort["Smoke Mephit"] = 3249; nameSort["Smoke Mephit 2025"] = 3250; nameSort["Snake Horror"] = 3251; nameSort["Snapping Hydra"] = 3252; nameSort["Snarla"] = 3253; nameSort["Sneak"] = 3254; nameSort["Snow Golem"] = 3255; nameSort["Snow Leopard"] = 3256; nameSort["Snow Maiden"] = 3257; nameSort["Snowy Owlbear"] = 3258; nameSort["Snurrevin"] = 3259; nameSort["Society of Sensation Muse"] = 3260; nameSort["Sofina"] = 3261; 
nameSort["Solar"] = 3262; nameSort["Solar 2025"] = 3263; nameSort["Solar Bastion Knight"] = 3264; nameSort["Solar Dragon Wyrmling"] = 3265; nameSort["Soldier"] = 3266; nameSort["Soluun Xibrindas"] = 3267; nameSort["Sorrowfish"] = 3268; nameSort["Soul Monger"] = 3269; nameSort["Soul Shaker"] = 3270; nameSort["Soulstinger Demon"] = 3271; nameSort["Sovereign Basidia"] = 3272; nameSort["Space Clown"] = 3273; nameSort["Space Eel"] = 3274; nameSort["Space Guppy"] = 3275; nameSort["Space Hamster"] = 3276; nameSort["Space Mollymawk"] = 3277; nameSort["Space Swine"] = 3278; nameSort["Spawn of Kyuss"] = 3279; nameSort["Speaker Devil"] = 3280; nameSort["Spectator"] = 3281; 
nameSort["Spectator 2025"] = 3282; nameSort["Specter"] = 3283; nameSort["Specter 2025"] = 3284; nameSort["Specter of Night"] = 3285; nameSort["Spectral Cloud"] = 3286; nameSort["Spellcaster"] = 3287; nameSort["Spellcaster (Healer)"] = 3288; nameSort["Spellcaster (Mage)"] = 3289; nameSort["Spellix Romwod"] = 3290; nameSort["Sperm Whale"] = 3291; nameSort["Sphinx of Judgment"] = 3292; nameSort["Sphinx of Lore 2025"] = 3293; nameSort["Sphinx of Secrets 2025"] = 3294; nameSort["Sphinx of Valor 2025"] = 3295; nameSort["Sphinx of Wonder 2025"] = 3296; nameSort["Sphinx (Type 1)"] = 3297; nameSort["Sphinx (Type 2)"] = 3298; nameSort["Spider"] = 3299; nameSort["Spider 2025"] = 3300; nameSort["Spiderbait"] = 3301; 
nameSort["Spiderdragon"] = 3302; nameSort["Spiderfrog"] = 3303; nameSort["Spider King"] = 3304; nameSort["Spiked Tomb Guardian"] = 3305; nameSort["Spined Devil"] = 3306; nameSort["Spined Devil 2025"] = 3307; nameSort["Spirit"] = 3308; nameSort["Spirit Dragon Wyrmling"] = 3309; nameSort["Spirit Naga"] = 3310; nameSort["Spirit Naga 2025"] = 3311; nameSort["Spirit of Hunger"] = 3312; nameSort["Spirit Statue Mascot"] = 3313; nameSort["Spirit Troll"] = 3314; nameSort["Spitting Mimic"] = 3315; nameSort["Splugoth the Returned"] = 3316; nameSort["Spore of Moander"] = 3317; nameSort["Spore Servant Octopus"] = 3318; nameSort["Spotted Lion"] = 3319; nameSort["Spring Eladrin"] = 3320; nameSort["Sprite"] = 3321; 
nameSort["Sprite 2025"] = 3322; nameSort["Sprite Skirmisher"] = 3323; nameSort["Spy"] = 3324; nameSort["Spy 2025"] = 3325; nameSort["Spy Master 2025"] = 3326; nameSort["Squiddly"] = 3327; nameSort["Squire"] = 3328; nameSort["Squirt the Oilcan"] = 3329; nameSort["Ssendam, Lord of Madness"] = 3330; nameSort["Ssurran Defiler"] = 3331; nameSort["Ssurran Poisoner"] = 3332; nameSort["Stalagma Steelshadow"] = 3333; nameSort["Stalker of Baphomet"] = 3334; nameSort["Stanimir"] = 3335; nameSort["Star Angler"] = 3336; nameSort["Stargleam"] = 3337; nameSort["Star Lancer"] = 3338; nameSort["Starlight Apparition"] = 3339; nameSort["Star Spawn Grue"] = 3340; nameSort["Star Spawn Hulk"] = 3341; 
nameSort["Star Spawn Larva Mage"] = 3342; nameSort["Star Spawn Mangler"] = 3343; nameSort["Star Spawn Seer"] = 3344; nameSort["Statue of Talos"] = 3345; nameSort["Statue of Vergadain"] = 3346; nameSort["Steam Mephit"] = 3347; nameSort["Steam Mephit 2025"] = 3348; nameSort["Steel Crane"] = 3349; nameSort["Steel Defender"] = 3350; nameSort["Steel Leaf Kavu"] = 3351; nameSort["Steel Predator"] = 3352; nameSort["Stegosaurus"] = 3353; nameSort["Stella Wachter"] = 3354; nameSort["Stench Kow"] = 3355; nameSort["Stirge"] = 3356; nameSort["Stirge 2025"] = 3357; nameSort["Stolos"] = 3358; nameSort["Stomping Foot"] = 3359; nameSort["Stonecloak"] = 3360; nameSort["Stone Cursed"] = 3361; 
nameSort["Stone Defender"] = 3362; nameSort["Stone Dragon Statue"] = 3363; nameSort["Stone Giant"] = 3364; nameSort["Stone Giant 2025"] = 3365; nameSort["Stone Giant Dreamwalker"] = 3366; nameSort["Stone Giant of Evil Earth"] = 3367; nameSort["Stone Giant Rockspeaker"] = 3368; nameSort["Stone Giant Statue"] = 3369; nameSort["Stone Golem"] = 3370; nameSort["Stone Golem 2025"] = 3371; nameSort["Stone Guardian (Animated Armor)"] = 3372; nameSort["Stone Guardian (Helmed Horror)"] = 3373; nameSort["Stone Guardian (Shield Guardian)"] = 3374; nameSort["Stone Guardian (Stone Golem)"] = 3375; nameSort["Stone Juggernaut"] = 3376; nameSort["Stonemelder"] = 3377; nameSort["Stone Warrior"] = 3378; nameSort["Stool"] = 3379; nameSort["Storm Crab"] = 3380; nameSort["Storm Giant"] = 3381; 
nameSort["Storm Giant 2025"] = 3382; nameSort["Storm Giant Quintessent"] = 3383; nameSort["Storm Giant Skeleton"] = 3384; nameSort["Storm Giant Tempest Caller"] = 3385; nameSort["Storm Herald"] = 3386; nameSort["Strahd, Master of Death House"] = 3387; nameSort["Strahd's Animated Armor"] = 3388; nameSort["Strahd von Zarovich"] = 3389; nameSort["Strahd Zombie"] = 3390; nameSort["Strefan Maurer"] = 3391; nameSort["Strigoi"] = 3392; nameSort["Strixhaven Campus Guide"] = 3393; nameSort["Strongheart"] = 3394; nameSort["Styx Dragon"] = 3395; nameSort["Succubus"] = 3396; nameSort["Succubus 2025"] = 3397; nameSort["Suldil Baldoriel"] = 3398; nameSort["Sul Khatesh"] = 3399; nameSort["Summer Eladrin"] = 3400; nameSort["Su-monster"] = 3401; 
nameSort["Sunbird"] = 3402; nameSort["Sunder Shaman"] = 3403; nameSort["Sundeth"] = 3404; nameSort["Sunfly"] = 3405; nameSort["Surrakar"] = 3406; nameSort["Svirfneblin Wererat"] = 3407; nameSort["Swanmay"] = 3408; nameSort["Swarm of Animated Books"] = 3409; nameSort["Swarm of Bats"] = 3410; nameSort["Swarm of Bats 2025"] = 3411; nameSort["Swarm of Beetles"] = 3412; nameSort["Swarm of Books"] = 3413; nameSort["Swarm of Campestris"] = 3414; nameSort["Swarm of Centipedes"] = 3415; nameSort["Swarm of Corrupted Rats"] = 3416; nameSort["Swarm of Cranium Rats"] = 3417; nameSort["Swarm of Crawling Claws 2025"] = 3418; nameSort["Swarm of Dretches 2025"] = 3419; nameSort["Swarm of Gibberlings"] = 3420; nameSort["Swarm of Gremishkas"] = 3421; 
nameSort["Swarm of Hoard Scarabs"] = 3422; nameSort["Swarm of Insects"] = 3423; nameSort["Swarm of Insects 2025"] = 3424; nameSort["Swarm of Larvae 2025"] = 3425; nameSort["Swarm of Lemures 2025"] = 3426; nameSort["Swarm of Maggots"] = 3427; nameSort["Swarm of Mechanical Spiders"] = 3428; nameSort["Swarm of Piranhas"] = 3429; nameSort["Swarm of Piranhas 2025"] = 3430; nameSort["Swarm of Poisonous Snakes"] = 3431; nameSort["Swarm of Quippers"] = 3432; nameSort["Swarm of Rats"] = 3433; nameSort["Swarm of Rats 2025"] = 3434; nameSort["Swarm of Ravens"] = 3435; nameSort["Swarm of Ravens 2025"] = 3436; nameSort["Swarm of Rot Grubs"] = 3437; nameSort["Swarm of Scarabs"] = 3438; nameSort["Swarm of Sorrowfish"] = 3439; nameSort["Swarm of Spiders"] = 3440; nameSort["Swarm of Stirges 2025"] = 3441; 
nameSort["Swarm of Sunflies"] = 3442; nameSort["Swarm of Undead Snakes"] = 3443; nameSort["Swarm of Venomous Snakes 2025"] = 3444; nameSort["Swarm of Wasps"] = 3445; nameSort["Swarm of Zombie Limbs"] = 3446; nameSort["Swashbuckler"] = 3447; nameSort["Swavain Basilisk"] = 3448; nameSort["Sweettooth Horror"] = 3449; nameSort["Sword Spider"] = 3450; nameSort["Sword Wraith Commander"] = 3451; nameSort["Sword Wraith Warrior"] = 3452; nameSort["Sylgar"] = 3453; nameSort["Sylvira Savikas"] = 3454; nameSort["Syndra Silvane"] = 3455; nameSort["Sythian Skalderang"] = 3456; nameSort["Szikzith"] = 3457; nameSort["Szoldar Szoldarovich"] = 3458; nameSort["Tabaxi Hunter"] = 3459; nameSort["Tabaxi Minstrel"] = 3460; nameSort["Talisolvanar Tally Fellbranch"] = 3461; 
nameSort["Talis the White"] = 3462; nameSort["Talon Beast"] = 3463; nameSort["Tanarukk"] = 3464; nameSort["Tanazir Quandrix"] = 3465; nameSort["Tarak"] = 3466; nameSort["Tarkanan Assassin"] = 3467; nameSort["Tarkanan Marauder"] = 3468; nameSort["Tarkanan Ruffian"] = 3469; nameSort["Tarnhem"] = 3470; nameSort["Tarrasque"] = 3471; nameSort["Tarrasque 2025"] = 3472; nameSort["Tartha"] = 3473; nameSort["Tarul Var"] = 3474; nameSort["Tasha the Witch"] = 3475; nameSort["Tashlyn Yafeera"] = 3476; nameSort["Tasloi"] = 3477; nameSort["Tasloi Sniper"] = 3478; nameSort["Tatina Rookledust"] = 3479; nameSort["Tau"] = 3480; nameSort["Tecuziztecatl"] = 3481; 
nameSort["Telepathic Pentacle"] = 3482; nameSort["Tempest Hart"] = 3483; nameSort["Tempest Spirit"] = 3484; nameSort["Tem Temble"] = 3485; nameSort["Terastodon"] = 3486; nameSort["Teremini Nightsedge"] = 3487; nameSort["Terenzio Cassalanter"] = 3488; nameSort["Terracotta Warrior"] = 3489; nameSort["Terran Magen"] = 3490; nameSort["Terra Stomper"] = 3491; nameSort["Thane Kayalithica"] = 3492; nameSort["Thanoi Hunter"] = 3493; nameSort["Tharashk Hunter"] = 3494; nameSort["Thavius Kreeg"] = 3495; nameSort["Thayan Apprentice"] = 3496; nameSort["Thayan Warrior"] = 3497; nameSort["The Abbot"] = 3498; nameSort["The Angry"] = 3499; nameSort["The Bagman"] = 3500; nameSort["The Demogorgon"] = 3501; 
nameSort["The Gardener"] = 3502; nameSort["The Hungry"] = 3503; nameSort["The Keeper"] = 3504; nameSort["The Lonely"] = 3505; nameSort["The Lord of Blades"] = 3506; nameSort["The Lost"] = 3507; nameSort["The Mad Mage of Mount Baratok"] = 3508; nameSort["Themberchaud"] = 3509; nameSort["The Pudding King"] = 3510; nameSort["Theran Chimera"] = 3511; nameSort["Therzt"] = 3512; nameSort["Thessalar"] = 3513; nameSort["Thessalar's Homunculus"] = 3514; nameSort["Thessalheart Construct"] = 3515; nameSort["Thessalhydra"] = 3516; nameSort["Thessalkraken"] = 3517; nameSort["The Stranger"] = 3518; nameSort["The Weevil"] = 3519; nameSort["The Wretched"] = 3520; nameSort["Thinnings"] = 3521; 
nameSort["Tholtz Daggerdark"] = 3522; nameSort["Thomas T. Toad"] = 3523; nameSort["Thopter (Bat)"] = 3524; nameSort["Thopter (Blood Hawk)"] = 3525; nameSort["Thopter (Eagle)"] = 3526; nameSort["Thopter (Hawk)"] = 3527; nameSort["Thopter (Owl)"] = 3528; nameSort["Thopter (Pseudodragon)"] = 3529; nameSort["Thopter (Raven)"] = 3530; nameSort["Thopter (Vulture)"] = 3531; nameSort["Thornboldt Thorn Durst"] = 3532; nameSort["Thorn Slinger"] = 3533; nameSort["Thorny"] = 3534; nameSort["Thorny Vegepygmy"] = 3535; nameSort["Thorvin Twinbeard"] = 3536; nameSort["Thought Spy"] = 3537; nameSort["Thousand Teeth"] = 3538; nameSort["Thrakkus"] = 3539; nameSort["Three Earrings"] = 3540; nameSort["Thri-kreen"] = 3541; 
nameSort["Thri-kreen Gladiator"] = 3542; nameSort["Thri-kreen Hunter"] = 3543; nameSort["Thri-kreen Marauder"] = 3544; nameSort["Thri-kreen Mystic"] = 3545; nameSort["Thri-kreen Psion"] = 3546; nameSort["Thug"] = 3547; nameSort["Thunderbeast Skeleton"] = 3548; nameSort["Thurl Merosska"] = 3549; nameSort["Thurstwell Vanthampur"] = 3550; nameSort["Thwad Underbrew"] = 3551; nameSort["Tiamat"] = 3552; nameSort["Tiax"] = 3553; nameSort["Tiberius Inuus"] = 3554; nameSort["Tiefling Acrobat"] = 3555; nameSort["Tiefling Muralist"] = 3556; nameSort["Tiger"] = 3557; nameSort["Tiger 2025"] = 3558; nameSort["Timbermaw"] = 3559; nameSort["Time Dragon Wyrmling"] = 3560; nameSort["Tin Soldier"] = 3561; 
nameSort["Tiny Servant"] = 3562; nameSort["Tissina Khyret"] = 3563; nameSort["Titanothere"] = 3564; nameSort["Titivilus"] = 3565; nameSort["Tixie's Shield Guardian"] = 3566; nameSort["Tixie Tockworth"] = 3567; nameSort["Tlacatecolo"] = 3568; nameSort["Tlexolotl"] = 3569; nameSort["Tlincalli"] = 3570; nameSort["Tloques-Popolocas"] = 3571; nameSort["Tomb Dwarf"] = 3572; nameSort["Tomb Guardian"] = 3573; nameSort["Tomb Tapper"] = 3574; nameSort["Tommy Two-Butts"] = 3575; nameSort["Tonalli"] = 3576; nameSort["Tooth-N-Claw"] = 3577; nameSort["Topaz Dragon Wyrmling"] = 3578; nameSort["Topaz Greatwyrm"] = 3579; nameSort["Topi"] = 3580; nameSort["Topolah"] = 3581; 
nameSort["Topsy"] = 3582; nameSort["Torbit"] = 3583; nameSort["Torgja Stonecrusher (Levels 1-4)"] = 3584; nameSort["Torgja Stonecrusher (Levels 5-8)"] = 3585; nameSort["Torgja Stonecrusher (Levels 9-11)"] = 3586; nameSort["Torlin Silvershield"] = 3587; nameSort["Tornscale"] = 3588; nameSort["Torogar Steelfist"] = 3589; nameSort["Tortle"] = 3590; nameSort["Tortle Druid"] = 3591; nameSort["Tosh Starling (Levels 1-4)"] = 3592; nameSort["Tosh Starling (Levels 5-8)"] = 3593; nameSort["Tosh Starling (Levels 9-11)"] = 3594; nameSort["Tough 2025"] = 3595; nameSort["Tough Boss 2025"] = 3596; nameSort["Tower Hand"] = 3597; nameSort["Tower Sage"] = 3598; nameSort["Traag Draconian"] = 3599; nameSort["Transcendent Order Conduit"] = 3600; nameSort["Transcendent Order Instinct"] = 3601; 
nameSort["Transmuter"] = 3602; nameSort["Transmuter Wizard"] = 3603; nameSort["Trapper"] = 3604; nameSort["Traxigor"] = 3605; nameSort["Treant"] = 3606; nameSort["Treant 2025"] = 3607; nameSort["Treant Sapling"] = 3608; nameSort["Treant Totem Elemental"] = 3609; nameSort["Tree Blight"] = 3610; nameSort["Tree Blight 2025"] = 3611; nameSort["Treefolk"] = 3612; nameSort["Trench Giant"] = 3613; nameSort["Trenzia"] = 3614; nameSort["Trepsin"] = 3615; nameSort["Tressym"] = 3616; nameSort["Tribal Warrior"] = 3617; nameSort["Tribal Warrior Spore Servant"] = 3618; nameSort["Triceratops"] = 3619; nameSort["Triceratops 2025"] = 3620; nameSort["Tridrone"] = 3621; 
nameSort["Tri-flower Frond"] = 3622; nameSort["Trilobite"] = 3623; nameSort["Trilobite (Giant)"] = 3624; nameSort["Triton Master of Waves"] = 3625; nameSort["Triton Shorestalker"] = 3626; nameSort["Trobriand"] = 3627; nameSort["Troglodyte"] = 3628; nameSort["Troglodyte 2025"] = 3629; nameSort["Troglodyte Champion of Laogzed"] = 3630; nameSort["Troll"] = 3631; nameSort["Troll 2025"] = 3632; nameSort["Troll Amalgam"] = 3633; nameSort["Troll Limb 2025"] = 3634; nameSort["Troll Mutate"] = 3635; nameSort["Tromokratis"] = 3636; nameSort["Trostani"] = 3637; nameSort["Tsucora Quori"] = 3638; nameSort["Tug"] = 3639; nameSort["Tungsten Ward"] = 3640; nameSort["Turlang"] = 3641; 
nameSort["Turntimber Giant"] = 3642; nameSort["Turvy"] = 3643; nameSort["Twig Blight"] = 3644; nameSort["Twig Blight 2025"] = 3645; nameSort["Two Dry Cloaks"] = 3646; nameSort["Two-Headed Cerberus"] = 3647; nameSort["Two-Headed Crocodile"] = 3648; nameSort["Two-Headed Owlbear"] = 3649; nameSort["Two-Headed Plesiosaurus"] = 3650; nameSort["Two-Headed Troll"] = 3651; nameSort["Typhon"] = 3652; nameSort["Tyrannosaurus Rex"] = 3653; nameSort["Tyrannosaurus Rex 2025"] = 3654; nameSort["Tyrannosaurus Zombie"] = 3655; nameSort["Tyrant"] = 3656; nameSort["Tyrant Shadow"] = 3657; nameSort["Tyreus, Illusionist"] = 3658; nameSort["Udaak"] = 3659; nameSort["Ulamog"] = 3660; nameSort["Ulder Ravengard"] = 3661; 
nameSort["Ulitharid"] = 3662; nameSort["Ultroloth"] = 3663; nameSort["Ultroloth 2025"] = 3664; nameSort["Uma"] = 3665; nameSort["Umber Hulk"] = 3666; nameSort["Umber Hulk 2025"] = 3667; nameSort["Umberto Noblin"] = 3668; nameSort["Umbragen Shadow Walker"] = 3669; nameSort["Umbraxakar"] = 3670; nameSort["Undead Bulette"] = 3671; nameSort["Undead Cockatrice"] = 3672; nameSort["Undead Shambling Mound"] = 3673; nameSort["Undead Soldier"] = 3674; nameSort["Undead Spirit"] = 3675; nameSort["Undead Tree"] = 3676; nameSort["Undercity Medusa"] = 3677; nameSort["Underworld Cerberus"] = 3678; nameSort["Undying Councilor"] = 3679; nameSort["Undying Soldier"] = 3680; nameSort["Unicorn"] = 3681; 
nameSort["Unicorn 2025"] = 3682; nameSort["Unspeakable Horror"] = 3683; nameSort["Urgala Meltimer"] = 3684; nameSort["Urstul Floxin"] = 3685; nameSort["Urwin Martikov"] = 3686; nameSort["Usagt"] = 3687; nameSort["Uthgardt Barbarian Leader"] = 3688; nameSort["Uthgardt Shaman"] = 3689; nameSort["Uvashar"] = 3690; nameSort["Uzoma Baten"] = 3691; nameSort["Vaal"] = 3692; nameSort["Vaasha"] = 3693; nameSort["Vadalis Heir"] = 3694; nameSort["Vaeve"] = 3695; nameSort["Vajra Safahr"] = 3696; nameSort["Valenar Hawk"] = 3697; nameSort["Valenar Hound"] = 3698; nameSort["Valenar Steed"] = 3699; nameSort["Valendar"] = 3700; nameSort["Valetta"] = 3701; 
nameSort["Valindra Shadowmantle"] = 3702; nameSort["Valin Sarnaster"] = 3703; nameSort["Valtagar Steelshadow"] = 3704; nameSort["Valygar"] = 3705; nameSort["Vampirate"] = 3706; nameSort["Vampirate Captain"] = 3707; nameSort["Vampirate Mage"] = 3708; nameSort["Vampire"] = 3709; nameSort["Vampire 2025"] = 3710; nameSort["Vampire Familiar 2025"] = 3711; nameSort["Vampire Infernalist"] = 3712; nameSort["Vampire Neonate"] = 3713; nameSort["Vampire Nightbringer 2025"] = 3714; nameSort["Vampire Null"] = 3715; nameSort["Vampire Spawn"] = 3716; nameSort["Vampire Spawn 2025"] = 3717; nameSort["Vampire Spellcaster"] = 3718; nameSort["Vampire Umbral Lord 2025"] = 3719; nameSort["Vampire Warden"] = 3720; nameSort["Vampire Warrior"] = 3721; 
nameSort["Vampiric Ixitxachitl"] = 3722; nameSort["Vampiric Ixitxachitl Cleric"] = 3723; nameSort["Vampiric Jade Statue"] = 3724; nameSort["Vampiric Mind Flayer"] = 3725; nameSort["Vampiric Mist"] = 3726; nameSort["Vanifer"] = 3727; nameSort["Varakkta"] = 3728; nameSort["Vargouille"] = 3729; nameSort["Vargouille Reflection"] = 3730; nameSort["Varnoth"] = 3731; nameSort["Varnyr"] = 3732; nameSort["Varram"] = 3733; nameSort["Vasilka"] = 3734; nameSort["Vecna Impersonator"] = 3735; nameSort["Vecna the Archlich"] = 3736; nameSort["Vegepygmy"] = 3737; nameSort["Vegepygmy Chief"] = 3738; nameSort["Vegepygmy Moldmaker"] = 3739; nameSort["Vegepygmy Scavenger"] = 3740; nameSort["Vegepygmy Thorny Hunter"] = 3741; 
nameSort["Veiled Presence"] = 3742; nameSort["Veldyskar"] = 3743; nameSort["Vellin Farstride"] = 3744; nameSort["Vellynne Harpell"] = 3745; nameSort["Velociraptor"] = 3746; nameSort["Velomachus Lorehold"] = 3747; nameSort["Venomfang"] = 3748; nameSort["Venomous Snake 2025"] = 3749; nameSort["Venom Troll"] = 3750; nameSort["Verbeeg Longstrider"] = 3751; nameSort["Verbeeg Marauder"] = 3752; nameSort["Verin Thelyss"] = 3753; nameSort["Verminaard"] = 3754; nameSort["Vertrand Shadowdusk"] = 3755; nameSort["Veteran"] = 3756; nameSort["Veteran of the Gauntlet"] = 3757; nameSort["Viari"] = 3758; nameSort["Vi Aroon"] = 3759; nameSort["Viconia DeVir"] = 3760; nameSort["Victoro Cassalanter"] = 3761; 
nameSort["Victor Vallakovich"] = 3762; nameSort["Viktor"] = 3763; nameSort["Vilnius"] = 3764; nameSort["Viln Tirin"] = 3765; nameSort["Vincent Trench"] = 3766; nameSort["Vine Blight"] = 3767; nameSort["Vine Blight 2025"] = 3768; nameSort["Vine Blight Tangler"] = 3769; nameSort["Vinx"] = 3770; nameSort["Violet Fungus"] = 3771; nameSort["Violet Fungus 2025"] = 3772; nameSort["Violet Fungus Necrohulk 2025"] = 3773; nameSort["Virruza"] = 3774; nameSort["Virvos Magen"] = 3775; nameSort["Vistana Assassin"] = 3776; nameSort["Vistana Bandit"] = 3777; nameSort["Vistana Bandit Captain"] = 3778; nameSort["Vistana Commoner"] = 3779; nameSort["Vistana Guard"] = 3780; nameSort["Vistana Spy"] = 3781; 
nameSort["Vistana Thug"] = 3782; nameSort["Vizeran DeVir"] = 3783; nameSort["Vladimir Horngaard"] = 3784; nameSort["Vlazok"] = 3785; nameSort["Voalsh"] = 3786; nameSort["Vocath"] = 3787; nameSort["Void Scavver"] = 3788; nameSort["Volenta Popofsky"] = 3789; nameSort["Volothamp Volo Geddarm"] = 3790; nameSort["Vorvolaka"] = 3791; nameSort["Vox Seeker"] = 3792; nameSort["Vrock"] = 3793; nameSort["Vrock 2025"] = 3794; nameSort["Vulkoori Stingblade"] = 3795; nameSort["Vulkoori Venom Priest"] = 3796; nameSort["Vulture"] = 3797; nameSort["Vulture 2025"] = 3798; nameSort["Vuuthramis"] = 3799; nameSort["Waeloquay"] = 3800; nameSort["Wakanga O'tamu"] = 3801; 
nameSort["Walking Corpse"] = 3802; nameSort["Walking Statue of Waterdeep"] = 3803; nameSort["Walnut Dankgrass"] = 3804; nameSort["Walrus"] = 3805; nameSort["Warden Archon"] = 3806; nameSort["War Devil"] = 3807; nameSort["Warduke"] = 3808; nameSort["Warforged Colossus"] = 3809; nameSort["Warforged Soldier"] = 3810; nameSort["Warforged Titan"] = 3811; nameSort["Warforged Warrior"] = 3812; nameSort["Warhorse"] = 3813; nameSort["Warhorse 2025"] = 3814; nameSort["Warhorse Skeleton"] = 3815; nameSort["Warhorse Skeleton 2025"] = 3816; nameSort["Warlock of the Archfey"] = 3817; nameSort["Warlock of the Fiend"] = 3818; nameSort["Warlock of the Great Old One"] = 3819; nameSort["Warlord"] = 3820; nameSort["War Priest"] = 3821; 
nameSort["Warrior"] = 3822; nameSort["Warrior Commander 2025"] = 3823; nameSort["Warrior Infantry 2025"] = 3824; nameSort["Warrior of Madarua"] = 3825; nameSort["Warrior Veteran 2025"] = 3826; nameSort["Warwyck Blastimoff"] = 3827; nameSort["Wasteland Dragonnel"] = 3828; nameSort["Wastrilith"] = 3829; nameSort["Water Elemental"] = 3830; nameSort["Water Elemental 2025"] = 3831; nameSort["Water Elemental Myrmidon"] = 3832; nameSort["Water Totem Elemental"] = 3833; nameSort["Water Weird"] = 3834; nameSort["Water Weird 2025"] = 3835; nameSort["Weasel"] = 3836; nameSort["Weasel 2025"] = 3837; nameSort["Wei Feng Ying"] = 3838; nameSort["Werebat"] = 3839; nameSort["Werebear"] = 3840; nameSort["Werebear 2025"] = 3841; 
nameSort["Wereboar"] = 3842; nameSort["Wereboar 2025"] = 3843; nameSort["Werejaguar"] = 3844; nameSort["Wererat"] = 3845; nameSort["Wererat 2025"] = 3846; nameSort["Wereraven"] = 3847; nameSort["Weretiger"] = 3848; nameSort["Weretiger 2025"] = 3849; nameSort["Werevulture"] = 3850; nameSort["Werewolf"] = 3851; nameSort["Werewolf 2025"] = 3852; nameSort["Werewolf (Krallenhorde)"] = 3853; nameSort["Werewyvern"] = 3854; nameSort["Wersten Kern"] = 3855; nameSort["West Wind"] = 3856; nameSort["Whirling Chandelier"] = 3857; nameSort["Whirlwyrm"] = 3858; nameSort["Whistler"] = 3859; nameSort["White Abishai"] = 3860; nameSort["White Dragon Wyrmling"] = 3861; 
nameSort["White Dragon Wyrmling 2025"] = 3862; nameSort["White Greatwyrm"] = 3863; nameSort["White Guard Drake"] = 3864; nameSort["White Jade Emperor"] = 3865; nameSort["White Maw"] = 3866; nameSort["Whymsee"] = 3867; nameSort["Wiggan Nettlebee"] = 3868; nameSort["Wight"] = 3869; nameSort["Wight 2025"] = 3870; nameSort["Wight Lifedrinker"] = 3871; nameSort["Wild Dog"] = 3872; nameSort["Wildfire Spirit"] = 3873; nameSort["Willifort Crowelle"] = 3874; nameSort["Will-o'-Wells"] = 3875; nameSort["Will-o'-Wisp"] = 3876; nameSort["Windfall"] = 3877; nameSort["Windharrow"] = 3878; nameSort["Wine Weird"] = 3879; nameSort["Winged Bull"] = 3880; nameSort["Winged Kobold"] = 3881; 
nameSort["Winged Kobold 2025"] = 3882; nameSort["Winged Lion"] = 3883; nameSort["Winged Thrull"] = 3884; nameSort["Winter Eladrin"] = 3885; nameSort["Winter Wolf"] = 3886; nameSort["Winter Wolf 2025"] = 3887; nameSort["Wiri Fleagol"] = 3888; nameSort["Witchkite"] = 3889; nameSort["Witchlight Hand (Medium)"] = 3890; nameSort["Witchlight Hand (Small)"] = 3891; nameSort["Witchstalker"] = 3892; nameSort["Witherbloom Apprentice"] = 3893; nameSort["Witherbloom Pledgemage"] = 3894; nameSort["Witherbloom Professor of Decay"] = 3895; nameSort["Witherbloom Professor of Growth"] = 3896; nameSort["Withers"] = 3897; nameSort["Woe Strider"] = 3898; nameSort["Wolf"] = 3899; nameSort["Wolf 2025"] = 3900; nameSort["Wolf-in-Sheep's-Clothing"] = 3901; 
nameSort["Wolf of the Overworld"] = 3902; nameSort["Wolfwere"] = 3903; nameSort["Wolfwere Alpha"] = 3904; nameSort["Woodcrasher Baloth"] = 3905; nameSort["Wood Elf"] = 3906; nameSort["Wood Elf Wizard"] = 3907; nameSort["Wooden Donkey"] = 3908; nameSort["Wood Woad"] = 3909; nameSort["Worg"] = 3910; nameSort["Worg 2025"] = 3911; nameSort["Worker Robot"] = 3912; nameSort["Wraith"] = 3913; nameSort["Wraith 2025"] = 3914; nameSort["Wretched Sorrowsworn"] = 3915; nameSort["Wurm"] = 3916; nameSort["Wyhan"] = 3917; nameSort["Wyllow"] = 3918; nameSort["Wynling"] = 3919; nameSort["Wyvern"] = 3920; nameSort["Wyvern 2025"] = 3921; 
nameSort["X01"] = 3922; nameSort["Xanathar"] = 3923; nameSort["Xandala"] = 3924; nameSort["Xan Moonblade"] = 3925; nameSort["Xarann A'Daragon"] = 3926; nameSort["Xardorok Sunblight"] = 3927; nameSort["Xazax the Eyemonger"] = 3928; nameSort["Xenk Yendar"] = 3929; nameSort["Xill"] = 3930; nameSort["Xilonen"] = 3931; nameSort["Xocopol"] = 3932; nameSort["Xolkin Alassandar"] = 3933; nameSort["Xorn"] = 3934; nameSort["Xorn 2025"] = 3935; nameSort["Xorta"] = 3936; nameSort["Xot"] = 3937; nameSort["Xvart"] = 3938; nameSort["Xvart Speaker"] = 3939; nameSort["Xvart Warlock of Raxivort"] = 3940; nameSort["Xzar the Chaos Clone"] = 3941; 
nameSort["Y"] = 3942; nameSort["Yagnoloth"] = 3943; nameSort["Yagra Stonefist"] = 3944; nameSort["Yak"] = 3945; nameSort["Yakfolk Priest"] = 3946; nameSort["Yakfolk Warrior"] = 3947; nameSort["Yalaga Maladwyn"] = 3948; nameSort["Yalah Gralhund"] = 3949; nameSort["Yan-C-Bin"] = 3950; nameSort["Yantha Coaxrock"] = 3951; nameSort["Yanthdel Henlifel"] = 3952; nameSort["Yarana"] = 3953; nameSort["Yarnspinner"] = 3954; nameSort["Y'demi"] = 3955; nameSort["Yeenoghu"] = 3956; nameSort["Yellow Musk Creeper"] = 3957; nameSort["Yellow Musk Zombie"] = 3958; nameSort["Yestabrod"] = 3959; nameSort["Yeth Hound"] = 3960; nameSort["Yeti"] = 3961; 
nameSort["Yeti 2025"] = 3962; nameSort["Yeti Leader"] = 3963; nameSort["Yeti Tyke"] = 3964; nameSort["Yevgeni Krushkin"] = 3965; nameSort["Yggdrasti"] = 3966; nameSort["Ygorl, Lord of Entropy"] = 3967; nameSort["Yinra Emberwind"] = 3968; nameSort["Yochlol"] = 3969; nameSort["Yochlol 2025"] = 3970; nameSort["Yorb"] = 3971; nameSort["Yorn"] = 3972; nameSort["Young Amethyst Dragon"] = 3973; nameSort["Young Amonkhet Dragon"] = 3974; nameSort["Young Basilisk"] = 3975; nameSort["Young Black Dragon"] = 3976; nameSort["Young Black Dragon 2025"] = 3977; nameSort["Young Blue Dragon"] = 3978; nameSort["Young Blue Dragon 2025"] = 3979; nameSort["Young Brass Dragon"] = 3980; nameSort["Young Brass Dragon 2025"] = 3981; 
nameSort["Young Bronze Dragon"] = 3982; nameSort["Young Bronze Dragon 2025"] = 3983; nameSort["Young Bulette"] = 3984; nameSort["Young Cloud Giant"] = 3985; nameSort["Young Copper Dragon"] = 3986; nameSort["Young Copper Dragon 2025"] = 3987; nameSort["Young Crystal Dragon"] = 3988; nameSort["Young Deep Dragon"] = 3989; nameSort["Young Dragon Turtle"] = 3990; nameSort["Young Emerald Dragon"] = 3991; nameSort["Young Fire Giant"] = 3992; nameSort["Young Frost Giant"] = 3993; nameSort["Young-Gi"] = 3994; nameSort["Young Gold Dragon"] = 3995; nameSort["Young Gold Dragon 2025"] = 3996; nameSort["Young Green Dragon"] = 3997; nameSort["Young Green Dragon 2025"] = 3998; nameSort["Young Griffon (Medium)"] = 3999; nameSort["Young Griffon (Small)"] = 4000; nameSort["Young Griffon (Tiny)"] = 4001; 
nameSort["Young Hill Giant"] = 4002; nameSort["Young Hook Horror"] = 4003; nameSort["Young Horizonback Tortoise"] = 4004; nameSort["Young Kraken"] = 4005; nameSort["Young Kruthik"] = 4006; nameSort["Young Lunar Dragon"] = 4007; nameSort["Young Moonstone Dragon"] = 4008; nameSort["Young Ogre Servant"] = 4009; nameSort["Young Purple Worm"] = 4010; nameSort["Young Red Dragon"] = 4011; nameSort["Young Red Dragon 2025"] = 4012; nameSort["Young Red Shadow Dragon"] = 4013; nameSort["Young Remorhaz"] = 4014; nameSort["Young Remorhaz 2025"] = 4015; nameSort["Young Sapphire Dragon"] = 4016; nameSort["Young Sea Serpent"] = 4017; nameSort["Young Silver Dragon"] = 4018; nameSort["Young Silver Dragon 2025"] = 4019; nameSort["Young Solar Dragon"] = 4020; nameSort["Young Spirit Dragon"] = 4021; 
nameSort["Young Time Dragon"] = 4022; nameSort["Young Topaz Dragon"] = 4023; nameSort["Young Troglodyte"] = 4024; nameSort["Young Wereraven"] = 4025; nameSort["Young White Dragon"] = 4026; nameSort["Young White Dragon 2025"] = 4027; nameSort["Young Winter Wolf"] = 4028; nameSort["Yuan-ti Abomination"] = 4029; nameSort["Yuan-ti Anathema"] = 4030; nameSort["Yuan-ti Broodguard"] = 4031; nameSort["Yuan-ti Infiltrator"] = 4032; nameSort["Yuan-ti Malison (Type 1)"] = 4033; nameSort["Yuan-ti Malison (Type 2)"] = 4034; nameSort["Yuan-ti Malison (Type 3)"] = 4035; nameSort["Yuan-ti Malison (Type 4)"] = 4036; nameSort["Yuan-ti Malison (Type 5)"] = 4037; nameSort["Yuan-ti Mind Whisperer"] = 4038; nameSort["Yuan-ti Nightmare Speaker"] = 4039; nameSort["Yuan-ti Pit Master"] = 4040; nameSort["Yuan-ti Priest"] = 4041; 
nameSort["Yuan-ti Pureblood"] = 4042; nameSort["Yuk Yuk"] = 4043; nameSort["Yusdrayl"] = 4044; nameSort["Zagum"] = 4045; nameSort["Zakya Rakshasa"] = 4046; nameSort["Zala Morphus"] = 4047; nameSort["Zalkoré"] = 4048; nameSort["Zaltember"] = 4049; nameSort["Zalthar Shadowdusk"] = 4050; nameSort["Zarak"] = 4051; nameSort["Zaratan"] = 4052; nameSort["Zargash"] = 4053; nameSort["Zargon the Returner"] = 4054; nameSort["Zariel"] = 4055; nameSort["Zaroum Al-Saryak"] = 4056; nameSort["Zastra"] = 4057; nameSort["Zaythir"] = 4058; nameSort["Zebra"] = 4059; nameSort["Zegana"] = 4060; nameSort["Zegdar"] = 4061; 
nameSort["Zendikar Dragon"] = 4062; nameSort["Zendikar Golem"] = 4063; nameSort["Zeond"] = 4064; nameSort["Zephyros"] = 4065; nameSort["Zhanthi"] = 4066; nameSort["Zhentarim Thug"] = 4067; nameSort["Zhentilar Paladin of Bane"] = 4068; nameSort["Zhentilar Soldier"] = 4069; nameSort["Zhent Martial Arts Adept"] = 4070; nameSort["Zikran"] = 4071; nameSort["Zikzokrishka"] = 4072; nameSort["Zilchyn Q'Leptin"] = 4073; nameSort["Zi Liang"] = 4074; nameSort["Zindar"] = 4075; nameSort["Ziraj the Hunter"] = 4076; nameSort["Zisatta"] = 4077; nameSort["Zlan"] = 4078; nameSort["Zodar"] = 4079; nameSort["Zombie"] = 4080; nameSort["Zombie 2025"] = 4081; 
nameSort["Zombie Cat"] = 4082; nameSort["Zombie Clot"] = 4083; nameSort["Zombie Horse"] = 4084; nameSort["Zombie Plague Spreader"] = 4085; nameSort["Zombie Rat"] = 4086; nameSort["Zombie Snake"] = 4087; nameSort["Zorak Lightdrinker"] = 4088; nameSort["Zorbo"] = 4089; nameSort["Zorhanna Adulare"] = 4090; nameSort["Zorhanna's Simulacrum"] = 4091; nameSort["Zox Clammersham"] = 4092; nameSort["Zress Orlezziir"] = 4093; nameSort["Zuggtmoy"] = 4094; nameSort["Zuleika Toranescu"] = 4095; nameSort["Zygfrek Belview"] = 4096; nameSort["Zythan"] = 4097; 
}

{
	switch($1) {
		case "ac.1.ac":
			extra_ac = $2;
			break;
		case "ac.1.condition":
			gsub("\"", "", $2);
			acc = sprintf("Extra AC: %d %s", extra_ac, $2); addnote(acc);
			break;
		case "ac.0":
		case "ac.0.ac":
			printf "sm[%d].i_armorClass[AC_NORMAL] = %d;\n", monCnt, $2;
			if (length(al) > 0) {
				switch (al) {
					case "CE":
						val = 9;
						break;
					case "CG":
						val = 7;
						break;
					case "CN":
						val = 8;
						break;
					case "LE":
						val = 3;
						break;
					case "LG":
						val = 1;
						break;
					case "LN":
						val = 2;
						break;
					case "N":
						val = 5;
						break;
					case "NE":
						val = 6;
						break;
					case "NG":
						val = 4;
						break;
					default:
						val = 7;
						break;
				}
				printf "sm[%d].i_alignment = %d;\n", monCnt, val;
			}
			break;
		case "ac.0.special":
			gsub("\"", "", $2);
			acs = sprintf("AC Special: %s", $2); addnote(acs);
			split($2, acss, " "); acss[1] += 0;
			printf "sm[%d].i_armorClass[AC_NORMAL] = %d;\n", monCnt, acss[1];
			break;
		case "action.0.entries.0":
		case "action.0.entries.1":
		case "action.0.entries.2":
		case "action.1.entries.0":
		case "action.1.entries.1":
		case "action.1.entries.2":
		case "action.2.entries.0":
		case "action.2.entries.1":
		case "action.2.entries.2":
		case "action.3.entries.0":
		case "action.3.entries.1":
		case "action.3.entries.2":
		case "action.4.entries.0":
		case "action.4.entries.1":
		case "action.4.entries.2":
		case "action.5.entries.0":
		case "action.5.entries.1":
		case "action.5.entries.2":
		case "action.6.entries.0":
		case "action.6.entries.1":
		case "action.6.entries.2":
		case "action.7.entries.0":
		case "action.7.entries.1":
		case "action.7.entries.2":
		case "action.8.entries.0":
		case "action.8.entries.1":
		case "action.8.entries.2":
		case "_copy._mod.action.0.items.entries.0":
		case "_copy._mod.action.1.items.entries.0":
		case "_copy._mod.action.2.items.entries.0":
		case "_copy._mod.action.3.items.entries.0":
		case "_copy._mod.action.4.items.entries.0":
		case "_copy._mod.action.items.entries.0":
			hi = index($2, "{@hit "); dm = index($2, "{@damage "); pl = index($2, "plus"); dam = "";
			printf "sm[%d].w_weapons[%d].i_attackBonus[0] = %d;\n", monCnt, monWeapCnt, tagcut($2, "{@hit ", "}");
			if (dm > 0) {
				dam = substr($2, dm, 19); fe = index(dam, "}");
				dam = substr($2, dm+9, fe-10);
				gsub(" ", "", dam);
			}
			if (pl > 0) {
				plus = substr($2, pl, 99); dm = index(plus, "{@damage"); fe = index(plus, "}"); 
				plus = substr($2, pl+dm+8, fe-dm-9);
				gsub(" ", "", plus);
				printf "strcpy(sm[%d].w_weapons[%d].c_damage, \"%s + %s\");\n", monCnt, monWeapCnt, dam, plus;
			} else {
				printf "strcpy(sm[%d].w_weapons[%d].c_damage, \"%s\");\n", monCnt, monWeapCnt, dam;
			}
			gsub("{@hit", "", $2); 
			gsub("{@h", "", $2); 
			gsub("{@damage", "", $2); 
			gsub("{@atkr m,r", "", $2); 
			gsub("{@atkr r", "", $2); 
			gsub("{@atkr m", "", $2); 
			gsub("{@condition", "", $2);
			gsub("{@variantrule ", "", $2);
			gsub("{@actSave", "Save", $2);
			gsub("{@actSaveFail}", "Fail", $2);
			gsub("{@actSaveSuccess}", "Success", $2);
			gsub("{@dc", "DC:", $2);
			gsub("}", "", $2); gsub("\"", "", $2);
			gsub(".XPHB", "", $2);
			printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 79);\n", monCnt, monWeapCnt, $2;
			printf "sm[%d].w_weapons[%d].c_message[79] = 0;\n", monCnt, monWeapCnt;
			if (length($2) > 79) { addnote(weaponName); addnote($2); }
			break;
		case "action.0.name":
		case "action.1.name":
		case "action.2.name":
		case "action.3.name":
		case "action.4.name":
		case "action.5.name":
		case "action.6.name":
		case "action.7.name":
		case "action.8.name":
		case "action.9.name":
		case "_copy._mod.action.items.name":
		case "_copy._mod.action.0.items.name":
		case "_copy._mod.action.1.items.name":
		case "_copy._mod.action.2.items.name":
		case "_copy._mod.action.3.items.name":
			monWeapCnt++;
			gsub("\"", "", $2); sub(" ", "", $2); sub("}", ")", $2);
			gsub("{@recharge", "(Recharge ", $2);
			printf "strncpy(sm[%d].w_weapons[%d].c_description, \"%s\", 30);\n", monCnt, monWeapCnt, $2;
			weaponName = $2;
			if (index($2, "Multiattack") > 0) {
				getline;
				if (index($2, "makes five") > 0) { printf "sm[%d].i_noAttacks = 5;\n", monCnt; }
				else if (index($2, "makes four") > 0) { printf "sm[%d].i_noAttacks = 4;\n", monCnt; }
				else if (index($2, "makes three") > 0 || index($2, "attacks three") > 0) { printf "sm[%d].i_noAttacks = 3;\n", monCnt; }
				else if (index($2, "makes two") > 0 || index($2, "attacks twice") > 0) { printf "sm[%d].i_noAttacks = 2;\n", monCnt; }

				if (index($2, " and one ") > 0 || index($2, "and once") > 0) { printf "sm[%d].i_noAttacks += 1;\n", monCnt; }
				else if (index($2, " and two ") > 0 || index($2, "and twice") > 0) { printf "sm[%d].i_noAttacks += 2;\n", monCnt; }
				else if (index($2, " and three ") > 0) { printf "sm[%d].i_noAttacks += 3;\n", monCnt; }
				else if (index($2, " and four ") > 0) { printf "sm[%d].i_noAttacks += 4;\n", monCnt; }
				else if (index($2, " and five ") > 0) { printf "sm[%d].i_noAttacks += 5;\n", monCnt; }

				gsub(" {@spell", "", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub(".XPHB", "", $2); gsub("{@variantrule ", "", $2);

				printf "strncpy(sm[%d].w_weapons[%d].c_message, \"%s\", 79);\n", monCnt, monWeapCnt, $2;
				printf "sm[%d].w_weapons[%d].c_message[79] = 0;\n", monCnt, monWeapCnt;
				if (length($2) > 79) { addnote(weaponName); addnote($2); }
			} else {
				printf "sm[%d].w_weapons[%d].c_available = 1;\n", monCnt, monWeapCnt;
			}
			break;
		case "action.0.entries.1.items.0.name":
		case "action.0.entries.1.items.1.name":
		case "action.0.entries.1.items.2.name":
		case "action.1.entries.1.items.0.name":
		case "action.1.entries.1.items.1.name":
		case "action.1.entries.1.items.2.name":
		case "action.2.entries.1.items.0.name":
		case "action.2.entries.1.items.1.name":
		case "action.2.entries.1.items.2.name":
		case "action.2.entries.1.items.3.name":
		case "action.2.entries.1.items.4.name":
		case "action.2.entries.1.items.5.name":
		case "action.2.entries.1.items.5.type":
		case "action.2.entries.1.items.6.name":
		case "action.2.entries.1.items.8.name":
		case "action.2.entries.1.items.9.name":
		case "action.3.entries.1.items.0.name":
		case "action.3.entries.1.items.1.name":
		case "action.3.entries.1.items.2.name":
		case "action.4.entries.1.items.0.name":
		case "action.4.entries.1.items.1.name":
		case "action.4.entries.1.items.2.name":
		case "action.6.entries.1.items.0.name":
		case "action.6.entries.1.items.1.name":
		case "action.6.entries.1.items.2.name":
		case "action.7.entries.1.items.0.name":
		case "action.7.entries.1.items.1.name":
		case "action.7.entries.1.items.2.name":
			gsub("\"", "", $2); gsub(".XPHB", "", $2); gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell", "", $2); gsub(".XPHB", "", $2);
			addnote($2);
			break;
		case "action.1.entries.1.items.0.entries.0":
		case "action.1.entries.1.items.1.entries.0":
		case "action.2.entries.1.items.0.entries.0":
		case "action.2.entries.1.items.1.entries.0":
		case "action.2.entries.1.items.2.entries.0":
		case "action.2.entries.1.items.3.entries.0":
		case "action.2.entries.1.items.4.entries.0":
		case "action.2.entries.1.items.5.entries.0":
		case "action.2.entries.1.items.6.entries.0":
		case "action.2.entries.1.items.7.entries.0":
		case "action.2.entries.1.items.8.entries.0":
		case "action.2.entries.1.items.9.entries.0":
		case "action.3.entries.1.items.0.entries.0":
		case "action.3.entries.1.items.1.entries.0":
		case "action.3.entries.1.items.2.entries.0":
			gsub("\"", "", $2); gsub(".XPHB", "", $2); gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell", "", $2); gsub(".XPHB", "", $2);
			addnote($2);
			break;
		case "action.1.entries.1.style":
			break;
		case "action.1.entries.1.type":
			break;
		case "action.1.entries.1.items.0.type":
		case "action.1.entries.1.items.1.type":
		case "action.2.entries.1.items.0.type":
		case "action.2.entries.1.items.1.type":
		case "action.2.entries.1.items.2.type":
		case "action.2.entries.1.items.3.type":
		case "action.2.entries.1.items.4.type":
		case "action.2.entries.1.items.6.type":
		case "action.2.entries.1.items.7.name":
		case "action.2.entries.1.items.7.type":
		case "action.2.entries.1.items.8.type":
		case "action.2.entries.1.items.9.type":
		case "action.3.entries.1.items.0.type":
		case "action.3.entries.1.items.1.type":
		case "action.3.entries.1.items.2.type":
			break;
		case "action.2.entries.1.style":
			break;
		case "action.2.entries.1.type":
			break;
		case "action.3.entries.1.style":
			break;
		case "action.3.entries.1.type":
			break;
		case "actionTags.0":
		case "actionTags.1":
		case "actionTags.2":
			break;
		case "alignment.0":
			gsub("\"", "", $2); gsub(" ", "", $2);
			al = $2;
			break;
		case "alignment.1":
			gsub("\"", "", $2); gsub(" ", "", $2);
			al = sprintf("%s%s", al, $2);
			break;
		case "attachedItems.0":
			break;
		case "bonus.0.entries.1.items.0.entry":
			break;
		case "bonus.0.entries.1.items.0.name":
			break;
		case "bonus.0.entries.1.items.0.type":
			break;
		case "bonus.0.entries.1.items.1.entry":
			break;
		case "bonus.0.entries.1.items.1.name":
			break;
		case "bonus.0.entries.1.items.1.type":
			break;
		case "bonus.0.entries.1.items.2.entry":
			break;
		case "bonus.0.entries.1.items.2.name":
			break;
		case "bonus.0.entries.1.items.2.type":
			break;
		case "bonus.0.entries.1.style":
			break;
		case "bonus.0.entries.1.type":
			break;
		case "bonus.0.entries.0":
		case "bonus.0.entries.1":
		case "bonus.0.entries.2":
		case "bonus.1.entries.0":
		case "bonus.1.entries.1":
		case "bonus.1.entries.2":
		case "bonus.2.entries.0":
		case "bonus.2.entries.1":
		case "bonus.2.entries.2":
		case "bonus.3.entries.0":
		case "bonus.3.entries.1":
		case "bonus.3.entries.2":
		case "bonus.4.entries.0":
		case "bonus.4.entries.1":
		case "bonus.4.entries.2":
			gsub("\"", "", $2); gsub(".XPHB", "", $2); gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell", "", $2); gsub(".XPHB", "", $2);
			addnote($2);
			break;
		case "bonus.0.name":
		case "bonus.1.name":
		case "bonus.2.name":
		case "bonus.3.name":
		case "bonus.4.name":
		case "bonus.5.name":
			gsub("\"", "", $2); gsub(".XPHB", "", $2); gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell", "", $2); gsub(".XPHB", "", $2);
			addnote($2);
			break;
		case "cha":
			printf "sm[%d].i_abilityStats[0][ABILITY_CHA] = %d;\n", monCnt, $2;
			printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, stattobonus($2);
			break;
		case "con":
			printf "sm[%d].i_abilityStats[0][ABILITY_CON] = %d;\n", monCnt, $2;
			printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, stattobonus($2);
			break;
		case "conditionImmune.0":
			break;
		case "conditionImmune.0.cond":
			break;
		case "conditionImmune.0.conditionImmune.0":
			break;
		case "conditionImmune.0.note":
			break;
		case "conditionImmune.1":
		case "conditionImmune.10":
		case "conditionImmune.11":
		case "conditionImmune.12":
		case "conditionImmune.2":
		case "conditionImmune.3":
		case "conditionImmune.4":
		case "conditionImmune.5":
		case "conditionImmune.6":
		case "conditionImmune.7":
		case "conditionImmune.8":
		case "conditionImmune.9":
			gsub("\"", "", $2);
			ci = sprintf("Condition Immunity: %s", $2);
			addnote(ci);
			break;
		case "conditionInflict.0":
		case "conditionInflict.1":
		case "conditionInflict.2":
		case "conditionInflict.3":
		case "conditionInflict.4":
		case "conditionInflict.5":
		case "conditionInflict.6":
		case "conditionInflict.7":
			break;
		case "conditionInflictSpell.0":
		case "conditionInflictSpell.1":
		case "conditionInflictSpell.2":
		case "conditionInflictSpell.3":
			break;
		case "cr":
		case "cr.cr":
			gsub(" ", "", $2); gsub("\"", "", $2);
			if ($2 == "1/4" || $2 == "0") { cr = 0.25; }
			else if ($2 == "1/8") { cr = 0.125; }
			else if ($2 == "1/2") { cr = 0.50; }
			else { cr = $2 + 0; }
			printf "sm[%d].f_challengeRating = %.2f;\n", monCnt, cr;
			break;
		case "cr.xp":
		case "cr.xpLair":
			gsub("\"", "", $2);
			xp = sprintf("XP:%s", $2); addnote(xp);
			break;
		case "damageTags.0":
		case "damageTags.1":
		case "damageTags.2":
		case "damageTags.3":
		case "damageTags.4":
		case "damageTags.5":
			break;
		case "damageTagsSpell.0":
		case "damageTagsSpell.1":
		case "damageTagsSpell.2":
		case "damageTagsSpell.3":
		case "damageTagsSpell.4":
			break;
		case "dex":
			printf "sm[%d].i_abilityStats[0][ABILITY_DEX] = %d;\n", monCnt, $2;
			printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, stattobonus($2);
			printf "sm[%d].i_initiative[0] = %d;\n", monCnt, init_bonus + stattobonus($2);
			break;
		case "dragonAge":
			break;
		case "environment.0":
		case "environment.1":
		case "environment.2":
		case "environment.3":
		case "environment.4":
		case "environment.5":
		case "environment.6":
		case "environment.7":
		case "environment.8":
			break;
		case "gear.0":
		case "gear.1":
		case "gear.2":
		case "gear.3":
			gsub("\"", "", $2); gsub(".xphb", "", $2);
			ge = sprintf("Gear: %s", $2); addnote(ge);
			break;
		case "gear.0.item":
			break;
		case "gear.0.quantity":
			break;
		case "gear.1.item":
			break;
		case "gear.1.quantity":
			break;
		case "group.0":
			break;
		case "hasFluff":
			break;
		case "hasFluffImages":
			break;
		case "hasToken":
			break;
		case "hp.special":
			gsub("\"", "", $2);
			hps = sprintf("HP Special: %s", $2); addnote(hps);
			split($2, stng, " "); stng[1] += 0;
			printf "sm[%d].i_hp[HP_MAX] = %d;\n", monCnt, stng[1];
			printf "sm[%d].i_hp[HP_CUR] = %d;\n", monCnt, stng[1];
			break;
		case "hp.average":
			printf "sm[%d].i_hp[HP_MAX] = %d;\n", monCnt, $2;
			printf "sm[%d].i_hp[HP_CUR] = %d;\n", monCnt, $2;
			break;
		case "hp.formula":
			gsub(" ", "", $2);
			printf "strcpy(sm[%d].c_hitDice, %s);\n", monCnt, $2;
			break;
		case "immune.0":
		case "immune.1":
		case "immune.2":
		case "immune.3":
		case "immune.4":
		case "immune.5":
			gsub("\"", "", $2);
			ci = sprintf("Immune:%s", $2);
			addnote(ci);
			break;
		case "initiative.proficiency":
			init_bonus = $2;
			break;
		case "int":
			printf "sm[%d].i_abilityStats[0][ABILITY_INT] = %d;\n", monCnt, $2;
			printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, stattobonus($2);
			break;
		case "languages.0":
		case "languages.1":
		case "languages.2":
		case "languages.3":
			gsub("\"", "", $2);
			la = sprintf("Languages: %s", $2);
			addnote(la);
			break;
		case "languageTags.0":
		case "languageTags.1":
		case "languageTags.2":
		case "languageTags.3":
		case "languageTags.4":
		case "languageTags.5":
			break;
		case "legendary.0.name":
		case "legendary.1.name":
		case "legendary.2.name":
			gsub("\"", "", $2);
			la = sprintf("Legendary Action: %s", $2);
			addnote(la);
			break;
		case "legendary.0.entries.0":
		case "legendary.1.entries.0":
		case "legendary.2.entries.0":
			gsub("\"", "", $2); gsub(".XPHB", "", $2); gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell", "", $2); gsub(".XPHB", "", $2);
			gsub("{@condition ", "", $2); gsub("{@dice ", "", $2); gsub("{@variantrule ", "", $2);
			addnote($2);
			break;
		case "legendaryActionsLair":
			gsub("\"", "", $2);
			la = sprintf("Legendary Actions in Lair: %s", $2);
			addnote(la);
			break;
		case "legendaryGroup.name":
			break;
		case "legendaryGroup.source":
			break;
		case "miscTags.0":
		case "miscTags.1":
		case "miscTags.2":
		case "miscTags.3":
		case "miscTags.4":
			break;
		case "name":
			monWeapCnt = -1; donote = 0; speed = "";
			init_bonus = 0;
			gsub("^ ", "", $2); gsub("\"", "", $2);
			monCnt = nameSort[$2] - 1; 
			if (monCnt == -1) { 
				monCnt=badMon++; 
				printf "\/\/ Error: nameSort = :%s:%d\n", $2, nameSort[$2];
			}
			printf "\nstrncpy(sm[%d].c_name, \"%s\", 30);\n", monCnt, $2;
			monName = $2;
			printf "sm[%d].i_bleeding = 0;\n", monCnt;
			printf "sm[%d].i_disabledAt = 0;\n", monCnt;
			printf "sm[%d].i_unconciousAt = -1;\n", monCnt;
			printf "sm[%d].i_inactive = 0;\n", monCnt;
			printf "sm[%d].i_stun = 0;\n", monCnt;
			printf "sm[%d].i_noAttacks = 1;\n", monCnt;
			printf "sm[%d].flags.f_isStabilised = 0;\n", monCnt;
			printf "sm[%d].flags.f_disabled = 0;\n", monCnt;
			printf "sm[%d].flags.f_ignoreCriticals = 0;\n", monCnt;
			printf "sm[%d].flags.f_autoStablise = 0;\n", monCnt;
			printf "sm[%d].flags.f_evasion = 0;\n", monCnt;
			printf "sm[%d].flags.f_srdMonster = 1;\n", monCnt;
			printf "sm[%d].i_monsterType = 0;\n", monCnt;
			printf "sm[%d].i_hp[HP_CUR] = sm[%d].i_hp[HP_MAX] = 1;\n", monCnt, monCnt;
			break;
		case "otherSources.0.page":
			break;
		case "otherSources.0.source":
			break;
		case "otherSources.1.source":
			break;
		case "page":
			break;
		case "passive":
			printf "sm[%d].i_skills[SKILL_CONCENTRATION] = %d;\n", monCnt, $2;
			break;
		case "resist.0.resist.0":
		case "resist.0.resist.1":
		case "resist.0.resist.2":
		case "resist.0.resist.3":
		case "resist.1.resist.0":
		case "resist.1.resist.1":
		case "resist.1.resist.2":
		case "resist.2.resist.0":
		case "resist.2.resist.1":
		case "resist.2.resist.2":
		case "resist.3.resist.0":
		case "resist.3.resist.1":
		case "resist.3.resist.2":
		case "resist.4.resist.0":
		case "resist.4.resist.1":
		case "resist.4.resist.2":
		case "resist.5.resist.0":
		case "resist.5.resist.1":
		case "resist.5.resist.2":
		case "resist.0.note":
		case "resist.1.note":
		case "resist.2.note":
		case "resist.3.note":
		case "resist.4.note":
		case "resist.5.note":
			gsub("\"", "", $2);
			res = sprintf("Resistant: %s", $2); addnote(res);
			break;
		case "reaction.0.entries.0":
			gsub("\"", "", $2); gsub(".XPHB", "", $2); gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell", "", $2); gsub(".XPHB", "", $2);
			gsub("{@actTrigger ", "", $2); gsub("{@actResponse ", "", $2);
			addnote($2);
			break;
		case "reaction.0.name":
			gsub("\"", "", $2); gsub(".XPHB", "", $2); gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell", "", $2); gsub(".XPHB", "", $2);
			addnote($2);
			break;
		case "resist.0.special":
			break;
		case "resist.0":
		case "resist.1":
		case "resist.2":
		case "resist.3":
		case "resist.4":
		case "resist.5":
		case "resist.6":
		case "resist.7":
			gsub("\"", "", $2); ri = sprintf("Resistant: %s", $2); addnote(ri);
			break;
		case "save.cha":
			gsub("\"", "", $2);
			printf "sm[%d].i_savingThrows[SAVE_CHA] = %d;\n", monCnt, $2;
			break;
		case "save.con":
			gsub("\"", "", $2);
			printf "sm[%d].i_savingThrows[SAVE_CON] = %d;\n", monCnt, $2;
			break;
		case "save.dex":
			gsub("\"", "", $2);
			printf "sm[%d].i_savingThrows[SAVE_DEX] = %d;\n", monCnt, $2;
			break;
		case "save.int":
			gsub("\"", "", $2);
			printf "sm[%d].i_savingThrows[SAVE_INT] = %d;\n", monCnt, $2;
			break;
		case "save.str":
			gsub("\"", "", $2);
			printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, $2;
			break;
		case "save.wis":
			gsub("\"", "", $2);
			printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, $2;
			break;
		case "savingThrowForced.0":
			break;
		case "savingThrowForcedSpell.0":
		case "savingThrowForcedSpell.1":
		case "savingThrowForcedSpell.2":
			break;
		case "senses.0":
		case "senses.1":
			gsub("\"", "", $2);
			addnote($2);
			break;
		case "senseTags.0":
		case "senseTags.1":
			break;
		case "size.0":
		case "size.1":
			gsub("\"", "", $2); gsub(" ", "", $2);
			if ($2 == "G") { printf "sm[%d].i_space = 40;\n", monCnt; printf "sm[%d].i_size = 6;\n", monCnt; }
			else if ($2 == "H") { printf "sm[%d].i_space = 20;\n", monCnt; printf "sm[%d].i_size = 4;\n", monCnt; }
			else if ($2 == "L") { printf "sm[%d].i_space = 10;\n", monCnt; printf "sm[%d].i_size = 3;\n", monCnt; }
			else if ($2 == "M") { printf "sm[%d].i_space = 5;\n", monCnt; printf "sm[%d].i_size = 2;\n", monCnt; }
			else if ($2 == "S") { printf "sm[%d].i_space = 5;\n", monCnt; printf "sm[%d].i_size = 1;\n", monCnt; }
			else if ($2 == "T") { printf "sm[%d].i_space = 5;\n", monCnt; printf "sm[%d].i_size = 0;\n", monCnt; }
			else { printf "sm[%d].i_space = 5;  \/\/ :%s:\n", monCnt, $2; printf "sm[%d].i_size = 0;\n", monCnt; }
			break;
		case "skill.acrobatics":
		case "skill.arcana":
		case "skill.athletics":
		case "skill.deception":
		case "skill.history":
		case "skill.insight":
		case "skill.investigation":
		case "skill.medicine":
		case "skill.nature":
		case "skill.performance":
		case "skill.persuasion":
		case "skill.religion":
		case "skill.survival":
			gsub("\"","", $0);
			addnote($0);
			break;
		case "skill.perception":
			gsub("\"","", $2);
			printf "sm[%d].i_skills[SKILL_SPOT] = %d;\n", monCnt, $2;
			break;
		case "skill.sleight of hand":
			gsub("\"","", $2);
			printf "sm[%d].i_skills[SKILL_SOH] = %d;\n", monCnt, $2;
			break;
		case "skill.stealth":
			gsub("\"","", $2);
			printf "sm[%d].i_skills[SKILL_MOVESILENTLY] = %d;\n", monCnt, $2;
			break;
		case "soundClip.path":
			break;
		case "soundClip.type":
			break;
		case "source":
			break;
		case "speed.canHover":
			break;
		case "speed.choose.amount":
			break;
		case "speed.choose.from.0":
			break;
		case "speed.choose.from.1":
			break;
		case "speed.choose.note":
			break;
		case "speed.burrow":
		case "speed.climb":
		case "speed.fly":
		case "speed.swim":
			if (length(speed) > 0) {
				addnote($0);
			} else {
				printf "sm[%d].i_speed = %d;\n", monCnt, $2;
			}
			break;
		case "speed.climb.condition":
			break;
		case "speed.climb.number":
			break;
		case "speed.fly.condition":
			break;
		case "speed.fly.number":
			break;
		case "speed.walk":
			printf "sm[%d].i_speed = %d;\n", monCnt, $2;
			speed = $2;
			break;
		case "speed.walk.condition":
			break;
		case "speed.walk.number":
			break;
		case "spellcasting.0.ability":
			break;
		case "spellcasting.0.daily.1.0":
		case "spellcasting.0.daily.1e.0":
		case "spellcasting.0.daily.1e.1":
		case "spellcasting.0.daily.1e.2":
		case "spellcasting.0.daily.1e.3":
		case "spellcasting.0.daily.1e.4":
		case "spellcasting.0.daily.1e.5":
		case "spellcasting.0.daily.1e.6":
		case "spellcasting.0.daily.2.0":
		case "spellcasting.0.daily.2e.0":
		case "spellcasting.0.daily.2e.1":
		case "spellcasting.0.daily.2e.2":
		case "spellcasting.0.daily.2e.3":
		case "spellcasting.0.daily.3.0":
			gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell ", "", $2); gsub(".XPHB", "", $2);
			str = sprintf("Daily:%s", $2);
			addnote(str);
			break;
		case "spellcasting.0.displayAs":
			break;
		case "spellcasting.0.headerEntries.0":
		case "spellcasting.1.headerEntries.0":
			sdc = index($2, "{@dc");
			if (sdc > 0) {
				spdc = substr($2, sdc+4, 4);
				gsub(" ", "", spdc); gsub("[a-z]", "", spdc); gsub(")", "", spdc);
				printf "sm[%d].i_spellDC[0] = %s;\n", monCnt, spdc;
			}
			gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell", "", $2); gsub(".XPHB", "", $2);
			addnote($2);
			break;
		case "spellcasting.0.hidden.0":
			break;
		case "spellcasting.0.legendary.1.0":
			break;
		case "spellcasting.0.name":
		case "spellcasting.1.name":
		case "spellcasting.2.name":
		case "spellcasting.3.name":
			gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell", "", $2); gsub(".XPHB", "", $2);
			addnote($2);
			break;
		case "spellcasting.0.recharge.4.0":
		case "spellcasting.0.recharge.4.1":
		case "spellcasting.0.recharge.4.2":
		case "spellcasting.0.recharge.5.0":
		case "spellcasting.0.recharge.5.1":
		case "spellcasting.0.recharge.5.2":
		case "spellcasting.0.recharge.6.0":
			break;
		case "spellcasting.0.restLong.1.0":
		case "spellcasting.0.restLong.1.1":
		case "spellcasting.0.restLong.1.2":
		case "spellcasting.0.restLong.1.3":
		case "spellcasting.0.restLong.1.4":
		case "spellcasting.0.restLong.1.5":
			break;
		case "spellcasting.0.type":
			break;
		case "spellcasting.0.will.0":
		case "spellcasting.0.will.1":
		case "spellcasting.0.will.2":
		case "spellcasting.0.will.3":
		case "spellcasting.0.will.4":
		case "spellcasting.0.will.5":
		case "spellcasting.0.will.6":
		case "spellcasting.0.will.7":
		case "spellcasting.1.will.0":
		case "spellcasting.1.will.1":
		case "spellcasting.1.will.2":
		case "spellcasting.1.will.3":
		case "spellcasting.1.will.4":
		case "spellcasting.2.will.0":
			gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell ", "", $2); gsub(".XPHB", "", $2);
			str = sprintf("At will:%s", $2);
			addnote(str);
			break;
		case "spellcasting.1.ability":
			break;
		case "spellcasting.1.daily.1.0":
		case "spellcasting.1.daily.1.1":
		case "spellcasting.1.daily.1.2":
		case "spellcasting.1.daily.2.0":
		case "spellcasting.1.daily.2.1":
		case "spellcasting.1.daily.2.2":
		case "spellcasting.1.daily.2.3":
		case "spellcasting.1.daily.2e.0":
		case "spellcasting.1.daily.2e.1":
		case "spellcasting.1.daily.2e.2":
		case "spellcasting.1.daily.3.0":
		case "spellcasting.1.daily.3.1":
		case "spellcasting.1.daily.3.2":
		case "spellcasting.1.daily.3.3":
			gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell ", "", $2); gsub(".XPHB", "", $2);
			str = sprintf("Daily:%s", $2);
			addnote(str);
			break;
		case "spellcasting.1.displayAs":
			break;
		case "spellcasting.1.hidden.0":
			break;
		case "spellcasting.1.legendary.1.0":
			break;
		case "spellcasting.1.recharge.4.0":
		case "spellcasting.1.recharge.4.1":
		case "spellcasting.1.recharge.4.2":
		case "spellcasting.1.recharge.4.3":
		case "spellcasting.1.recharge.5.0":
		case "spellcasting.1.recharge.5.1":
		case "spellcasting.1.recharge.5.2":
			break;
		case "spellcasting.1.type":
			break;
		case "spellcasting.2.ability":
			break;
		case "spellcasting.2.daily.1.0":
		case "spellcasting.2.daily.1.1":
		case "spellcasting.2.daily.1.2":
		case "spellcasting.2.daily.2.0":
		case "spellcasting.2.daily.2.1":
		case "spellcasting.2.daily.3.0":
		case "spellcasting.2.daily.3.1":
			gsub("{@dc", "DC:", $2); gsub("}", "", $2); gsub("\"", "", $2); gsub("{@spell ", "", $2); gsub(".XPHB", "", $2);
			str = sprintf("Daily:%s", $2);
			addnote(str);
			break;
		case "spellcasting.2.displayAs":
			break;
		case "spellcasting.2.headerEntries.0":
			break;
		case "spellcasting.2.headerEntries.1":
			break;
		case "spellcasting.2.hidden.0":
			break;
		case "spellcasting.2.legendary.1.0":
			break;
		case "spellcasting.2.type":
			break;
		case "spellcastingTags.0":
			break;
		case "str":
			printf "sm[%d].i_abilityStats[0][ABILITY_STR] = %d;\n", monCnt, $2;
			printf "sm[%d].i_savingThrows[SAVE_STR] = %d;\n", monCnt, stattobonus($2);
			break;
		case "token.name":
			break;
		case "token.source":
			break;
		case "trait.0.name":
		case "trait.1.name":
		case "trait.2.name":
		case "trait.3.name":
		case "trait.4.name":
		case "trait.5.name":
		case "trait.6.name":
		case "trait.7.name":
		case "trait.8.name":
		case "trait.9.name":
			gsub("\"", "", $2); addnote($2);
			break;
		case "trait.0.entries.0":
		case "trait.0.entries.1":
		case "trait.0.entries.2":
		case "trait.1.entries.0":
		case "trait.1.entries.1":
		case "trait.1.entries.2":
		case "trait.2.entries.0":
		case "trait.2.entries.1":
		case "trait.2.entries.2":
		case "trait.3.entries.0":
		case "trait.3.entries.1":
		case "trait.3.entries.2":
		case "trait.4.entries.0":
		case "trait.4.entries.1":
		case "trait.4.entries.2":
		case "trait.5.entries.0":
		case "trait.5.entries.1":
		case "trait.5.entries.2":
		case "trait.6.entries.0":
		case "trait.6.entries.1":
		case "trait.6.entries.2":
		case "trait.7.entries.0":
		case "trait.7.entries.1":
		case "trait.7.entries.2":
		case "trait.8.entries.0":
		case "trait.8.entries.1":
		case "trait.8.entries.2":
		case "trait.9.entries.0":
		case "trait.9.entries.1":
		case "trait.9.entries.2":
			regen = index($2, "regains");
			if (regen > 0) {
				regen = substr($2, regen+8, 3);
				gsub(" ", "", regen); gsub("[a-z]", "", regen);
				printf "sm[%d].i_regeneration = %d;\n", monCnt, regen;
			}
			gsub("\"", "", $2); addnote($2);
			break;
		case "trait.1.entries.1.items.0.entries.0":
			break;
		case "trait.1.entries.1.items.0.entry":
			break;
		case "trait.1.entries.1.items.0.name":
			break;
		case "trait.1.entries.1.items.0.type":
			break;
		case "trait.1.entries.1.items.1.entries.0":
			break;
		case "trait.1.entries.1.items.1.entry":
			break;
		case "trait.1.entries.1.items.1.name":
			break;
		case "trait.1.entries.1.items.1.type":
			break;
		case "trait.1.entries.1.items.2.entries.0":
			break;
		case "trait.1.entries.1.items.2.entry":
			break;
		case "trait.1.entries.1.items.2.name":
			break;
		case "trait.1.entries.1.items.2.type":
			break;
		case "trait.1.entries.1.items.3.entries.0":
			break;
		case "trait.1.entries.1.items.3.name":
			break;
		case "trait.1.entries.1.items.3.type":
			break;
		case "trait.1.entries.1.style":
			break;
		case "trait.1.entries.1.type":
			break;
		case "trait.2.entries.1.items.0.entries.0":
			break;
		case "trait.2.entries.1.items.0.name":
			break;
		case "trait.2.entries.1.items.0.type":
			break;
		case "trait.2.entries.1.items.1.entries.0":
			break;
		case "trait.2.entries.1.items.1.name":
			break;
		case "trait.2.entries.1.items.1.type":
			break;
		case "trait.2.entries.1.items.2.entries.0":
			break;
		case "trait.2.entries.1.items.2.name":
			break;
		case "trait.2.entries.1.items.2.type":
			break;
		case "trait.2.entries.1.items.3.entries.0":
			break;
		case "trait.2.entries.1.items.3.name":
			break;
		case "trait.2.entries.1.items.3.type":
			break;
		case "trait.2.entries.1.style":
			break;
		case "trait.2.entries.1.type":
			break;
		case "trait.3.entries.1.items.0.entries.0":
			break;
		case "trait.3.entries.1.items.0.name":
			break;
		case "trait.3.entries.1.items.0.type":
			break;
		case "trait.3.entries.1.items.1.entries.0":
			break;
		case "trait.3.entries.1.items.1.name":
			break;
		case "trait.3.entries.1.items.1.type":
			break;
		case "trait.3.entries.1.items.2.entries.0":
			break;
		case "trait.3.entries.1.items.2.name":
			break;
		case "trait.3.entries.1.items.2.type":
			break;
		case "trait.3.entries.1.items.3.entries.0":
			break;
		case "trait.3.entries.1.items.3.name":
			break;
		case "trait.3.entries.1.items.3.type":
			break;
		case "trait.3.entries.1.style":
			break;
		case "trait.3.entries.1.type":
			break;
		case "traitTags.0":
			break;
		case "traitTags.1":
			break;
		case "traitTags.2":
			break;
		case "traitTags.3":
			break;
		case "treasure.0":
			break;
		case "treasure.1":
			break;
		case "type":
			break;
		case "type.note":
			break;
		case "type.swarmSize":
			break;
		case "type.tags.0":
			break;
		case "type.type":
			break;
		case "type.type.choose.0":
			break;
		case "type.type.choose.1":
			break;
		case "vulnerable.0":
		case "vulnerable.1":
		case "vulnerable.0.vulnerable.0":
		case "vulnerable.0.vulnerable.1":
		case "vulnerable.0.vulnerable.2":
		case "vulnerable.1.vulnerable.0":
		case "vulnerable.1.vulnerable.1":
		case "vulnerable.1.vulnerable.2":
			gsub("\"", "", $2); va = sprintf("Vulnerable:%s", $2); addnote(va);
			break;
		case "vulnerable.0.note":
		case "vulnerable.1.note":
			gsub("\"", "", $2); addnote($2);
			break;
		case "vulnerable.0.cond":
			break;
		case "wis":
			printf "sm[%d].i_abilityStats[0][ABILITY_WIS] = %d;\n", monCnt, $2;
			printf "sm[%d].i_savingThrows[SAVE_WIS] = %d;\n", monCnt, stattobonus($2);
			break;
		case "_copy._mod.trait.items.1.entries.1.items.0":
		case "_copy._mod.trait.items.1.entries.1.items.1":
		case "_copy._mod.trait.items.1.entries.1.items.2":
		case "_copy._mod.trait.items.1.entries.1.items.3":
		case "_copy._mod.trait.items.1.entries.1.items.4":
			gsub("\"", "", $2); addnote($2);
			break;
		case "_copy.name":
			gsub("^ ", "", $2); gsub("\"", "", $2);
			idx = nameSort[$2] - 1;
			if (idx != -1) {
				printf "copyDetails(%d, %d); \/\/ %s - %s\n", monCnt, nameSort[$2] - 1, monName, $2 >> "/tmp/copyDetails.txt";
			} else {
				printf "\/\/ Unknown %s - %d\n", $0, monCnt;
			}
			break;
		case "srd":
			printf "\/\/ SRD Monster %s - %d\n", $0, monCnt;
			printf "sm[%d].i_monsterType = 1;\n", monCnt;
			break;
		case "srd52":
			printf "\/\/ SRD 52 Monster %s - %d\n", $0, monCnt;
			printf "sm[%d].i_monsterType = 2;\n", monCnt;
			break;
		default:
#			printf "// unknown token %s\n", $0;
			break;
	}
}

END {
	printf "// final monCnt is %d\n", monCnt;
}
