using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class Matching
    {
        public string ID { get; set; }
        public string SortNumber { get; set; }
        public string RightRiderName { get; set; }
        public string LeftRiderName { get; set; }
        public string RightTeamName { get; set; }
        public string LeftBikeNumber { get; set; }
        public string RightBikeNumber { get; set; }
        public string WinnerBikeNumber { get; set; }
        public string LoserBikeNumber { get; set; }
        public string BracketID { get; set; }
        public bool IsDone { get; set; }
        public string LeftTeamName { get; set; }

        public static void Create(int SortNumber
                            , string RightRiderName
                            , string LeftRiderName
                            , string RightTeamName
                            , string LeftTeamName
                            , string RightBikeNumber
                            , string LeftBikeNumber
                            , string WinnerBikeNumber
                            , string LoserBikeNumber
                            , string BracketID
                            , bool IsDone
                            )
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand("Create_Matching", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Sort_Number", SortNumber);
            cmd.Parameters.AddWithValue("@Right_Rider_Name", RightRiderName);
            cmd.Parameters.AddWithValue("@Left_Rider_Name", LeftRiderName);
            cmd.Parameters.AddWithValue("@Right_Team_Name", RightTeamName);
            cmd.Parameters.AddWithValue("@Left_Bike_Number", LeftBikeNumber);
            cmd.Parameters.AddWithValue("@Right_Bike_Number", RightBikeNumber);
            cmd.Parameters.AddWithValue("@Winner_Bike_Number", WinnerBikeNumber);
            cmd.Parameters.AddWithValue("@Loser_Bike_Number", LoserBikeNumber);
            cmd.Parameters.AddWithValue("@Bracket_ID", BracketID);
            cmd.Parameters.AddWithValue("@Is_Done", IsDone);
            cmd.Parameters.AddWithValue("@Left_Team_Name", LeftTeamName);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public void ExtractFromReader(IDataRecord record)
        {
            this.ID = record["Tournament_Matching_ID"].ToString();
            this.SortNumber = record["Tournament_Matching_Sort_Number"].ToString();
            this.RightRiderName = record["Tournament_Matching_Right_Rider_Name"].ToString();
            this.LeftRiderName = record["Tournament_Matching_Left_Rider_Name"].ToString();
            this.RightTeamName = record["Tournament_Matching_Right_Team_Name"].ToString();
            this.LeftBikeNumber = record["Tournament_Matching_Left_Bike_Number"].ToString();
            this.RightBikeNumber = record["Tournament_Matching_Right_Bike_Number"].ToString();
            this.WinnerBikeNumber = record["Tournament_Matching_Winner_Bike_Number"].ToString();
            this.LoserBikeNumber = record["Tournament_Matching_Loser_Bike_Number"].ToString();
            this.BracketID = record["Tournament_Matching_Bracket_ID"].ToString();
            this.IsDone = bool.Parse(record["Tournament_Matching_Is_Done"].ToString());
            this.LeftTeamName = record["Tournament_Matching_Left_Team_Name"].ToString();
        }

        public static Matching Read(string id)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            Matching matching = null;
            conn.Open();
            SqlCommand cmd = new SqlCommand("Read_Matching", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                matching = new Matching();
                matching.ExtractFromReader(dr);
            }
            conn.Close();
            return matching;
        }

        public void Delete(int ID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand("Delete_Matching", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Matching_ID", ID);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public void Update()
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);

            conn.Open();
            SqlCommand cmd = new SqlCommand("Update_Matching", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", ID);
            cmd.Parameters.AddWithValue("@Sort_Number", SortNumber);
            cmd.Parameters.AddWithValue("@Right_Rider_Name", RightRiderName);
            cmd.Parameters.AddWithValue("@Left_Rider_Name", LeftRiderName);
            cmd.Parameters.AddWithValue("@Right_Team_Name", RightTeamName);
            cmd.Parameters.AddWithValue("@Left_Bike_Number", LeftBikeNumber);
            cmd.Parameters.AddWithValue("@Right_Bike_Number", RightBikeNumber);
            cmd.Parameters.AddWithValue("@Winner_Bike_Number", WinnerBikeNumber);
            cmd.Parameters.AddWithValue("@Loser_Bike_Number", LoserBikeNumber);
            cmd.Parameters.AddWithValue("@Bracket_ID", BracketID);
            cmd.Parameters.AddWithValue("@Is_Done", IsDone);
            cmd.Parameters.AddWithValue("@Left_Team_Name", LeftTeamName);
            cmd.ExecuteNonQuery();

            conn.Close();

        }
    }
}
