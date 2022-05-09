using Dapper;
using NewMedicoRx.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NewMedicoRx.Controllers
{
    public class DoctorController : Controller
    {
        // GET: Doctor
        public ActionResult ReferDocIndex()
        {
            var rd = RetuningData.ReturnigList<DoctorModel>("usp_getDoctorsDetail", null);

            return View(rd);
        }


        public ActionResult CreateRecord()
        {
            var rd = RetuningData.ReturnigList<DoctorModel>("usp_getListDoctors", null);

            ViewBag.Doctor = new SelectList(rd, "docid", "doctorName");
            return View();
        }

        [HttpPost]
        public ActionResult CreateRecord(DoctorModel rdm)
        {
            var param = new DynamicParameters();

            param.Add("@DoctorName", rdm.DoctorName);
            param.Add("@Specilization", rdm.Specilization);
            param.Add("@Signature", rdm.Signature);
            param.Add("@Qualification", rdm.Qualification);
            param.Add("@ContactNumber", rdm.ContactNumber);
            param.Add("@EmailId", rdm.EmailId);
            param.Add("@Address1", rdm.Address1);
            param.Add("@Address2", rdm.Address2);
            param.Add("@Address3", rdm.Address3);
            param.Add("@MobileAdd1", rdm.MobileAdd1);
            param.Add("@MobileAdd2", rdm.MobileAdd2);
            param.Add("@MobileAdd3", rdm.MobileAdd3);
            param.Add("@DayAndTime1", rdm.DayAndTime1);
            param.Add("@DayAndTime2", rdm.DayAndTime2);
            param.Add("@DayAndTime3", rdm.DayAndTime3);

            param.Add("@CreatedBy", 1);
            param.Add("@UpdatedBy", 1);

            int i = RetuningData.AddOrSave<int>("usp_DoctorsInfo", param);
            if (i > 0)
            {

                return RedirectToAction("ReferDocIndex");
            }

            return View();
        }
        public ActionResult EditRecord(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@Docid", id);
            var rdm = RetuningData.ReturnigList<DoctorModel>("usp_getDoctorsDetailById", param).SingleOrDefault();
            return View(rdm);

        }


        [HttpPost]
        public ActionResult EditRecord(DoctorModel rdm)
        {
            var param = new DynamicParameters();
            param.Add("@Specilization", rdm.Specilization);
            param.Add("@Signature", rdm.Signature);
            param.Add("@Qualification", rdm.Qualification);
            param.Add("@ContactNumber", rdm.ContactNumber);
            param.Add("@EmailId", rdm.EmailId);
            param.Add("@Address1", rdm.Address1);
            param.Add("@Address2", rdm.Address2);
            param.Add("@Address3", rdm.Address3);
            param.Add("@MobileAdd1", rdm.MobileAdd1);
            param.Add("@MobileAdd2", rdm.MobileAdd2);
            param.Add("@MobileAdd3", rdm.MobileAdd3);
            param.Add("@DayAndTime1", rdm.DayAndTime1);
            param.Add("@DayAndTime2", rdm.DayAndTime2);
            param.Add("@DayAndTime3", rdm.DayAndTime3);
            param.Add("@DocId", rdm.DocId);
            param.Add("@DoctorName", rdm.DoctorName);
            param.Add("@CreatedBy", 1);
            param.Add("@UpdatedBy", 1);

            int i = RetuningData.AddOrSave<int>("usp_DoctorsInfo", param);

            if (i > 0)
            {
                return RedirectToAction("ReferDocIndex");
            }
            return View();
        }


        public ActionResult DeleteRecord(int? id)
        {

            var param = new DynamicParameters();
            param.Add("@Rid", id);
            var rm = RetuningData.ReturnigList<DoctorModel>("sp_ReferDoctorById", param).SingleOrDefault();
            return View(rm);
        }

        public ActionResult Details(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@Docid", id);
            var rdm = RetuningData.ReturnigList<DoctorModel>("usp_getDoctorsDetailById", param).SingleOrDefault();
            return View(rdm);
        }

        [HttpPost]
        public ActionResult DeleteConfirm(int? id)
        {

            var param = new DynamicParameters();

            param.Add("@DocId", id);
            var num = RetuningData.ReturnigList<int>("[uspDeleteDoctor]", param).SingleOrDefault();


            if (num > 0)
            {
                ViewBag.msg = "Record Deleted";
                return RedirectToAction("ReferDocIndex");
            }

            return RedirectToAction("ReferDocIndex");
        }
    }
}