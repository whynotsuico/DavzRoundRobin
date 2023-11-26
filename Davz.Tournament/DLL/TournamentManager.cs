using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Davz.Tournament.DLL
{
    public class TournamentManager
    {
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

        public static IEnumerable<Registration> ReadAllRegistration()
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            List<Registration> lst = new List<Registration>();
            Registration reg = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("ReadAll_Registration", conn);
                cmd.CommandType = CommandType.StoredProcedure;
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
    }
}
