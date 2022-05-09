using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NewMedicoRx.Models
{
    public class DoctorModel
    {
        public int DocId { get; set; }

        [Required(ErrorMessage = "Enter Doctor Name")]
        [Display(Name = "Doctor Name")]
        public string DoctorName { get; set; }

        public string Mobile { get; set; }

        public string EmailId { get; set; }
        public string Signature { get; set; }
        public string Qualification { get; set; }
        public string ContactNumber { get; set; }
        public string Specilization { get; set; }


        public string CreatedName { get; set; }
        public string UpdatedName { get; set; }

        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int UpdatedBy { get; set; }
        [Display(Name = "Address 1")]

        public string Address1 { get; set; }
        [Display(Name = "Address 2")]

        public string Address2 { get; set; }
        [Display(Name = "Address 3")]


        public string Address3 { get; set; }

        [Display(Name = "Days and Time")]
        [DataType(DataType.MultilineText)]

        public string DayAndTime1 { get; set; }
        [Display(Name = "Mobile")]
        public string MobileAdd1 { get; set; }

        [Display(Name = "Days And Time")]
        [DataType(DataType.MultilineText)]
        public string DayAndTime2 { get; set; }
        [Display(Name = "Mobile")]
        public string MobileAdd2 { get; set; }
        [Display(Name = "Mobile")]

        public string MobileAdd3 { get; set; }

        [Display(Name = "Days and Time")]
        [DataType(DataType.MultilineText)]
        public string DayAndTime3 { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}