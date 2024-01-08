local luatohtml = require("deps/luatohtml")

local site = newSite()

site = put(site, "title", nil, "Welcome to the example website!", true)
site = put(site, "style", nil, [[
body {
	margin: 0;
	background: linear-gradient(to left, green, yellow);
}
]], true)
site = put(site, "h1", nil, nil, false, true)
site = put(site, "p", nil, "i guess its a text")
site = put(site, "/h1", nil, nil, false, true)
site = put(site, "button", {{"style", "background-color: orange; margin: 10px;"}}, "i guess its a button")
site = prepare(site)

-- Requites Luvit, note that this is just an example and the library itself may not require Luvit.
require("coro-http").createServer("127.0.0.1", 80, function(req, body)
	if req.path == "/example.html" then
		local info = {
			{"Content-Length", tostring(#site)},
			{"Content-Type", "text/html"},
			{"Connection", "close"},
			code = 200,
			reason = "OK",
		}
		return info, site
	end
end)
