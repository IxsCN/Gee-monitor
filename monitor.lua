--[[


]]--

module("luci.controller.app.monitor", package.seeall)

function index()

    local page   = node("app")
    page.target  = firstchild()
    page.title   = _("")
    page.order   = 10

	page.sysauth = "root"
	page.sysauth_authenticator = "htmlauth"

	entry({"status"}, call("get"), _(""), 135)

end

local utils = require "openapi.utils.utils"

function get()
	local http = require "luci.http"
    local out_obj={}
	out_obj.CPU_IDLE=luci.sys.exec(". /etc/market/monitor.script; get_CPU_IDLE")
    out_obj.MEM_FREE=luci.sys.exec(". /etc/market/monitor.script; get_MEM_FREE")
    out_obj.MEM_USED=luci.sys.exec(". /etc/market/monitor.script; get_MEM_USED")
	http.write_json(out_obj, true) 
end