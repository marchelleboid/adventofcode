namespace AdventOfCode2024.Day8;

public class Day8A : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day8.txt");

        var maxX = lines[0].Length;
        var maxY = lines.Length;

        var antennas = new Dictionary<char, List<(int, int)>>();

        for (var y = 0; y < lines.Length; y++)
        {
            for (var x = 0; x < lines[0].Length; x++)
            {
                if (lines[y][x] != '.')
                {
                    var list = antennas.GetValueOrDefault(lines[y][x], []);
                    list.Add((x, y));
                    antennas[lines[y][x]] = list;
                }
            }
        }

        var antinodes = new HashSet<(int, int)>();

        foreach (var frequency in antennas)
        {
            for (var i = 0; i < frequency.Value.Count - 1; i++)
            {
                for (var j = i + 1; j < frequency.Value.Count; j++)
                {
                    var first = frequency.Value[i];
                    var second = frequency.Value[j];
                    
                    var slopeX = first.Item1 - second.Item1;
                    var slopeY = first.Item2 - second.Item2;
                    
                    var antinode1 = (first.Item1 + slopeX, first.Item2 + slopeY);
                    var antinode2 = (second.Item1 - slopeX, second.Item2 - slopeY);

                    if (antinode1.Item1 >= 0 && antinode1.Item1 < maxX &&
                        antinode1.Item2 >= 0 && antinode1.Item2 < maxY)
                    {
                        antinodes.Add(antinode1);
                    }
                    
                    if (antinode2.Item1 >= 0 && antinode2.Item1 < maxX &&
                        antinode2.Item2 >= 0 && antinode2.Item2 < maxY)
                    {
                        antinodes.Add(antinode2);
                    }
                }
            }
        }
        
        Console.WriteLine(antinodes.Count);
    }
}