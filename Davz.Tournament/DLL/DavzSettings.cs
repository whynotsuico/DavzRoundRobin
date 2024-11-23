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
    public class DavzSettings
    {
        public string ID { get; set; }
        public bool ShowTimer { get; set; }
        public string RaceLength { get; set; }
        public string PrinterName { get; set; }
        public int TimerSeconds { get; set; }


        public void ExtractFromReader(IDataRecord record)
        {
            this.ID = record["Davz_Settings_ID"].ToString();
            this.RaceLength = record["Davz_Settings_Length"].ToString();
            this.PrinterName = record["Davz_Settings_Printer_Name"].ToString();
            this.ShowTimer = bool.Parse(record["Davz_Settings_Show_Timer"].ToString());
            this.TimerSeconds = int.Parse(record["Davz_Settings_Timer_Seconds"].ToString());
        }

        public static DavzSettings Read()
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            DavzSettings davz = null;
            conn.Open();
            SqlCommand cmd = new SqlCommand("Davz_Settings_Read", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                davz = new DavzSettings();
                davz.ExtractFromReader(dr);
            }
            conn.Close();

            return davz;
        }

        public void Update()
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand("Davz_Settings_Update", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ShowTimer", ShowTimer);
            cmd.Parameters.AddWithValue("@Length", RaceLength);
            cmd.Parameters.AddWithValue("@PrinterName", PrinterName);
            cmd.Parameters.AddWithValue("@TimerSeconds", TimerSeconds);
            cmd.ExecuteNonQuery();
            conn.Close();

        }

    }
}
