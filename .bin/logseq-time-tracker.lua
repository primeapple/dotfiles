#!/usr/bin/env lua

-- Logseq Time Tracker
-- Parses journal files and calculates work time durations

---@enum WorkType
local WorkType = {
	collab = "collab",
	dev = "dev",
	know = "know",
	org = "org",
	quit = "quit",
	rand = "rand",
}
local CategoryOrder = {
	WorkType.dev,
	WorkType.collab,
	WorkType.know,
	WorkType.org,
	WorkType.rand,
}

--- @alias WorkItem { category: WorkType, time: string, minutes: number}
--- @alias WorkSession { category: WorkType, startTime: string, startMinutes: number, endTime: string, endMinutes: number }
--- @alias WorkSummary { date: osdateparam, totalDuration: number, sessionsByType: table<WorkType, { totalDuration: number, totalPercentage: number, sessions: WorkSession[]}> }

--- @param path string
--- @return osdateparam date
local function parsePathDate(path)
	local year, month, day = path:match(".*(%d%d%d%d)_(%d%d)_(%d%d).md")
	return {
		year = year,
		month = month,
		day = day,
	}
end

local isDebug = os.getenv("DEBUG") ~= nil

--- @param timeStr string
--- @return number?
local function parseTime(timeStr)
	local hour, minute = timeStr:match("(%d+):(%d+)")
	if hour and minute then
		return tonumber(hour) * 60 + tonumber(minute)
	end
	return nil
end

--- @param line string
--- @return WorkItem?
local function parseWorkEntry(line)
	-- Match pattern: - 10:15 #work/category
	local time, category = line:match("^- (%d+:%d+) #work/(%w+)")

	if time and category then
		category = WorkType[category]
		local minutes = parseTime(time)

		if minutes and category then
			return { category = category, time = time, minutes = minutes }
		end
	end

	return nil
end

--- @param entries WorkItem[]
--- @return WorkSession
local function calculateWorkSessions(entries)
	local sessions = {}
	local currentStart = nil
	local currentCategory = nil

	for _, entry in ipairs(entries) do
		if currentStart and currentCategory then
			assert(
				currentStart.minutes < entry.minutes,
				"There was a task at time "
					.. entry.time
					.. " of category "
					.. entry.category
					.. "that has a start date before the previous task in the journal"
			)
			table.insert(sessions, {
				category = currentCategory,
				startTime = currentStart.time,
				startMinutes = currentStart.minutes,
				endTime = entry.time,
				endMinutes = entry.minutes,
			})
		end
		if entry.category == WorkType.quit then
			currentStart = nil
			currentCategory = nil
		else
			currentStart = entry
			currentCategory = entry.category
		end
	end

	assert(currentStart == nil and currentCategory == nil)

	return sessions
end

--- @param sessions WorkSession[]
--- @param date osdateparam
--- @return WorkSummary
local function summarizeByCategory(sessions, date)
	--- @type WorkSummary
	local summary = {
		date = date,
		totalDuration = 0,
		sessionsByType = {},
	}
	for _, category in pairs(WorkType) do
		summary.sessionsByType[category] = {
			totalDuration = 0,
			totalPercentage = 0,
			sessions = {},
		}
	end

	local dailyTotalDuration = 0
	for _, session in ipairs(sessions) do
		summary.sessionsByType[session.category].totalDuration = summary.sessionsByType[session.category].totalDuration
			+ session.endMinutes
			- session.startMinutes
		table.insert(summary.sessionsByType[session.category].sessions, session)
		dailyTotalDuration = dailyTotalDuration + session.endMinutes - session.startMinutes
	end
	summary.totalDuration = dailyTotalDuration

	for _, summarized in pairs(summary.sessionsByType) do
		if dailyTotalDuration == 0 then
			summarized.totalPercentage = 0
		else
			summarized.totalPercentage = summarized.totalDuration / dailyTotalDuration
		end
	end

	return summary
end

--- @param minutes number
--- @return string
local function minutesToTime(minutes)
	local hours = math.floor(minutes / 60)
	local mins = minutes % 60
	return string.format("%dh %02dm", hours, mins)
end

--- @param filename string
--- @return WorkSummary
local function processJournalFile(filename)
	local file = io.open(filename, "r")
	if not file then
		error("Could not open file " .. filename)
	end

	local entries = {}
	for line in file:lines() do
		local entry = parseWorkEntry(line)
		if entry then
			if #entries > 1 then
				assert(
					entry.minutes > entries[#entries].minutes,
					"Journal " .. filename .. " appears unordered at entry " .. entry.time
				)
			end
			table.insert(entries, entry)
		end
	end
	file:close()

	if #entries == 0 then
		if isDebug then
			print("Journal page was empty: " .. "filename")
		end
		return summarizeByCategory({}, parsePathDate(filename))
	end

	assert(
		entries[#entries].category == WorkType.quit,
		"Last item at time " .. entries[#entries].time .. " is not #work/quit on journal " .. filename
	)

	if isDebug then
		print("=== Journal: " .. filename .. " ===")
		print("Found " .. #entries .. " work entries:")
		for _, entry in ipairs(entries) do
			print("  " .. entry.time .. " #work/" .. entry.category)
		end
		print()
	end

	local sessions = calculateWorkSessions(entries)
	if isDebug then
		print("Work Sessions:")
		for _, session in ipairs(sessions) do
			print(
				string.format(
					"  %s-%s #work/%s (%s)",
					session.startTime,
					session.endTime,
					session.category,
					minutesToTime(session.endMinutes - session.startMinutes)
				)
			)
		end
		print()
	end

	local summary = summarizeByCategory(sessions, parsePathDate(filename))
	if isDebug then
		print("Summary by Category:")
		for category, data in pairs(summary.sessionsByType) do
			print(string.format("  %s: %s (%d sessions)", category, minutesToTime(data.totalDuration), #data.sessions))
		end
		print(string.format("  TOTAL: %s", minutesToTime(summary.totalDuration)))
		print()
	end

	return summary
end

---@param summary WorkSummary
local function plotData(summary)
	local dateStr = string.format("%04d-%02d-%02d", summary.date.year, summary.date.month, summary.date.day)
	print("Date: " .. dateStr .. " | Total: " .. minutesToTime(summary.totalDuration))

	local maxHours = 0
	for _, category in ipairs(CategoryOrder) do
		local hours = summary.sessionsByType[category].totalDuration / 60
		if hours > maxHours then
			maxHours = hours
		end
	end
	local yMax = math.ceil(maxHours * 2) / 2
	if yMax == 0 then
		yMax = 0.5
	end
	local height = math.ceil(yMax * 2) + 2

	local gnuplotScript = {}
	table.insert(gnuplotScript, "reset session")
	table.insert(gnuplotScript, "set terminal dumb size 80 " .. height)

	table.insert(gnuplotScript, "set yrange [0:" .. yMax .. "]")
	table.insert(gnuplotScript, "set ytics 0, 0.5, " .. yMax .. " format \"%.1fh\"")
	table.insert(gnuplotScript, "unset key")
	table.insert(gnuplotScript, "set tics nomirror")
	table.insert(gnuplotScript, "set bmargin 1")
	table.insert(gnuplotScript, "set tmargin 0")
	table.insert(gnuplotScript, "set offsets 0,0,0,0")
	table.insert(gnuplotScript, "set style fill solid 1.0 noborder")
	table.insert(gnuplotScript, "set boxwidth 0.8")

	table.insert(gnuplotScript, "$Data << EOD")
	for _, category in ipairs(CategoryOrder) do
		table.insert(gnuplotScript, category .. " " .. summary.sessionsByType[category].totalDuration / 60)
	end
	table.insert(gnuplotScript, "EOD")

	table.insert(gnuplotScript, "plot $Data using ($0+1):($2):xtic(1) with boxes")

	local gp = io.popen("gnuplot -persist", "w")
	if gp then
		gp:write(table.concat(gnuplotScript, "\n") .. "\n")
		gp:close()
	else
		io.stderr:write("Error: Could not start gnuplot\n")
	end
end

local function getSummaries(filenames)
	--- @type WorkSummary[]
	local summaries = {}
	for _, filename in ipairs(filenames) do
		local summary = processJournalFile(filename)
		table.insert(summaries, summary)
	end
	table.sort(summaries, function(s1, s2)
		return os.time(s1.date) < os.time(s2.date)
	end)

	--- @type WorkSummary[]
	local summariesWithOffDays = {}
	local nextDate = summaries[1].date
	for _, summary in ipairs(summaries) do
		while
			(nextDate.year .. nextDate.month .. nextDate.day)
			< (summary.date.year .. summary.date.month .. summary.date.day)
		do
			table.insert(summariesWithOffDays, summarizeByCategory({}, nextDate))
			nextDate = os.date("*t", os.time(nextDate) + 24 * 60 * 60) --[[@as osdateparam]]
		end
		table.insert(summariesWithOffDays, summary)
		nextDate = os.date("*t", os.time(nextDate) + 24 * 60 * 60) --[[@as osdateparam]]
	end

	return summariesWithOffDays
end

local function main()
	local filenames = {}
	local plotDay = false

	for i, v in ipairs(arg) do
		if i > 0 then
			if v == "--plot-day" then
				plotDay = true
			else
				table.insert(filenames, v)
			end
		end
	end

	if #filenames == 0 then
		print("Usage: lua logseq_tracker.lua [--plot-day] <journal_file1.md> [journal_file2.md] ...")
		print("Example: lua logseq_tracker.lua journals/2024_01_15.md")
		print("Example: lua logseq_tracker.lua --plot-day journals/2024_01_15.md")
		os.exit(1)
	end

	local summaries = getSummaries(filenames)
	if plotDay then
		for _, summary in ipairs(summaries) do
			plotData(summary)
		end
	end
end

main()
