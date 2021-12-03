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
    | _ -> printfn "Oops!"
    0
