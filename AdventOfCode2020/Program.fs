module Program

[<EntryPoint>]
let main argv =
    match argv.[0] with
    | "1a" -> Day1a.solver
    | "1b" -> Day1b.solver
    | "2a" -> Day2a.solver
    | "2b" -> Day2b.solver
    | "3a" -> Day3a.solver
    | "3b" -> Day3b.solver
    | "4a" -> Day4a.solver
    | "4b" -> Day4b.solver
    | "5a" -> Day5a.solver
    | "5b" -> Day5b.solver
    | "6a" -> Day6a.solver
    | "6b" -> Day6b.solver
    | "7a" -> Day7a.solver
    | "7b" -> Day7b.solver
    | "8a" -> Day8a.solver
    | "8b" -> Day8b.solver
    | "9a" -> Day9a.solver
    | "9b" -> Day9b.solver
    | "10a" -> Day10a.solver
    | "10b" -> Day10b.solver
    | _ -> printfn "Oops!"
    0
