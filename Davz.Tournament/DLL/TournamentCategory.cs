using System;
using System.Collections.Generic;
using System.Configuration;
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

        string strcon = ConfigurationManager.ConnectionStrings["default"].ConnectionString;

        public TournamentCategory ReadAll() 
        {
            var test = new TournamentCategory();
            this.ID = test.ID;
            this.Name = test.Name;
            return test;
        }

        public void Create(string Name)
        {
            SqlConnection conn = new SqlConnection(strcon);
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
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Category", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Category_Name", Name);
                cmd.Parameters.AddWithValue("Category_ID", ID);
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

        public void Delete(int ID)
        {
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Category", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Category_ID", ID);
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
    }
}
