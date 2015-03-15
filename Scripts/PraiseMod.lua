--- @author Mercor

include("Scripts/Core/Common.lua")

-------------------------------------------------------------------------------
if PraiseMod == nil then
	PraiseMod = EternusEngine.ModScriptClass.Subclass("PraiseMod")
end

-------------------------------------------------------------------------------
-- Create namespace for the mod
if EternusEngine.mods == nil then
  EternusEngine.mods = {}
end

if EternusEngine.mods.Praise == nil then
  EternusEngine.mods.Praise = {}
end


-------------------------------------------------------------------------------
-- This is called on .new()
function PraiseMod:Constructor()

end

-------------------------------------------------------------------------------
-- Called once from C++ at engine initialization time
function PraiseMod:Initialize()

  self.options = {}
  self.options.useDebug = false

  self:ExtractCredits()

end

-------------------------------------------------------------------------------
-- Called from C++ when the current game enters (on game start: when 100% of world loaded)
function PraiseMod:Enter()

end

-------------------------------------------------------------------------------
-- Called from C++ when the game leaves it current mode
function PraiseMod:Leave()

end


-------------------------------------------------------------------------------
-- Called from C++ every update tick
function PraiseMod:Process(dt)

end


function PraiseMod:loadConfing()

end

-------------------------------------------------------------------------------
-- Read through mods.txt, and extract credits from all mods listed in it, if they have CREDITS.txt.
-- Based on JohnyCilohokla's code in CommonLib mod for TUG
function PraiseMod:ExtractCredits()

	self:Debug("Extracting credits from mods\n")
	local mods = {}

	local file = io.open("Config/mods.txt", "r")
	if file then
		for line in file:lines() do
			line = line:gsub("%s+", "") -- remove whitespace
			if (strStartsWith(line,"\"") and strEndsWith(line,"\"")) then -- if line starts and ends with "", a.k.a is a mod path
				local modPath = string.sub(line,2,-2)
				self:Debug("Loading "..modPath.."\n")

        local mod = {}
        local nFields = 0

        local manifestFile=io.open(modPath.."/Manifest.txt","r") -- load manifest.txt
				if manifestFile~=nil then
					self:Debug("Found Manifest for  "..modPath.."\n")

          local majorVersion = nil
          local minorVersion = nil
          local patchVersion = nil

					for manifestLine in manifestFile:lines() do
						manifestLine = manifestLine:gsub("%s+", "") -- remove whitespace
						if (strStartsWith(manifestLine,"Name=\"") and strEndsWith(manifestLine,"\"")) then
							mod.name = string.sub(manifestLine, 7, -2)
							self:Debug("Name="..manifestLine.."\n")
              nFields = nFields + 1
            elseif (strStartsWith(manifestLine,"Description=\"") and strEndsWith(manifestLine,"\"")) then
							mod.description = string.sub(manifestLine, 14, -2)
							self:Debug("Description="..manifestLine.."\n")
              nFields = nFields + 1
            elseif (strStartsWith(manifestLine,"MajorVersion=\"") and strEndsWith(manifestLine,"\"")) then
							mod.majorVersion = string.sub(manifestLine, 14, -1)
							self:Debug("MajorVersion="..manifestLine.."\n")
              nFields = nFields + 1
            elseif (strStartsWith(manifestLine,"MinorVersion=\"") and strEndsWith(manifestLine,"\"")) then
							mod.minorVersion = string.sub(manifestLine, 14, -1)
							self:Debug("MinorVersion="..manifestLine.."\n")
              nFields = nFields + 1
            elseif (strStartsWith(manifestLine,"PatchVersion=\"") and strEndsWith(manifestLine,"\"")) then -- doesn't exist, but it should
							mod.patchVersion = string.sub(manifestLine, 14, -1)
							self:Debug("PatchVersion="..manifestLine.."\n")
              nFields = nFields + 1
        		elseif (strStartsWith(manifestLine,"ScriptFile=\"") and strEndsWith(manifestLine,"\"")) then
							mod.scriptFile = string.sub(manifestLine, 13, -2)
							self:Debug("ScriptFile="..manifestLine.."\n")
              nFields = nFields + 1
						elseif (strStartsWith(manifestLine,"ScriptClass=\"") and strEndsWith(manifestLine,"\"")) then
							mod.scriptClass = string.sub(manifestLine, 14, -2)
							self:Debug("ScriptClass="..manifestLine.."\n")
              nFields = nFields + 1
						end
					end

          majorVersion = mod.majorVersion and mod.majorVersion or "0"
          minorVersion = mod.minorVersion and mod.minorVersion or "0"
          patchVersion = mod.patchVersion and mod.patchVersion or "0"

          mod.version = majorVersion .. "." .. minorVersion .. "." .. patchVersion

				end
        manifestFile:close()

        local creditFile = io.open(modPath.."/CREDITS.txt", "r")
        if creditFile~=nil then
          self:Debug("Found CREDITS.txt for "..modPath.."\n")
          creditString = creditFile:read("*a")
          creditFile:close()

          tempFile = io.open("Mods/Praise/praise_temporary_file.txt", "w")
          tempFile:write(creditString)
          tempFile:close()

          local credits = NKParseFile("praise_temporary_file.txt")
          if (credits~=nil) then
            self:Debug("Reading CREDITS.txt with NKParseFile\n")
            self:Debug("Syntax: "..(credits["PraiseSyntax"] and credits["PraiseSyntax"] or "not found").."\n")
            if (credits["PraiseSyntax"] == "0.0.1") then
              self:Debug("Credits syntax version 0.0.1\n")
              mod.tinyCredits = credits["TinyCredits"] and string.sub(credits["TinyCredits"], 1, 140) or nil
              mod.shortCredits = credits["ShortCredits"] and string.sub(credits["ShortCredits"], 1, 500) or nil
              mod.longCredits = credits["LongCredits"] and string.sub(credits["LongCredits"], 1, 1000) or nil
              mod.fullCredits = credits["FullCredits"] and credits["FullCredits"] or nil
            end
          end
        end

        if (mod.name~=nil) and (mod.scriptFile~=nil) and (mod.scriptClass~=nil) then
          table.insert(mods, mod)
        end

       self:Debug("TinyCredits: " .. (mod.tinyCredits and mod.tinyCredits or "not found") .. "\n")
       self:Debug("ShortCredits: " .. (mod.shortCredits and mod.shortCredits or "not found") .. "\n")
       self:Debug("LongCredits: " .. (mod.longCredits and mod.longCredits or "not found") .. "\n")
       self:Debug("FullCredits: " .. (mod.fullCredits and mod.fullCredits or "not found") .. "\n")
			end
		end
		io.close(file)

    local tempFile = io.open("Mods/Praise/praise_temporary_file.txt", "w")
    tempFile:write("Praise temp file.")
    tempFile:close()
	else
		self:Debug("Couldn't load Config/mods.txt")
	end

  EternusEngine.mods.Praise.mods = mods
end

-------------------------------------------------------------------------------
-- Uses NKPrint to print the message given as param
function PraiseMod:Debug(msg)
	if self.options.useDebug then
    NKPrint(msg)
	end
end

EntityFramework:RegisterModScript(PraiseMod)
