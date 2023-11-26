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
    public class Category
    {
        public string ID { get; set; }
        public string Name { get; set; }

        public void Create(string Name)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Create_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Category_Name", Name);
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
            this.ID = record["Tournament_Category_ID"].ToString();
            this.Name = record["Tournament_Category_Name"].ToString();
        }

        public static Category Read(string id)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            Category category = null;
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Read_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Category_ID", id);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    category = new Category();
                    category.ExtractFromReader(dr);
                }

            }
            catch (Exception)
            {

            }
            finally
            {
                conn.Close();
            }

            return category;
        }

        public void Update(string ID, string Name)
        {
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Category_Name", Name);
                cmd.Parameters.AddWithValue("Category_ID", ID);
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
            SqlConnection conn = new SqlConnection(DataBase.ConnectionString);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update_Category", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("Category_ID", ID);
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