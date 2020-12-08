module Day8b

open System.IO

let parseInstruction (line : string) =
    let parts = line.Split(" ")
    parts.[0], int parts.[1]

let rec findSwappableInstructions swaps index instructions =
    if index = Array.length instructions then swaps
    else
        let instruction, value = instructions.[index]
        match instruction with
        | "nop" | "jmp" -> findSwappableInstructions (index :: swaps) (index + 1) instructions
        | _ -> findSwappableInstructions swaps (index + 1) instructions

let rec runProgram instructionPointer accumulator seen swap (instructions : array<string * int>) =
    if instructionPointer = Array.length instructions then true, accumulator
    else if Set.contains instructionPointer seen then false, accumulator
    else
        let instruction, value = instructions.[instructionPointer]
        match instruction with
        | "acc" -> runProgram (instructionPointer + 1) (accumulator + value) (Set.add instructionPointer seen) swap instructions
        | "jmp" when instructionPointer = swap -> runProgram (instructionPointer + 1) accumulator (Set.add instructionPointer seen) swap instructions
        | "jmp" -> runProgram (instructionPointer + value) accumulator (Set.add instructionPointer seen) swap instructions
        | "nop" when instructionPointer = swap -> runProgram (instructionPointer + value) accumulator (Set.add instructionPointer seen) swap instructions
        | _ -> runProgram (instructionPointer + 1) accumulator (Set.add instructionPointer seen) swap instructions

let solver =
    let instructions = File.ReadLines "Inputs\\day8.txt" |> Seq.map parseInstruction |> Seq.toArray
    findSwappableInstructions List.empty 0 instructions
        |> Seq.map (fun swap -> runProgram 0 0 Set.empty swap instructions)
        |> Seq.iter (fun (x, y) -> if x = true then printfn "%d" y)
