import strutils

var maxCalories = 0
var currentCalories = 0
for line in lines("input"):
    let stripped = line.strip
    if stripped.isEmptyOrWhitespace:
        if currentCalories > maxCalories:
            maxCalories = currentCalories
        currentCalories = 0
    else:
        currentCalories += stripped.parseInt

if currentCalories > maxCalories:
    maxCalories = currentCalories

echo maxCalories