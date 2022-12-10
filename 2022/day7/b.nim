import sets
import strutils
import tables

var currentDirectory = ""

var dirs = initHashSet[string]()
var childrenDirs = initTable[string, HashSet[string]]()
var fileSizes = initTable[string, int]()

for line in lines("input"):
    let splitLine = line.strip.split(" ")
    if splitLine[0] == "$":
        if splitLine[1] == "cd":
            if splitLine[2] == "..":
                let lastSlash = currentDirectory.rfind("/")
                if lastSlash == 0:
                    currentDirectory = "/"
                else:
                    currentDirectory = currentDirectory[0 ..< lastSlash]
            else:
                if splitLine[2] == "/":
                    currentDirectory = "/"
                else:
                    currentDirectory = currentDirectory & "/" & splitLine[2]
                dirs.incl(currentDirectory)
    else:
        if splitLine[0] == "dir":
            var currentChildren = childrenDirs.getOrDefault(currentDirectory, initHashSet[string]())
            currentChildren.incl(splitLine[1])
            childrenDirs[currentDirectory] = currentChildren
        else:
            let currentSize = fileSizes.getOrDefault(currentDirectory, 0)
            fileSizes[currentDirectory] = currentSize + splitLine[0].parseInt

proc countFileSizes(dir: string): int =
    var childCount = 0
    for child in childrenDirs.getOrDefault(dir, initHashSet[string]()):
        childCount += countFileSizes(dir & "/" & child)
    return childCount + fileSizes.getOrDefault(dir, 0)

let unusedSpace = 70000000 - countFileSizes("/")
let needToDelete = 30000000 - unusedSpace

var smallestValidSize = 30000000
for dir in dirs:
    let size = countFileSizes(dir)
    if size >= needToDelete and size < smallestValidSize:
        smallestValidSize = size

echo smallestValidSize