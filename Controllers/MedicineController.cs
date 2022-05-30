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

        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(MedicineModel ms)
        {

            var param = new DynamicParameters();
            param.Add("@MedicineName", ms.MedicineName);
            param.Add("@Formula", ms.Formula);
            param.Add("@DisseaseId", ms.DisseaseId);
            param.Add("@Comment", ms.Comment);
            param.Add("@CreatedBy", ms.CreatedBy);
            param.Add("@UpdatedBy", ms.UpdatedBy);


            int i = RetuningData.AddOrSave<int>("sp_Insert_Medicine", param);
            if (i > 0)
            {
                return RedirectToAction("GetMedicines");
            }
            else
            {
                return View();
            }



        }
        public ActionResult Edit(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@id", id);
            var DisseaseList = RetuningData.ReturnigList<MedicineModel>("sp_get_Medicine_byId", param).SingleOrDefault();
            return View(DisseaseList);
        }
        [HttpPost]
        public ActionResult Edit(MedicineModel dis)
        {
            var param = new DynamicParameters();
            param.Add("@Mid", dis.MId);
            param.Add("@MedicineName", dis.MedicineName);
            param.Add("@Formula", dis.Formula);
            param.Add("@DisseaseId", dis.DisseaseId);
            param.Add("@Comment", dis.Comment);
            param.Add("@UpdatedBy", 1);
            var i = RetuningData.AddOrSave<int>("sp_Update_Medicine", param);
            if (i > 0)
            {
                return RedirectToAction("GetMedicines");
            }
            else
            {
                return View();
            }
        }
        public ActionResult Delete(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@id", id);
            var MedicineList = RetuningData.ReturnigList<MedicineModel>("sp_get_Medicine_byId", param).SingleOrDefault();
            return View(MedicineList);
        }
        [HttpPost]
        [ActionName("Delete")]
        public ActionResult DeleteConfirmed(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@id", id);


            var i = RetuningData.AddOrSave<int>("sp_delete_Medicine_byId", param);
            if (i > 0)
            {
                return RedirectToAction("GetMedicines");
            }
            else
            {
                return View();
            }
        }
    }
}