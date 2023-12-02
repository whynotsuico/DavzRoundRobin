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

                // Swap sides alternately in each round
                if (i % 2 == 1)
                {
                    (l1, l2) = (l2, l1);
                }

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

            var lst = TournamentManager.GetAllMatchingBracketByCategoryIDAndEventID(categoryID, eventID).Count();

            var matchingBracket = MatchingBracket.Create(eventID, $"Bracket {lst += 1}", categoryID, false);

            foreach (var match in bracketList)
            {
                var leftPlayer = Registration.Read(match.Item1);
                var rightPlayer = Registration.Read(match.Item2);

                var rightRiderName = leftPlayer == null ? "BYE" : leftPlayer.RiderName;
                var rightTeamName = leftPlayer == null ? "BYE" : leftPlayer.TeamName;
                var rightDragBikeNumber = leftPlayer == null ? "BYE" : leftPlayer.DragBikeNumber;

                var leftRiderName = rightPlayer == null ? "BYE" : rightPlayer.RiderName;
                var leftTeamName = rightPlayer == null ? "BYE" : rightPlayer.TeamName;
                var leftDragBikeNumber = rightPlayer == null ? "BYE" : rightPlayer.DragBikeNumber;

                Matching.Create(roundNumber++,
                                rightRiderName, leftRiderName,
                                rightTeamName, leftTeamName,
                                rightDragBikeNumber, leftDragBikeNumber,
                                "", "", matchingBracket.ID, false);


                //Update
                if (leftPlayer != null) {
                    leftPlayer.IsAlreadyBracket = true;
                    leftPlayer.Update();
                }

                if (rightPlayer != null)
                {
                    rightPlayer.IsAlreadyBracket = true;
                    rightPlayer.Update();
                }

            }
        }

        public static void GenerateMatchBracket(List<string> bikerNumbers, string eventID, string categoryID)
        {
            Random rng = new Random();

            List<Tuple<string, string>> bracketMatch = GenerateRoundRobinSchedule(bikerNumbers.ToList());

            AssignedMatchAndSaveToDataBase(bracketMatch, eventID, categoryID);

        }

    }
}
