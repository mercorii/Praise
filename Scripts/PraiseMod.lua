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
-- Include mod files
--include("Scripts/PraiseMain.lua")
--include("Scripts/UI/PraiseConsoleUI.lua")
--include("Scripts/UI/PraiseCompass.lua")

-------------------------------------------------------------------------------
-- This is called on .new()
function PraiseMod:Constructor(  )

  self:ExtractCredits()

--	self:loadConfing()

--	if EternusEngine.mods.Praise.Mod == nil then
--		EternusEngine.mods.Praise.Mod = self
--	end

--	if EternusEngine.mods.Praise.Main == nil then
--	  EternusEngine.mods.Praise.Main = PraiseMain.new()
--	end

--	if EternusEngine.mods.Praise.ConsoleUI == nil then
--	  EternusEngine.mods.Praise.ConsoleUI = PraiseConsoleUI.new()
--	end

	-- Load CEGUI scheme
--	if self.options.useCompass then
--		CEGUI.SchemeManager:getSingleton():createFromFile("Praise.scheme")
--	end
end

-------------------------------------------------------------------------------
-- Called once from C++ at engine initialization time
function PraiseMod:Initialize()

--	self:Debug("PraiseMod:Initialize was just called.....\n")

--  EternusEngine.mods.Praise.Main:Initialize()

--  if self.useConsole and EternusEngine.mods.Praise.ConsoleUI then
--    EternusEngine.mods.Praise.ConsoleUI:Initialize()
--  end

	-- use ui
--	if self.options.useCompass then
--		self.m_compassVisible = true
--		self.m_PraiseCompassView = PraiseCompass.new("PraiseCompassLayout.layout")
--		EternusEngine.mods.Praise.CompassUI = self.m_PraiseCompassView
--	end

--	if self.useConsole and EternusEngine.mods.Praise.ConsoleUI then
--		EternusEngine.mods.Praise.ConsoleUI:SetupInputSystem()
--	end

--	if self.options.toggleCompassWithKey and self.options.toggleCompassKey then
--		self:Debug("\nRegisterning key for toggling on/off compass (show/hide): " .. self.options.toggleCompassKey .. "\n")
--		Eternus.World:NKGetKeybinds():NKRegisterDirectCommand(self.options.toggleCompassKey, self, "ToggleCompass", KEY_ONCE)
--	end
end

-------------------------------------------------------------------------------
-- Called from C++ when the current game enters (on game start: when 100% of world loaded)
function PraiseMod:Enter()

--  EternusEngine.mods.Praise.Main:Enter()

--  if self.useConsole and EternusEngine.mods.Praise.ConsoleUI then
--    EternusEngine.mods.Praise.ConsoleUI:Enter()
--  end

--	if self.m_PraiseCompassView then
--		self.m_PraiseCompassView:Show()
--	end
end

-------------------------------------------------------------------------------
-- Called from C++ when the game leaves it current mode
function PraiseMod:Leave()
--  EternusEngine.mods.Praise.Main:Leave()

--  if self.useConsole and EternusEngine.mods.Praise.ConsoleUI then
--    EternusEngine.mods.Praise.ConsoleUI:Leave()
--  end

--	if self.m_PraiseCompassView then
--		self.m_PraiseCompassView:Hide()
--	end
end


-------------------------------------------------------------------------------
-- Called from C++ every update tick
-- function PraiseMod:Process(dt)
--  EternusEngine.mods.Praise.Main:Process(dt)

--	if self.m_compassVisible and self.m_PraiseCompassView then
--		self.m_PraiseCompassView:Update(dt)
--  end
-- end


--function PraiseMod:ToggleCompass(down)
--	if down then
--		return
--	end

--	self:Debug("PraiseMod:ToggleCompass(down) called\n")

--	if self.m_compassVisible then
--		self:Debug("Hiding compass\n")
-- 		self.m_PraiseCompassView:Hide()
-- 		self.m_compassVisible = false
-- 	else
-- 		self:Debug("Making compass visible\n")
-- 		self.m_PraiseCompassView:Show()
-- 		self.m_compassVisible = true
-- 	end
-- end

function PraiseMod:loadConfing()
--	--NKPrint("PraiseMod:loadConfing() called\n")

	-- if self.options == nil then
	-- 	self.options = {}
	-- end

  --	local m_user_config = NKParseFile("config.txt")


  -- -- NKPrint("Trying to read txt file parsed with NKParseFile\n")

	-- if m_user_config["ENABLE_DEBUG"] ~= 0 then
	-- 	self.options.useDebug = true
	-- else
	-- 	self.options.useDebug = false
	-- end
  --
	-- if m_user_config["ENABLE_CHAT_CONSOLE_MESSAGES"] ~= 0 then
	-- 	self.options.useConsole = true
	-- else
	-- 	self.options.useConsole = false
	-- end
  --
	-- if m_user_config["ENABLE_COMPASS"] ~= 0 then
	-- 	self.options.useCompass = true
	-- else
	-- 	self.options.useCompass = false
	-- end
  --
	-- if m_user_config["LAYOUT"] then
	-- 	-- TODO: decide how to do layout changing
	-- 	self.options.layout = "Mouse Wizard" -- for now only one layout
	-- end
  --
	-- if m_user_config["TOGGLE_COMPASS_WITH_KEY"] ~= 0 then
	-- 	self.options.toggleCompassWithKey = true
	-- else
	-- 	self.options.toggleCompassWithKey = false
	-- end
  --
	-- if m_user_config["User Keybinds"] then
  --
	-- 	if m_user_config["User Keybinds"] then
	-- 		self.options.toggleCompassKey = m_user_config["User Keybinds"]["TOGGLE_COMPASS"]
	-- 	end
	-- end
end

---
-- Read through mods.txt, and extract credits from all mods listed in it, if they have credits.txt.
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

          majorVersion = mod.MajorVersion and mod.MajorVersion or "0"
          minorVersion = mod.MinorVersion and mod.MinorVersion or "0"
          patchVersion = mod.PatchVersion and mod.PatchVersion or "0"

          mod.version = majorVersion .. "." .. minorVersion .. "." .. patchVersion

				end
        manifestFile:close()

        local creditFile = io.open(modPath.."/CREDITS.txt", "r")
        if creditFile~=nil then
        creditString = creditFile:read("*a")
        creditFile:close()

        tempFile = io.open("Mods/Praise/praise_temporary_file.txt", "w")
        tempFile:write(creditString)
        tempFile:close()

        local credits = NKParseFile("praise_temporary_file.txt")
        if credits~=nil and credits["PraiseSyntax"] == "0.0.1"  then
          mod.tinyCredits = credits["TinyCredits"] and string.sub(credits["TinyCredits"] 1, 140) or nil
          mod.shortCredits = credits["ShortCredits"] and string.sub(credits["ShortCredits"], 1, 500) or nil
          mod.longCredits = credits["LongCredits"] and string.sub(credits["LongCredits"], 1, 1000) or nil
          mod.fullCredits = credits["FullCredits"] and credits["FullCredits"] or nil
        end

        if (mod.name~=nil) and (mod.scriptFile~=nil) and (mod.scriptClass~=nil) then
          table.insert(mods, mod)
        end

        self:Debug("TinyCredits: " .. mod.tinyCredits)

				-- local manifestFile=io.open(modPath.."/Manifest.txt","r") -- load manifest.txt
				-- if manifestFile~=nil then
				-- 	NKPrint("Found Manifest for  "..modPath.."\n")
				-- 	local ScriptFile = nil
				-- 	local ScriptClass = nil
				-- 	for manifestLine in manifestFile:lines() do
				-- 		manifestLine = manifestLine:gsub("%s+", "")
				-- 		if (strStartsWith(manifestLine,"ScriptFile=\"") and strEndsWith(manifestLine,"\"")) then
				-- 			ScriptFile = string.sub(manifestLine, 13, -2)
				-- 			NKPrint("ScriptFile="..manifestLine.."\n")
				-- 		elseif (strStartsWith(manifestLine,"ScriptClass=\"") and strEndsWith(manifestLine,"\"")) then
				-- 			ScriptClass = string.sub(manifestLine, 14, -2)
				-- 			NKPrint("ScriptClass="..manifestLine.."\n")
				-- 		end
				-- 	end
        --
				-- 	if (ScriptFile~=nil) and (ScriptClass~=nil) then
				-- 		include(ScriptFile)
				-- 		local ScriptMod = _G[ScriptClass].new()
				-- 		table.insert(CL.tugMods, ScriptMod)
				-- 	end
				-- end
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

function PraiseMod:Debug(msg)
	if self.options.useDebug then
		NKPrint(msg)
	end
end

EntityFramework:RegisterModScript(PraiseMod)
