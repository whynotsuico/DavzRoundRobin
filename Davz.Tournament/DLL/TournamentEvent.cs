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
        public string ID { get; set; }
        public string Name { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        
        public void Create(string TournamentEventName, DateTime TournamentEventCreateDate, DateTime TournamentEventStartDate, DateTime TournamentEventEndDate)
        {
            SqlConnection conn = new SqlConnection(database.ConnectionString());
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
            SqlConnection conn = new SqlConnection(database.ConnectionString());
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
            SqlConnection conn = new SqlConnection(database.ConnectionString());
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
            SqlConnection conn = new SqlConnection(database.ConnectionString());
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
