﻿using System;
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
            Random rng = new Random();

            if (n % 2 == 1)
            {
                teams.Add("BYE");
                n++;
            }

            for (int i = 0; i < n - 1; i++)
            {
                List<string> l1 = teams.GetRange(0, n / 2);
                List<string> l2 = teams.GetRange(n / 2, n / 2);

                // Randomly determine which side each bike number should be on
                for (int j = 0; j < n / 2; j++)
                {
                    if (rng.Next(2) == 1)
                    {
                        // Swap positions
                        string temp = l1[j];
                        l1[j] = l2[j];
                        l2[j] = temp;
                    }
                }

                List<Tuple<string, string>> round = new List<Tuple<string, string>>();
                for (int j = 0; j < n / 2; j++)
                {
                    Tuple<string, string> match = new Tuple<string, string>(l1[j], l2[j]);
                    round.Add(match);
                }

                schedule.AddRange(round);

                // Rotate the teams in the list
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
                Registration leftPlayer = Registration.Read(match.Item1);
                Registration rightPlayer = Registration.Read(match.Item2);

                var rightRiderName = rightPlayer.RiderName;
                var rightTeamName = rightPlayer.TeamName;
                var rightDragBikeNumber = rightPlayer.DragBikeNumber;

                var leftRiderName = leftPlayer.RiderName;
                var leftTeamName = leftPlayer.TeamName;
                var leftDragBikeNumber = leftPlayer.DragBikeNumber;

                Matching.Create(roundNumber++,
                                rightRiderName, leftRiderName,
                                rightTeamName, leftTeamName,
                                rightDragBikeNumber, leftDragBikeNumber,
                                "", "", matchingBracket.ID, false);

                // Update
                leftPlayer.IsAlreadyBracket = true;
                leftPlayer.Update();

                rightPlayer.IsAlreadyBracket = true;
                rightPlayer.Update();
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
