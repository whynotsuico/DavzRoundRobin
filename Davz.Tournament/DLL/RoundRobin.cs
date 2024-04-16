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

            var lst = TournamentManager.GetAllMatchingBracketByCategoryIDAndEventID(categoryID, eventID).Count();

            RegistrationCategory regCat = RegistrationCategory.Read(categoryID);

            var matchingBracket = MatchingBracket.Create(eventID, $"{regCat.CategoryName} B-[{lst += 1}]", categoryID, false);

            foreach (var match in bracketList)
            {
                Registration leftPlayer = null;
                Registration rightPlayer = null;

                if (match.Item1 != "BYE")
                    leftPlayer = Registration.Read(match.Item1);

                if (match.Item2 != "BYE")
                    rightPlayer = Registration.Read(match.Item2);

                var leftRiderName = leftPlayer == null ? "BYE" : leftPlayer.RiderName;
                var leftTeamName = leftPlayer == null ? "BYE" : leftPlayer.TeamName;
                var leftDragBikeNumber = leftPlayer == null ? "BYE" : leftPlayer.DragBikeNumber;
                var registrationLeftID = leftPlayer == null ? "0" : leftPlayer.ID;


                var rightRiderName = rightPlayer == null ? "BYE" : rightPlayer.RiderName;
                var rightTeamName = rightPlayer == null ? "BYE" : rightPlayer.TeamName;
                var rightDragBikeNumber = rightPlayer == null ? "BYE" : rightPlayer.DragBikeNumber;
                var registrationRightID = rightPlayer == null ? "0" : rightPlayer.ID;

                Matching.Create(roundNumber++,
                                rightRiderName, leftRiderName,
                                rightTeamName, leftTeamName,
                                rightDragBikeNumber, leftDragBikeNumber,
                                "", "", matchingBracket.ID, false, registrationLeftID, registrationRightID);


                //Update
                if (leftPlayer != null)
                {
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

            List<Tuple<string, string>> bracketMatch = GenerateRoundRobinSchedule(bikerNumbers.ToList());

            AssignedMatchAndSaveToDataBase(bracketMatch, eventID, categoryID);
        }



    }
}
