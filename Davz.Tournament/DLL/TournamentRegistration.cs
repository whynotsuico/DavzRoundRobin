using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class TournamentRegistration
    {
        public string ID { get; set; }
        public string EventID { get; set; }
        public string RiderName { get; set; }
        public string DragBikeNumber { get; set; }
        public string CategoryID { get; set; }
        public string TeamName { get; set; }

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
