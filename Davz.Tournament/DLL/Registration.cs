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
    public class Registration
    {
        public string ID { get; set; }
        public string EventID { get; set; }
        public string RiderName { get; set; }
        public string DragBikeNumber { get; set; }
        public string CategoryID { get; set; }
        public string TeamName { get; set; }
        public bool IsAlreadyBracket { get; set; }

        public static void Create(string EventID, string RiderName, string DragBikeNumber, string CategoryID, string TeamName)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Registration", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventID", EventID);
                cmd.Parameters.AddWithValue("@RiderName", RiderName);
                cmd.Parameters.AddWithValue("@BikeNumber", DragBikeNumber);
                cmd.Parameters.AddWithValue("@CategoryID", CategoryID);
                cmd.Parameters.AddWithValue("@TeamName", TeamName);
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
            this.ID = record["Tournament_Registration_ID"].ToString();
            this.EventID = record["Tournament_Registration_Event_ID"].ToString();
            this.RiderName = record["Tournament_Registration_Rider_Name"].ToString();
            this.DragBikeNumber = record["Tournament_Registration_Drag_Bike_Number"].ToString();
            this.CategoryID = record["Tournament_Registration_Category_ID"].ToString();
            this.TeamName = record["Tournament_Registration_Team_Name"].ToString();
            this.IsAlreadyBracket = bool.Parse(record["Tournament_Registration_Is_Already_Bracket"].ToString());
        }

        public static Registration Read(string id)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            Registration registration = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Read_Registration", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ID", id);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    registration = new Registration();
                    registration.ExtractFromReader(dr);
                }

            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }

            return registration;
        }

        public static void Delete(string ID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Delete_Registration", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Registration_ID", ID);
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

        public void Update()
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Registration", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", ID);
                cmd.Parameters.AddWithValue("@EventID", EventID);
                cmd.Parameters.AddWithValue("@RideName", RiderName);
                cmd.Parameters.AddWithValue("@BikeNumber", DragBikeNumber);
                cmd.Parameters.AddWithValue("@CategoryID", CategoryID);
                cmd.Parameters.AddWithValue("@TeamName", TeamName);
                cmd.Parameters.AddWithValue("@IsAlreadyBracket", IsAlreadyBracket);
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
