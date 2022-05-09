using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NewMedicoRx.Models
{
    public class InvestigationModel
    {
        public int Id { get; set; }

        [Display(Name="Investigation")]
        public string Invistagation { get; set; }
    }
}