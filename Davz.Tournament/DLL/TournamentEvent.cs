using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament
{
    public class TournamentEvent
    {
        public string ID { get; set; }
        public string Name { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        string strcon = ConfigurationManager.ConnectionStrings["default"].ConnectionString;

        public void Create(string Name, DateTime CreateDate, DateTime StartDate, DateTime EndDate)
        {
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Event", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
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

        public void Delete(int TournamentEventID)
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

        public void Update(int ID, string Name, DateTime CreateDate, DateTime StartDate, DateTime EndDate)
        {
            SqlConnection conn = new SqlConnection(strcon);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Event", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
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
