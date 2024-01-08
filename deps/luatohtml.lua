function newSite()
	return {}
end

--[[
Puts tags into your website!
`site` - your site instance
`tag` - tag name
`attributes` - attributes inside of the tag
`content` - text inside/right after the tag
`head` - if true, tag will be in "head" section
`open` - if true, tag will not be closed right after
]]--
function put(site, tag, attributes, content, head, open)
	if head == true then head = "head" else head = "body" end
	if not content then content = "" end
	if not attributes then attributes = {} end
	if not open then open = false end
	site[#site + 1] = {tag, attributes, content, head, open}
	return site
end

-- Changes Lua functions into HTML code.
function prepare(site)
	head = {}
	body = {}
	for i = 1, #site do
		local site = site[i]
		local attributes = ""
		for j = 1, #site[2] do
			local site2 = site[2][j]
			attributes = attributes .. site2[1] .. "=\"" .. site2[2] .. "\" "
		end
		if site[5] == false then
			tag = "<" .. site[1] .. " " .. attributes .. ">" .. site[3] .. "</" .. site[1] .. ">"
		else tag = "<" .. site[1] .. " " .. attributes .. ">" .. site[3] end
		if site[4] == "head" then head[#head+1] = tag else body[#body+1] = tag end
	end
	texthead, textbody = "", ""
	for i = 1, #head do
		texthead = texthead .. head[i] .. "\n"
	end
	for i = 1, #body do
		textbody = textbody .. body[i] .. "\n"
	end
	return [[<html>
	<head>
		]] .. texthead .. [[
	</head>
	<body>
		]] .. textbody .. [[
	</body>
</html>]]
end
