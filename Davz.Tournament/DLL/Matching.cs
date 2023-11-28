using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Davz.Tournament
{
    public class Matching
    {
        public string ID { get; set; }
        public string CategoryID { get; set; }
        public string SortNumber { get; set; }
        public string RegistrationID { get; set; }
        public string RegistrationRiderName { get; set; }
        public string RegistrationTeamName { get; set; }
        public string LeftBikeNumber { get; set; }
        public string RightBikeNumber { get; set; }
        public string WinnerBikeNumber { get; set; }

        public void Create(   int CategoryID
                            , int SortNumber
                            , int RegistrationID
                            , string RegistrationRiderName
                            , string RegistrationBikeNumber
                            , string LeftBikeNumber
                            , string RightBikeNumber
                            , string WinnerBikeNumber)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Matching", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Category_ID", CategoryID);
                cmd.Parameters.AddWithValue("@Sort_Number", SortNumber);
                cmd.Parameters.AddWithValue("@Registration_ID", RegistrationID);
                cmd.Parameters.AddWithValue("@Rider_Name", RegistrationRiderName);
                cmd.Parameters.AddWithValue("@Registration_Team_Name", RegistrationBikeNumber);
                cmd.Parameters.AddWithValue("@Left_Bike_Number", LeftBikeNumber);
                cmd.Parameters.AddWithValue("@Right_Bike_Number", RightBikeNumber);
                cmd.Parameters.AddWithValue("@Winner_Bike_Number", WinnerBikeNumber);
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
            this.ID = record["Tournament_Matching_ID"].ToString();
            this.CategoryID = record["Tournament_Matching_Category_ID"].ToString();
            this.SortNumber = record["Tournament_Matching_Sort_Number"].ToString();            
            this.RegistrationID = record["Tournament_Matching_Registration_ID"].ToString();
            this.RegistrationRiderName = record["Tournament_Matching_Registration_Rider_Name"].ToString();
            this.RegistrationTeamName = record["Tournament_Matching_Registration_Team_Name"].ToString();
            this.LeftBikeNumber = record["Tournament_Matching_Left_Bike_Number"].ToString();
            this.RightBikeNumber = record["Tournament_Matching_Right_Bike_Number"].ToString();
            this.WinnerBikeNumber = record["Tournament_Matching_Winner_Bike_Number"].ToString();
        }

        public static Matching Read(string id)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            Matching matching = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Read_Matching", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ID", id);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    matching = new Matching();
                    matching.ExtractFromReader(dr);
                }

            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }

            return matching;
        }

        public void Delete(int ID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Delete_Matching", conn);
                cmd.CommandType = CommandType.StoredProcedure;
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
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Matching", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Matching_ID", ID);
                cmd.Parameters.AddWithValue("@Category_ID", CategoryID);
                cmd.Parameters.AddWithValue("@Sort_Number", SortNumber);
                cmd.Parameters.AddWithValue("@Registration_ID", RegistrationID);
                cmd.Parameters.AddWithValue("@Rider_Name", RegistrationRiderName);
                cmd.Parameters.AddWithValue("@Registration_Team_Name", RegistrationBikeNumber);
                cmd.Parameters.AddWithValue("@Left_Bike_Number", LeftBikeNumber);
                cmd.Parameters.AddWithValue("@Right_Bike_Number", RightBikeNumber);
                cmd.Parameters.AddWithValue("@Winner_Bike_Number", WinnerBikeNumber);
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
