using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

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

        public void Create(   int CategoryID
                            , int SortNumber
                            , int RegistrationID
                            , string RegistrationRiderName
                            , string RegistrationBikeNumber
                            , string LeftBikeNumber
                            , string RightBikeNumber
                            , string WinnerBikeNumber)
        {
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Matching", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Matching_CategoryID", CategoryID);
                cmd.Parameters.AddWithValue("Matching_SortNumber", SortNumber);
                cmd.Parameters.AddWithValue("Matching_RegistrationID", RegistrationID);
                cmd.Parameters.AddWithValue("Matching_RegistrationRiderName", RegistrationRiderName);
                cmd.Parameters.AddWithValue("Matching_RegistrationBikeNumber", RegistrationBikeNumber);
                cmd.Parameters.AddWithValue("Matching_LeftBikeNumber", LeftBikeNumber);
                cmd.Parameters.AddWithValue("Matching_RightBikeNumber", RightBikeNumber);
                cmd.Parameters.AddWithValue("Matching_WinnerBikeNumber", WinnerBikeNumber);
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
                SqlCommand cmd = new SqlCommand("Update_Matching", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Matching_ID", ID);
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

        public void Update(   int ID
                            , int CategoryID
                            , int SortNumber
                            , int RegistrationID
                            , string RegistrationRiderName
                            , string RegistrationBikeNumber
                            , string LeftBikeNumber
                            , string RightBikeNumber
                            , string WinnerBikeNumber)
        {
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Matching", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Matching_ID", ID);
                cmd.Parameters.AddWithValue("Matching_CategoryID", CategoryID);
                cmd.Parameters.AddWithValue("Matching_SortNumber", SortNumber);
                cmd.Parameters.AddWithValue("Matching_RegistrationID", RegistrationID);
                cmd.Parameters.AddWithValue("Matching_RegistrationRiderName", RegistrationRiderName);
                cmd.Parameters.AddWithValue("Matching_RegistrationBikeNumber", RegistrationBikeNumber);
                cmd.Parameters.AddWithValue("Matching_LeftBikeNumber", LeftBikeNumber);
                cmd.Parameters.AddWithValue("Matching_RightBikeNumber", RightBikeNumber);
                cmd.Parameters.AddWithValue("Matching_WinnerBikeNumber", WinnerBikeNumber);
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
