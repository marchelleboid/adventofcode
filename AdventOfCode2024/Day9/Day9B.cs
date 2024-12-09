namespace AdventOfCode2024.Day9;

public class Day9B : ISolver
{
    public void Solve()
    {
        var input = File.ReadAllLines("Inputs\\day9.txt")[0];
        
        var pointer = 0;
        var moved = new HashSet<int>();

        var checksum = 0L;
        for (var leftBlockPointer = 0; leftBlockPointer < input.Length; leftBlockPointer++)
        {
            if (moved.Contains(leftBlockPointer))
            {
                pointer += (input[leftBlockPointer] - '0');
                continue;
            }
            
            if (leftBlockPointer % 2 == 0)
            {
                var id = leftBlockPointer / 2;
                for (var i = 0; i < (input[leftBlockPointer] - '0'); i++)
                {
                    checksum += id * pointer;
                    pointer++;
                }
            }
            else
            {
                var available = input[leftBlockPointer] - '0';
                while (available > 0)
                {
                    var done = true;
                    for (var rightBlockPointer = (input.Length - 1); rightBlockPointer > leftBlockPointer; rightBlockPointer -= 2)
                    {
                        if (moved.Contains(rightBlockPointer))
                        {
                            continue;
                        }

                        var rightBlockSpace = input[rightBlockPointer] - '0';
                        if (rightBlockSpace <= available)
                        {
                            for (var i = 0; i < rightBlockSpace; i++)
                            {
                                checksum += (rightBlockPointer / 2) * pointer;
                                pointer++;
                            }
                            moved.Add(rightBlockPointer);
                            available -= rightBlockSpace;
                            done = false;
                            break;
                        }
                    }

                    if (done)
                    {
                        pointer += available;
                        break;
                    }
                }
            }
        }
        
        Console.WriteLine(checksum);
    }
}