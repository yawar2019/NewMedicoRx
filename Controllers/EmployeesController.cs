using Dapper;
using NewMedicoRx.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NewMedicoRx.Controllers
{
    public class EmployeesController : Controller
    {
        // GET: Employees
        public ActionResult Employees()
        {
            var employees = RetuningData.ReturnigList<RegistrationModel>("usp_GetEmployees", null);

            return View(employees);
        }

        //public ActionResult Registration()
        //{
        //    var dlist = RetuningData.ReturnigList<CenterModel>("usp_getCenter", null);
        //    ViewBag.Center = new SelectList(dlist, "CenterId", "CenterName");
        //    return View();
        //}
        [HttpPost]
        public ActionResult Registration(RegistrationModel reg)
        {
            var param = new DynamicParameters();
            param.Add("@Name", reg.name);
            param.Add("@Email", reg.emalid);
            param.Add("@Passward", reg.password);
            param.Add("@RoleId", reg.RoleId);
            param.Add("@Status", reg.status);
            param.Add("@Experience", reg.Experience);
            param.Add("@Qualification", reg.Qualification);
            param.Add("@UID", reg.UID);
            param.Add("@MobileNo", reg.MobileNo);
            param.Add("@DOJ", reg.DOJ);
            param.Add("@Address", reg.Address);
            param.Add("@CollectedByUser", reg.CollectedByUser);
            param.Add("@CenterId", reg.CenterId);

            int i = RetuningData.AddOrSave<int>("usp_getUserLogin", param);
            if (i > 0)
            {
                return RedirectToAction("Employees");
            }
            else
            {
                return View();
            }
        }

        public ActionResult EditRegistration(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@id", id);

            var Emp = RetuningData.ReturnigList<RegistrationModel>("sp_getLoginbyId", param).SingleOrDefault();

            return View(Emp);
        }

        [HttpPost]
        public ActionResult EditRegistration(RegistrationModel reg)
        {
            var param = new DynamicParameters();
            param.Add("@id", reg.EmpId);
            param.Add("@Name", reg.name);
            param.Add("@Email", reg.emalid);
            param.Add("@Passward", reg.password);
            param.Add("@RoleId", reg.RoleId);
            param.Add("@Status", reg.status);
            param.Add("@Experience", reg.Experience);
            param.Add("@Qualification", reg.Qualification);
            param.Add("@UID", reg.UID);
            param.Add("@MobileNo", reg.MobileNo);
            param.Add("@DOJ", reg.DOJ);
            param.Add("@Address", reg.Address);
            param.Add("@CollectedByUser", reg.CollectedByUser);
            param.Add("@Center", reg.CenterId);
            param.Add("@UpdatedBy", 1);
            param.Add("@UpdatedOn", DateTime.Now);

            int i = RetuningData.AddOrSave<int>("usp_UpdateUserLogin", param);
            if (i > 0)
            {
                return RedirectToAction("Employees");
            }
            else
            {
                return View();
            }
        }


      
        public ActionResult DeleteRegistration(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@id", id);

            var Emp = RetuningData.ReturnigList<RegistrationModel>("sp_getLoginbyId", param).SingleOrDefault();

            return View(Emp);
        }

        [HttpPost]
        [ActionName("DeleteRegistration")]
        public ActionResult DeleteConfirm(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@id", id);

            int i = RetuningData.AddOrSave<int>("usp_DeleteEmployee", param);
            if (i > 0)
            {
                return RedirectToAction("Employees");
            }
            else
            {
                return View();
            }
        }


        public ActionResult DetailsRegistration(int? id)
        {
            var param = new DynamicParameters();
            param.Add("@id", id);

            var Emp = RetuningData.ReturnigList<RegistrationModel>("sp_getLoginbyId", param).SingleOrDefault();

            return View(Emp);
        }
    }
}