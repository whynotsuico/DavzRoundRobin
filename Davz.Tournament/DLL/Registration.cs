﻿using System;
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

        public void Create(int EventID, string RiderName, int DragBikeNumber, int CategoryID, string TeamName)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Registration", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Event_ID", EventID);
                cmd.Parameters.AddWithValue("Rider_Name", RiderName);
                cmd.Parameters.AddWithValue("Bike_Number", DragBikeNumber);
                cmd.Parameters.AddWithValue("Category_ID", CategoryID);
                cmd.Parameters.AddWithValue("Team_Name", TeamName);
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

        public void Delete(int ID)
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

        public void Update(int ID, int EventID, string RiderName, int DragBikeNumber, int CategoryID, string TeamName)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Registration", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Registration_ID", ID);
                cmd.Parameters.AddWithValue("Event_ID", EventID);
                cmd.Parameters.AddWithValue("Rider_Name", RiderName);
                cmd.Parameters.AddWithValue("Bike_Number", DragBikeNumber);
                cmd.Parameters.AddWithValue("Category_ID", CategoryID);
                cmd.Parameters.AddWithValue("Team_Name", TeamName);
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