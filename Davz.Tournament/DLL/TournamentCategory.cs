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
        public string ID { get; set; }
        public string Name { get; set; }

        public void Create(string Name)
        {
            SqlConnection conn = new SqlConnection(database.ConnectionString());
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Category", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Category_Name", Name);
                cmd.ExecuteNonQuery();
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

        public void Update(int ID, string Name)
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

        public void Delete(int TournamentCategoryID)
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
