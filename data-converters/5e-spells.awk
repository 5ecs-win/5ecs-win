BEGIN {
	FS=":";
	spellFile = "";
	spt[1] =	2; spt[2] =	3; spt[3] =	5; spt[4] =	6; spt[5] =	7; spt[6] =	9; spt[7] =	10; spt[8] =	11; spt[9] =	13;
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
			printf "<strong>Concentration Required</strong>\n" >> spellFile;
			break;
		case "duration.0.duration.amount":
		case "duration.1.duration.amount":
			gsub("\"", "", $2);
			printf "<strong>Duration:</strong> %s %s</p>\n", $2, dtype >> spellFile;
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
			if (length(components) > 0) {
				printf "<strong>Components:</strong>%s", components >> spellFile;
				if (length(compm) > 0) {
					printf " (%s)", compm >> spellFile;
				}
				printf "<br />\n" >> spellFile;
				components = compm = "";
			}
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
			printf "<p><strong>Level:</strong> %s (SpellPts: %d)<br />\n", $2, spt[$2] >> spellFile;
			break;
		case "meta.ritual":
			break;
		case "miscTags.0":
		case "miscTags.1":
		case "miscTags.2":
		case "miscTags.3":
		case "miscTags.4":
			break;
		case "name":
			if (length(spellFile) > 0) { close(spellFile); }
			gsub("/", " or ", $2);
			gsub("\"", "", $2); gsub("^ ", "", $2); spellName = $2;
			gsub(" ", "_", $2); gsub("^_", "", $2); gsub("'", "", $2);
			spellFile = sprintf("/tmp/sdc/%s.html", tolower($2));
			#printf "<div class=\"content-separator\" style=\"display: none:\"></div>\n" > spellFile;
			printf "<strong><bold><center>%s</strong></bold></center>\n", spellName > spellFile;
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
			printf "<br /><strong>Source:</strong> %s pg %s<br />\n", source, $2 >> spellFile;
			break;
		case "range.distance.amount":
			printf "<strong>Range:</strong> %s %s<br />\n", $2, rtype >> spellFile;
			break;
		case "range.distance.type":
			gsub("\"", "", $2); gsub(" ", "", $2);
			rtype = $2;
			if (rtype == "self") {
				printf "<strong>Range:</strong> %s<br />\n", rtype >> spellFile;
			}
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
			printf "%s<br .>\n", $2 >> spellFile;
			break;
		case "time.0.note":
			break;
		case "time.0.number":
			ctime = $2;
			break;
		case "time.0.unit":
			gsub("\"", "", $2);
			printf "<p><strong>Casting Time:</strong> %s %s<br />\n", ctime, $2 >> spellFile;
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
			printf "<p><br />%s<br />\n", $2 >> spellFile;
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
			printf "<p><strong><em>At Higher Levels.</em></strong> %s<br />\n", $2 >> spellFile;
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
