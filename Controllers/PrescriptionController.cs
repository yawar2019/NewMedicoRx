using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NewMedicoRx.Controllers
{
    public class PrescriptionController : Controller
    {
        // GET: Prescription
        public ActionResult Index()
        {
            return View();
        }
    }
}