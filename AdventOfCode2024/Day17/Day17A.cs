namespace AdventOfCode2024.Day17;

public class Day17A : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day17.txt");

        var a = int.Parse(lines[0].Split(": ")[1]);
        var b = int.Parse(lines[1].Split(": ")[1]);
        var c = int.Parse(lines[2].Split(": ")[1]);

        var program = lines[4].Split(": ")[1].Split(",").Select(int.Parse).ToArray();
        
        int GetComboOperand(int i)
        {
            return i switch
            {
                >= 0 and <= 3 => i,
                4 => a,
                5 => b,
                6 => c,
                _ => throw new ArgumentOutOfRangeException()
            };
        }

        var pointer = 0;
        var output = new List<int>();
        while (pointer < program.Length)
        {
            var instruction = program[pointer];
            var operand = program[pointer + 1];

            switch (instruction)
            {
                case 0:
                    a = a / (1 << GetComboOperand(operand));
                    break;
                case 1:
                    b ^= operand;
                    break;
                case 2:
                    b = GetComboOperand(operand) % 8;
                    break;
                case 3:
                    if (a != 0)
                    {
                        pointer = operand;
                        continue;
                    }
                    break;
                case 4:
                    b ^= c;
                    break;
                case 5:
                    output.Add(GetComboOperand(operand) % 8);
                    break;
                case 6:
                    b = a / (1 << GetComboOperand(operand));
                    break;
                case 7:
                    c = a / (1 << GetComboOperand(operand));
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

            pointer += 2;
        }
        
        Console.WriteLine(string.Join(",", output.ConvertAll(n => n.ToString())));
    }
}