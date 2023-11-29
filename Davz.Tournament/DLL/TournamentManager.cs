using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Davz.Tournament.DLL;

namespace Davz.Tournament
{
    public class TournamentManager
    {

        public static DataTable GetAllMatchingByCategoryIDAndEventID(string categoryID, string eventID)
        {
            SqlConnection con = new SqlConnection(DataBase.ConnectionString);
            DataTable dt = new DataTable();

            con.Open();
            SqlCommand cmd = new SqlCommand("ReadAll_By_Category_ID_And_Event_ID", con);
            cmd.Parameters.AddWithValue("@CategoryID", categoryID);
            cmd.Parameters.AddWithValue("@EventID", eventID);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            dt.Load(dr);

            con.Close();

            return dt;
        }

        public static IEnumerable<MatchingBracket> GetAllMatchingBracketByCategoryIDAndEventID(string categoryID, string eventID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            List<MatchingBracket> lst = new List<MatchingBracket>();
            MatchingBracket matchingBracket = null;

            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("ReadAll_Matching_Bracket_By_Category_ID_And_Event_ID", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CategoryID", categoryID);
                cmd.Parameters.AddWithValue("@EventID", eventID);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    matchingBracket = new MatchingBracket();
                    matchingBracket.ExtractFromReader(dr);
                    lst.Add(matchingBracket);
                }
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }
            return lst;
        }

        public static DataTable GetAllRegistrationCategory(string eventID)
        {
            SqlConnection con = new SqlConnection(DataBase.ConnectionString);
            DataTable dt = new DataTable();

            con.Open();
            SqlCommand cmd = new SqlCommand("Get_All_Registration_Category_By_Event_ID", con);
            cmd.Parameters.AddWithValue("@EventID", eventID);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            dt.Load(dr);

            con.Close();

            return dt;
        }

        public static IEnumerable<RegistrationCategory> ReadAllRegistrationCategory()
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            List<RegistrationCategory> lst = new List<RegistrationCategory>();
            RegistrationCategory regCat = null;

            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("ReadAll_Registration_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    regCat = new RegistrationCategory();
                    regCat.ExtractFromReader(dr);
                    lst.Add(regCat);
                }
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }
            return lst;
        }

        public static IEnumerable<Category> ReadAllCategory()
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            List<Category> lst = new List<Category>();
            Category cat = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("ReadAll_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    cat = new Category();
                    cat.ExtractFromReader(dr);
                    lst.Add(cat);

                }
            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }
            return lst;

        }

        public static IEnumerable<RegistrationCategory> ReadAllRegistrationCategory(string eventID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            List<RegistrationCategory> lst = new List<RegistrationCategory>();
            RegistrationCategory cat = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Get_All_Registration_Category_By_Event_ID", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventID", eventID);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    cat = new RegistrationCategory();
                    cat.ExtractFromReader(dr);
                    lst.Add(cat);

                }
            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }
            return lst;

        }

        public static IEnumerable<Event> ReadAllEvent()
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            List<Event> lst = new List<Event>();
            Event events = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("ReadAll_Event", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    events = new Event();
                    events.ExtractFromReader(dr);
                    lst.Add(events);

                }
            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }
            return lst;

        }

        public static IEnumerable<Matching> ReadAllMatching()
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            List<Matching> lst = new List<Matching>();
            Matching matching = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("ReadAll_Matching", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    matching = new Matching();
                    matching.ExtractFromReader(dr);
                    lst.Add(matching);

                }
            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }
            return lst;

        }

        public static IEnumerable<Registration> ReadAllRegistrationByCategoryAndEventID(string categoryID, string eventID)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            List<Registration> lst = new List<Registration>();
            Registration reg = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("ReadAll_Registration_By_Category_And_Event_ID", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EventID", eventID);
                cmd.Parameters.AddWithValue("@CategoryID", categoryID);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    reg = new Registration();
                    reg.ExtractFromReader(dr);
                    lst.Add(reg);

                }
            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }
            return lst;

        }

        public static IEnumerable<Registration> ReadAllRegistrationByEventID(string id)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            List<Registration> lst = new List<Registration>();
            Registration reg = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("ReadAll_Registration_By_EventID", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ID", id);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    reg = new Registration();
                    reg.ExtractFromReader(dr);
                    lst.Add(reg);

                }
            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }
            return lst;

        }

        public static DataSet GetAllRegistrationByEventID(string eventID, string categoryID)
        {
            SqlConnection con = new SqlConnection(DataBase.ConnectionString);
            DataSet ds = new DataSet();

            con.Open();
            SqlCommand cmd = new SqlCommand("ReadAll_Registration_By_EventID", con);
            cmd.Parameters.AddWithValue("@EventID", eventID);
            cmd.Parameters.AddWithValue("@CategoryID", categoryID);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            da.Fill(ds);

            con.Close();

            ds.Relations.Add("LineItems", ds.Tables[0].Columns["Tournament_Category_ID"], ds.Tables[1].Columns["Tournament_Registration_Category_ID"]);

            return ds;
        }
    }
}
