using Davz.Tournament;

class TEstRoundRobin
{
    
    static void PrintSchedule(List<Tuple<string, string>> schedule)
    {
        int roundNumber = 1;
        foreach (var match in schedule)
        {
            Console.WriteLine($"Round {roundNumber++}: {match.Item1} vs {match.Item2}");
        }
    }

    static void Main()
    {
        List<string> teams = new List<string> { "Team B", "Team A", "Team D" };

     RoundRobin.GenerateMatchBracket(teams, "1", "2");
      
    }
}