local beautiful = require("beautiful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local ip_widget = {}
local function worker(user_args)
    local args = user_args or {}

    local font = args.font or beautiful.font
    local timeout = args.timeout or 30
    local adapter = args.adapter or 'eth0'

    local ip_widget = wibox.widget {
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox,
        font   = font
    }


    local update_widget = function(widget, stdout)
        widget:set_text(stdout:gsub("%s+", ""))
    end

    watch(string.format([[bash -c "ip -o -4 addr list %s | awk '{print $4}'"]], adapter),
        timeout, update_widget, ip_widget)


    return ip_widget
end

return setmetatable(ip_widget, { __call = function(_, ...) return worker(...) end })
