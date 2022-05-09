using NewMedicoRx.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NewMedicoRx.Controllers
{
    public class DisseaseController : Controller
    {
        // GET: Dissease
        public ActionResult GetDisseases()
        {
            var DisseaseList = RetuningData.ReturnigList<DisseasesModel>("sp_get_Dissease", null);
            return View(DisseaseList.ToList());
        }
    }
}