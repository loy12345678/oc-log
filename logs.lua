local component = require("component")
local sides = require("sides")

local t = component.transposer
local sideNames = {
  left = "left",
  right = "right", 
  front = "front",
  back = "back",
  top = "top",
  bottom = "bottom"
}

print("=== DIAGNOSTYKA TRANSCIVERA ===\n")

-- 1. Listuj dostępne komponenty
print("📦 KOMPONENTY:")
for name, addr in pairs(component.list()) do
  print("  " .. name .. " → " .. addr)
end

print("\n📍 STRONY TRANSCIVERA:")
local sides_list = {sides.left, sides.right, sides.front, sides.back, sides.top, sides.bottom}
local sides_names = {"left", "right", "front", "back", "top", "bottom"}

for idx, side in ipairs(sides_list) do
  local name = sides_names[idx]
  local size = t.getInventorySize(side)
  
  if size then
    print("  [" .. name .. "] → Inwentarz " .. size .. " slotów")
    -- Pokaż zawartość pierwszych 3 slotów
    for i = 1, math.min(3, size) do
      local stack = t.getStackInSlot(side, i)
      if stack then
        print("      Slot " .. i .. ": " .. stack.label .. " (×" .. stack.size .. ")")
      else
        print("      Slot " .. i .. ": [pusty]")
      end
    end
  else
    print("  [" .. name .. "] → Brak (przeszkoda)")
  end
end

print("\n✅ REKOMENDACJA CHAIN:")
print("local CHAIN = {sides.left, sides.right}")
print("  lub")
print("local CHAIN = {sides.front, sides.back}")
print("  w zależności od fizycznego ułożenia modułów")
