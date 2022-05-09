using System;
using Dapper;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;
using System.Configuration;

namespace NewMedicoRx.Models
{
    public static class RetuningData
    {


        public static T AddOrSave<T>(String spName, DynamicParameters param)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlCon"].ToString());
            var result = (T)Convert.ChangeType(con.Execute(spName, param, commandType: CommandType.StoredProcedure), typeof(T));
            return result;
        }
        public static T ReturnSingleValue<T>(String spName, DynamicParameters param)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlCon"].ToString());
            var result = (T)Convert.ChangeType(con.ExecuteScalar(spName, param, commandType: CommandType.StoredProcedure), typeof(T));
            return result;
        }
        public static IEnumerable<T> ReturnigList<T>(String spName, DynamicParameters param)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["sqlCon"].ToString());
            return con.Query<T>(spName, param, commandType: CommandType.StoredProcedure);
        }

    }
}