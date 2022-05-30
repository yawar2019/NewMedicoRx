using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NewMedicoRx.Models
{
    public class MedicineModel
    {
        [Key]
        public string MId { get; set; }
        public string MedicineName { get; set; }
        public string Formula { get; set; }
        public string DisseaseId { get; set; }
        public string DisseaseName { get; set; }
        public string Comment { get; set; }
        public string CreatedBy { get; set; }
        public string CreationDate { get; set; }
        public string UpdatedBy { get; set; }
        public string Updationdate { get; set; }
    }
}