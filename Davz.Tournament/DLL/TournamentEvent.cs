using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class TournamentEvent
    {
        public int TournamentEventID { get; set; }
        public string TournamentEventName { get; set; }
        public DateTime TournamentEventCreateDate { get; set; }
        public DateTime TournamentEventStartDate { get; set; }
        public DateTime TournamentEventEndDate { get; set; }
        
        public void Create(string TournamentEventName, DateTime TournamentEventCreateDate, DateTime TournamentEventStartDate, DateTime TournamentEventEndDate)
        {
            SqlConnection conn = new SqlConnection("");
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
            SqlConnection conn = new SqlConnection("");
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
            SqlConnection conn = new SqlConnection("");
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
            SqlConnection conn = new SqlConnection("");
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
