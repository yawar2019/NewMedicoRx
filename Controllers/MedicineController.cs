using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Dapper;
using NewMedicoRx.Models;

namespace NewMedicoRx.Controllers
{
    public class MedicineController : Controller
    {
        // GET: Medicine
        public ActionResult GetMedicines()
        {
            // var Medicines=
             
                var medicinesList = RetuningData.ReturnigList<MedicineModel>("sp_get_Medicine", null);
                return View(medicinesList.ToList());
           
            
        }
    }
}