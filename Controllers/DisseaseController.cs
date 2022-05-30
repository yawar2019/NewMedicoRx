using Dapper;
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
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(DisseasesModel dis)
        {

            var param = new DynamicParameters();
            param.Add("@DisseaseName", dis.DisseaseName);
            param.Add("@Description", dis.Description);
            param.Add("@CreatedBy", dis.CreatedBy);
            param.Add("@UpdatedBy", dis.UpdatedBy);
            

            int i = RetuningData.AddOrSave<int>("sp_Insert_Dissease", param);
            if (i > 0)
            {
                return RedirectToAction("GetDisseases");
            }
            else
            {
                return View();
            }


           
        }
        public ActionResult Edit(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@Id", id);
            var DisseaseList = RetuningData.ReturnigList<DisseasesModel>("sp_get_Dissease_ById", param).SingleOrDefault();
            return View(DisseaseList);
        }
        [HttpPost]
        public ActionResult Edit(DisseasesModel dis)
        {
            var param = new DynamicParameters();
            param.Add("@Id", dis.DisseasesId);
            param.Add("@DisseaseName", dis.DisseaseName);
            param.Add("@Description", dis.Description);
            param.Add("@UpdatedBy", 1);
            var i = RetuningData.AddOrSave<int>("sp_Update_Dissease_ById", param);
            if (i > 0)
            {
                return RedirectToAction("GetDisseases");
            }
            else
            {
                return View();
            }
        }
        public ActionResult Delete(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@Id", id);
            var DisseaseList = RetuningData.ReturnigList<DisseasesModel>("sp_get_Dissease_ById", param).SingleOrDefault();
            return View(DisseaseList);
        }
        [HttpPost]
        [ActionName("Delete")]
        public ActionResult DeleteConfirmed(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@Id", id);

           
            var i = RetuningData.AddOrSave<int>("sp_Delete_Dissease_ById", param);
            if (i > 0)
            {
                return RedirectToAction("GetDisseases");
            }
            else
            {
                return View();
            }
        }
    }
}



//tble_TabletTypeForm (screen and crud operation using dapper and storeproc)( anil work)
//tble_TabletDosesForm(screen and crud operation using dapper and storeproc)(smarti work)
//tble_Dictionary(screen and crud operation using dapper and storeproc) (sanjay work)