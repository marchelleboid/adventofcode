module Program

[<EntryPoint>]
let main argv =
    match argv.[0] with
    | "1a" -> Day1a.solver
    | "1b" -> Day1b.solver
    | _ -> printfn "Oops!"
    0
