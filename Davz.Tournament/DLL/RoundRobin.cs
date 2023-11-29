using Davz.Tournament.DLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class RoundRobin
    {
        public static List<Tuple<string, string>> GenerateRoundRobinSchedule(List<string> teams)
        {
            int n = teams.Count;
            List<Tuple<string, string>> schedule = new List<Tuple<string, string>>();

            if (n % 2 == 1)
            {
                teams.Add("BYE");
                n++;
            }

            for (int i = 0; i < n - 1; i++)
            {
                List<string> l1 = teams.GetRange(0, n / 2);
                List<string> l2 = teams.GetRange(n / 2, n / 2);
                l2.Reverse();

                List<Tuple<string, string>> round = new List<Tuple<string, string>>();
                for (int j = 0; j < n / 2; j++)
                {
                    Tuple<string, string> match = new Tuple<string, string>(l1[j], l2[j]);
                    round.Add(match);
                }

                schedule.AddRange(round);

                teams.Insert(1, teams[n - 1]);
                teams.RemoveAt(n);
            }

            return schedule;
        }

        public static void AssignedMatchAndSaveToDataBase(List<Tuple<string, string>> bracketList, string eventID, string categoryID)
        {



            int roundNumber = 1;

            var matchingBracket = MatchingBracket.Create(eventID, "Test Bracket Name", categoryID, false);

            foreach (var match in bracketList)
            {


                var leftPlayer = Registration.Read(match.Item1);
                var rightPlayer = Registration.Read(match.Item2);

                Matching.Create(roundNumber,
                                rightPlayer.RiderName, leftPlayer.RiderName,
                                rightPlayer.TeamName,leftPlayer.TeamName,
                                rightPlayer.DragBikeNumber, leftPlayer.DragBikeNumber, 
                                "","", matchingBracket.ID, false );

            }
        }


        public static void GenerateMatchBracket(List<string> bikerNumbers, string eventID, string categoryID)
        {
            Random rng = new Random();

            List<Tuple<string, string>> bracketMatch = GenerateRoundRobinSchedule(bikerNumbers.OrderBy(x => rng.Next()).ToList());

            AssignedMatchAndSaveToDataBase(bracketMatch, eventID, categoryID);

        }

    }
}
