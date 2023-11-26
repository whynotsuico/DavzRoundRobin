using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class RegistrationCategory
    {
        public string ID { get; set; }
        public string CategoryID { get; set; }
        public string EventID { get; set; }
        public string CategoryName { get; set; }

        public static void Create(string categoryID, string eventID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Registration_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CategoryID", categoryID);
                cmd.Parameters.AddWithValue("@EventID", eventID);
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
            this.ID = record["Registration_Category_Category_ID"].ToString();
            this.CategoryID = record["Registration_Category_Category_ID"].ToString();
            this.EventID = record["Registration_Category_Category_ID"].ToString();

            this.CategoryName = record["Tournament_Category_Name"].ToString();
        }

        public static void Update(int ID, int CategoryID, int EventID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Registration_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ID", ID);
                cmd.Parameters.AddWithValue("Category_ID", CategoryID);
                cmd.Parameters.AddWithValue("Event_ID", EventID);
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
        public static void Delete(int ID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Delete_Registration_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ID", ID);
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
