module Day4b

open System
open System.IO
open System.Collections.Generic
open System.Text.RegularExpressions

let rec combinePair xs =
    match xs with
    | [] | [_] -> []
    | x1::x2::rest -> (x1, x2) :: (combinePair rest)

let handleLine (current : Dictionary<string, string>) (line : string) =
    let zipped = line.Split(" :".ToCharArray(), StringSplitOptions.RemoveEmptyEntries) |> Array.toList |> combinePair
    zipped |> List.iter (fun (k, v) -> current.Add(k, v))
    current

let rec parseLines passports current lines =
    match lines with
    | [] -> (current :: passports)
    | x::rest ->
        match x with
        | "" -> parseLines (current :: passports) (new Dictionary<string, string>()) rest
        | _ -> parseLines passports (handleLine current x) rest

let isValidByr byr =
    let intByr = int byr
    intByr >= 1920 && intByr <= 2002

let isValidIyr iyr =
    let intIyr = int iyr
    intIyr >= 2010 && intIyr <= 2020

let isValidEyr eyr =
    let intEyr = int eyr
    intEyr >= 2020 && intEyr <= 2030

let isValidHgt (hgt : string) =
    match Seq.length hgt with
    | 4 -> hgt.[2..3] = "in" && hgt.[0..1] |> Seq.forall Char.IsDigit && (int hgt.[0..1] >= 59) && (int hgt.[0..1] <= 76)
    | 5 -> hgt.[3..4] = "cm" && hgt.[0..2] |> Seq.forall Char.IsDigit && (int hgt.[0..2] >= 150) && (int hgt.[0..2] <= 193)
    | _ -> false

let isValidHcl hcl =
    Regex.IsMatch(hcl, @"^#[0-9a-f]{6}$")

let isValidEcl ecl =
    List.contains ecl ["amb"; "blu"; "brn"; "gry"; "grn"; "hzl"; "oth"]

let isValidPid pid =
    pid |> Seq.length = 9 && pid |> Seq.forall Char.IsDigit

let isValidPassport (passport : Dictionary<string, string>) =
    if not (passport.Count = 8 || (passport.Count = 7 && not (passport.ContainsKey("cid")))) then false
    else
        isValidByr(passport.["byr"]) &&
        isValidIyr(passport.["iyr"]) &&
        isValidEyr(passport.["eyr"]) &&
        isValidHgt(passport.["hgt"]) &&
        isValidHcl(passport.["hcl"]) &&
        isValidEcl(passport.["ecl"]) &&
        isValidPid(passport.["pid"])

let solver =
    File.ReadLines "Inputs\\day4.txt"
        |> List.ofSeq
        |> parseLines List.empty<Dictionary<string, string>> (new Dictionary<string, string>())
        |> List.filter isValidPassport
        |> List.length
        |> printfn "%d"