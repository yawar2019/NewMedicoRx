using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewMedicoRx.Models
{
    public class PrescriptionModel
    {
        public int Rpid { get; set; }
        public Nullable<int> Pid { get; set; }
        public Nullable<int> Did { get; set; }
        public string PTName { get; set; }
        public string Gender { get; set; }
        public string Age { get; set; }
        public string Ht { get; set; }
        public string WT { get; set; }
        public string ReferBy { get; set; }
        public string Complain { get; set; }
        public string History { get; set; }
        public string Dx { get; set; }
        public string Investigation { get; set; }
        public string Advice { get; set; }
        public string GC { get; set; }
        public string Temp { get; set; }
        public string PR { get; set; }
        public string LR { get; set; }
        public string BP { get; set; }
        public string SPO2 { get; set; }
        public string PA { get; set; }
        public string CNS { get; set; }
        public string GRBS { get; set; }
        public string Review { get; set; }
        public string Emergency { get; set; }
        public string HR { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDatetime { get; set; }
        public Nullable<int> UpdatedBy { get; set; }
        public Nullable<System.DateTime> Updateddatetime { get; set; }
    }
}