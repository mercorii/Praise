# Praise Mod

Praise extracts credits data from mods, and helps give credit to mod makers.

It expects credits to be available in a file named CREDITS.txt at the root of the mod folder. In addition to this, it also makes available the mod's information from its manifest.txt file.

In addition to the official manifest.txt variables TUG supports, Praise also supports a third version parameter called PatchVersion.

### How to show the credits in-game

Praise doesn't show any data in-game.

You need another mod to show the information provided by Praise. Praise only extracts the information from CREDITS.txt.

### How to use:

```
for mod in EternusEngine.mods.Praise.mods do
  -- Mod name from manifest.txt
  mod.name

  -- Description from manifest.txt
  mod.description

  -- MajorVersion from manifest.txt. The first number in version: MAJOR.y.z
  mod.majorVersion

  -- MinorVersion from manifest.txt. The second number in version: x.MINOR.z
  mod.minorVersion

  -- PatchVersion from manifest.txt. The third number in version: x.y.PATCH
  mod.patchVersion

  -- Full version number as string. Format: "MajorVersion.MinorVersion.PatchVersion"
  mod.version

  -- Tiny version of credits
  mod.tinyCredits

  -- Short version of credits
  mod.shortCredits

  -- Long version of credits
  mod.longCredits
end
```

### CREDITS.txt syntax (syntax version 0.0.1)

`PraiseSyntax`

Version number describing the syntax you are using in your credits.

`TinyCredits`

Shortest form of credits (tweet size, max. 140 chars). Different to other formats, as tiny credits is expected to contain mod's name in it. Expected to be used when there are lots of mods installed, but only little space or time to show credits.

`ShortCredits`

Short credits. Max 500 chars. Code using this field is expected to get the mod name from the name property (extracted from manifest.txt).

`LongCredits`

Longer credits. Max 1000 chars. Code using this field is expected to get the mod name from the name property (extracted from manifest.txt).

`FullCredits`

Longest form of credits. No character limits. Thank everyone you need to. This is the place for all the moose credits.

#### Example CREDITS.txt

```
Credits
{
  PraiseSyntax = "0.0.1"

  TinyCredits = "Tiny credits. Maximum length of 140 characters. Mod name should be included."

  ShortCredits = "Short credits. Maximum length of 500 characters. Mod name not included."

  LongCredits = "Long credits. Maximum length of 1000 characters. Mod name not included."

  FullCredits = "Extra long credits. No character limit. Mod name not included in the beginning."
}
```

#### How to install

  1. Download the zip from the right -->
  2. Extract the contents of the zip to folder TUG/Mods/Praise
  3. Add line "Mods/Praise" to Config/mods.txt
  4. Install mod that shows the information provided by Praise

#### Known issues

  * All spaces in names and descriptions are dropped.
  * No mod to actually show the information extracted by Praise. There will soon™ be a mod to that.
