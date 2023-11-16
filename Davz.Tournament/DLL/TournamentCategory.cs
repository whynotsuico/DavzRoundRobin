using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class TournamentCategory
    {
        public int TournamentCategoryID { get; set; }
        public string TournamentCategoryName { get; set; }

        public void Create(string TournamentCategoryName)
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

        public void Update(int TournamentCategoryID, string TournamentCategoryName)
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

        public void Delete(int TournamentCategoryID)
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
