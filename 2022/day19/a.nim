import deques
import math
import sequtils
import strscans

type
    Cost = object
        ore: int
        clay: int
        obsidian: int

type
    Blueprint = object
        id: int
        oreRobotCost: Cost
        clayRobotCost: Cost
        obsidianRobotCost: Cost
        geodeRobotCost: Cost

type
    State = object
        minute: int
        ore: int
        clay: int
        obsidian: int
        geodes: int
        oreRobots: int
        clayRobots: int
        obsidianRobots: int

func parseLine(line: string): Blueprint =
    var id, oreCost, clayCost, obsidianOreCost, obsidianClayCost, geodeOreCost, geodeObsidianCost: int
    discard line.scanf("Blueprint $i: Each ore robot costs $i ore. Each clay robot costs $i ore. Each obsidian robot costs $i ore and $i clay. Each geode robot costs $i ore and $i obsidian.", id, oreCost, clayCost, obsidianOreCost, obsidianClayCost, geodeOreCost, geodeObsidianCost)
    let oreRobotCost = Cost(ore: oreCost)
    let clayRobotCost = Cost(ore: clayCost)
    let obsidianRobotCost = Cost(ore: obsidianOreCost, clay: obsidianClayCost)
    let geodeRobotCost = Cost(ore: geodeOreCost, obsidian: geodeObsidianCost)
    return Blueprint(id: id, oreRobotCost: oreRobotCost, clayRobotCost: clayRobotCost, obsidianRobotCost: obsidianRobotCost, geodeRobotCost: geodeRobotCost)

proc getQualityLevel(blueprint: Blueprint): int =
    var maxGeodes = 0
    let initialState = State(oreRobots: 1)

    var states = [initialState].toDeque
    while states.len > 0:
        let state = states.popFirst
        if state.minute >= 24:
            maxGeodes = max(maxGeodes, state.geodes)
            continue

        let couldBuildGeodeRobot = true
        let couldBuildObsidianRobot = state.obsidianRobots < blueprint.geodeRobotCost.obsidian
        let couldBuildClayRobot = state.clayRobots < blueprint.obsidianRobotCost.clay
        let couldBuildOreRobot = 
            state.oreRobots < max(blueprint.clayRobotCost.ore, max(blueprint.obsidianRobotCost.ore, blueprint.geodeRobotCost.ore))

        let minutesLeft = 24 - state.minute
        if couldBuildGeodeRobot:
            if state.obsidianRobots != 0:
                let minutesNeededOre = int(ceil((blueprint.geodeRobotCost.ore - state.ore) / state.oreRobots))
                let minutesNeededObsidian = int(ceil((blueprint.geodeRobotCost.obsidian - state.obsidian) / state.obsidianRobots))
                let minutesNeeded = max(max(minutesNeededOre, minutesNeededObsidian), 0)
                if minutesNeeded < minutesLeft:
                    var newGeodesState = state
                    newGeodesState.minute = state.minute + (minutesNeeded + 1)
                    newGeodesState.ore = state.ore + state.oreRobots * (minutesNeeded + 1) - blueprint.geodeRobotCost.ore
                    newGeodesState.clay = state.clay + state.clayRobots * (minutesNeeded + 1)
                    newGeodesState.obsidian = state.obsidian + state.obsidianRobots * (minutesNeeded + 1) - blueprint.geodeRobotCost.obsidian
                    newGeodesState.geodes = state.geodes + (minutesLeft - (minutesNeeded + 1))
                    maxGeodes = max(maxGeodes, newGeodesState.geodes)
                    states.addLast(newGeodesState)
        if couldBuildObsidianRobot:
            if state.clayRobots != 0:
                let minutesNeededOre = int(ceil((blueprint.obsidianRobotCost.ore - state.ore) / state.oreRobots))
                let minutesNeededClay = int(ceil((blueprint.obsidianRobotCost.clay - state.clay) / state.clayRobots))
                let minutesNeeded = max(max(minutesNeededOre, minutesNeededClay), 0)
                if minutesNeeded < minutesLeft:
                    var newObsidianState = state
                    newObsidianState.minute = state.minute + (minutesNeeded + 1)
                    newObsidianState.ore = state.ore + state.oreRobots * (minutesNeeded + 1) - blueprint.obsidianRobotCost.ore
                    newObsidianState.clay = state.clay + state.clayRobots * (minutesNeeded + 1) - blueprint.obsidianRobotCost.clay
                    newObsidianState.obsidian = state.obsidian + state.obsidianRobots * (minutesNeeded + 1)
                    newObsidianState.obsidianRobots = state.obsidianRobots + 1
                    states.addLast(newObsidianState)
        if couldBuildClayRobot:
            let minutesNeeded = max(int(ceil((blueprint.clayRobotCost.ore - state.ore) / state.oreRobots)), 0)
            if minutesNeeded < minutesLeft:
                var newClayState = state
                newClayState.minute = state.minute + minutesNeeded + 1
                newClayState.ore = state.ore + state.oreRobots * (minutesNeeded + 1) - blueprint.clayRobotCost.ore
                newClayState.clay = state.clay + state.clayRobots * (minutesNeeded + 1)
                newClayState.obsidian = state.obsidian + state.obsidianRobots * (minutesNeeded + 1)
                newClayState.clayRobots = state.clayRobots + 1
                states.addLast(newClayState)
        if couldBuildOreRobot:
            let minutesNeeded = max(int(ceil((blueprint.oreRobotCost.ore - state.ore) / state.oreRobots)), 0)
            if minutesNeeded < minutesLeft:
                var newOreState = state
                newOreState.minute = state.minute + (minutesNeeded + 1)
                newOreState.ore = state.ore + state.oreRobots * (minutesNeeded + 1) - blueprint.oreRobotCost.ore
                newOreState.clay = state.clay + state.clayRobots * (minutesNeeded + 1)
                newOreState.obsidian = state.obsidian + state.obsidianRobots * (minutesNeeded + 1)
                newOreState.oreRobots = state.oreRobots + 1
                states.addLast(newOreState)

    return maxGeodes * blueprint.id

var blueprints: seq[Blueprint]
for line in lines("input"):
    blueprints.add(parseLine(line))

echo map(blueprints, getQualityLevel).foldl(a + b)