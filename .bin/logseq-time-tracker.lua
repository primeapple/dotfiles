#!/usr/bin/env lua

-- Logseq Time Tracker
-- Parses journal files and calculates work time durations

---@enum WorkType
local WorkType = {
	feat = "feat",
	incident = "incident",
	know = "know",
	maintenance = "maintenance",
	org = "org",
	quit = "quit",
	support = "support",
}
local CategoryExcelOrder = { "feat", "incident", "know", "maintenance", "org", "support" }

--- @alias WorkItem { category: WorkType, time: string, minutes: number}
--- @alias WorkSession { category: WorkType, startTime: string, startMinutes: number, endTime: string, endMinutes: number }
--- @alias WorkSummary  table<WorkType, { totalDuration: number, totalPercentage: number, sessions: WorkSession[]}>

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
			assert(currentStart.minutes < entry.minutes)
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
--- @return WorkSummary
local function summarizeByCategory(sessions)
	--- @type WorkSummary
	local summary = {}
	for _, category in pairs(WorkType) do
		summary[category] = {
			totalDuration = 0,
			totalPercentage = 0,
			sessions = {},
		}
	end

	local dailyTotalDuration = 0
	for _, session in ipairs(sessions) do
		summary[session.category].totalDuration = summary[session.category].totalDuration
			+ session.endMinutes
			- session.startMinutes
		table.insert(summary[session.category].sessions, session)
		dailyTotalDuration = dailyTotalDuration + session.endMinutes - session.startMinutes
	end

	for _, summarized in pairs(summary) do
		summarized.totalPercentage = summarized.totalDuration / dailyTotalDuration
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
--- @param shouldPrint boolean
--- @return WorkSummary?
local function processJournalFile(filename, shouldPrint)
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
		return
	end

	assert(
		entries[#entries].category == WorkType.quit,
		"Last item at time " .. entries[#entries].time .. " is not #work/quit on journal " .. filename
	)

	if shouldPrint then
		print("=== Journal: " .. filename .. " ===")
		print("Found " .. #entries .. " work entries:")
		for _, entry in ipairs(entries) do
			print("  " .. entry.time .. " #work/" .. entry.category)
		end
		print()
	end

	local sessions = calculateWorkSessions(entries)
	if shouldPrint then
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

	local summary = summarizeByCategory(sessions)
	if shouldPrint then
		print("Summary by Category:")
		local totalTime = 0
		for category, data in pairs(summary) do
			print(string.format("  %s: %s (%d sessions)", category, minutesToTime(data.totalDuration), #data.sessions))
			totalTime = totalTime + data.totalDuration
		end
		print(string.format("  TOTAL: %s", minutesToTime(totalTime)))
		print()
	end

	return summary
end

local function main()
	if #arg == 0 then
		print("Usage: lua logseq_tracker.lua <journal_file1.md> [journal_file2.md] ...")
		print("Example: lua logseq_tracker.lua journals/2024_01_15.md")
		os.exit(1)
	end

	local summaries = {}
	for _, filename in ipairs(arg) do
		local summary = processJournalFile(filename, true)
		if summary then
			table.insert(summaries, { date = filename, summary = summary })

			io.write(filename .. "\n")
			for _, category in ipairs(CategoryExcelOrder) do
				io.write(category .. ", ")
			end
            io.write("\n")
			for _, category in ipairs(CategoryExcelOrder) do
				io.write(summary[category].totalPercentage .. ", ")
			end
            io.write("\n")
		end
	end
end

main()
