namespace AdventOfCode2024.Day17;

public class Day17B : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day17.txt");

        var program = lines[4].Split(": ")[1].Split(",").Select(int.Parse).ToArray();

        var candidates = new HashSet<ulong>();
        
        var queue = new Queue<(ulong previous, int position)>();
        queue.Enqueue((0UL, program.Length - 1));
        while (queue.Count > 0)
        {
            var (previous, position) = queue.Dequeue();
            if (position == -1)
            {
                candidates.Add(previous);
                continue;
            }
            
            for (var i = 0UL; i < 8UL; i++)
            {
                var a = (previous << 3) | i;
                var output = RunProgram(a, 0, 0, program, true);
                if ((int) output[0] == program[position])
                {
                    queue.Enqueue((a, position - 1));
                }
            }
        }
        
        Console.WriteLine(candidates.Min());
    }

    private static List<ulong> RunProgram(ulong a, ulong b, ulong c, int[] program, bool stopFirst)
    {
        ulong GetComboOperand(ulong i)
        {
            return i switch
            {
                >= 0 and <= 3 => i,
                4 => a,
                5 => b,
                6 => c,
                _ => throw new ArgumentOutOfRangeException(i.ToString())
            };
        }

        var pointer = 0;
        var output = new List<ulong>();
        while (pointer < program.Length)
        {
            var instruction = program[pointer];
            var operand = (ulong) program[pointer + 1];

            switch (instruction)
            {
                case 0:
                    a = a / (1UL << (int) GetComboOperand(operand));
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
                        pointer = (int) operand;
                        continue;
                    }
                    break;
                case 4:
                    b ^= c;
                    break;
                case 5:
                    output.Add(GetComboOperand(operand) % 8);
                    if (stopFirst)
                    {
                        return output;
                    }
                    break;
                case 6:
                    b = a / (1UL << (int) GetComboOperand(operand));
                    break;
                case 7:
                    c = a / (1UL << (int) GetComboOperand(operand));
                    break;
                default:
                    throw new ArgumentOutOfRangeException(instruction.ToString());
            }

            pointer += 2;
        }

        return output;
    }
}