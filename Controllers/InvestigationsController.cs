using NewMedicoRx.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NewMedicoRx.Controllers
{
    public class InvestigationsController : Controller
    {
        // GET: Investigations
        public ActionResult GetInvestigation()
        {
            var InvestigationList = RetuningData.ReturnigList<InvestigationModel>("usp_getInsvestigation", null);
            return View(InvestigationList.ToList());
        }
    }
}