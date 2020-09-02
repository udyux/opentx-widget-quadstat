--[[ QuadStat v1.0

https://github.com/udyux/opentx-widget-quadstat
Copyright 2020 | Nicolas Udy | MIT License

DISCLAIMER
This script does not rely on telemetry. It does not reflect the actual craft's state and should not
be used in situations where reliable data is critical. It is the user's responsibility to check for
correct operation before use.

**IF IN DOUBT DO NOT FLY!**
]]

local inputs = {
  { "Armed", SOURCE, 115 },
  { "Level", SOURCE, 111 },
  { "Turtle", SOURCE, 112 },
  { "ArmClr", COLOR, WHITE },
  { "DisarmClr", COLOR, LIGHTGREY }
}

local function create(zone, options)
  return { zone = zone, options = options }
end

local function update(widget, options)
  widget.options = options
end

local function background() end

local function refresh(widget)
  if getValue(widget.options.Armed) <= 0 then
    lcd.setColor(CUSTOM_COLOR, widget.options.DisarmClr)
    lcd.drawText(widget.zone.x, widget.zone.y, "Disarmed", DBLSIZE + CUSTOM_COLOR)
    return
  end

  local modeState = getValue(widget.options.Turtle) > 0 and "Turlte"
    or getValue(widget.options.Level) > 0 and "Level"
    or "Acro"

  lcd.setColor(CUSTOM_COLOR, widget.options.ArmClr)
  lcd.drawText(widget.zone.x, widget.zone.y, "Armed", DBLSIZE + CUSTOM_COLOR)
  lcd.drawText(widget.zone.x + 108, widget.zone.y + 14, modeState, CUSTOM_COLOR)
end

return {
  name = "QuadStat",
  options = inputs,
  create = create,
  background = background,
  update = update,
  refresh = refresh
}
