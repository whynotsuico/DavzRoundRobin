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
    public class Event
    {
        public string ID { get; set; }
        public string Name { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        public static void Create(string Name, DateTime CreateDate, DateTime StartDate, DateTime EndDate)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Event", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Event_Name", Name);
                cmd.Parameters.AddWithValue("Event_CreateDate", CreateDate);
                cmd.Parameters.AddWithValue("Event_StartDate", StartDate);
                cmd.Parameters.AddWithValue("Event_EndDate", EndDate);
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
            this.ID = record["Tournament_Event_ID"].ToString();
            this.Name = record["Tournament_Event_Name"].ToString();
            this.CreateDate = DateTime.Parse(record["Tournament_Event_Create_Date"].ToString());
            this.StartDate = DateTime.Parse(record["Tournament_Event_Start_Date"].ToString());
            this.EndDate = DateTime.Parse(record["Tournament_Event_End_Date"].ToString());
        }

        public static Event Read(string id)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            Event events = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Read_Event", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ID", id);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    events = new Event();
                    events.ExtractFromReader(dr);
                }

            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }

            return events;
        }

        public static void Delete(string ID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Delete_Event", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Event_ID", ID);
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

        public void Update(int ID, string Name, DateTime CreateDate, DateTime StartDate, DateTime EndDate)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Event", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Event_ID", ID);
                cmd.Parameters.AddWithValue("Event_Name", Name);
                cmd.Parameters.AddWithValue("Event_CreateDate", CreateDate);
                cmd.Parameters.AddWithValue("Event_StartDate", StartDate);
                cmd.Parameters.AddWithValue("Event_EndDate", EndDate);
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
