local wibox = require("wibox")
local beautiful = require('beautiful')
local gears = require('gears')

local ICON_DIR = os.getenv("HOME") .. '/.config/awesome/awesome-wm-widgets/volume-widget/icons/'

local ICON_NORMAL = ICON_DIR .. 'audio-volume-high-symbolic.svg'
local ICON_MUTED = ICON_DIR .. 'audio-volume-muted-symbolic.svg'

local widget = {}

function widget.get_widget(widgets_args)
    local args = widgets_args or {}

    local thickness = args.thickness or 2
    local main_color = args.main_color or beautiful.fg_color
    local bg_color = args.bg_color or '#ffffff11'
    local size = args.size or 18

    local icon = wibox.widget {
        id = "icon",
        image = gears.color.recolor_image(ICON_NORMAL, beautiful.fg_normal),
        resize = true,
        widget = wibox.widget.imagebox,
    }
    return wibox.widget {
        icon,
        max_value = 100,
        thickness = thickness,
        start_angle = 4.71238898, -- 2pi*3/4
        forced_height = size,
        forced_width = size,
        bg = bg_color,
        paddings = 2,
        widget = wibox.container.arcchart,
        colors = { main_color },

        set_volume_level = function(self, new_value)
            self.value = new_value
        end,
        mute = function(self)
            icon.image = gears.color.recolor_image(ICON_MUTED, beautiful.fg_normal)
            self.colors = { '#ffffff00' }
        end,
        unmute = function(self)
            icon.image = gears.color.recolor_image(ICON_NORMAL, beautiful.fg_normal)
            self.colors = { main_color }
        end
    }

end

return widget
