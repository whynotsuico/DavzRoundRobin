using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.CompilerServices;
using System.Xml.Linq;

namespace Davz.Tournament.DLL
{
    public class MatchingBracket
    {
        public string ID { get; set; }
        public string EventID { get; set; }
        public string BracketName { get; set; }
        public string CategoryID { get; set; }
        public bool IsDone { get; set; }

        public static MatchingBracket Create(string EventID, string BracketName, string CategoryID, bool IsDone)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);

            conn.Open();
            SqlCommand cmd = new SqlCommand("Create_Matching_Bracket", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EventID", EventID);
            cmd.Parameters.AddWithValue("@BracketName", BracketName);
            cmd.Parameters.AddWithValue("@CategoryID", CategoryID);
            cmd.Parameters.AddWithValue("@IsDone", IsDone);
            var result = cmd.ExecuteScalar();

            conn.Close();

            return Read(result.ToString());
        }

        public void ExtractFromReader(IDataRecord record)
        {
            this.ID = record["Matching_Bracket_ID"].ToString();
            this.EventID = record["Matching_Bracket_Event_ID"].ToString();
            this.BracketName = record["Matching_Bracket_Name"].ToString();
            this.CategoryID = record["Matching_Bracket_Category_ID"].ToString();
            this.IsDone = bool.Parse(record["Matching_Bracket_Is_Done"].ToString()); ;
        }

        public static MatchingBracket Read(string id)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            MatchingBracket matchingBracket = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Read_Matching_Bracket", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", id);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    matchingBracket = new MatchingBracket();
                    matchingBracket.ExtractFromReader(dr);
                }

            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }

            return matchingBracket;
        }

        public void Update(string ID, string EventID, string BracketName, string CategoryID, bool IsDone)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Matching_Bracket", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", ID);
                cmd.Parameters.AddWithValue("@Event_ID", EventID);
                cmd.Parameters.AddWithValue("@Bracket_Name", BracketName);
                cmd.Parameters.AddWithValue("@Category_ID", CategoryID);
                cmd.Parameters.AddWithValue("@Is_Done", IsDone);
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

        public static void Delete(string ID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Delete_Matching_Bracket", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", ID);
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
