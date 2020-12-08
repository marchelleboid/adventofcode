module Day8a

open System.IO

let parseInstruction (line : string) =
    let parts = line.Split(" ")
    parts.[0], int parts.[1]

let rec runProgram instructionPointer accumulator seen (instructions : array<string * int>) =
    if Set.contains instructionPointer seen then accumulator
    else
        let instruction, value = instructions.[instructionPointer]
        match instruction with
        | "acc" -> runProgram (instructionPointer + 1) (accumulator + value) (Set.add instructionPointer seen) instructions
        | "jmp" -> runProgram (instructionPointer + value) accumulator (Set.add instructionPointer seen) instructions
        | _ -> runProgram (instructionPointer + 1) accumulator (Set.add instructionPointer seen) instructions

let solver =
    File.ReadLines "Inputs\\day8.txt"
        |> Seq.map parseInstruction
        |> Seq.toArray
        |> runProgram 0 0 Set.empty
        |> printfn "%d"
