using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class TournamentMatching
    {
        public string ID { get; set; }
        public string CategoryID { get; set; }
        public string SortNumber { get; set; }
        public string RegistrationID { get; set; }
        public string RegistrationRiderName { get; set; }
        public string RegistrationBikeNumber { get; set; }
        public string LeftBikeNumber { get; set; }
        public string RightBikeNumber { get; set; }
        public string WinnerBikeNumber { get; set; }

        string strcon = ConfigurationManager.ConnectionStrings["default"].ConnectionString;

        public void Create(string TournamentEventName, DateTime TournamentEventCreateDate, DateTime TournamentEventStartDate, DateTime TournamentEventEndDate)
        {
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }
        }

        public void Delete(int TournamentEventID)
        {
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }
        }

        public void Update(int TournamentEventID, string TournamentEventName, DateTime TournamentEventCreateDate, DateTime TournamentEventStartDate, DateTime TournamentEventEndDate)
        {
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }
        }

        public void ReadAll()
        {
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
