using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewMedicoRx.Models
{
    public class AppointmentModel
    {
        public int AppointmentId { get; set; }
        public Nullable<int> PId { get; set; }
        public Nullable<int> Did { get; set; }
        public string PName { get; set; }
        public string DName { get; set; }
        public Nullable<System.DateTime> DateOfAppointment { get; set; }
        public string TimeOfAppointment { get; set; }
        public Nullable<System.DateTime> CreationDate { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<int> UpdatedBy { get; set; }
        public Nullable<System.DateTime> UpdationDate { get; set; }
        public string AgeSex { get; set; }
        public string pAddress { get; set; }
        public string Wt { get; set; }
        public string Ht { get; set; }
        public string MobileNo { get; set; }
        public string GRBS { get; set; }
        public string GC { get; set; }
        public string Temp { get; set; }
        public string BP { get; set; }
        public string SPO2 { get; set; }
        public string PR { get; set; }
        public string HR { get; set; }
        public string LR { get; set; }
        public string PA { get; set; }
        public string CNS { get; set; }
        public string Complain { get; set; }
        public string HO { get; set; }
        public string ClinicalHistory { get; set; }
        public string DX { get; set; }
         public string Investigation { get; set; }
        public string Advice { get; set; }
    }
}