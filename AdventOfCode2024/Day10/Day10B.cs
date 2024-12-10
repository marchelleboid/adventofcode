namespace AdventOfCode2024.Day10;

public class Day10B : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day10.txt");

        var count = 0;
        for (var y = 0; y < lines.Length; y++)
        {
            for (var x = 0; x < lines[0].Length; x++)
            {
                if (lines[y][x] == '0')
                {
                    count += GetTrailheadScore(x, y, lines);
                }
            }
        }
        Console.WriteLine(count);
    }

    private int GetTrailheadScore(int x, int y, string[] lines)
    {
        var score = 0;
        
        var queue = new Queue<(int, int)>();
        queue.Enqueue((x, y));

        while (queue.Count > 0)
        {
            var (x2, y2) = queue.Dequeue();
            var level = lines[y2][x2];
            if (level == '9')
            {
                score++;
                continue;
            }
            if (x2 > 0)
            {
                if (lines[y2][x2 - 1] == level + 1)
                {
                    queue.Enqueue((x2 - 1, y2));
                }
            }

            if (x2 < lines[0].Length - 1)
            {
                if (lines[y2][x2 + 1] == level + 1)
                {
                    queue.Enqueue((x2 + 1, y2));
                }
            }

            if (y2 > 0)
            {
                if (lines[y2 - 1][x2] == level + 1)
                {
                    queue.Enqueue((x2, y2 - 1));
                }
            }

            if (y2 < lines.Length - 1)
            {
                if (lines[y2 + 1][x2] == level + 1)
                {
                    queue.Enqueue((x2, y2 + 1));
                }
            }
        }
        return score;
    }
}