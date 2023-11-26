using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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

        public TournamentCategory ReadAll() 
        {
            var cat = new TournamentCategory();
            this.ID = cat.ID;
            this.Name = cat.Name;
            return cat;
        }

        public void Create(string Name)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
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

        public void ExtractFromReader(IDataRecord record)
        {
            this.ID = record["Tournament_Category_ID"].ToString();
            this.Name = record["Tournament_Category_Name"].ToString();
        }

        public void Update(int ID, string Name)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
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
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
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
