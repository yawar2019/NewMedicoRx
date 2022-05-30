using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewMedicoRx.Models
{
    public class Appoint_Tab_Doses_Model
    {
        public Nullable<int> Pid { get; set; }
        public Nullable<int> AppointmentId { get; set; }
        public string TabName { get; set; }
        public Nullable<int> RpId { get; set; }
        public string Dosses { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public int UpdatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDatetime { get; set; }
        public Nullable<System.DateTime> UpdatedDatetime { get; set; }
        public string tabtype1 { get; set; }
        public string tab1 { get; set; }
        public string Dosses1 { get; set; }


        public string tabtype2 { get; set; }
        public string tab2{ get; set; }
        public string Dosses2 { get; set; }


        public string tabtype3 { get; set; }
        public string tab3 { get; set; }
        public string Dosses3 { get; set; }


        public string tabtype4 { get; set; }
        public string tab4 { get; set; }
        public string Dosses4 { get; set; }


        public string tabtype5 { get; set; }
        public string tab5 { get; set; }
        public string Dosses5 { get; set; }



        public string tabtype6 { get; set; }
        public string tab6 { get; set; }
        public string Dosses6 { get; set; }


        public string tabtype7 { get; set; }
        public string tab7 { get; set; }
        public string Dosses7 { get; set; }


        public string tabtype8 { get; set; }
        public string tab8 { get; set; }
        public string Dosses8 { get; set; }

        public string tabtype9 { get; set; }
        public string tab9 { get; set; }
        public string Dosses9 { get; set; }

        public string tabtype10 { get; set; }
        public string tab10 { get; set; }
        public string Dosses10 { get; set; }
    }
}