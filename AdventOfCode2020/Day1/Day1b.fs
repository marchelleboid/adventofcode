module Day1b

open System.IO

let solver =
    let expenses = File.ReadLines "Inputs\\day1.txt" |> Seq.map int
    let expensesLength = Seq.length expenses
    for i = 0 to (expensesLength - 3) do
        for j = i + 1 to (expensesLength - 2) do
            let first = Seq.item i expenses
            let second = Seq.item j expenses
            if first + second < 2020 then
                for k = j + 1 to (expensesLength - 1) do
                    let third = Seq.item k expenses
                    if first + second + third = 2020 then printf "%d" (first * second * third)
