using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class TournamentMatching
    {
        public int TournamentMatchingID { get; set; }
        public int TournamentMatchingCategoryID { get; set; }
        public int TournamentMatchingSortNumber { get; set; }
        public int TournamentMatchingRegistrationID { get; set; }
        public string TournamentMatchingRegistrationRiderName { get; set; }
        public string TournamentMatchingRegistrationBikeNumber { get; set; }
        public string TournamentMatchingLeftBikeNumber { get; set; }
        public string TournamentMatchingRightBikeNumber { get; set; }
        public string TournamentMatchingWinnerBikeNumber { get; set; }
    }
}
