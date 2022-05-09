using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NewMedicoRx.Models
{
    public class DisseasesModel
    {
        [Key]
        public int DisseasesId { get; set; }
        public string DisseaseName { get; set; }
        public string Description { get; set; }
        public string CreatedBy { get; set; }
        public string CreationDate { get; set; }
        public string UpdatedBy { get; set; }
        public string Updationdate { get; set; }
    }
}