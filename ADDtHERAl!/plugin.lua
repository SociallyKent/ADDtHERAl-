function Startup() -- dump after use
	imgui.SetNextWindowSizeConstraints({265, 48}, {265, 48})
	iPushCol = imgui.PushStyleColor
	iPopCol = imgui.PopStyleColor
	icol = imgui_col
	imgui.StyleColorsClassic()
	local Black = {0, 0, 0, .5}
	local DarkGray = {.09, .09, .09, 1}
	local DarkPurple = {.13, .07, .5, 1}
	local GrayLight = {.34, .34, .34, 1}
	iPushCol(icol.Border, DarkPurple)--{.13, .07, .5, 1}
	iPushCol(icol.Button, DarkPurple)--{.09, .09, .09, 1}
	iPushCol(icol.ButtonActive, {.14, .11, .36, 1})
	iPushCol(icol.ButtonHovered, GrayLight)--{.34, .34, .34, 1}
	iPushCol(icol.FrameBg, GrayLight)
	iPushCol(icol.FrameBgActive, {.26, .59, .98, .67})
	iPushCol(icol.FrameBgHovered, DarkGray)--{0, .82, 1, .4}
	iPushCol(icol.ResizeGrip, DarkPurple)
	iPushCol(icol.ResizeGripActive, GrayLight)
	iPushCol(icol.ResizeGripHovered, DarkGray)
	iPushCol(icol.ScrollbarBg, {.02, 0.02, 0.02, .5})
	iPushCol(icol.ScrollbarGrab, DarkGray)
	iPushCol(icol.ScrollbarGrabActive, GrayLight)
	iPushCol(icol.ScrollbarGrabHovered, {.13, .07, .5, 1})
	iPushCol(icol.Text, {1, 1, 1, 1})
	iPushCol(icol.TitleBg, DarkPurple)
	iPushCol(icol.TitleBgActive, {.14, 0.11, .36, 1})
	iPushCol(icol.TitleBgCollapsed, Black)
	iPushCol(icol.WindowBg, Black)
----Shortcut
	iButton = imgui.Button
	iColumn = imgui.Columns
	-- iColumnCount = imgui.GetColumnCount
	iColumnIndex = imgui.GetColumnIndex
	iColumnNext = imgui.NextColumn
	iColumnOffsetSet = imgui.SetColumnOffset
	iColumnOffsetGet = imgui.GetColumnOffset
	iColumnWidthSet = imgui.SetColumnWidth
	iColumnWidthGet = imgui.GetColumnWidth
	iText, iTextFormatless = imgui.Text, imgui.TextUnformatted
	iSameLine = imgui.SameLine
	iSelectable = imgui.Selectable

	aPerform, aPerformBatch = actions.Perform, actions.PerformBatch
	uCreateEA = utils.CreateEditorAction
	uCreateBM = utils.CreateBookmark--StartTime, Note
	uCreateEL = utils.CreateEditorLayer--Name, ¿?Hidden, ¿?ColorRgb
	uCreateHO = utils.CreateHitObject--StartTime, Lane, ¿EndTime, ¿HitSound, ¿EditorLayer, ¿Type
	uCreateSG = utils.CreateScrollGroup--ScrollVelocities, InitialScrollVelocity, ColorRgb
	uCreateSSF = utils.CreateScrollSpeedFactor--StartTime, Multiplier, ¿IsEditableInLuaScript
	uCreateSV = utils.CreateScrollVelocity--StartTime, Multiplier, ¿IsEditableInLuaScript
	uCreateTP = utils.CreateTimingPoint--StartTime, Bpm, Signature, ¿Hidden
	
	iKeyDown = imgui.IsKeyDown
	uKeyDown = utils.IsKeyDown
	Startup = function() -- recycle as
       	imgui.PushStyleVar(imgui_style_var.ItemInnerSpacing, {0, 0})
		imgui.PushStyleVar(imgui_style_var.ItemSpacing, {10, 10})
		imgui.PushStyleVar(imgui_style_var.WindowPadding, {5, 5})
		imgui.PushStyleVar(imgui_style_var.WindowBorderSize, 5)
    end
end
_Alphabet =
	{
	"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
	}
--TABLE table
--CHILD numeric
function table.average(TABLE, CHILD)
	for i, v in ipairs(TABLE) do
	end
end
function table.create(VARA)
	local Table = {}
	for i, v in ipairs({VARA}) do
		Table[i] = v end
	setmetatable(Table, {__index = table})
	return Table
end
 --Create user for user = data in TABLE
--TABLE table
function table.create_User(TABLE)
	local Table = table.create()
	for i, _ in pairs(TABLE) do
		Table[#Table + 1] = i end
	return table.duplicate_Remove(Table)
end
 --Duplicate a TABLE
  --useful for temperary changes
--TABLE table
function table.duplicate(TABLE)
	if not TABLE then return {} end
	local Table = {}
	if TABLE[1] then
		for i = 1, #TABLE do
			local Value = TABLE[i]
			Table[i] = type(Value) == "table" and table.duplicate(Value) or Value end
	else--if table is userdata, clone that too
		for _, v in ipairs(table.create_User(TABLE)) do
			local Value = TABLE[v]
			Table[v] = type(Value) == "table" and table.duplicate(Value) or Value end
	end
	return Table
end
function table.match(TABLE, ITEM)
	for i, v in pairs(TABLE) do
		if v == ITEM then
			return i
	end end
	return false
end
 -- Get all matches of user INDEX inside of TABLE
--TABLE table
--INDEX user varable
function table.inside(TABLE, INDEX)
	local Table = {}
	for i, v in pairs(TABLE) do
		if v[INDEX] then
			Table[#Table+1] = v[INDEX]
	end end
	return Table
end
 -- Gives the Min and Max values inside of TABLE
--TABLE table
function table.minmax(TABLE)
	local Min = math.min(table.unpack(TABLE))
	local Max = math.max(table.unpack(TABLE))
	return Min, Max
end
-- function table.REmoer()today(ADD)
-- return ADD
-- end
function table.pharse(TABLE, END, START)
	START = START or 1
	local Table = {}
	for i = END, START, -1 do
		Table[i] = TABLE[i] end
	return START ~= 1 and table.remove_Valueless(Table, END, true) or Table
end
--TABLE table
--INDEX numeric
function table.duplicate_Remove(TABLE)
	local Holder, Table, EndIndex = {}, {}, false
	for i, v in ipairs(TABLE) do
		if not (Holder[v]) then
			Holder[v] = true
			EndIndex, Table[i] = i, v
	end end
	return EndIndex and table.remove_Valueless(Table, EndIndex, true) or Table
end
 -- Removes all valueless values from INDEX to 0 inside TABLE.
  -- Nesh due to it's purpose. It is used primarily within game. and ungame.
--TABLE table
--INDEX numeric
--START boolean
function table.remove_Valueless(TABLE, INDEX, START)
	local Table = {}
	if not (START) then
		while TABLE[INDEX] do
			table.insert(Table, TABLE[INDEX])
			INDEX = INDEX - 1 end
	else
		while INDEX > 0 do
			if TABLE[INDEX] then
				table.insert(Table, TABLE[INDEX]) end
			INDEX = INDEX - 1
	end end
	return table.reverse(Table)
end
 -- Reverse a TABLE's indexs
--TABLE table
--USER varable
function table.reverse(TABLE, USER)
	local Table = {}
	for i = #TABLE, 1, -1 do
		Table[#Table + 1] = TABLE[i] end
	return Table
end
-- TABLE table
-- INDEX varable
function table.reverse_Data(TABLE, INDEX)
	local Table = {}
		local Duplicit = table.duplicate(TABLE)
	for i = #TABLE, 1, -1 do
		Table[#Table+1] = TABLE[i][INDEX] end
	for i, v in ipairs(Table) do
		Duplicit[i][INDEX] = v end
	return Duplicit 
end

function math.clamp(NUM, HIGH, LOW)
	return NUM < LOW and LOW or NUM > HIGH and HIGH or NUM
end
 -- Rounds a NUMBER to whole or to DECIMAL placement
--NUMBER numeric
--DECIMAL numeric
function math.round(NUM, DECIMAL)
	local Notation = 10^(DECIMAL or 0)
	return math.floor(Notation * NUM+0.5)/Notation
end
 -- wrap a NUMBER to fit within a CLAMP
--A numeric
--B numeric
function math.wrap(A, B)
	local a, b = math.modf(A/B)
	return string.format("%.12f", B * b), a
end
-- function Math.() end
-- function Math.() end
-- function Math.() end
-- function Math.() end
 -- Split a STRING into a table using FORMAT
--STRING string
--FORMAT string
function string.split(STRING, FORMAT)
	local FORMAT = FORMAT or "%g+"
	local Table = {}
	for i, v in STRING:gmatch(FORMAT) do
		Table[i] = v
	end
	return Table
end
--"[^\n]+"
sort =
	{
	numbers = {},
	game = {}
	}
function sort.game.byLane(A, B)
	if A.StartTime ~= B.StartTime then
		return A.StartTime < B.StartTime
	end
	return A.Lane < B.Lane
end
function sort.game.byMultiplier(A, B)
	return A.Multiplier < B.Multiplier
end
function sort.game.byTime(A, B)
	return A.StartTime < B.StartTime
end
function sort.numbers(A, B)
	return A < B
end
game =
	{
	Factors =
		{},
	Get =
		{},
	Groups =
		{},
	Marks =
		{},
	Notes =
		{},
	Points =
		{},
	Velocities =
		{},
	}
--¿START numeric
--¿END numeric
function game.SetupSelection(START, END)
	if START and END then
		return START, END end
	local Sel = state.SelectedHitObjects
	if not Sel[1] then
		return 0, 0 end
	return Sel[1].StartTime, Sel[#Sel].StartTime end
--PERFORM boolean
--... table{action_type, data}
function game.PerformAction(PERFORM, ...)
	local CreateEA = {}
	for i, v in ipairs(...) do
		CreateEA[i] = uCreateEA(v[1], v[2])
	end
	if not (PERFORM) then
		return CreateEA end
	aPerformBatch(CreateEA) end

 --Create a USER table using DATA
  --creates userdata using USER for utils[USER] and DATA for utils[](DATA)
--USER utils
--DATA table
function game.Create(USER, DATA)
	local Table = {}
	for i, v in ipairs(DATA) do
		Table[i] = utils[USER](table.unpack(v)) end
	return Table end
function game.Get.LengthBetween(START, END)
	local Truthy = (START and END)
	local START = Truthy and START or state.SelectedHitObjects[1].StartTime
	local END = Truthy and END or state.SelectedHitObjects[#state.SelectedHitObjects].StartTime
	return START, END, END - START end
function game.Get.SelectedOffsets()
	return state.SelectedHitObjects[1].StartTime, state.SelectedHitObjects[#state.SelectedHitObjects].StartTime end
 --if INDEX has values at START or END
--INDEX userdata
function game.Validate(INDEX, START, END)
	local START, END = game.SetupSelection(START, END)
	local Start, End = game.Get.OffsetIndex(INDEX, START, END)
	local Start = INDEX[Start].StartTime == START
	local End = INDEX[End].StartTime == END
	return Start, End end
 --indexs between selected hitobjects
--INDEX userdata
function game.Get.OffsetIndex(INDEX, START, END)
	for i = 1, #INDEX do
		if START <= INDEX[i].StartTime then
			START = i break
	end end
	for i = START, #INDEX do
		if INDEX[i].StartTime > END then
			END = i-1 break
	end end
	return START, END end

 -- needs: .StartTime .Multiplier
--SV userdata
function game.Velocities.Average(SV)
	local Start, End = game.SetupSelection()
	local Truthy = SV[#SV].StartTime == state.SelectedHitObjects[#state.SelectedHitObjects].StartTime
	local Index = Truthy and #SV - 1 or #SV
	for i = 1, Index - 1 do
		local A, B = SV[i], SV[i+1]
		local area =(B.StartTime - A.StartTime)*(A.Multiplier + B.Multiplier) / 2
		totalArea = (totalArea or 0) + area end
	return totalArea / (SV[#SV].StartTime - SV[1].StartTime) end

function game.Factors.Between(START, END)
	local START, END = game.SetupSelection(START, END)
	local Table, EndIndex = {}, false
	for i, v in ipairs(map.ScrollSpeedFactors) do
		if START <= v.StartTime then
			if v.StartTime > END then break end
			EndIndex, Table[i] = i, {StartTime = v.StartTime, Multiplier = v.Multiplier}
	end end
	return EndIndex and table.remove_Valueless(Table, EndIndex) end
function game.Marks.Between(START, END)
	local START, END = game.SetupSelection(START, END)
	local Table, EndIndex = {}, false
	for i, v in ipairs(map.Bookmarks) do
		if START <= v.StartTime then
			if v.StartTime > END then break end
			EndIndex, Table[i] = i, v
	end end
	return EndIndex and table.remove_Valueless(Table, EndIndex) end
function game.Notes.Between(START, END)
	local START, END = game.SetupSelection(START, END)
	local Table, EndIndex = {}, false
	for i, v in ipairs(map.HitObjects) do
		if START <= v.StartTime then
			if v.StartTime > END then break end
			EndIndex, Table[i] = i, {StartTime = v.StartTime, Lane = v.Lane, EndTime = v.EndTime}
	end end
	local Table = EndIndex and table.remove_Valueless(Table, EndIndex) or Table
	return table.sort(Table, sort.game.byLane) end
function game.Points.Between(START, END)
	local START, END = game.SetupSelection(START, END)
	local Table, EndIndex = {}, false
	for i, v in ipairs(map.TimingPoints) do
		if START <= v.StartTime then
			if v.StartTime > END then break end
			EndIndex, Table[i] = i, {StartTime = v.StartTime, Bpm = v.Bpm}
	end end
	return EndIndex and table.remove_Valueless(Table, EndIndex) end
function game.Velocities.Between(START, END)
	local START, END = game.SetupSelection(START, END)
	local Table, EndIndex = {}, false
	for i, v in ipairs(map.ScrollVelocities) do
		if START <= v.StartTime then
			if v.StartTime > END then break end
			EndIndex, Table[i] = i, {StartTime = v.StartTime, Multiplier = v.Multiplier}
	end end
	return EndIndex and table.remove_Valueless(Table, EndIndex) end

function game.Factors.BetweenRaw(START, END)
	local START, END = game.SetupSelection(START, END)
	local Table, EndIndex = {}, false
	for i, v in ipairs(map.ScrollSpeedFactors) do
		if START <= v.StartTime then
			if v.StartTime > END then break end
			EndIndex, Table[i] = i, v
	end end
	return EndIndex and table.remove_Valueless(Table, EndIndex) end
function game.Velocities.BetweenRaw(START, END)
	local START, END = game.SetupSelection(START, END)
	local Table, EndIndex = {}, false
	for i, v in ipairs(map.ScrollVelocities) do
		if START <= v.StartTime then
			if v.StartTime > END then break end
			EndIndex, Table[i] = i, v
	end end
	return EndIndex and table.remove_Valueless(Table, EndIndex) end

--- function game.Factors.Create() end
--- function game.Groups.Create() end
function game.Marks.Create(TIMES, WORDS, MARK)
	local WORDS = string.split(WORDS)
	local Add, Remove = {}, {}
	for i, v in ipairs(TIMES) do
		if not (WORDS[i]) then break end
		Add[i] = utils.CreateBookmark(v.StartTime, MARK and (MARK .. " " .. WORDS[i]) or WORDS[i]) end
	return Add end
--INDEX userdata(HitObject)
function game.Notes.Create(INDEX)
	local Table = {}
	for i, v in ipairs(INDEX) do
		Table[i] = utils.CreateHitObject(v.StartTime, v.Lane, v.EndTime) end
	return Table end
--- function game.Points.Create() end
--INDEX userdata(ScrollVelocity)
function game.Velocities.Create(INDEX)
	local Table = {}
	for i, v in ipairs(INDEX) do
		Table[i] = utils.CreateScrollVelocity(v.StartTime, v.Multiplier) end
	return Table end

function game.Factors.Get()
	local Table = {}
	for i, v in ipairs(map.ScrollVelocities) do
		Table[i] = {StartTime = v.StartTime, Multiplier = v.Multiplier} end
	return Table end
--- function game.Groups.Get() end
function game.Notes.Get()
	local Table = {}
	for i, v in ipairs(map.HitObjects) do
		Table[i] = {StartTime = v.StartTime, Lane = v.Lane, EndTime = v.EndTime ~= 0 and v.EndTime} end
	return table.sort(Table, sort.game.byLane) end
function game.Points.Get()
	local Table = {}
	for i, v in ipairs(map.TimingPoints) do
		Table[i] = {StartTime = v.StartTime, Bpm = v.Bpm} end
	return Table end
--- used primarly for it's short {StartTime, Multiplier}; helps performace
function game.Velocities.Get()
	local Table = {}
	for i, v in ipairs(map.ScrollVelocities) do
		Table[i] = {StartTime = v.StartTime, Multiplier = v.Multiplier} end
	return Table end

--INDEX userdata
function game.Notes.Unique(INDEX)
	local Holder, Table, EndIndex = {}, {}, false
	for i, v in ipairs(INDEX) do
		if not (Holder[v.StartTime]) then
			Holder[v.StartTime] = true
			EndIndex, Table[i] = i, v.StartTime
	end end
	local Table = EndIndex and table.remove_Valueless(Table, EndIndex, true) or Table
	return table.sort(Table, sort.game.byLane) end
function game.Notes.unUnique(INDEX)
	local INDEX = INDEX or map.HitObjects
	local Holder, Table = {}, {}
	for _, v in ipairs(INDEX) do
		if not (Holder[v.StartTime]) then
		--unique
			Holder[v.StartTime] = {[v.Lane] = true, [v.EndTime] = true}
		elseif not (Holder[v.StartTime][v.Lane]) then--same StartTime--not Lane
		elseif not (Holder[v.StartTime][v.EndTime]) then--same StartTime--not EndTime
		else--same All
	end end
	return Table end
function game.Marks.unUnique(INDEX)
	local INDEX = INDEX or map.Bookmarks
	local Holder, Table = {}, {}
	for _, v in ipairs(INDEX) do
		if not (Holder[v.StartTime]) then--unique
			Holder[v.StartTime] = {[v.Note] = true}
		elseif not (Holder[v.StartTime][v.Note]) then--same StartTime--not same Note
		else--same All
	end end
	return Table end
function game.Factors.unUnique(INDEX)
	local INDEX = INDEX or map.ScrollSpeedFactors
	local Table = {}
	for i = 3, #INDEX do
		if i > Num then break end
		if INDEX[i-2].Multiplier == INDEX[i-1].Multiplier and v.Multiplier == SFs[i].Multiplier then
			table.insert(Table, INDEX[i-1])
	end end
	return Table end
--RANGE numeric
function game.Velocities.unUnique(INDEX, RANGE)
	local INDEX = INDEX or map.ScrollVelocities
	local Table = {}
	if RANGE then
		for i = 2, #INDEX do
			local Multi = INDEX[i-1].Multiplier - INDEX[i].Multiplier
			if Multi >= -RANGE and Multi <= RANGE then
				table.insert(Table, INDEX[i])
		end end
	else
		for i = 2, #INDEX do
			if INDEX[i-1].Multiplier == INDEX[i].Multiplier then
				table.insert(Table, INDEX[i])
		end end
	end
	return Table end
key = { index = {} }
--KEY string
--COMBO string
function key.IsKeyCombo(KEY, COMBO)
	local uKey = tonumber(keys[KEY])
	local iKey = tonumber(imgui_key[KEY])
	local isPressed = utils.IsKeyPressed(uKey) or imgui.IsKeyPressed[iKey]
	if not COMBO then return isPressed end
	local Ctrl =
		uKeyDown(keys.LeftControl) or uKeyDown(keys.RightControl)
		or iKeyDown(imgui_key.LeftControl) or iKeyDown(imgui_key.RightControl)
	local Shift =
		uKeyDown(keys.LeftShift) or uKeyDown(keys.RightShift)
		or iKeyDown(imgui_key.LeftShift) or iKeyDown(imgui_key.RightShift)
	local Alt =
		uKeyDown(keys.LeftAlt) or uKeyDown(keys.RightAlt)
		or iKeyDown(imgui_key.LeftAlt) or iKeyDown(imgui_key.RightAlt)
	if (COMBO == "CTRL") and (not Ctrl) then
		return false end
	if (COMBO == "SHIFT") and (not Shift) then
		return false end
	if (COMBO == "ALT") and (not Alt) then
		return false end
	return isPressed
end
kolor = { window = {} }
function kolor.ize(R, G, B, A)
	local R, G, B = R/255, G/255, B/255
	return {R, G, B, A or 1} end
function kolor.Mix(KOLOR1, KOLOR2, ALPHA)
	local R,G,B = table.unpack(KOLOR1)
	local R2,G2,B2 = table.unpack(KOLOR2)
	local R,G,B = R+R2, G+G2, B+B2
	return {R/2, G/2, B/2, ALPHA or 1} end
TKColors =
	{
	BM = kolor.ize(187, 153, 238),--Bookmarks
	HO = kolor.ize(153, 204, 238),--HitObject
	SSF = kolor.ize(204, 102, 119),--ScrollSpeedFactor
	SV = kolor.ize(170, 68, 153), --ScrollVelocity
	TG = kolor.ize(204, 51, 17),  --TimingGroup
	TP = kolor.ize(153, 204, 238) --TimingPoint
	}
size =
	{
	Button =
		{
		Friendly = {22.4, 25},
		Satisfiing = {130, 50},
		Standard = {50, 0},
		},
	}
_Keylist =
	{
	Action = "T",
	ActionSub = "Shift+T",
	Swap = "S",
	Negate = "N",
	}
_Keynumb =
	{Action = 1, ActionSub = 2, Swap = 3, Negate = 4}
globalVars =
	{
	optionsTypeIndex = 3,
	createTypeIndex =
		{1, 1, 1, 1},
	editorTypeIndex = 
		{1, 1, 1, 1},
	toolsTypeIndex = 
		{1, 1, 1, 1},
	
	scrollGroupIndex = 1,
	KeyList = table.duplicate(_Hotkeys),
	}
local function cGraphStats() return {Min = 0, Max = 0, MinDist= 0, MaxDist = 0} end
local function cStats() return {minSV = 0, maxSV = 0, avgSV = 0} end
----
--Varables for Menus and children Menus
_MenuVars =
	{
	Create = --Create new Exsitings
		{
		Bookmarks =
			{Holder = {}
			},--Bookmarks
		Objects =
			{Holder = {}
			},--Objects
		Scrolls =
			{
			Normal =
				{
				interlace = false,
				interlaceRatio = -0.5,
				svDist = {},
				svGraphStats = cGraphStats(),
				svMulti = {},
				svStats = cStats(),
				TypeIndex = 1,
				},
			Special =
				{TypeIndex = 1},
			Still =
				{
				interlace = false,
				interlaceRatio = -0.5,
				noteSpacing = 1,
				overrideFinal = false,
				prePlaceDistances = {},
				stillBehavior = 1,
				stillDistance = 0,
				stillTypeIndex = 1,
				svDist = {},
				svGraphStats = cGraphStats(),
				svMulti = {},
				svStats = cStats(),
				},
			Other = {},
			},--Scrolls
		Universal =
			{Holder = {}
			},--Universal
		},--Create
	Editor = --Edit already Exsitings
		{
		Bookmarks =
			{Holder = {}
			},--Bookmarks
		Objects =
			{
			ShiftVertical = {},
			ShiftHorizontal = {},
			FlipVertical = {},
			},--Objects
		Scrolls =
			{
			DisplaceNote =
				{
				distance1 = 200,
				distance2 = 0,
				distance3 = 200,
				linearlyChange = false,
				},
			DisplaceView =
				{distance = 200},
			Flicker =
				{
				distance1 = -69420.727,
				distance2 = 0,
				distance3 = -69420.727,
				flickerPosition = 0.5,
				flickerTypeIndex = 1,
				linearlyChange = false,
				numFlickers = 1,
				},
			scaleDisplace =
				{
				avgSV = 1,
				dist = 100,
				ratio = 1,
				scaleSpotIndex = 1,
				scaleTypeIndex = 1,
				},
			scaleMultiply =
				{
				avgSV = 1,
				dist = 100,
				ratio = 0.6,
				scaleTypeIndex = 1,
				},
			Split =
				{
				cloneRadius = 1000,
				cloneSVs = false,
				modeIndex = 1,
				reuseTGs = false,
				},
			Teleport =
				{
				distance = 10727,
				teleportBeforeHand = false,
				},
			verticalShift =
				{verticalShift = 1},
			},--Scrolls
		Universal =
			{Holder = {}
			},--Universal
		},--Editor
	Tools = --Tools for changing already Exsitings
		{
		Bookmarks =
			{Holder = {},
			},--Bookmarks
		Objects =
			{Holder = {},
			},--Objects
		Scrolls =
			{
			Measure =
				{
				Data =
					{
					avgSV = 0,
					Ruler = 0,
					},
				avgSV = false,
				Input = 4,
				Msx = 0,
				Ruler = false,
				Snap = 4,
				},
			},--Scrolls
		Universal =
			{
			Copy =
				{
				Data =
					{
					AddBM={}, AddHO={}, AddSSF={}, AddSV={}, AddTP={},
					BMs=false, HOs=false, SSFs=false, SVs=false, TPs=false,
					},
				Mimic = true,
				Replace = true,
				Stretch = true,
				kBM = false,
				kHO = false,
				kSSF = false,
				kSV = true,
				kTP = false,
				},
			Declutter =
				{},
			Delete =
				{},
			Split =
				{},
			},--Universal
		},--Tools
	}--_MenuVars
_MVDefault = table.duplicate(_MenuVars)
----
--Options for chosing menus
_MenuOpts =
	{
	Options =
		{
		"Bookmarks", "Objects", "Scrolls", "Universal"
		},
	Create =
		{
		Bookmarks =
			{"Holder"
			},
		Objects =
			{"Holder"
			},
		Scrolls =
			{
			"Normal",
			"Special",
			"Still",
			"Other",
			},
		Universal =
			{"Holder"
			},
		},--Create
	Editor =
		{
		Bookmarks =
			{"Holder"
			},
		Objects =
			{
			"(flip) Vertical",
			"(shift) Horizontal",
			"(shift) Vertical",
			},
		Scrolls =
			{
			"(displace) Note",
			"(displace) View",
			"Flicker",
			"(scale) Displace",
			"(scale) Multiply",
			"Teleport",
			},
		Universal =
			{"Holder"
			},
		},--Editor
	Tools =
		{
		Bookmarks =
			{"Holder"
			},
		Objects =
			{
			"Place Between",
			},
		Scrolls =
			{
			"Measure",
			},
		Universal =
			{
			"Copy",
			"Declutter",
			"Delete",
			"Split",
			},
		},--Tools
	}--_MenuOpts
----
--Varables for children menus
_SetaVars =
	{
	Bookmarks =
		{Holder = {}
		},--Bookmarks
	Objects =
		{Holder = {}
		},--Objects
	Scrolls =
		{
		Normal =
			{
			Linear = 
				{
				End = 0.5,
				EndType = 1,
				Points = 14,
				Start = 1.5,
				},
			Exponential =
				{
				End = 0.5,
				EndType = 1,
				Points = 14,
				Start = 1.5,
				},
			Circular =
				{
				End = 0.5,
				EndType = 1,
				Points = 14,
				Start = 1.5,
				},
			Chinchilla =
				{},
			},--Normal
		Special =
			{
			},
		Still =
			{
			Linear = {},
			Exponential = {},
			Circular = {},
			Chinchilla = {},
			},--Still
		},--Scrolls
	Universal =
		{Holder = {},
		},--Universal
	}--_SetaVars
----
--Options for children menus
_SetaOpts =
	{
	Bookmarks =
		{"Holder"
		},--Bookmarks
	Objects =
		{"Holder"
		},--Objects
	Scrolls =
		{
		Normal =
			{
			"Linear",
			"Exponential",
			"Circular",
			"Chinchilla"
			},
		Special =
			{},
		Still =
			{
			"Linear",
			"Exponential",
			"Circular",
			"Chinchilla",
			Behavior = {"Region", "Scroll Group"},
			Displace = {"No", "Start", "End", "Auto", "Otua"},
			},
		Other =
			{},
		},--Scrolls
	Universal =
		{"Holder"
		},--Universal
	}--_SetaOpts
_Ends =
	{
	"Custom", -- editable
	"Contiue", -- disabled
	"None", -- disabled
	"Replace", -- editable
	}
_ChinchillaOpts =
	{
	"Linear",
	"Exponential",
	"Circular",

	"Brachistochrone curve",
	"Peter Stock",
	"Power (Inverse)",
	"Power",
	"Sine Power (Arc)",
	"Sine Power"
	}
_MainMenus =
	{
	{Name = "Create", Switch = false},
	{Name = "Editor", Switch = false},
	{Name = "Tools",  Switch = false},
	}
menu =
	{ index = {} }
Create =
	{
	Bookmarks =
		{ index = {} },
	Objects =
		{ index = {} },
	Scrolls =
		{ index = {} },
	Universal =
		{ index = {} },
	}
Editor =
	{
	Bookmarks =
		{ index = {} },
	Objects =
		{ index = {} },
	Scrolls =
		{ index = {} },
	Universal =
		{ index = {} },
	}
Tools =
	{
	Bookmarks =
		{ index = {} },
	Objects =
		{ index = {} },
	Scrolls =
		{ index = {} },
	Universal =
		{ index = {} },
	}
function Menus()
	if imgui.BeginMenuBar() then
		for i, v in ipairs(_MainMenus) do
			if imgui.MenuItem(v.Name, true, v.Switch) then
				_MainMenus[i].Switch = not v.Switch
			end
			if v.Switch then
				imgui.SetNextWindowSizeConstraints({310, 0}, {310, math.huge})
				menu[v.Name](v.Name, i, globalVars.optionsTypeIndex, 32)
		end end
	imgui.EndMenuBar()
end end
	--L(Lable) string
	--O(Options) table
	--I(Index) string
	function createThatMenu(L1, O1, I1, S, L2, O2, I2)
		imgui.PushItemWidth(150)
		globalVars[I1][S] = Combo(L1, O1, globalVars[I1][S])
		imgui.SameLine(0, 0)
		globalVars[I2] = Combo(L2, O2, globalVars[I2])
		imgui.PopItemWidth() end
	function createThatSubMenu(L1, O1, O2, O3)
		imgui.PushItemWidth(150)
		_MenuVars[O1][O2][O3].TypeIndex = Combo(L1, _SetaOpts[O2][O3], _MenuVars[O1][O2][O3].TypeIndex)
		imgui.PopItemWidth() end
	function createOptionsMenu(FUNCTION, YPOS)
		imgui.Indent(190) imgui.Button("Options", {70, 0}) imgui.Unindent(190)
		if imgui.BeginPopupContextItem("Options", 1) then
			imgui.BeginPopup("Options")
			FUNCTION()
			imgui.EndPopup() end
		imgui.SetCursorPosY(YPOS or 57) end
	function BeginFocusBlock()
		local Disabled = not imgui.IsWindowFocused(1) and not imgui.IsWindowHovered()
		if Disabled then imgui.BeginDisabled() end
		return Disabled end
	function EndFocusBlock(DISABLED)
		if DISABLED then imgui.EndDisabled() end end
function setup(TYPEINDEX, TYPE, OPT)
	local Index = globalVars[TYPEINDEX][OPT]
	local Option = _MenuOpts.Options[OPT]
	local Menu = _MenuOpts[TYPE][Option]
	-- print(_MenuOpts.Options[OPT],_MenuOpts[TYPE])
	createThatMenu(
		"##" .. TYPE, Menu, TYPEINDEX, OPT,
		"##Options", _MenuOpts.Options, "optionsTypeIndex"
		)
	return Index, Option, Menu
end
menu['Create'] = function(NAME, INDEX, OPT, FLAGS)
	local _, B = imgui.Begin(NAME, true, FLAGS)
	local Disabled = BeginFocusBlock()
	local Index, Option, Creates = setup("createTypeIndex", "Create", OPT)
	Create[Option][Creates[Index]]()
	EndFocusBlock(Disabled)
	imgui.End()
	if not B then _MainMenus[INDEX].Switch = false end
end
Create["Bookmarks"]["Holder"] = function()
	iTextFormatless("PlaceHolder") end
-- 
Create["Objects"]["Holder"] = function()
	iTextFormatless("PlaceHolder") end
--
Create["Scrolls"]["Normal"] = function()
	createThatSubMenu("##Normal", "Create", "Scrolls", "Normal")
end
Normal =
	{"Linear", "Exponential", "Circular", "Chinchilla"}
Normal['Linear'] = function() end
Normal['Exponential'] = function() end
Normal['Circular'] = function() end
Normal['Chinchilla'] = function() end
Special =
	{}
Create["Scrolls"]["Special"] = function()
	iTextFormatless("PlaceHolder") end
Still =
	{"Linear", "Exponential", "Circular", "Chinchilla", }
Create["Scrolls"]["Still"] = function()
	iTextFormatless("PlaceHolder") end
Still['Linear'] = function() end
Still['Exponential'] = function() end
Still['Circular'] = function() end
Still['Chinchilla'] = function() end

Other =--Posablility used for testing
	{}
Create["Scrolls"]["Other"] = function()
	iTextFormatless("PlaceHolder") end
Create["Universal"]["Holder"] = function()
	iTextFormatless("PlaceHolder") end

menu['Editor'] = function(NAME, INDEX, OPT, FLAGS)
	local _, B = imgui.Begin(NAME, true, FLAGS)
	local Disabled = BeginFocusBlock()
	local Index, Option, Menu = setup("editorTypeIndex", "Editor", OPT)
	Editor[Option][Menu[Index]]()
	EndFocusBlock(Disabled)
	imgui.End()
	if not B then _MainMenus[INDEX].Switch = false end
end
Editor["Bookmarks"]["Holder"] = function() end
--
Editor["Objects"]["(flip) Vertical"] = function() end
Editor["Objects"]["(shift) Horizontal"] = function() end
Editor["Objects"]["(shift) Vertical"] = function() end
--
Editor["Scrolls"]["(displace) Note"] = function() end
Editor["Scrolls"]["(displace) View"] = function() end
Editor["Scrolls"]["Flicker"] = function()
	iTextFormatless("PlaceHolder:\nFlicker with SVs on and off") end
Editor["Scrolls"]["(scale) Displace"] = function() end
Editor["Scrolls"]["(scale) Multiply"] = function() end
Editor["Scrolls"]["Teleport"] = function() end
--
Editor["Universal"]["Holder"] = function() end

menu['Tools'] = function(NAME, INDEX, OPT, FLAGS)
	local _, B = imgui.Begin(NAME, true, FLAGS)
	local Disabled = BeginFocusBlock()
	local Index, Option, Menu = setup("toolsTypeIndex", "Tools", OPT)
	Tools[Option][Menu[Index]]()
	EndFocusBlock(Disabled)
	imgui.End()
	if not B then _MainMenus[INDEX].Switch = false end
end
Tools["Bookmarks"]["Holder"] = function() end
--
Tools["Objects"]["Place Between"] = function() end
--
Tools["Scrolls"]["Measure"] = function()
	local Menu = _MenuVars.Tools.Scrolls.Measure
	local Data = _MenuVars.Tools.Scrolls.Measure.Data
	createOptionsMenu(function()
		Menu.Ruler = CheckBox("Ruler", Menu.Ruler)
		Menu.avgSV = CheckBox("SV Average", Menu.avgSV)
	end)
	if state.SelectedHitObjects[2] then
		Object1, Object2 = game.Get.SelectedOffsets()
		if Start ~= Object1 or End ~= Object2 then
			Start, End = game.SetupSelection()
			if Menu.Ruler then
				Data.Ruler = End-Start
				imgui.Text(Data.Ruler)
			end
			if Menu.avgSV then
				Data.avgSV = game.Velocities.Average(game.Velocities.Between())
				imgui.Text(Data.avgSV)
			end
	end end
	-- game.Velocities.Average(SV)
	imgui.PushItemWidth(150)
	Active, Menu.Input = imgui.InputFloat("##Snap", Menu.Input, 1, 0.05, "%.4g")
	if (Active or Menu.Msx == 0) and state.CurrentTimingPoint then
		Menu.Input = math.clamp(Menu.Input, 48, 0)
		Menu.Msx = (60000 / map.getTimingPointAt(state.SongTime).Bpm / Menu.Input)*4
	end
	-- 512 ReadOnly ; 4096 AutoSelectAll ; 32768 NoHorizontalScroll
	imgui.InputText(string.format("1/%.4g", Menu.Input),
		Menu.Msx, 50, 512 + 4096 + 32768)
	imgui.PopItemWidth()
end
--
Tools["Universal"]["Copy"] = function()
	local Menu = _MenuVars.Tools.Universal.Copy
	local Copy = _MenuVars.Tools.Universal.Copy.Data
	createOptionsMenu(function()
		Menu.Replace = CheckBox("Replace", Menu.Replace)
		iSameLine(0, 1)
		Menu.Stretch = CheckBox("Stretch", Menu.Stretch)
		Menu.Mimic = CheckBox("Mimic Offsets", Menu.Mimic)
	end)
	Menu.kSV = CheckBox("SVs", Menu.kSV)
	iSameLine(0, 1)
	Menu.kSSF = CheckBox("SSF", Menu.kSSF)
	if imgui.Button("Collect", {70, 0}) then
		Copy.Data = table.duplicate(_MVDefault.Tools.Universal.Copy.Data)
		Copy.SVs = Menu.kSV and game.Velocities.Between()
		Copy.SSFs = Menu.kSSF and game.Factors.Between()
		if Copy.SVs then print() end
		local Mimic = function(SO)
			local Start, End = game.SetupSelection()
			if SO[1].StartTime ~= Start then
				table.insert(SO, 1, {StartTime = Start, Multiplier = string.byte("mimic")}) end
			if SO[#SO].StartTime ~= End then
				table.insert(SO, {StartTime = End, Multiplier = string.byte("mimic")}) end
			return SO
		end
		if Copy.SVs then
			if Menu.Mimic then Copy.SVs = Mimic(Copy.SVs) end
			local EndIndex = false
			local Start = Copy.SVs[1].StartTime
			for i, v in ipairs(Copy.SVs) do
				Copy.SVs[i].StartTime = v.StartTime - Start
				EndIndex = i end
			if EndIndex and #Copy.SVs ~= EndIndex then
				Copy.SVs = table.pharse(Copy.SVs, EndIndex)
		end end
		if Copy.SSF then
			local EndIndex = false
			if Menu.Mimic then
				Copy.SSFs = Mimic(Copy.SSFs) end
			local Start = Copy.SSFs[1].StartTime
			for i, v in ipairs(Copy.SSFs) do
				Copy.SSFs[i].StartTime = v.StartTime - Start
				EndIndex = i end
			if EndIndex and #Copy.SSFs ~= EndIndex then
				Copy.SSFs = table.pharse(Copy.SSFs, EndIndex)
		end end
	end
	if (Copy.SVs or Copy.SSFs) then
		if imgui.Button("Paste", {70, 0}) and state.SelectedHitObjects[1] then
			local Mimic = function(SO)
				if SO[1].Multiplier == string.byte("mimic") then
					table.remove(SO, 1) end
				if SO[#SO].Multiplier == string.byte("mimic") then
					table.remove(SO, #SO) end
				return SO
			end
			local Table = {}
			local Start, _, Length = game.Get.LengthBetween()
			if Menu.kSV then
				if Menu.Stretch then
					local CopyLength = Copy.SVs[#Copy.SVs].StartTime
					local Scale = CopyLength > 0 and (Length / CopyLength) or 0
					for i, v in pairs(Copy.SVs) do
						Copy.AddSV[i] = uCreateSV(v.StartTime*Scale + Start, v.Multiplier)
					end
				else
					for i, v in pairs(Copy.SVs) do
						Copy.AddSV[i] = uCreateSV(v.StartTime + Start, v.Multiplier)
				end end
				if Menu.Mimic then--
					Copy.AddSV = Mimic(Copy.AddSV) end
				Table[1] = {action_type.AddScrollVelocityBatch, Copy.AddSV}
				if Menu.Replace then
					local Raw = game.Velocities.BetweenRaw()
					Table[#Table+1] = Raw and {action_type.RemoveScrollVelocityBatch, Raw}
			end end
			if Menu.kSSF then
				if Menu.Stretch then
					local CopyLength = Copy.SSFs[#Copy.SSFs].StartTime
					local Scale = CopyLength > 0 and (Length / CopyLength) or 0
					for i, v in pairs(Copy.SSFs) do
						Copy.AddSSF[i] = uCreateSSF(v.StartTime*Scale + Start, v.Multiplier) 
					end
				else
					for i, v in pairs(SSFs) do
						Copy.AddSSF[i] = uCreateSSF(v.StartTime + Start, v.Multiplier)
				end end
				if Menu.Mimic then--
					Copy.AddSSF = Mimic(Copy.AddSSF) end
				Table[#Table+1] = {action_type.AddScrollSpeedFactorBatch, AddSSF}
				if Menu.Replace then
					local Raw = game.Factors.BetweenRaw()
					Table[#Table+1] = Raw and {action_type.RemoveScrollSpeedFactorBatch, Raw}
			end end
			game.PerformAction(true, Table)
end end end
Tools["Universal"]["Declutter"] = function(CATEGORY)
	if CATEGORY == 3 and imgui.Button("12") then end
	if imgui.Button("CheckSV") then
		local SVs = game.Velocities.unUnique(false, 0.0001)
		print("i!", #SVs .. " SVs Removed", SVs)
		if SVs[1] then actions.RemoveScrollVelocityBatch(SVs) end
	end--all data to delete
	if imgui.Button("CheckSSF") then
		local SSFs = game.Factors.unUnique()
		print("i!", #SSFs .. " SSFs Removed", SSFs)
		if SSFs[1] then aPerform(uCreateEA(action_type.RemoveScrollSpeedFactorBatch, SSFs)) end
	end--all data to delete
	if imgui.Button("CheckNotes") then
		local Notes = game.Notes.unUnique()
		print("i!", #Notes .. " Notes Removed")
		if Notes[1] then actions.RemoveHitObjectBatch(Notes) end
	end--all data to delete
	if imgui.Button("CheckMarks") then
		local Marks = game.Marks.unUnique()
		print("i!", #Marks .. " Bookmarks Removed")
		if Marks[1] then actions.RemoveBookmarkBatch(Marks) end
end end--all data to delete
Tools["Universal"]["Delete"] = function() end
Tools["Universal"]["Split"] = function() end
Tools["Universal"]["Shift"] = function() end
--LABLE string
--VALUE boolean
function CheckBox(LABLE, VALUE)
	local _, VALUE = imgui.CheckBox(LABLE, VALUE)
	return VALUE end
--LABLE string
--SELECTION table
--INDEX numeric
function Combo(LABEL, SELECTION, INDEX, FLAGS)
	if imgui.BeginCombo(LABEL, SELECTION[INDEX], FLAGS or 8) then
		for i = 1, #SELECTION do
			if imgui.Selectable(SELECTION[i]) then
				INDEX = i	
		end end
		imgui.EndCombo() end
	return INDEX end
--LABLE string
--OPTIONS table
--NAME1 string
--NAME2 string
--FORMAT stringformat
function SwapNegateInputFloat2(LABEL, OPTIONS, NAME1, NAME2, FORMAT)
	FORMAT = FORMAT or "%.2gx"
	local swapButton = iButton("S##" .. NAME1, size.Button.Friendly)
	imgui.SameLine()
	local negaButton = iButton("N##" .. NAME2, size.Button.Friendly)
	imgui.SameLine()
	local InText = vector.New(OPTIONS[NAME1], OPTIONS[NAME2])
	local _, OutText = imgui.InputFloat2(LABEL, InText, FORMAT)
	local SwapAction = swapButton or key.IsKeyCombo(globalVars.KeyList[_Keylist.swap])
	if SwapAction then
		OPTIONS[NAME1] = InText.y
		OPTIONS[NAME2] = InText.x
		return true end
	local NegaAction = negaButton or key.IsKeyCombo(globalVars.KeyList[_Keylist.negate])
	if NegaAction then
		OPTIONS[NAME1] = -InText.x
		OPTIONS[NAME2] = -InText.y
		return true end
	OPTIONS[NAME1] = OutText.x
	OPTIONS[NAME2] = OutText.y
	return InText ~= OutText
end
co = coroutine.create(function()
	for i=1,10 do
		-- return i
		coroutine.yield(i)
	end
end)


a = {1,2,3}
b = a
a = {}
print(#b) -- still 3

a = {1,2,3}
b = a
for i = #a,1,-1 do
    a[i] = nil
end
print(#b) -- now 0
function draw()
	if imgui.Begin("ADDtHERAl!", 2 + 1024) then
		Startup()
		Menus()
		imgui.End()
	end
	-- iColumn = imgui.Columns
	-- iColumnCountGet = imgui.GetColumnCount
	-- iColumnIndexGet = imgui.GetColumnIndex
	-- iColumnNext = imgui.NextColumn
	-- iColumnOffsetSet = imgui.SetColumnOffset
	-- iColumnOffsetGet = imgui.GetColumnOffset
	-- iColumnWidthSet = imgui.SetColumnWidth
	-- iColumnWidthGet = imgui.GetColumnWidth
	imgui.PushStyleVar(imgui_style_var.ItemInnerSpacing, {0, 0})
	imgui.PushStyleVar(imgui_style_var.ItemSpacing, {0, 0})
	imgui.PushStyleVar(imgui_style_var.WindowPadding, {0, 0})
	imgui.PushStyleVar(imgui_style_var.WindowBorderSize, 5)
	imgui.ShowStyleEditor()
	imgui.SetNextWindowSizeConstraints({600, 300}, {600, 300})
	if imgui.Begin("adfs", 64) then
		-- local drawlist = imgui.GetOverlayDrawList()
		-- local Width = 600
		-- local X, Y = table.unpack(imgui.GetWindowPos())
		-- local darkblood = 0xFF0F0851
		-- local lightblood = 0xFF211C67
		-- local whiteblood = 0xFF938CAF
		-- local black = 0xFF000000
		-- local iV =function(X1, Y1)
			-- return imgui.CreateVector2(X1+X, Y1+Y)
		-- end
		-- local XX,YY = 0,45
		-- local XXX,YYY = 600,45
		-- drawlist.AddQuadFilled(
			-- iV(XX, YY), iV(XXX, YYY),
			-- iV(XXX, YYY), iV(XX, YY),
			-- whiteblood)
		-- local XX,YY = 0,45+220
		-- local XXX,YYY = 600,45+220
		-- drawlist.AddQuadFilled(
			-- iV(XX, YY), iV(XXX, YYY),
			-- iV(XXX, YYY), iV(XX, YY),
			-- whiteblood)
		-- local XX,YY = 400,45+220
		-- local XXX,YYY = 400,45
		-- drawlist.AddQuadFilled(
			-- iV(XX, YY), iV(XXX, YYY),
			-- iV(XXX, YYY), iV(XX, YY),
			-- whiteblood)
			iColumn(2)
			iColumnOffsetSet(1, 400)
			iColumnOffsetSet(2, 600)
			
			imgui.Button("123", {-1, 0})
			imgui.Button("123", {-1, 0})
			imgui.SetCursorPos({5, 45})
		if imgui.BeginChild("11", {400, 220}) then
			imgui.InputTextMultiline("##Sfas", "12", 1999, {-1, -1})
			imgui.EndChild()
		end
		imgui.Button("123", {-1, 0})
		imgui.Button("123", {-1, 0})
		iColumnNext()
		imgui.Button("123", {-1, 0})
		imgui.Button("123", {-1, 0})
		imgui.Button("Place", {-1, 0})
		imgui.Button("Destroy", {-1, 0})
		imgui.Button("Clear", {-1, 0})
		-- print(imgui.GetCursorPos())
		
		-- if imgui.BeginChild("151", {200, 220}) then
			-- imgui.InputTextMultiline("##Sfas", "", 1999, {-1, -1})
			-- imgui.EndChild()
		-- end
		-- imgui.Button("123", {-1, 0})
		-- imgui.Button("123", {-1, 0})
		local Table1 = {1,2,3}
		local Table2 = {4,5,6}
		local Table3 = {7,8,9}
		-- imgui.ArrowButton("af", "Down")
		-- imgui.Separator()
		-- imgui.Columns(2)
		
		-- imgui.SetColumnOffset()
		-- imgui.Text("dasf")
	end
end