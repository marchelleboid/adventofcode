namespace AdventOfCode2024.Day9;

public class Day9A : ISolver
{
    public void Solve()
    {
        var input = File.ReadAllLines("Inputs\\day9.txt")[0];

        var leftBlockPointer = 0;
        var leftPointer = 0;
        var rightBlockPointer = input.Length - 1;
        var rightOffset = 0;

        var checksum = 0L;
        var done = false;
        while (!done)
        {
            if (leftBlockPointer % 2 == 0)
            {
                var id = leftBlockPointer / 2;
                var end = input[leftBlockPointer] - '0';
                if (leftBlockPointer == rightBlockPointer)
                {
                    end -= rightOffset;
                    done = true;
                }
                for (var i = 0; i < end; i++)
                {
                    checksum += id * leftPointer;
                    leftPointer++;
                }
            }
            else
            {
                for (var i = 0; i < (input[leftBlockPointer] - '0'); i++)
                {
                    checksum += (rightBlockPointer / 2) * leftPointer;
                    leftPointer++;

                    rightOffset++;
                    if (rightOffset == (input[rightBlockPointer] - '0'))
                    {
                        rightBlockPointer -= 2; // Can input[rightPointer] be 0?
                        rightOffset = 0;

                        if (rightBlockPointer < leftBlockPointer)
                        {
                            done = true;
                            break;
                        }
                    }
                }
            }

            leftBlockPointer++;
        }
        Console.WriteLine(checksum);
    }
}