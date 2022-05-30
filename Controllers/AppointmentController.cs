using Dapper;
using NewMedicoRx.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NewMedicoRx.Controllers
{
    public class AppointmentController : Controller
    {
        // GET: Appointment
        public ActionResult ViewAppointment()
        {
            var AppointmentList = RetuningData.ReturnigList<AppointmentModel>("sp_getAppointment", null);
            return View(AppointmentList.ToList());
        }
        public ActionResult PrescriptionForm()
        {
            AppointmentModel ap = new AppointmentModel();
            ap.PId = 1211;
            ap.PName = "Mohd Yawar Ali";
            ap.MobileNo="9390359098";
            ap.AgeSex="21/Male";
            ap.pAddress="Shahlibanda";
            ap.Ht="5'4";
            ap.Wt="72kg";
            ap.GRBS = "100mg/dl";
            ap.GC = "Fair";
            ap.Temp = "99";
            ap.BP = "120/90mmhg";
            ap.SPO2 = "99";
            ap.PR = "99";
            ap.HR = "S1S2";
            ap.LR = "40";
            ap.CNS = "NAD";
            ap.PA = "NAD";
            ap.Complain = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.Investigation = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.HO = "Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.ClinicalHistory = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.DX = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.Advice = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            return View(ap);
        }

        public ActionResult CreatePrescriptionForm()
        {
            AppointmentModel ap = new AppointmentModel();
            ap.PId = 1211;
            ap.PName = "Mohd Yawar Ali";
            ap.MobileNo = "9390359098";
            ap.AgeSex = "21/Male";
            ap.pAddress = "Shahlibanda";
            ap.Ht = "5'4";
            ap.Wt = "72kg";
            ap.GRBS = "100mg/dl";
            ap.GC = "Fair";
            ap.Temp = "99";
            ap.BP = "120/90mmhg";
            ap.SPO2 = "99";
            ap.PR = "99";
            ap.HR = "S1S2";
            ap.LR = "40";
            ap.CNS = "NAD";
            ap.PA = "NAD";
            ap.Complain = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.Investigation = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.HO = "Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.ClinicalHistory = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.DX = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            ap.Advice = "  Suffering from Viral Fever Suffering from Viral FeverSuffering from Viral FeverSuffering from Viral FeverSuffering from Viral Fever";
            return View(ap);
        }

        public ActionResult GetTabletTypeForm()
        {
            var TabletTypeFormList = RetuningData.ReturnigList<string>("sp_TabletTypeForm", null);
            return Json(TabletTypeFormList.ToList(),JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetTabletMedicineForm()
        {
            var TabletMedicineFormList = RetuningData.ReturnigList<string>("sp_TabletMedicineNameForm", null);
            return Json(TabletMedicineFormList.ToList(), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetTabletDosesNameForm()
        {
            var TabletMedicineFormList = RetuningData.ReturnigList<string>("sp_TabletDosesNameForm", null);
            return Json(TabletMedicineFormList.ToList(), JsonRequestBehavior.AllowGet);
        }

        

        [HttpPost]
        public ActionResult CreatePrescriptionForm(PrescriptionModel obj, Appoint_Tab_Doses_Model Tab)
        {


            var param = new DynamicParameters();
            int AppointmentId = 0;
            if (Request.QueryString["AppointmentId"] != null)
            {
                AppointmentId = Convert.ToInt32(Request.QueryString["AppointmentId"]);
            }
            else
            {

                param.Add("@AppointmentId", AppointmentId);

                param.Add("@Emergency", obj.Emergency != string.Empty ? obj.Emergency : "");
                param.Add("@Review", obj.Review != string.Empty ? obj.Review : "");
                param.Add("@Complain", obj.Complain != string.Empty ? obj.Complain : "");
                param.Add("@History", obj.History != string.Empty ? obj.History : "");
                param.Add("@Dx", obj.Dx != string.Empty ? obj.Dx : "");
                param.Add("@Investigation", obj.Investigation != string.Empty ? obj.Investigation : "");
                param.Add("@Advice", obj.Advice != string.Empty ? obj.Advice : "");
                param.Add("@GC", obj.GC != string.Empty ? obj.GC : "");
                param.Add("@Temp", obj.Temp != string.Empty ? obj.Temp : "");
                param.Add("@PR", obj.PR != string.Empty ? obj.PR : "");
                param.Add("@LR", obj.LR != string.Empty ? obj.LR : "");
                param.Add("@BP", obj.BP != string.Empty ? obj.BP : "");
                param.Add("@SPO2", obj.SPO2 != string.Empty ? obj.SPO2 : "");
                param.Add("@PA", obj.PA != string.Empty ? obj.PA : "");
                param.Add("@CNS", obj.CNS != string.Empty ? obj.CNS : "");
                param.Add("@GRBS", obj.GRBS);
                param.Add("@HR", obj.HR != string.Empty ? obj.HR : "");
                param.Add("@CreatedBy", 1);
                param.Add("@CreatedDatetime", DateTime.Now);
                param.Add("@UpdatedBy", 1);
                param.Add("@Updateddatetime", DateTime.Now);
                int i = RetuningData.ReturnSingleValue<int>("sp_insertPatientReport", param);
                if (i > 0)
                {
                    int t = 0;
                    t = Tab.tabtype1 != null ? insertDoses(AppointmentId, Tab.tabtype1, Tab.tab1, Tab.Dosses1) : 0;
                    t = Tab.tabtype2 != null ? insertDoses(AppointmentId, Tab.tabtype2, Tab.tab2, Tab.Dosses2) : 0;
                    t = Tab.tabtype3 != null ? insertDoses(AppointmentId, Tab.tabtype3, Tab.tab3, Tab.Dosses3) : 0;
                    t = Tab.tabtype4 != null ? insertDoses(AppointmentId, Tab.tabtype4, Tab.tab4, Tab.Dosses4) : 0;
                    t = Tab.tabtype5 != null ? insertDoses(AppointmentId, Tab.tabtype5, Tab.tab5, Tab.Dosses5) : 0;
                    t = Tab.tabtype6 != null ? insertDoses(AppointmentId, Tab.tabtype6, Tab.tab6, Tab.Dosses6) : 0;
                    t = Tab.tabtype7 != null ? insertDoses(AppointmentId, Tab.tabtype7, Tab.tab7, Tab.Dosses7) : 0;
                    t = Tab.tabtype8 != null ? insertDoses(AppointmentId, Tab.tabtype8, Tab.tab8, Tab.Dosses8) : 0;
                    t = Tab.tabtype9 != null ? insertDoses(AppointmentId, Tab.tabtype9, Tab.tab9, Tab.Dosses9) : 0;
                    t = Tab.tabtype10 != null ? insertDoses(AppointmentId, Tab.tabtype10, Tab.tab10, Tab.Dosses10) : 0;

                    return RedirectToAction("PrescriptionForm");
                }
                else
                {
                    return View();
                }
            }
            return View();
        }

        public int insertDoses(int? AppointmentId,string TabType,string TabName,string Doses)
        {
                    var param2 = new DynamicParameters();
                    param2.Add("@AppointmentId", AppointmentId);
                    param2.Add("@TabType", TabType);
                    param2.Add("@TabName", TabName);
                    param2.Add("@Doses", Doses);
                   int i = RetuningData.ReturnSingleValue<int>("sp_insertPatientReport", param2);
            return i;

        }

        public ActionResult GetDictionary()
        {
            var TabletMedicineFormList = RetuningData.ReturnigList<string>("sp_getDictionary", null);
            return Json(TabletMedicineFormList.ToList(), JsonRequestBehavior.AllowGet);
        }
    }
}
 