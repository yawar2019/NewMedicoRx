USE [master]
GO
/****** Object:  Database [HospitalManagement]    Script Date: 09-05-2022 08:34:01 ******/
CREATE DATABASE [HospitalManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HospitalManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\HospitalManagement.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HospitalManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\HospitalManagement_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [HospitalManagement] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HospitalManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HospitalManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HospitalManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HospitalManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HospitalManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HospitalManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [HospitalManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HospitalManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HospitalManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HospitalManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HospitalManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HospitalManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HospitalManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HospitalManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HospitalManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HospitalManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HospitalManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HospitalManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HospitalManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HospitalManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HospitalManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HospitalManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HospitalManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HospitalManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HospitalManagement] SET  MULTI_USER 
GO
ALTER DATABASE [HospitalManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HospitalManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HospitalManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HospitalManagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [HospitalManagement] SET DELAYED_DURABILITY = DISABLED 
GO
USE [HospitalManagement]
GO
/****** Object:  User [NT AUTHORITY\NETWORK SERVICE]    Script Date: 09-05-2022 08:34:02 ******/
CREATE USER [NT AUTHORITY\NETWORK SERVICE] FOR LOGIN [NT AUTHORITY\NETWORK SERVICE] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [IIS APPPOOL]    Script Date: 09-05-2022 08:34:02 ******/
CREATE USER [IIS APPPOOL] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[db_accessadmin]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\NETWORK SERVICE]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [NT AUTHORITY\NETWORK SERVICE]
GO
ALTER ROLE [db_owner] ADD MEMBER [IIS APPPOOL]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [IIS APPPOOL]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [IIS APPPOOL]
GO
ALTER ROLE [db_datareader] ADD MEMBER [IIS APPPOOL]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [IIS APPPOOL]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 09-05-2022 08:34:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[Split](@String varchar(MAX), @Delimiter char(1))       
returns @temptable TABLE (items varchar(MAX))       
as       
begin      
    declare @idx int       
    declare @slice varchar(8000)       

    select @idx = 1       
        if len(@String)<1 or @String is null  return       

    while @idx!= 0       
    begin       
        set @idx = charindex(@Delimiter,@String)       
        if @idx!=0       
            set @slice = left(@String,@idx - 1)       
        else       
            set @slice = @String       

        if(len(@slice)>0)  
            insert into @temptable(Items) values(@slice)       

        set @String = right(@String,len(@String) - @idx)       
        if len(@String) = 0 break       
    end   
return 
end;

GO
/****** Object:  Table [dbo].[Account]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[BillId] [int] IDENTITY(1,1) NOT NULL,
	[DrId] [int] NULL,
	[PatId] [int] NULL,
	[TotalAmount] [float] NULL,
	[DR_Percentage] [int] NULL,
	[Referal_Percentage] [int] NULL,
	[NetAmount] [float] NULL,
	[Createdby] [int] NULL,
	[UpdatedBy] [int] NULL,
	[Createddate] [datetime] NULL,
	[Updateddate] [datetime] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[AppointmentId] [int] IDENTITY(1,1) NOT NULL,
	[PId] [int] NULL,
	[Did] [int] NULL,
	[DateOfAppointment] [datetime] NULL,
	[TimeOfAppointment] [nvarchar](max) NULL,
	[CreationDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[UpdationDate] [datetime] NULL,
 CONSTRAINT [PK_Appointment] PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[ContactName] [nvarchar](max) NULL,
	[Designation] [nvarchar](max) NULL,
	[EmailId] [nvarchar](50) NULL,
	[PhoneNo1] [nvarchar](50) NULL,
	[PhoneNo2] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DiognasisTest]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DiognasisTest](
	[TestId] [int] IDENTITY(1,1) NOT NULL,
	[TestName] [varchar](max) NULL,
	[Description] [varchar](max) NULL,
	[IsChecked] [bit] NOT NULL CONSTRAINT [DF_DiognasisTest_IsChecked]  DEFAULT ((1)),
 CONSTRAINT [PK_DiognasisTest] PRIMARY KEY CLUSTERED 
(
	[TestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Diseasses]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diseasses](
	[DiseasesId] [int] IDENTITY(1,1) NOT NULL,
	[DisseaseName] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Diseasses] PRIMARY KEY CLUSTERED 
(
	[DiseasesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[DoctorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[EmailId] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[Qualification] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Specialist] [nvarchar](50) NULL,
	[Photo] [nvarchar](max) NULL,
	[Date_of_joining] [datetime] NULL,
	[Address] [nvarchar](50) NULL,
	[Timing] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdationDate] [datetime] NULL,
 CONSTRAINT [PK_Doctors] PRIMARY KEY CLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DosesDetail]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DosesDetail](
	[DoseId] [int] IDENTITY(1,1) NOT NULL,
	[DosesName] [nvarchar](max) NULL,
 CONSTRAINT [PK_DosesDetail] PRIMARY KEY CLUSTERED 
(
	[DoseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GeneralPrescriptiom]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeneralPrescriptiom](
	[Rpid] [int] IDENTITY(1,1) NOT NULL,
	[Pid] [int] NULL,
	[Did] [int] NULL,
	[PTName] [nvarchar](max) NULL,
	[Gender] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_Gender]  DEFAULT (' '),
	[Age] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_Age]  DEFAULT (' '),
	[Ht] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_Ht]  DEFAULT (' '),
	[WT] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_WT]  DEFAULT (' '),
	[ReferBy] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_ReferBy]  DEFAULT (' '),
	[Complain] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_Complain]  DEFAULT (' '),
	[History] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_History]  DEFAULT (' '),
	[Dx] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_Dx]  DEFAULT (' '),
	[Investigation] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_Investigation]  DEFAULT (' '),
	[Advice] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_Advice]  DEFAULT (' '),
	[GC] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_GC]  DEFAULT (' '),
	[Temp] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_Temp]  DEFAULT (' '),
	[PR] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_PR]  DEFAULT (' '),
	[LR] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_LR]  DEFAULT (' '),
	[BP] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_BP]  DEFAULT (' '),
	[SPO2] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_SPO2]  DEFAULT (''),
	[PA] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_PA]  DEFAULT (''),
	[CNS] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_CNS]  DEFAULT (''),
	[GRBS] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_GRBS]  DEFAULT (''),
	[Review] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_Review]  DEFAULT (''),
	[Emergency] [nvarchar](max) NULL CONSTRAINT [DF_GeneralPrescriptiom_Emergency]  DEFAULT (''),
	[HR] [nvarchar](50) NULL CONSTRAINT [DF_GeneralPrescriptiom_HR]  DEFAULT (''),
	[CreatedBy] [int] NULL CONSTRAINT [DF_GeneralPrescriptiom_CreatedBy]  DEFAULT ((0)),
	[CreatedDatetime] [datetime] NULL CONSTRAINT [DF_GeneralPrescriptiom_CreatedDatetime]  DEFAULT (NULL),
	[UpdatedBy] [int] NULL CONSTRAINT [DF_GeneralPrescriptiom_UpdatedBy]  DEFAULT ((0)),
	[Updateddatetime] [datetime] NULL CONSTRAINT [DF_GeneralPrescriptiom_Updateddatetime]  DEFAULT (NULL),
 CONSTRAINT [PK_GeneralPrescriptiom] PRIMARY KEY CLUSTERED 
(
	[Rpid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvestigationDetails]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvestigationDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Invistagation] [nvarchar](max) NULL,
 CONSTRAINT [PK_InvestigationDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Medicine]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicine](
	[MId] [int] IDENTITY(1,1) NOT NULL,
	[MedicineName] [nvarchar](max) NULL,
	[Formula] [nvarchar](max) NULL,
	[DisseaseId] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreationDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[Updationdate] [datetime] NULL,
 CONSTRAINT [PK_Medicine] PRIMARY KEY CLUSTERED 
(
	[MId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notepad]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notepad](
	[TopicId] [int] IDENTITY(1,1) NOT NULL,
	[TopicName] [nvarchar](max) NULL,
	[TopicContent] [nvarchar](max) NULL,
 CONSTRAINT [PK_Notepad] PRIMARY KEY CLUSTERED 
(
	[TopicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patient]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[Pid] [int] IDENTITY(1,1) NOT NULL,
	[PName] [nvarchar](50) NULL,
	[PatientType] [int] NULL,
	[ReferBy] [nvarchar](50) NULL,
	[Age] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NULL,
	[MobileNo] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
	[Date_of_Admission] [datetime] NULL,
	[Date_of_DisCharge] [datetime] NULL,
	[Createdby] [int] NULL,
	[Updatedby] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatetedTime] [datetime] NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientTypes]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientTypes](
	[PTypeId] [int] IDENTITY(1,1) NOT NULL,
	[PatientType] [nvarchar](50) NULL,
 CONSTRAINT [PK_PatientTypes] PRIMARY KEY CLUSTERED 
(
	[PTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReferalDoctor]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReferalDoctor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferalDoctorName] [varchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_ReferalDoctor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RegisterdUsers]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisterdUsers](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[UserTypeId] [int] NULL,
	[RoleId] [int] NULL,
	[EmailId] [nvarchar](50) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_RegisterdUsers_IsActive]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[Updatedby] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_RegisterdUsers] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SettingInfo]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SettingInfo](
	[sno] [int] IDENTITY(1,1) NOT NULL,
	[Logo] [nvarchar](max) NULL,
	[TitleName] [nvarchar](max) NULL,
 CONSTRAINT [PK_SettingInfo] PRIMARY KEY CLUSTERED 
(
	[sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TabletAndDoses]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TabletAndDoses](
	[Pid] [int] NULL,
	[TabName] [nvarchar](500) NULL,
	[RpId] [int] NULL,
	[Dosses] [nvarchar](500) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NOT NULL,
	[CreatedDatetime] [datetime] NULL,
	[UpdatedDatetime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_BillingMaster]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_BillingMaster](
	[BilIingId] [int] IDENTITY(1,1) NOT NULL,
	[PId] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Paid] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 0) NULL,
	[Expenses] [decimal](18, 0) NULL,
	[ReferalPercentage] [decimal](18, 0) NULL,
	[ReferalAmount] [decimal](18, 0) NULL,
	[DUE] [decimal](18, 0) NULL,
	[CollectedById] [int] NULL,
	[BillNumber] [varchar](50) NULL,
	[Status] [bit] NULL CONSTRAINT [DF__tbl_Billi__Statu__3E1D39E1]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK__tbl_Bill__4473BF9A68C9D675] PRIMARY KEY CLUSTERED 
(
	[BilIingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Doctor]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Doctor](
	[DocId] [int] IDENTITY(1,1) NOT NULL,
	[DoctorName] [varchar](50) NULL,
	[Specilization] [varchar](max) NULL,
	[Signature] [varchar](max) NULL,
	[EmailId] [varchar](50) NULL,
	[Qualification] [varchar](max) NULL,
	[DoctorPhoto] [varchar](max) NULL,
	[ContactNumber] [varchar](50) NULL,
	[Address1] [varchar](max) NULL,
	[Address2] [varchar](max) NULL,
	[Address3] [varchar](max) NULL,
	[MobileAdd1] [varchar](50) NULL,
	[MobileAdd2] [varchar](50) NULL,
	[MobileAdd3] [varchar](50) NULL,
	[DayAndTime1] [varchar](max) NULL,
	[DayAndTime2] [varchar](max) NULL,
	[DayAndTime3] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_Doctor_1] PRIMARY KEY CLUSTERED 
(
	[DocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_UserLogin]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_UserLogin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Passward] [varchar](50) NULL,
	[Status] [bit] NULL,
	[Center] [varchar](50) NULL,
	[MobileNo] [varchar](50) NULL,
	[Qualification] [varchar](500) NULL,
	[DOJ] [varchar](50) NULL,
	[Experience] [varchar](500) NULL,
	[UID] [varchar](500) NULL,
	[Address] [varchar](max) NULL,
	[CollectedByUser] [varchar](500) NULL,
	[RoleId] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tbl_UserLogin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tble_Employee]    Script Date: 09-05-2022 08:34:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tble_Employee](
	[EmpId] [int] IDENTITY(1,1) NOT NULL,
	[EmpName] [nvarchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tble_Employee] PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (1, 1, 1, 500.09, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (2, 23, 38, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-11 22:59:52.817' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (1002, 25, 1022, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-17 02:14:40.297' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (1003, 25, 1022, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-17 02:16:54.743' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (1004, 25, 1022, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-17 02:20:53.720' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (1005, 25, 1022, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-17 02:21:16.670' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (1006, 25, 1022, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-17 02:21:58.677' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (1007, 25, 1022, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-17 02:22:16.733' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (1008, 25, 1022, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-25 03:45:10.983' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (1009, 25, 1026, 500, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-24 19:46:46.897' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (2002, 25, 1234, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-25 23:59:17.787' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (2003, 25, 1034, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-11-26 00:00:21.257' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (3002, 25, 1234, 400, NULL, NULL, NULL, 1, NULL, CAST(N'2018-12-02 02:18:45.920' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (3003, 25, 2021, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-12-02 02:53:09.517' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (4002, 23, 3021, 200, NULL, NULL, NULL, 1, NULL, CAST(N'2018-12-09 02:50:11.533' AS DateTime), NULL)
INSERT [dbo].[Account] ([BillId], [DrId], [PatId], [TotalAmount], [DR_Percentage], [Referal_Percentage], [NetAmount], [Createdby], [UpdatedBy], [Createddate], [Updateddate]) VALUES (4003, 25, 3026, 400, NULL, NULL, NULL, 1, NULL, CAST(N'2018-12-09 06:31:39.930' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[Appointment] ON 

INSERT [dbo].[Appointment] ([AppointmentId], [PId], [Did], [DateOfAppointment], [TimeOfAppointment], [CreationDate], [CreatedBy], [UpdatedBy], [UpdationDate]) VALUES (3003, 1234, 25, CAST(N'2018-12-02 02:18:45.920' AS DateTime), N'2pm', CAST(N'2018-12-02 02:18:45.920' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Appointment] ([AppointmentId], [PId], [Did], [DateOfAppointment], [TimeOfAppointment], [CreationDate], [CreatedBy], [UpdatedBy], [UpdationDate]) VALUES (3004, 2021, 25, CAST(N'2018-12-02 02:53:09.517' AS DateTime), N'2pm', CAST(N'2018-12-02 02:53:09.517' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Appointment] ([AppointmentId], [PId], [Did], [DateOfAppointment], [TimeOfAppointment], [CreationDate], [CreatedBy], [UpdatedBy], [UpdationDate]) VALUES (4003, 3021, 23, CAST(N'2018-12-09 02:50:11.533' AS DateTime), N'2pm', CAST(N'2018-12-09 02:50:11.533' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Appointment] ([AppointmentId], [PId], [Did], [DateOfAppointment], [TimeOfAppointment], [CreationDate], [CreatedBy], [UpdatedBy], [UpdationDate]) VALUES (4004, 3026, 25, CAST(N'2018-12-09 06:31:39.943' AS DateTime), N'4pm', CAST(N'2018-12-09 06:31:39.943' AS DateTime), 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Appointment] OFF
SET IDENTITY_INSERT [dbo].[Contacts] ON 

INSERT [dbo].[Contacts] ([ContactId], [ContactName], [Designation], [EmailId], [PhoneNo1], [PhoneNo2], [Address]) VALUES (1, N'Md yawar ali', NULL, N'amair@gmail.com', N'9160020272', N'987654234455', N'Jubli hills Hyderabad')
INSERT [dbo].[Contacts] ([ContactId], [ContactName], [Designation], [EmailId], [PhoneNo1], [PhoneNo2], [Address]) VALUES (2, N'Shaik aijaz Ahmed', NULL, N'Ajaiz18@hotmail.com', N'123456', N'234567', N'Noor pasha masjid,hyderabad,opposite of sky school')
INSERT [dbo].[Contacts] ([ContactId], [ContactName], [Designation], [EmailId], [PhoneNo1], [PhoneNo2], [Address]) VALUES (3, N'sami', NULL, N'sami@gmail.com', N'12345566', N'23434234234', N'Noor pasha masjid,hyderabad,opposite of sky school')
INSERT [dbo].[Contacts] ([ContactId], [ContactName], [Designation], [EmailId], [PhoneNo1], [PhoneNo2], [Address]) VALUES (5, N'Dr Malika Nigar ', N'BUMS ,OBS & GYN', N'Ajaiz18@hotmail.com', N'9985055663', N'9392447742', N'kalapather bilal nager kalapather bilal nager kalapather bilal nager kalapather bilal nager kalapather bilal nager kalapather bilal nager kalapather bilal nager kalapather bilal nager kalapather bilal nager kalapather bilal nager ')
SET IDENTITY_INSERT [dbo].[Contacts] OFF
SET IDENTITY_INSERT [dbo].[DiognasisTest] ON 

INSERT [dbo].[DiognasisTest] ([TestId], [TestName], [Description], [IsChecked]) VALUES (1, N'FAD', N'FAD', 1)
INSERT [dbo].[DiognasisTest] ([TestId], [TestName], [Description], [IsChecked]) VALUES (2, N'Tad', N'Tad', 1)
SET IDENTITY_INSERT [dbo].[DiognasisTest] OFF
SET IDENTITY_INSERT [dbo].[Diseasses] ON 

INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1, N'Resuscitation', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2, N'Respiratory distress', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (3, N'Apnoea', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (4, N'Birth injuries', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (5, N'Convulsion', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (6, N'Infections & Septicaemia', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (7, N'Haemolytic disease of the newborn', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (8, N'Prematurity', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (9, N'Congestive cardiac failure', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (10, N'Diarrhoea', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (11, N'Abdominal distension & Colic', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (12, N'Colic', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (13, N'Congenital distension & Colic', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (14, N'Meconium plug syndrome & Meconium ileus', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (15, N'Volvulus neonatorum', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (16, N'Incessant crying', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (17, N'Hypoglycaemia', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (18, N'Tetanus neonatorum', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (19, N'Tetany (see section III,chap.  XIV)', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (20, N'Haemorrhagic disease of the new bowborn', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (21, N'Congenital anomalies', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (22, N'Respiratory ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (23, N'Gastro intestinal Emergencies ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (24, N'Dehydration ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (25, N'Electrolyte balance', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (26, N'Breath holding & Food poisoning', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (27, N'Food Chocking', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (28, N'Electric shock', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (29, N'Lightining', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (30, N'Travel sickness', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (31, N'Driwning ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (32, N'Tussive syncope ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (33, N'Acute stridor ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (34, N'Spinal paralytic poliomyelitis ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (35, N'Bulbae poliomyelitis', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (36, N'Shock', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (37, N'Cardiac arrest', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (38, N'Laryngeal obstruction', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (39, N'Intestinal obstruction', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (40, N'Acute appendicitis', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (41, N'Burns & Scalds ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (42, N'Injuries ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (43, N'Foreign bodies ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (44, N'Battered baby ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (45, N'Acyte otitis media', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (46, N'Gas gangrene ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (47, N'Head injury ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (48, N'Dyspnoea ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (49, N'Colics ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (50, N'High fever ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (51, N'Diarrhoea', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (52, N'Heat exhaustion', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (53, N'Heat stroke ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (54, N'Cold injuries ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (55, N'Hiccup', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (56, N'Vertigo ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (57, N'Faintiog ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (58, N'Headache ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (59, N'Dysmenorrhoea & Menorrhagia', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (60, N'Bleeding disorders ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (61, N'Tetany  ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (62, N'Acute Hepatic failure', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (63, N'Haematuria ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (64, N'Acute renal failure ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (65, N'Congestive cardiac failure ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (66, N'Unconsciousness', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (67, N'Surgical', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (68, N'Sick cell syndrome ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (69, N'Metabolic acidosis ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (70, N'Primary care of the injured ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (71, N'Acute Appendicitis ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (72, N'Acute intestinal obstruction', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (73, N'Acute Abdomen pain', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (74, N'Acute  ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (75, N' Acute Pancreatitis ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (76, N'Rectal pain ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (77, N'Proctalgia fugax', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (78, N'Impacted faeces (megacolon)', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (79, N'Acute urinary retenssion', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (80, N'Urinary retension', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (81, N'Priapism', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (82, N'Paraphmosis ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (83, N'Rupture of urethra ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (84, N'Torsion of the testis', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (85, N'Imperforate hymen & haematocolpos', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (86, N'Ruptured ectopic gestation', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (87, N'Epistaxis', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (88, N'Sudden blindness', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (89, N'Tooth ache ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (90, N'Ache', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (91, N'Tetanus neonatorum', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (92, N'Psychiatric', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (93, N'Antisocial behaviour', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (94, N'Unsocialized aggressive behaviour', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (95, N'Truancy', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (96, N'Night terrors & nightmares ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (97, N'Panic', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (98, N'phobias', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (99, N'Excitement & agitation', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (100, N'Stupor ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (101, N'Delirium', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (102, N'Twilight states ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (103, N'Depression', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (104, N'Hysterical reactions ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (105, N'Amnesia ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (106, N'Epileptic', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (107, N'Epileptic & post epileptic & post epileptic phenomena', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (108, N'Phenomena', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (109, N'Drug withdrawal', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (110, N'MLC', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (111, N'Medico - Legal Emergencies ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (112, N'Intoxicatuin', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (113, N' Suicide', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (114, N'Hanging', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (115, N'Assault', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (116, N'Rape on minor', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (117, N'Criminal abortion', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (118, N'Abandoned child ', N'test123', NULL, NULL, 1, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (119, N'DERMATOLOGICAL', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (120, N'Itching ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (121, N'Prickly heat', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (122, N'Napkin rash', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (123, N'Urtciaria', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (124, N'Angioneurotic oedema', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (125, N'Bullous impetige ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (126, N'Ecthyma', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (127, N'Infected scabies', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (128, N'Scabies', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (129, N'Infantile seborrhoic dermatitis ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (130, N'Infantile atopic eczema ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (131, N'Eczema', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (132, N'Candidosis', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (133, N'Leiner`s disease', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (134, N'Disease', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (135, N'Erythema nodosum', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (136, N'Drug eruption', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (137, N'Toxic epidermal necrolysis', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (138, N'Herxheimer reaction', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (139, N'Lepra reaction', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (140, N'Steven johnson syndrome', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (141, N'Koposi`s vericelliform eruption', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (142, N'Herpes zoster', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (143, N'Anhidrotic ectodermal dysplasia', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (144, N'Lamellar ichthyosis', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (145, N'Acrodermatitis enteropathica', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (146, N'Stings and Bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (147, N'Bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (148, N'Ants bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (149, N'Bees bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (150, N'Wasps & hornets bites', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (151, N'Spider bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (152, N'Fish bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (153, N'Scorpion stings bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (154, N'Centepede bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (155, N'Millipede bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (156, N'Tick bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (157, N'Myiasis ,(maggots) ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (158, N'Blistering beetles ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (159, N'Hairy caterpillar bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (160, N'Stinging nettle (bichu buti)', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (161, N'Dog bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (162, N'Jackal bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (163, N'Wolf bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (164, N'Human bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (165, N'Mosquito bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (166, N'Monkey bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (167, N'Bedbug bites ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (168, N'Snake bite', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1212, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1213, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1214, N'GYNAECOLOGICAL SYMPTOM																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1215, N'GYNAECOLOGICAL																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1216, N'Leucorrhoea 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1217, N'Early detection of cancer																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1218, N'Dysmenorrhoea																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1219, N'Heavy menstrual flow 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1220, N'Post ponement of minses																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1221, N'Premenstrual symptom 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1222, N'Family planning 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1223, N'OBSTETRIC SYMPTOMS																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1224, N'Pregnancy 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1225, N'Postnatal problem																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1226, N'Routine 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1227, N'Routine antenatal checkup 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1228, N'Prescribing in pregnancy																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1229, N'Problem of early pregnancy															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1230, N'Vomiting 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1231, N'Bleeding pv																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1232, N'Anemia 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1233, N'Pre eclomptic toxemia																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1234, N'Convulsion 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1235, N'Heart disease 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1236, N'Insufficient breast milk																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1237, N'Painfull cracks on nipple 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1238, N'Stretch marks and pigmentation														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1239, N'SURGICAL SYMPTOM																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1240, N'Breast lump 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1241, N'Bleeding per rectum																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1242, N'Pain at anus																			', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1243, N'Anus pain																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1244, N'Anal lesions 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1245, N'Psychiatric symptoms																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1246, N'Anxiety 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1247, N'Neurosis 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1248, N'Psychic complaints																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1249, N'Panick reaction phobia																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1250, N'Hysteria 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1251, N'Obsessive compulsive																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1252, N'Neurosis continuous talker															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1253, N'Depression																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1254, N'Schizophrenia 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1255, N'Psychsomatic illnesses 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1256, N'MARITAL AND SEXUAL PROBLEM															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1257, N'Marital problems																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1258, N'Consanguinity																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1259, N'Engagement 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1260, N'Neuresis 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1261, N'Marital counselling 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1262, N'SEXUAL DYSFUNCTION MALE 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1263, N'Impotence erctile dysfunction															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1264, N'Pain during ejaculation 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1265, N'Dysparunia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1266, N'Nocturnal emissions 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1267, N'Passage of semen 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1268, N'Semen 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1269, N'Masturbation																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1270, N'Emergencies 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1271, N'Anophylaxis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1272, N'Cardio pulmonary arrest																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1273, N'Unconscious																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1274, N'Diabetic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1275, N'Suspected myocodial infaect															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1276, N'Myocodial infaect																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1277, N'Acute hypotension (shock)																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1278, N'Watery diarrhoea & hypotension														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1279, N'Acute hypertension																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1280, N'Hypertesion 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1281, N'Breath lessness with wheezing 														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1282, N'Breath lessness with out wheezing 													', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1283, N'Severe 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1284, N'Severe hemetemesis 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1285, N'Hemoptysis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1286, N'Myocodial ischemia 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1287, N'Coronary insufficiency 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1288, N'Subendocardial ischemia 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1289, N'Unstable angina 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1290, N'Stable angina																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1291, N'Hyperventilation																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1292, N'Hypokalemia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1293, N'Right or left ventricular hypertropy													', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1294, N'RBBB																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1295, N'LBBB																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1296, N'WPW 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1297, N'Tachycardia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1298, N'Mitral value prolape 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1299, N'Sinus tachycardia 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1300, N'Regular rhythm																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1301, N'Aorta 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1302, N'Left pulmonary artery																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1303, N'Left artrium																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1304, N'Left pulmonary veins 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1305, N'Aortic sem																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1306, N'																						', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1307, N'Oxygen therapy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1308, N'Pleural aspiration																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1309, N'Pericardial paracentesis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1310, N'Peritoneal paracentesis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1311, N'Tracheostomy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1312, N'Endotracheal entubation																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1313, N'Liver biopsy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1314, N'Renal biopsy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1315, N'Bone marrow biopy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1316, N'Splenic biopsy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1317, N'Splenoportogram																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1318, N'Bronchogram																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1319, N'Cerebral angiogram																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1320, N'Angiocardiography																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1321, N'Ventriculography																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1322, N'Irradiation																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1323, N'Injrction reactions																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1324, N'Venesection																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1325, N'Blood trensfusion																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1326, N'Lumber puncture																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1327, N'Eye																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1328, N'Pallor 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1329, N'Lymph node																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1330, N'Splenomegaly																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1331, N'Pneumonia																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1332, N'Icterus eye & tongue																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1333, N'Tongue 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1334, N'Yellow																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1335, N'Fever																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1336, N'Cold																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1337, N'Cough 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1338, N'LRTI																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1339, N'URTI																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1340, N'UTI 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1341, N'HTN																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1342, N'CAD																					', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1343, N'COPD																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1344, N'Animia 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1345, N'Enteritis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1346, N'Gynoecological																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1347, N'Infection 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1348, N'Otitis media 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1349, N'SSTI																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1350, N'Typhoid																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1351, N'Diarrhoea 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1352, N'Dysentery																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1353, N'Gynoecological Infertion																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1354, N'Orodental infertion																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1355, N'Orthopedic infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1356, N'Post surgical infection																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1357, N'Community Aequiral																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1358, N'Nosocomial pneumonia 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1359, N'Gynaecological																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1360, N'Diabetic foot ulcer																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1361, N'Ulcer																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1362, N'Dental infection																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1363, N'Lower abdaminal infection 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1364, N'Infection due to Haemorchoids 														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1365, N'Ano- rectal infection 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1366, N'Infection																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1367, N'Infective																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1368, N'Colitis																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1369, N'Colo rectal infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1370, N'Acute Appendicitis 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1371, N'Appendicitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1372, N'Haemorrhoidectomy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1373, N'Post Operative infertion																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1374, N'Tuberculosis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1375, N'Intra abdominal infection																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1376, N'Bone & joint infection																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1377, N'Ophthalmic infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1378, N'Bacteremia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1379, N'Septicemia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1380, N'Meningitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1381, N'Burns																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1382, N'Anti Diabetic																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1383, N'G.I. infection																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1384, N'For newly diagnosed diabetic patient													', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1385, N'Non insulin dependent diabetes mellitus 												', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1386, N'NIDDM																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1387, N'Uncontrolled 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1388, N'with																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1389, N'Monotherapy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1390, N'Type 2 diabetic																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1391, N'Type 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1392, N'FPG																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1393, N'Dyslipdemia																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1394, N'Dysmenorrhoea																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1395, N'NSAISDs																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1396, N'Biliary colic																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1397, N'Inestinal colic																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1398, N'Arthritic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1399, N'Lumbago																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1400, N'Cervical pain 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1401, N'Post traumatic pain 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1402, N'Inflammatory 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1403, N'Candition																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1404, N'Spondylitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1405, N'Sprain 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1406, N'Strain																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1407, N'Dental pain																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1408, N'Traumatic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1409, N'Injury																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1410, N'Orthopedic infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1411, N'Severe Dysmenorrhoea 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1412, N'Dental surgery																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1413, N'Hematoma																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1414, N'Orthopedic surgery																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1415, N'Acute pain																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1416, N'Rheumotic stiff joint																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1417, N'Soft & Hard tissue injary																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1418, N'Wound 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1419, N'Osteoarthritis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1420, N'Rheumatoid																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1421, N'Arthritis																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1422, N'Hysterectomy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1423, N'post partum 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1424, N'Sinusitis																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1425, N'Pharyngitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1426, N'Tonsilitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1427, N'Peptic Ulcer 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1428, N'Hyperacidity																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1429, N'Dyspepsia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1430, N'GERD																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1431, N'Contipation																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1432, N'GI infection																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1433, N'Nausea & vomting 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1434, N'Nausea 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1435, N'Vomting																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1436, N'Febrille illness																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1437, N'Diarrhoea & Dysentery																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1438, N'Diarrhoea 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1439, N'Dysentery																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1440, N'Pre & operative condition																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1441, N'Gastro enteritis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1442, N'Appetite																				', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1443, N'Stimulant																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1444, N'Half 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1445, N'Half headach																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1446, N'Diabetic  																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1447, N'CVD 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1448, N'CKD																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1449, N'Pre diabetic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1450, N'PCOS																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1451, N'RTI																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1452, N'Musculo pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1453, N'Musculo skeletal pain																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1454, N'Osteopenia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1455, N'Osteoporosis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1456, N'Melasma 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1457, N'Dark sport																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1458, N'Erythema & pre mature skin aging														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1459, N'Immunity																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1460, N'Diabetic Neuropathy																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1461, N'Diabetic retinopathy																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1462, N'Alcoholic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1463, N'Alcoholic neuropathy																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1464, N'As																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1465, N'an																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1466, N'Adjunct 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1467, N'Cardiac therapy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1468, N'Neuropathy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1469, N'Convalescence 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1470, N'Chronic fatigue syndrome																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1471, N'Trigeminal 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1472, N'Neurolgia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1473, N'Post Herpetic neuralgia																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1474, N'Third melar extraction																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1475, N'Peripheral 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1476, N'Mild 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1477, N'Mild neuropathic pain 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1478, N'Hypertension																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1479, N'Muscle cramp																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1480, N'Fungal infection																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1481, N'Fungal skin infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1482, N'Seborrhoeic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1483, N'Dermatitis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1484, N'Oral 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1485, N'Oral candidiasis																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1486, N'Oropharyngeal 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1487, N'Candidiasis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1488, N'Vulvo vaginal candidiasis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1489, N'Pityriasis versicolor																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1490, N'Tinea corparis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1491, N'Tinea cruris 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1492, N'Mixed skin infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1493, N'Tinea infection																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1494, N'Vulvar itching 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1495, N'Ringworm 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1496, N'Eczema 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1497, N'Darmatitis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1498, N'Dry cough 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1499, N'Recurrent 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1500, N'Allergic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1501, N'Rhinitis & allergic 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1502, N'Asthama allergic 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1503, N'Rhinitics congestion																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1504, N'Chronic idiopathic 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1505, N'Urticaria 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1506, N'Allergic associated with cold & congestion											', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1507, N'Diahoea & dysentery																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1508, N'Gynoecological Infertion																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1509, N'Anxiety																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1510, N'Orbital pain																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1511, N'Mouth ulcer																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1512, N'Oral candidiasis																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1513, N'Acute otitis media																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1514, N'Otitis  																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1515, N'Chronic obesity																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1516, N'Oral contraceptive																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1517, N'Vulvo vaginal  																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1518, N'Orthopedic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1519, N'COPD & Asthama 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1520, N'Psoriasis & Eczema 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1521, N'Haemarrhagic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1522, N'Candition																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1523, N'GASTROINTESTINAL SYMPTOMS																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1524, N'Anorexia 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1525, N'Nausea 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1526, N'Flalutence (gas)																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1527, N'Chronic constiption																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1528, N'Acute watery diarrhoea 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1529, N'Acute mucus diarroea 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1530, N'Chronic diarrhoea 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1531, N'Irritable bowel syndrome 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1532, N'Dysphagia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1533, N'Hiccups																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1534, N'Joundice																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1535, N'Ascites																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1536, N'Chronic alcoholic with tremor 														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1537, N'Worm infestation 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1538, N'Epgastric pain																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1539, N'Duodenal ulcer																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1540, N'Pain in rigth hypochondrium															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1541, N'Amorbic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1542, N'Hepatitis 																			', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1543, N'Pain in rigth iliac fossa 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1544, N'Colicky pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1545, N'Pain in abdaman																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1546, N'Ureteric renal colic 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1547, N'Small intestinal colic 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1548, N'Large intestinal colic																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1549, N'Cardiao vascular symptom																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1550, N'Anginal pain																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1551, N'Palpitation																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1552, N'Syncopal attack																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1553, N'Sudden onset breathlessnerr 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1554, N'SOB																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1555, N'Congestive cardiac failure 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1556, N'Hypertension																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1557, N'Rheumatic heart disease																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1558, N'Care after heart attack 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1559, N'Treatment of hyperlipidemia															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1560, N'RESPIRATARY SYSMTOM 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1561, N'Hemoptysis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1562, N'Bronchial asthma 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1563, N'Hoarseness of voice 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1564, N'Chest pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1565, N'Pleural pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1566, N'Pain of rib trauma 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1567, N'Pain of costo chondritis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1568, N'Pain of muscle sprain 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1569, N'Sprain 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1570, N'Repeated cold 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1571, N'Emphysema																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1572, N'CNS SYMTOMS																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1573, N'Headach 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1574, N'Migraine 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1575, N'Convulsion																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1576, N'Epilepsy																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1577, N'Hysterical																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1578, N'Fit 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1579, N'Trismus (Lock jaw)																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1580, N'Giddiness																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1581, N'Tremors 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1582, N'Bell`s polsy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1583, N'C.V.A																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1584, N'C.V.A with hemiplegia 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1585, N'Rt hemiplegia 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1586, N'Lt hemiplegia																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1587, N'Coma 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1588, N'After care of stroke 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1589, N'ORTHOPAEDIC SYMTOMS																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1590, N'Pain in knec 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1591, N'Heel pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1592, N'Low back ache 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1593, N'Neck pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1594, N'Ankle pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1595, N'Ankle sprain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1596, N'Fractures 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1597, N'Cramps in calf 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1598, N'Intermittent claudication 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1599, N'Tingling of limbs 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1600, N'Osteoporasis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1601, N'Osteoporasis with fracture spine 														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1602, N'RENAL SYMPTOM																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1603, N'Edema 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1604, N'Frequncy of urin 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1605, N'Enlaged prostate 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1606, N'Acute retention of urin 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1607, N'Retention of urin																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1608, N'Hematuria 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1609, N'Acute renal failure 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1610, N'Chronic renal failure 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1611, N'Nephrotic syndeome 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1612, N'ENDOCRINE DISEASES																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1613, N'Diabetes Obesty																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1614, N'Obesty 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1615, N'Hypothyroidism																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1616, N'Hyperthyroidism																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1617, N'GENERAL SYMPTOMS																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1618, N'Loss of weight 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1619, N'Fatigue 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1620, N'Fever with chills																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1621, N'Fever with out chills																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1622, N'Typhoid 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1623, N'Fever pallor 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1624, N'Stomatitis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1625, N'Oral submucus fibrosis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1626, N'Bitter teste in mouth 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1627, N'Crack on soles 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1628, N'Excessive sweating 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1629, N'Tooth ache 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1630, N'Dental hygeine 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1631, N'Bleeding 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1632, N'Bleeding gum 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1633, N'Hypersensitive																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1634, N'Teeth																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1635, N'ENT & EYE SYMPTOM																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1636, N'Throat pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1637, N'Tonsilitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1638, N'Blocking of nostrils 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1639, N'Common cold 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1640, N'Epistaxis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1641, N'Pain in ear 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1642, N'Discharging ear 																		', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1643, N'Diminished hearing 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1644, N'Tinnitus 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1645, N'F.B. in ear 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1646, N'Acute conjunctivitis																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1647, N'Chronic blepharitis 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1648, N'Acute dacryocystitis																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1649, N'F.B. in eye																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1650, N'GERIATRIC SYMPTOMS 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1651, N'Insomnia 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1652, N'Farget fulness																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1653, N'Frequncy of micturition																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1654, N'Tremors 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1655, N'Managing bedridden 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1656, N'Patient at home 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1657, N'PEDIATRIC SYMPTOM																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1658, N'Immunisation																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1659, N'Schedule 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1660, N'Neonatal jaundic																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1661, N'Jaundic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1662, N'Neonatal convulsion 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1663, N'Excessive crying																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1664, N'Crying 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1665, N'Neonatal vomiting 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1666, N'Pratein caloriemalnutrition															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1667, N'Gastro enteritis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1668, N'Febrile 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1669, N'Convulsion																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1670, N'Child not goining weight																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1671, N'Child eating mud 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1672, N'Thumb 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1673, N'Thumb sucking 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1674, N'Nocturnal enuresis																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1675, N'Infant with painfull lag 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1676, N'Chickenpox																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1677, N'Measles																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1678, N'Mumps																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1679, N'Rheumatic fever 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1680, N'Acute Bronchialitis 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1681, N'Polio																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1682, N'Art of prescribing to children														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1683, N'Common pediatric prescription															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1684, N'SKIN SYMPTOM & VENEREAL DISEASES														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1685, N'Hypopigmented patches																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1686, N'Lepresy 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1687, N'Tenia versicolor																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1688, N'Vitiligo																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1689, N'Patches on cheek																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1690, N'urticarial Rashes																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1691, N'Generalised itching 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1692, N' Itching Around Anus																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1693, N'Itching of vulva 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1694, N'Itching of scalp dandruff																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1695, N'Baldness																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1696, N'Alopecia 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1697, N'Areata 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1698, N'Premature greying of hair 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1699, N'Excessive lass of hair																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1700, N'Hypertrophic scar & keloid 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1701, N'Herpes zoster 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1702, N'Hespes simplex																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1703, N'Eczema 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1704, N'Psoriasis  																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1705, N'Teniasis																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1706, N'Acne																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1707, N'Vulgaris 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1708, N'Sare on penis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1709, N'Pusper urethra 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1710, N'Urethra																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1711, N'A.I.D.S.                                                                              ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1712, N'Oxygen therapy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1713, N'Pleural aspiration																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1714, N'Pericardial paracentesis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1715, N'Peritoneal paracentesis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1716, N'Tracheostomy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1717, N'Endotracheal entubation																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1718, N'Liver biopsy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1719, N'Renal biopsy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1720, N'Bone marrow biopy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1721, N'Splenic biopsy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1722, N'Splenoportogram																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1723, N'Bronchogram																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1724, N'Cerebral angiogram																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1725, N'Angiocardiography																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1726, N'Ventriculography																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1727, N'Irradiation																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1728, N'Injrction reactions																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1729, N'Venesection																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1730, N'Blood trensfusion																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1731, N'Lumber puncture																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1732, N'Eye																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1733, N'Pallor 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1734, N'Lymph node																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1735, N'Splenomegaly																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1736, N'Pneumonia																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1737, N'Icterus eye & tongue																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1738, N'Tongue 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1739, N'Yellow																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1740, N'Fever																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1741, N'Cold																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1742, N'Cough 																				', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1743, N'LRTI																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1744, N'URTI																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1745, N'UTI 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1746, N'HTN																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1747, N'CAD																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1748, N'COPD																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1749, N'Animia 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1750, N'Enteritis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1751, N'Gynoecological																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1752, N'Infection 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1753, N'Otitis media 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1754, N'SSTI																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1755, N'Typhoid																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1756, N'Diarrhoea 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1757, N'Dysentery																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1758, N'Gynoecological Infertion																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1759, N'Orodental infertion																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1760, N'Orthopedic infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1761, N'Post surgical infection																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1762, N'Community Aequiral																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1763, N'Nosocomial pneumonia 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1764, N'Gynaecological																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1765, N'Diabetic foot ulcer																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1766, N'Ulcer																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1767, N'Dental infection																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1768, N'Lower abdaminal infection 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1769, N'Infection due to Haemorchoids 														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1770, N'Ano- rectal infection 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1771, N'Infection																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1772, N'Infective																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1773, N'Colitis																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1774, N'Colo rectal infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1775, N'Acute Appendicitis 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1776, N'Appendicitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1777, N'Haemorrhoidectomy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1778, N'Post Operative infertion																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1779, N'Tuberculosis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1780, N'Intra abdominal infection																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1781, N'Bone & joint infection																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1782, N'Ophthalmic infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1783, N'Bacteremia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1784, N'Septicemia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1785, N'Meningitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1786, N'Burns																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1787, N'Anti Diabetic																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1788, N'G.I. infection																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1789, N'For newly diagnosed diabetic patient													', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1790, N'Non insulin dependent diabetes mellitus 												', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1791, N'NIDDM																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1792, N'Uncontrolled 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1793, N'with																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1794, N'Monotherapy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1795, N'Type 2 diabetic																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1796, N'Type 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1797, N'FPG																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1798, N'Dyslipdemia																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1799, N'Dysmenorrhoea																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1800, N'NSAISDs																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1801, N'Biliary colic																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1802, N'Inestinal colic																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1803, N'Arthritic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1804, N'Lumbago																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1805, N'Cervical pain 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1806, N'Post traumatic pain 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1807, N'Inflammatory 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1808, N'Candition																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1809, N'Spondylitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1810, N'Sprain 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1811, N'Strain																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1812, N'Dental pain																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1813, N'Traumatic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1814, N'Injury																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1815, N'Orthopedic infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1816, N'Severe Dysmenorrhoea 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1817, N'Dental surgery																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1818, N'Hematoma																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1819, N'Orthopedic surgery																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1820, N'Acute pain																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1821, N'Rheumotic stiff joint																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1822, N'Soft & Hard tissue injary																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1823, N'Wound 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1824, N'Osteoarthritis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1825, N'Rheumatoid																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1826, N'Arthritis																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1827, N'Hysterectomy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1828, N'post partum 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1829, N'Sinusitis																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1830, N'Pharyngitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1831, N'Tonsilitis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1832, N'Peptic Ulcer 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1833, N'Hyperacidity																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1834, N'Dyspepsia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1835, N'GERD																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1836, N'Contipation																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1837, N'GI infection																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1838, N'Nausea & vomting 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1839, N'Nausea 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1840, N'Vomting																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1841, N'Febrille illness																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1842, N'Diarrhoea & Dysentery																	', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1843, N'Diarrhoea 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1844, N'Dysentery																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1845, N'Pre & operative condition																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1846, N'Gastro enteritis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1847, N'Appetite																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1848, N'Stimulant																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1849, N'Half 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1850, N'Half headach																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1851, N'Diabetic  																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1852, N'CVD 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1853, N'CKD																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1854, N'Pre diabetic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1855, N'PCOS																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1856, N'RTI																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1857, N'Musculo pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1858, N'Musculo skeletal pain																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1859, N'Osteopenia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1860, N'Osteoporosis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1861, N'Melasma 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1862, N'Dark sport																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1863, N'Erythema & pre mature skin aging														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1864, N'Immunity																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1865, N'Diabetic Neuropathy																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1866, N'Diabetic retinopathy																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1867, N'Alcoholic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1868, N'Alcoholic neuropathy																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1869, N'As																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1870, N'an																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1871, N'Adjunct 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1872, N'Cardiac therapy																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1873, N'Neuropathy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1874, N'Convalescence 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1875, N'Chronic fatigue syndrome																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1876, N'Trigeminal 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1877, N'Neurolgia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1878, N'Post Herpetic neuralgia																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1879, N'Third melar extraction																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1880, N'Peripheral 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1881, N'Mild 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1882, N'Mild neuropathic pain 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1883, N'Hypertension																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1884, N'Muscle cramp																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1885, N'Fungal infection																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1886, N'Fungal skin infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1887, N'Seborrhoeic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1888, N'Dermatitis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1889, N'Oral 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1890, N'Oral candidiasis																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1891, N'Oropharyngeal 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1892, N'Candidiasis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1893, N'Vulvo vaginal candidiasis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1894, N'Pityriasis versicolor																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1895, N'Tinea corparis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1896, N'Tinea cruris 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1897, N'Mixed skin infection																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1898, N'Tinea infection																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1899, N'Vulvar itching 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1900, N'Ringworm 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1901, N'Eczema 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1902, N'Darmatitis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1903, N'Dry cough 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1904, N'Recurrent 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1905, N'Allergic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1906, N'Rhinitis & allergic 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1907, N'Asthama allergic 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1908, N'Rhinitics congestion																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1909, N'Chronic idiopathic 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1910, N'Urticaria 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1911, N'Allergic associated with cold & congestion											', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1912, N'Diahoea & dysentery																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1913, N'Gynoecological Infertion																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1914, N'Anxiety																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1915, N'Orbital pain																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1916, N'Mouth ulcer																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1917, N'Oral candidiasis																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1918, N'Acute otitis media																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1919, N'Otitis  																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1920, N'Chronic obesity																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1921, N'Oral contraceptive																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1922, N'Vulvo vaginal  																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1923, N'Orthopedic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1924, N'COPD & Asthama 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1925, N'Psoriasis & Eczema 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1926, N'Haemarrhagic 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1927, N'Candition																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1928, N'GASTROINTESTINAL SYMPTOMS																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1929, N'Anorexia 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1930, N'Nausea 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1931, N'Flalutence (gas)																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1932, N'Chronic constiption																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1933, N'Acute watery diarrhoea 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1934, N'Acute mucus diarroea 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1935, N'Chronic diarrhoea 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1936, N'Irritable bowel syndrome 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1937, N'Dysphagia 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1938, N'Hiccups																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1939, N'Joundice																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1940, N'Ascites																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1941, N'Chronic alcoholic with tremor 														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1942, N'Worm infestation 																		', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1943, N'Epgastric pain																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1944, N'Duodenal ulcer																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1945, N'Pain in rigth hypochondrium															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1946, N'Amorbic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1947, N'Hepatitis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1948, N'Pain in rigth iliac fossa 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1949, N'Colicky pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1950, N'Pain in abdaman																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1951, N'Ureteric renal colic 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1952, N'Small intestinal colic 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1953, N'Large intestinal colic																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1954, N'Cardiao vascular symptom																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1955, N'Anginal pain																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1956, N'Palpitation																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1957, N'Syncopal attack																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1958, N'Sudden onset breathlessnerr 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1959, N'SOB																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1960, N'Congestive cardiac failure 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1961, N'Hypertension																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1962, N'Rheumatic heart disease																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1963, N'Care after heart attack 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1964, N'Treatment of hyperlipidemia															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1965, N'RESPIRATARY SYSMTOM 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1966, N'Hemoptysis																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1967, N'Bronchial asthma 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1968, N'Hoarseness of voice 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1969, N'Chest pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1970, N'Pleural pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1971, N'Pain of rib trauma 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1972, N'Pain of costo chondritis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1973, N'Pain of muscle sprain 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1974, N'Sprain 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1975, N'Repeated cold 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1976, N'Emphysema																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1977, N'CNS SYMTOMS																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1978, N'Headach 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1979, N'Migraine 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1980, N'Convulsion																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1981, N'Epilepsy																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1982, N'Hysterical																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1983, N'Fit 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1984, N'Trismus (Lock jaw)																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1985, N'Giddiness																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1986, N'Tremors 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1987, N'Bell`s polsy																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1988, N'C.V.A																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1989, N'C.V.A with hemiplegia 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1990, N'Rt hemiplegia 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1991, N'Lt hemiplegia																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1992, N'Coma 																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1993, N'After care of stroke 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1994, N'ORTHOPAEDIC SYMTOMS																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1995, N'Pain in knec 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1996, N'Heel pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1997, N'Low back ache 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1998, N'Neck pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (1999, N'Ankle pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2000, N'Ankle sprain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2001, N'Fractures 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2002, N'Cramps in calf 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2003, N'Intermittent claudication 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2004, N'Tingling of limbs 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2005, N'Osteoporasis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2006, N'Osteoporasis with fracture spine 														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2007, N'RENAL SYMPTOM																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2008, N'Edema 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2009, N'Frequncy of urin 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2010, N'Enlaged prostate 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2011, N'Acute retention of urin 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2012, N'Retention of urin																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2013, N'Hematuria 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2014, N'Acute renal failure 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2015, N'Chronic renal failure 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2016, N'Nephrotic syndeome 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2017, N'ENDOCRINE DISEASES																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2018, N'Diabetes Obesty																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2019, N'Obesty 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2020, N'Hypothyroidism																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2021, N'Hyperthyroidism																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2022, N'GENERAL SYMPTOMS																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2023, N'Loss of weight 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2024, N'Fatigue 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2025, N'Fever with chills																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2026, N'Fever with out chills																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2027, N'Typhoid 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2028, N'Fever pallor 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2029, N'Stomatitis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2030, N'Oral submucus fibrosis																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2031, N'Bitter teste in mouth 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2032, N'Crack on soles 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2033, N'Excessive sweating 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2034, N'Tooth ache 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2035, N'Dental hygeine 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2036, N'Bleeding 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2037, N'Bleeding gum 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2038, N'Hypersensitive																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2039, N'Teeth																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2040, N'ENT & EYE SYMPTOM																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2041, N'Throat pain 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2042, N'Tonsilitis																			', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2043, N'Blocking of nostrils 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2044, N'Common cold 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2045, N'Epistaxis 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2046, N'Pain in ear 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2047, N'Discharging ear 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2048, N'Diminished hearing 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2049, N'Tinnitus 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2050, N'F.B. in ear 																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2051, N'Acute conjunctivitis																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2052, N'Chronic blepharitis 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2053, N'Acute dacryocystitis																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2054, N'F.B. in eye																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2055, N'GERIATRIC SYMPTOMS 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2056, N'Insomnia 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2057, N'Farget fulness																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2058, N'Frequncy of micturition																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2059, N'Tremors 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2060, N'Managing bedridden 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2061, N'Patient at home 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2062, N'PEDIATRIC SYMPTOM																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2063, N'Immunisation																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2064, N'Schedule 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2065, N'Neonatal jaundic																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2066, N'Jaundic																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2067, N'Neonatal convulsion 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2068, N'Excessive crying																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2069, N'Crying 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2070, N'Neonatal vomiting 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2071, N'Pratein caloriemalnutrition															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2072, N'Gastro enteritis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2073, N'Febrile 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2074, N'Convulsion																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2075, N'Child not goining weight																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2076, N'Child eating mud 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2077, N'Thumb 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2078, N'Thumb sucking 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2079, N'Nocturnal enuresis																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2080, N'Infant with painfull lag 																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2081, N'Chickenpox																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2082, N'Measles																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2083, N'Mumps																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2084, N'Rheumatic fever 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2085, N'Acute Bronchialitis 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2086, N'Polio																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2087, N'Art of prescribing to children														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2088, N'Common pediatric prescription															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2089, N'SKIN SYMPTOM & VENEREAL DISEASES														', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2090, N'Hypopigmented patches																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2091, N'Lepresy 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2092, N'Tenia versicolor																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2093, N'Vitiligo																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2094, N'Patches on cheek																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2095, N'urticarial Rashes																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2096, N'Generalised itching 																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2097, N' Itching Around Anus																	', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2098, N'Itching of vulva 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2099, N'Itching of scalp dandruff																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2100, N'Baldness																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2101, N'Alopecia 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2102, N'Areata 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2103, N'Premature greying of hair 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2104, N'Excessive lass of hair																', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2105, N'Hypertrophic scar & keloid 															', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2106, N'Herpes zoster 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2107, N'Hespes simplex																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2108, N'Eczema 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2109, N'Psoriasis  																			', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2110, N'Teniasis																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2111, N'Acne																					', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2112, N'Vulgaris 																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2113, N'Sare on penis 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2114, N'Pusper urethra 																		', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2115, N'Urethra																				', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Diseasses] ([DiseasesId], [DisseaseName], [Description], [CreatedBy], [CreationDate], [UpdatedBy], [UpdatedDate]) VALUES (2116, N'A.I.D.S.                                                                              ', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Diseasses] OFF
SET IDENTITY_INSERT [dbo].[Doctors] ON 

INSERT [dbo].[Doctors] ([DoctorId], [Name], [EmailId], [Gender], [Qualification], [Mobile], [Specialist], [Photo], [Date_of_joining], [Address], [Timing], [CreatedBy], [CreationDate], [UpdatedBy], [UpdationDate]) VALUES (23, N'Mr Azam', N'Azam@gmail.com', N'Male', N'MBBS', N'98772727', N'Heart', NULL, NULL, N'hyd', N'8pm-10pm', 1, CAST(N'2018-10-14 18:36:26.410' AS DateTime), 1, CAST(N'2019-10-26 08:32:59.560' AS DateTime))
INSERT [dbo].[Doctors] ([DoctorId], [Name], [EmailId], [Gender], [Qualification], [Mobile], [Specialist], [Photo], [Date_of_joining], [Address], [Timing], [CreatedBy], [CreationDate], [UpdatedBy], [UpdationDate]) VALUES (24, N'Mr Ali', N'yawarali13@gmail.com', N'Male', N'MBBS', N'97654333', N'Cancer', NULL, CAST(N'2018-10-14 00:00:00.000' AS DateTime), N'hyderabad', NULL, 1, CAST(N'2018-10-14 18:38:16.920' AS DateTime), 1, CAST(N'2018-10-14 18:38:16.920' AS DateTime))
INSERT [dbo].[Doctors] ([DoctorId], [Name], [EmailId], [Gender], [Qualification], [Mobile], [Specialist], [Photo], [Date_of_joining], [Address], [Timing], [CreatedBy], [CreationDate], [UpdatedBy], [UpdationDate]) VALUES (25, N'Dr Aijaz Ahmed', N'Ahmed@gmail.com', N'Male', N'MABS', N'Ahmed@gmail.com', N'Cancer', NULL, NULL, N'hyderabad a', N'8pm-10pm', 1, CAST(N'2018-10-14 18:43:36.060' AS DateTime), 1, CAST(N'2019-01-26 14:51:52.157' AS DateTime))
SET IDENTITY_INSERT [dbo].[Doctors] OFF
SET IDENTITY_INSERT [dbo].[DosesDetail] ON 

INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (1, N'1/2  OD							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (2, N'1/2     1/2 BID					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (3, N'1/2  1/2   1/2 TID				  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (4, N'1/2   1/2   1/2  1/2QID			  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (5, N'0       OD						  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (6, N'0 - 0 BID							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (7, N'0 - 0  - 0 TID					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (8, N'0 - 0 -0 -0  QID					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (9, N'1 in a 7 DAY						  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (10, N'BBF/BD							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (11, N'0 BT								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (12, N'   0   SOS						  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (13, N'q									  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (14, N'qd								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (15, N'qod								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (16, N'qh								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (17, N'S									  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (18, N'SS								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (19, N'C									  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (20, N'AC								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (21, N'PC								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (22, N'TW								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (23, N'IM								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (24, N'ID								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (25, N'IV								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (26, N'QAM								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (27, N'QPM								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (28, N'Q4H								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (29, N'QOD								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (30, N'HS								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (31, N'AC								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (32, N'PC								  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (33, N'2.5ml OD							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (34, N'2.5ml 2.5 ml  BID					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (35, N'2.5ml 2.5ml 2.5ml TID				  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (36, N'2.5ml QID							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (37, N'5ml OD							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (38, N'5ml 5ml BID						  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (39, N'5ml  5ml  5ml TID					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (40, N'5ml QID							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (41, N'5ml BT							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (42, N'10ml BT							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (43, N'15ml BT							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (44, N'30ml BT							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (45, N'q = Every							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (46, N'qd = Every day 					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (47, N'qh = Every hour 					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (48, N'S = Without						  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (49, N'SS = On e half 					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (50, N'C = With 							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (51, N'SOS = If needed 					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (52, N'AC = Before Meals					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (53, N'PC = After meals					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (54, N'TW = Twice a week					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (55, N'0.5ml OD							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (56, N'0.5ml  0.5ml BID					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (57, N'0.5ml 0.5ml  0.5ml TID			  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (58, N'0.5ml QID							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (59, N'0.5ml BT							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (60, N'1ml OD							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (61, N'1ml  1ml  BID						  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (62, N'1ml  1ml 1ml  TID					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (63, N'1ml QID							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (64, N' 1ml BT							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (65, N'8 drop OD							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (66, N'8 drop  8drop BID					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (67, N'8 drop  8drop  8drop  TID			  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (68, N'6 drop OD							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (69, N'6 drop  6drop BID					  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (70, N'6 drop TID						  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (71, N' 1/1 drop							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (72, N'2/2 drop							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (73, N'4/4 drop							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (74, N'6/6 drop							  ')
INSERT [dbo].[DosesDetail] ([DoseId], [DosesName]) VALUES (75, N'8/8 drop                            ')
SET IDENTITY_INSERT [dbo].[DosesDetail] OFF
SET IDENTITY_INSERT [dbo].[GeneralPrescriptiom] ON 

INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (1, 2021, 1, N'ferd', N',mn', N'asdf', N'nhn', N'sdff', N'asd', N'eerf', N'ddf', N'eef', N'fgg', N'ffee', N'dd', N'aa', N'dfdf', N'ffee', N'ddff', N'eaa', N'fff', N'eef', N'ddss', N'mfdk', N',jjjs', N'nnm', 1, NULL, NULL, NULL)
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (2, 2021, 1, N'IBrahim', N'Male', N'23', N'22', N'55kg', N'Dr Jamal', N'Dehydration  ', N'Dehydration  ', N'Driwning  ', N'DHEA ', N'sadfsdf', N'Fair', N'99F', N'72', N'NAD', N'120/90mmhg', N'99', N'Soft', N'NAD', N'120', N'5', N'Alpha hospita', N'S1S2', 0, CAST(N'2018-12-05 01:07:49.300' AS DateTime), 0, CAST(N'2018-12-05 01:07:51.520' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (3, 2021, 1, N'IBrahim', N'Male', N'23', N'22', N'55kg', N'Dr Jamal', N'Food Chocking ', N'Dehydration  ', N'Driwning  ', N'Stool for Ph & Reducing Substances  ', N'sd', N'Fair', N'99F', N'72', N'NAD', N'120/90mmhg', N'99', N'Soft', N'NAD', N'120', N'5', N'Alpha hospita', N'S1S2', 0, CAST(N'2018-12-05 01:15:55.813' AS DateTime), 0, CAST(N'2018-12-05 01:15:57.103' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (4, 2021, 1, N'IBrahim', N'Male', N'23', N'22', N'55kg', N'Dr Jamal', N'Injuries  ', N'Acute appendicitis ', N'Birth injuries Haemolytic disease of the newborn ', N' Urin for Bence jones Proteins ', N'ja', N'Fair', N'99F', N'72', N'NAD', N'120/90mmhg', N'99', N'Soft', N'NAD', N'120', N'5', N'Alpha hospita', N'S1S2', 0, CAST(N'2018-12-05 01:54:02.970' AS DateTime), 0, CAST(N'2018-12-05 01:54:02.970' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (5, 2021, 1, N'IBrahim', N'Male', N'23', N'22', N'55kg', N'Dr Jamal', N'Shock ', N'Surgical ', N'Diarrhoea ', N'Diabetic profile  ', N'd', N'Fair', N'99F', N'72', N'NAD', N'120/90mmhg', N'99', N'Soft', N'NAD', N'120', N'5', N'Alpha hospita', N'S1S2', 0, CAST(N'2018-12-05 01:57:20.717' AS DateTime), 0, CAST(N'2018-12-05 01:57:20.717' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (6, 2021, 1, N'IBrahim', N'Male', N'23', N'22', N'55kg', N'Dr Jamal', N'Diarrhoea ', N'Diarrhoea ', N'Diarrhoea ', N'Diabetic profile  ', N'ssdfasd', N'Fair', N'99F', N'72', N'NAD', N'120/90mmhg', N'99', N'Soft', N'NAD', N'120', N'asdf', N'asd', N'S1S2', 0, CAST(N'2018-12-07 00:39:23.667' AS DateTime), 0, CAST(N'2018-12-07 00:39:23.667' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (7, 2021, 1, N'IBrahim', N'Male', N'23', N'22', N'55kg', N'Dr Jamal', N'Gas gangrene  ', N'Meconium plug syndrome & Meconium ileus ', N'Dehydration  ', N'Factor VIII & IX Screen ', N'd', N'Fair', N'99F', N'72', N'NAD', N'120/90mmhg', N'99', N'Soft', N'NAD', N'120', N'd', N'd', N'S1S2', 0, CAST(N'2018-12-07 01:04:13.240' AS DateTime), 0, CAST(N'2018-12-07 01:04:14.537' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (8, 2021, 1, N'IBrahim', N'Male', N'23', N'22', N'55kg', N'Dr Jamal', N'Acute stridor  ', N'Dehydration  ', N'Driwning  ', N'DHEA ', N'asdf', N'Fair', N'99F', N'72', N'NAD', N'120/90mmhg', N'99', N'Soft', N'NAD', N'120', N'sd', N'asd', N'S1S2', 0, CAST(N'2018-12-09 05:32:01.450' AS DateTime), 0, CAST(N'2018-12-09 05:32:03.880' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (9, 2021, 1, N'IBrahim', N'Male', N'23', N'22', N'34', N'Dr Jamal', N'Dyspnoea  ', N'Driwning  ', N'Congestive cardiac failure ', N'CBP  ', N'c', N'Fair', N'99F', N'72', N'NAD', N'120/90mmhg', N'99', N'Soft', N'NAD', N'120', N'd', N'd', N'S1S2', 0, CAST(N'2018-12-09 05:43:10.790' AS DateTime), 0, CAST(N'2018-12-09 05:43:10.790' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (1008, 2021, 1, N'IBrahim', N'IBrahim', N'23', N'IBrahim', NULL, N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'120', NULL, N'IBrahim', N'IBrahim', 0, CAST(N'2019-01-26 14:54:11.717' AS DateTime), 0, CAST(N'2019-01-26 14:54:11.717' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (1009, 2021, 1, N'IBrahim', N'IBrahim', N'23', N'IBrahim', NULL, N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'120', NULL, N'IBrahim', N'IBrahim', 0, CAST(N'2019-11-02 23:06:12.777' AS DateTime), 0, CAST(N'2019-11-02 23:06:12.777' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (1010, 2021, 1, N'IBrahim', N'IBrahim', N'23', N'IBrahim', NULL, N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'120', NULL, N'IBrahim', N'IBrahim', 0, CAST(N'2019-11-02 23:10:20.137' AS DateTime), 0, CAST(N'2019-11-02 23:10:20.137' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (1011, 2021, 1, N'IBrahim', N'IBrahim', N'23', N'IBrahim', NULL, N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'120', NULL, N'IBrahim', N'IBrahim', 0, CAST(N'2019-11-02 23:11:09.567' AS DateTime), 0, CAST(N'2019-11-02 23:11:09.567' AS DateTime))
INSERT [dbo].[GeneralPrescriptiom] ([Rpid], [Pid], [Did], [PTName], [Gender], [Age], [Ht], [WT], [ReferBy], [Complain], [History], [Dx], [Investigation], [Advice], [GC], [Temp], [PR], [LR], [BP], [SPO2], [PA], [CNS], [GRBS], [Review], [Emergency], [HR], [CreatedBy], [CreatedDatetime], [UpdatedBy], [Updateddatetime]) VALUES (2009, 2021, 1, N'IBrahim', N'IBrahim', N'23', N'IBrahim', NULL, N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'IBrahim', N'120', NULL, N'IBrahim', N'IBrahim', 0, CAST(N'2020-11-23 08:46:57.803' AS DateTime), 0, CAST(N'2020-11-23 08:46:57.803' AS DateTime))
SET IDENTITY_INSERT [dbo].[GeneralPrescriptiom] OFF
SET IDENTITY_INSERT [dbo].[InvestigationDetails] ON 

INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (1, N'CUE')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (2, N'Urine for Bile Salts & Bile Pigments')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (3, N' Urin for Ketone Bodies')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (4, N' Urin for Bence jones Proteins')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (5, N'Urine for Spot Protein / Creatinine Ratio')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (6, N'Urine for Microalbumin ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (7, N'Urine for Amino Acid Screen ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (8, N'Urine for Metabolic Screen')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (9, N'SEMEN ANALYSIS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (10, N'Stool for Ova & Cysts ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (11, N'Stool for Occult Blood ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (12, N'Stool for Ph & Reducing Substances ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (13, N'HAEMATOLOGY ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (14, N'HB%')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (15, N'CBP ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (16, N'ESR ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (17, N'Blood for MP / Parasite F')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (18, N'Blood for Microfilaria ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (19, N'Platelet Count ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (20, N'BT & CT')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (21, N'Reticulocyte Count')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (22, N'Absolute Eosinophil Count')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (23, N' P.T (prothrombin Time)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (24, N' APTT (Activated partial thrombo plastin time)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (25, N'Nasal Smear for Eosinophils  ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (26, N'G6PD Assay')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (27, N'MICROBIOLOGY')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (28, N'CULTURE & Sensitivity of')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (29, N'C/S Urin')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (30, N'C/S Throat Swab')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (31, N'C/S  pus')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (32, N'C/S Blood Routine')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (33, N'C/S Gram`s Stain (Specimen   )')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (34, N'AFB Stain (Specimen)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (35, N'Throat Swab for K.L.B.( C. Dipththeria)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (36, N'Skin Clipping for Fungus')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (37, N'Fungal Culture ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (38, N'AFB Culture')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (39, N'SEROLOGY & IMMUNOLGY')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (40, N'Pregnancy Test Routine ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (41, N'Pregnancy Test Rapid (Elisa) ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (42, N'Blood Grouping & Rh Typing')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (43, N'VDRL ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (44, N'TPHA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (45, N'HBsAg')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (46, N'HIV I & II (AIDS TEST)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (47, N'Widal test ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (48, N'Brucella')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (49, N'Mantoux Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (50, N'RA ASO Titre ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (51, N'CRP')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (52, N'Coombs Test Direct ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (53, N'Coombs Test Indirect (Antiglobulin Test) ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (54, N'Serum  IgG  IgM  IgA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (55, N'Serum IgE')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (56, N'BIOCHEMISTRY ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (57, N'Blood Sugar FBS/PLBS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (58, N'RBS ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (59, N'Oral GTT E xtended ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (60, N'Oral GTT Mini')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (61, N'Blood for Glyco Haemoglobin (HbA1c)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (62, N'Blood Urea ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (63, N'Blood Urea Nitrogen (BUN)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (64, N'Serum Creatinine')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (65, N'Cholesterol ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (66, N'Triglycerides')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (67, N'HDL Cholesterol')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (68, N'Lipid Profile ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (69, N'LFT ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (70, N'Bilirubuin Total ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (71, N'S.G.P.T.')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (72, N'S.G.O.T.')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (73, N'Alkaline Phosphatase ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (74, N'Gama GTP ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (75, N'Serum Calcium ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (76, N'Serum Phosphorus')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (77, N'Amylase ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (78, N'Lipase ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (79, N'Uric Acid ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (80, N'Serum Magnesium ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (81, N'Serum Acid Phosphatase Total')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (82, N'Prostatic Fraction')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (83, N'Serum Iron ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (84, N'TIBC')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (85, N'Serum Ferritin')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (86, N'Serum ADA ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (87, N'Serum L.D.H.')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (88, N'C.P.K. -MB')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (89, N'Creatinine Clearance Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (90, N'24 Hours urine Proteins')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (91, N'Blood Ammonia Level')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (92, N'Blood Lactate')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (93, N'V.M.A. Spot Test ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (94, N'Serum Protein Electrophoresis (M. Protein)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (95, N'HAEMATOLOGY (SPECIAL TESTS)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (96, N'Sickling Test ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (97, N'Plasma Fibrinogen')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (98, N'Haemoglobin Electrophoresis')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (99, N'Foetal Hb%')
GO
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (100, N'Osmotic Fragility')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (101, N'Pyruvate Kinase Screen ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (102, N'Lupus Anticoagulant Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (103, N'Anti Phospholipid Antibody Test ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (104, N'Factor VIII & IX Screen')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (105, N'NBT Test ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (106, N'L.E. Cell Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (107, N'SEROGY & IMMUNOLGY (SPECIAL TESTS)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (108, N'ANA, Anti Ds DNA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (109, N'HAV  IgM (Hepatitis A  Virus)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (110, N'HCV    Monospot Test (IM)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (111, N'Anti TB   IgG   IgM   IgA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (112, N'Anti Thyroid Anbodies ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (113, N'Torch Complex')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (114, N'TOXO   HSV I & II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (115, N'HIV DUO TEST ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (116, N'Western blot for HIV ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (117, N'CD4 & CD8  COUNTS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (118, N'HORMONES & TUMOUR MARKERS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (119, N'T3 T4 TSH ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (120, N'FSH  LH  Prolactin ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (121, N' Testosterone  P.S.A.')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (122, N'BHCG ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (123, N'Estradiol ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (124, N'DHEA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (125, N'Human Growth Hormone')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (126, N'PTH')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (127, N'CEA  ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (128, N'CA  125')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (129, N'AFP')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (130, N'PROFILES')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (131, N'Antenatal profile ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (132, N'Anaemia profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (133, N'Haemolytic Anaemia profile ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (134, N'Coagulation profile ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (135, N'Diabetic profile ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (136, N'Hypertension profile ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (137, N'Renal profile ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (138, N'STD Profile I           STD Profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (139, N'Cardiac profile I        Cardiac profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (140, N'Collagen profile I     Collagen profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (141, N'Executive profile  I  Executive profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (142, N'Master Health Check Up I  ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (143, N'MHCU II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (144, N'FLUID ANALYSIS & HISTOPATHOLOGY ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (145, N'Pleurl fluid   Ascitic fluid ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (146, N'Synovial fluid ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (147, N'Fluid ADA ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (148, N'Fluid Lactate ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (149, N'Histopathology')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (150, N'Bone Marrow ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (151, N'FNAC')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (152, N'X-Ray ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (153, N'E.C.G')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (154, N'U.S Scan ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (155, N'2D Echo')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (156, N'TMT ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (157, N'Colour Doppler')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (158, N'Spirometry (PFT)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (159, N'COLOUR DOPPER STUDY')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (160, N'Carotid Vassels')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (161, N'Peripheral Vascular Studies ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (162, N'Upper Limbs ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (163, N'Lower Limbs')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (164, N'ABDOMINAL ORGANS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (165, N'Portal System ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (166, N'Renal Artery Doppler')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (167, N'Aorta & its branches')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (168, N'Thyroid ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (169, N'Scrotum ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (170, N'2 D Echo Cardiography')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (171, N'ANTENATAL SCAN')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (172, N'Routine ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (173, N'Single ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (174, N' Multipe ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (175, N' TIFFA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (176, N'NT Scan (11-13 Weeks & 6days)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (177, N'3D & 4D Scan ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (178, N'Biophyical Profile ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (179, N'Fetal Echo')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (180, N' ABDOMEN')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (181, N'Liver & Biliary Tract')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (182, N'Pancreas')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (183, N'G.I. Tract & Appendix')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (184, N'KUB')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (185, N'Retroperitoneum')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (186, N'FEMALE - PELVIS ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (187, N'Routine ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (188, N'Colour Doppler')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (189, N'Trans-Vaginal Scan')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (190, N'Follicular Study')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (191, N'HIGH RESOLUTION SCAN')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (192, N'Breast')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (193, N'Thyroid / parathyroids')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (194, N'Neck')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (195, N'Scrotum ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (196, N'Eye')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (197, N'Musculo -Skeletal System')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (198, N'SPECIAL PROCEDURES ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (199, N'Trans -Rectal Scan (TRUS)')
GO
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (200, N'Prostate')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (201, N'Rectum ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (202, N'Cervix')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (203, N'Neonatal Hip')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (204, N'Neurosonography')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (205, N'US GUIDED INTERVENTIONS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (206, N'TRUS Biopsy')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (207, N'Aspiration / FNAC')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (208, N'Biopsy')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (209, N'Abscess Drainage')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (210, N'Pleural ')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (211, N'Peritoneal Tap')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (212, N'CUE')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (213, N'Urine for Bile Salts & Bile Pigments')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (214, N' Urin for Ketone Bodies')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (215, N' Urin for Bence jones Proteins')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (216, N'Urine for Spot Protein / Creatinine Ratio')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (217, N'Urine for Microalbumin')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (218, N'Urine for Amino Acid Screen')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (219, N'Urine for Metabolic Screen')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (220, N'SEMEN ANALYSIS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (221, N'Stool for Ova & Cysts')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (222, N'Stool for Occult Blood')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (223, N'Stool for Ph & Reducing Substances')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (224, N'HAEMATOLOGY')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (225, N'HB%')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (226, N'CBP')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (227, N'ESR')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (228, N'Blood for MP / Parasite F')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (229, N'Blood for Microfilaria')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (230, N'Platelet Count')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (231, N'BT & CT')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (232, N'Reticulocyte Count')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (233, N'Absolute Eosinophil Count')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (234, N' P.T (prothrombin Time)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (235, N' APTT (Activated partial thrombo plastin time)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (236, N'Nasal Smear for Eosinophils')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (237, N'G6PD Assay')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (238, N'MICROBIOLOGY')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (239, N'CULTURE & Sensitivity of')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (240, N'C/S Urin')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (241, N'C/S Throat Swab')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (242, N'C/S  pus')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (243, N'C/S Blood Routine')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (244, N'C/S Gram`s Stain (Specimen   )')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (245, N'AFB Stain (Specimen)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (246, N'Throat Swab for K.L.B.( C. Dipththeria)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (247, N'Skin Clipping for Fungus')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (248, N'Fungal Culture')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (249, N'AFB Culture')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (250, N'SEROLOGY & IMMUNOLGY')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (251, N'Pregnancy Test Routine')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (252, N'Pregnancy Test Rapid (Elisa)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (253, N'Blood Grouping & Rh Typing')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (254, N'VDRL')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (255, N'TPHA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (256, N'HBsAg')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (257, N'HIV I & II (AIDS TEST)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (258, N'Widal test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (259, N'Brucella')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (260, N'Mantoux Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (261, N'RA ASO Titre')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (262, N'CRP')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (263, N'Coombs Test Direct')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (264, N'Coombs Test Indirect (Antiglobulin Test)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (265, N'Serum  IgG  IgM  IgA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (266, N'Serum IgE')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (267, N'BIOCHEMISTRY')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (268, N'Blood Sugar FBS/PLBS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (269, N'RBS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (270, N'Oral GTT E xtended')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (271, N'Oral GTT Mini')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (272, N'Blood for Glyco Haemoglobin (HbA1c)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (273, N'Blood Urea')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (274, N'Blood Urea Nitrogen (BUN)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (275, N'Serum Creatinine')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (276, N'Cholesterol')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (277, N'Triglycerides')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (278, N'HDL Cholesterol')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (279, N'Lipid Profile')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (280, N'LFT')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (281, N'Bilirubuin Total')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (282, N'S.G.P.T.')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (283, N'S.G.O.T.')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (284, N'Alkaline Phosphatase')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (285, N'Gama GTP')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (286, N'Serum Calcium')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (287, N'Serum Phosphorus')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (288, N'Amylase')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (289, N'Lipase')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (290, N'Uric Acid')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (291, N'Serum Magnesium')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (292, N'Serum Acid Phosphatase Total')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (293, N'Prostatic Fraction')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (294, N'Serum Iron')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (295, N'TIBC')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (296, N'Serum Ferritin')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (297, N'Serum ADA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (298, N'Serum L.D.H.')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (299, N'C.P.K. -MB')
GO
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (300, N'Creatinine Clearance Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (301, N'24 Hours urine Proteins')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (302, N'Blood Ammonia Level')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (303, N'Blood Lactate')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (304, N'V.M.A. Spot Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (305, N'Serum Protein Electrophoresis (M. Protein)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (306, N'HAEMATOLOGY (SPECIAL TESTS)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (307, N'Sickling Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (308, N'Plasma Fibrinogen')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (309, N'Haemoglobin Electrophoresis')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (310, N'Foetal Hb%')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (311, N'Osmotic Fragility')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (312, N'Pyruvate Kinase Screen')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (313, N'Lupus Anticoagulant Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (314, N'Anti Phospholipid Antibody Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (315, N'Factor VIII & IX Screen')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (316, N'NBT Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (317, N'L.E. Cell Test')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (318, N'SEROGY & IMMUNOLGY (SPECIAL TESTS)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (319, N'ANA, Anti Ds DNA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (320, N'HAV  IgM (Hepatitis A  Virus)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (321, N'HCV    Monospot Test (IM)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (322, N'Anti TB   IgG   IgM   IgA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (323, N'Anti Thyroid Anbodies')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (324, N'Torch Complex')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (325, N'TOXO   HSV I & II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (326, N'HIV DUO TEST')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (327, N'Western blot for HIV')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (328, N'CD4 & CD8  COUNTS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (329, N'HORMONES & TUMOUR MARKERS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (330, N'T3 T4 TSH')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (331, N'FSH  LH  Prolactin')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (332, N' Testosterone  P.S.A.')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (333, N'BHCG')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (334, N'Estradiol')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (335, N'DHEA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (336, N'Human Growth Hormone')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (337, N'PTH')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (338, N'CEA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (339, N'CA  125')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (340, N'AFP')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (341, N'PROFILES')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (342, N'Antenatal profile')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (343, N'Anaemia profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (344, N'Haemolytic Anaemia profile')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (345, N'Coagulation profile')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (346, N'Diabetic profile')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (347, N'Hypertension profile')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (348, N'Renal profile')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (349, N'STD Profile I           STD Profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (350, N'Cardiac profile I        Cardiac profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (351, N'Collagen profile I     Collagen profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (352, N'Executive profile  I  Executive profile II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (353, N'Master Health Check Up I')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (354, N'MHCU II')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (355, N'FLUID ANALYSIS & HISTOPATHOLOGY')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (356, N'Pleurl fluid   Ascitic fluid')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (357, N'Synovial fluid')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (358, N'Fluid ADA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (359, N'Fluid Lactate')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (360, N'Histopathology')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (361, N'Bone Marrow')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (362, N'FNAC')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (363, N'X-Ray')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (364, N'E.C.G')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (365, N'U.S Scan')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (366, N'2D Echo')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (367, N'TMT')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (368, N'Colour Doppler')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (369, N'Spirometry (PFT)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (370, N'COLOUR DOPPER STUDY')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (371, N'Carotid Vassels')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (372, N'Peripheral Vascular Studies')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (373, N'Upper Limbs')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (374, N'Lower Limbs')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (375, N'ABDOMINAL ORGANS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (376, N'Portal System')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (377, N'Renal Artery Doppler')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (378, N'Aorta & its branches')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (379, N'Thyroid')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (380, N'Scrotum')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (381, N'2 D Echo Cardiography')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (382, N'ANTENATAL SCAN')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (383, N'Routine')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (384, N'Single')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (385, N' Multipe')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (386, N' TIFFA')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (387, N'NT Scan (11-13 Weeks & 6days)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (388, N'3D & 4D Scan')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (389, N'Biophyical Profile')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (390, N'Fetal Echo')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (391, N' ABDOMEN')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (392, N'Liver & Biliary Tract')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (393, N'Pancreas')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (394, N'G.I. Tract & Appendix')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (395, N'KUB')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (396, N'Retroperitoneum')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (397, N'FEMALE - PELVIS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (398, N'Routine')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (399, N'Colour Doppler')
GO
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (400, N'Trans-Vaginal Scan')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (401, N'Follicular Study')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (402, N'HIGH RESOLUTION SCAN')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (403, N'Breast')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (404, N'Thyroid / parathyroids')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (405, N'Neck')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (406, N'Scrotum')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (407, N'Eye')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (408, N'Musculo -Skeletal System')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (409, N'SPECIAL PROCEDURES')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (410, N'Trans -Rectal Scan (TRUS)')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (411, N'Prostate')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (412, N'Rectum')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (413, N'Cervix')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (414, N'Neonatal Hip')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (415, N'Neurosonography')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (416, N'US GUIDED INTERVENTIONS')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (417, N'TRUS Biopsy')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (418, N'Aspiration / FNAC')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (419, N'Biopsy')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (420, N'Abscess Drainage')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (421, N'Pleural')
INSERT [dbo].[InvestigationDetails] ([Id], [Invistagation]) VALUES (422, N'Peritoneal Tap')
SET IDENTITY_INSERT [dbo].[InvestigationDetails] OFF
SET IDENTITY_INSERT [dbo].[Medicine] ON 

INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (1, N'Cap Augmentin 375mg', N'Amoxyln', 1, N'asdf', 1, CAST(N'2020-02-01 00:00:00.000' AS DateTime), 1, CAST(N'2020-02-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (2, N'Cap Augmentin 625mg', N'Amoxyln', 2, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (3, N'Tab Ampilox kid', N'Amoxyln', 2, N'RTI Entric Fever', NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (4, N'Cap Ampilox 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (5, N'Tab Azithral kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (6, N'Tab Azithral 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (7, N'Tab Azithral 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (8, N'Tab Azibest 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (9, N'Tab Azibest 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (10, N'Tab Azibest 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (11, N'Tab Amlokind at', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (12, N'Tab Amloking 5mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (13, N'Tab Amlokind 2.5mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (14, N'Tab Aten 25mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (15, N'Tab Aten 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (16, N'Tab Alday 10mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (17, N'Tab Alerid ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (18, N'Tab A to Z', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (19, N'Tab Aciloc 150mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (20, N'Tab Aciloc rd ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (21, N'Tab Atarax 10mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (22, N'Tab Atarax 25mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (23, N'Tab Andial', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (24, N'Tab Ark ap ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (25, N'Tab Ark 75mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (26, N'Tab Angicam 5mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (27, N'Tab Angicam 10mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (28, N'Drop Atarax', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (29, N'Drop A to Z', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (30, N'Drop Ambrodil', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (31, N'Drop Althrocin', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (32, N'Drop Ascoril ls', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (33, N'Syrp Augmentin duo', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (34, N'Syrp Augmentin dds', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (35, N'Syrp Atarax', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (36, N'Syrp A to Z', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (37, N'Syrp Ascazin', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (38, N'Syrp Althrocin', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (39, N'Syrp Amical', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (40, N'Syrp Apispur', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (41, N'Syrp Ambrodil s', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (42, N'Syrp Ascoril ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (43, N'Syrp Ascoril ls', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (44, N'Syrp Asthakind', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (45, N'Syrp Asthakind dx', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (46, N'Syrp Ascoril d', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (47, N'Syrp Azithral 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (48, N'Syrp Azithral 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (49, N'Syrp Azee 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (50, N'Syrp Azee 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (51, N'Cap Becosule', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (52, N'Cap Becozinc', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (53, N'Tab Becozinc c forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (54, N'Tab Beplex forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (55, N'Tab Bigspas', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (56, N'Tab Brufen 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (57, N'Tab Brufen 400mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (58, N'Tab Brufen 600mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (59, N'Tab Brutaflam plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (60, N'Tab Brutaflam mr 4mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (61, N'Tab Brutaflam 90mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (62, N'Tab Benefit', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (63, N'Tab Buscogust ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (64, N'Tab Buscogust plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (65, N'Cap Bevon', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (66, N'Tab Brutacef 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (67, N'Tab Brutacef o 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (68, N'Drop Bevon', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (69, N'Syrp Bevon', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (70, N'Syrp Becosule', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (71, N'Syrp Beplex forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (72, N'Syrp Brutacef ds ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (73, N'Respules Budecort', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (74, N'REspules Budesol', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (75, N'Tab Clavam dt kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (76, N'Tab Clavam 375mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (77, N'Tab Clavam 625mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (78, N'Tab Cv Mox 625mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (79, N'Cap Cobadex forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (80, N'Cap Caldikind', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (81, N'Cap Caldikind plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (82, N'Tab Cremalax', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (83, N'Tab Calcimax 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (84, N'Tab Calcimax 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (85, N'Tab Calcimax forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (86, N'Tab Citzine', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (87, N'Tab Cataspa', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (88, N'Tab Chymorol forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (89, N'Tab Chymorol plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (90, N'Tab Citravit z', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (91, N'Tab Calciguard 10mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (92, N'Tab Calciguard 5mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (93, N'Tab CZ3', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (94, N'Tab Cyclopam', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (95, N'Sachet Caldikind', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (96, N'Sachet Calcirol', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (97, N'Sachet Citro soda', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (98, N'Drop Colicaid ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (99, N'Drop Colimex', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (100, N'Drop Calpol', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (101, N'Drop Clavam', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (102, N'Syrp Clavam', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (103, N'Syrp Clavam BID', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (104, N'Syrp Cv Mox ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (105, N'Syrp Colicaid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (106, N'Syrp Colimex', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (107, N'Syrp Clarinova', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (108, N'Syrp Calcimax ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (109, N'Syrp Caldikind', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (110, N'Syrp Cremaffin ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (111, N'Syrp Cremaffin plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (112, N'Syrp Citzine ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (113, N'Syrp Citiriz', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (114, N'Syrp Calpol 120mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (115, N'Syrp Calpol 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (116, N'Syrp Crocin', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (117, N'Syrp Cyclopam', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (118, N'Powder Candid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (119, N'Cream Candid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (120, N'Cream Candid b', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (121, N'Tab Dolonex dt', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (122, N'Tab Doxinate ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (123, N'Tab Doxinate plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (124, N'Tab Dolo 650mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (125, N'Tab Decdan', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (126, N'Tab Domstal ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (127, N'Tab Dompan ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (128, N'Tab Daflon 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (129, N'Tab Daflon 1000mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (130, N'Tab Dolokind 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (131, N'Tab Dolokind sr', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (132, N'Tab Dolokind mr', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (133, N'Tab Dolokind aa', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (134, N'Tab Dolokind plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (135, N'Tab Dicloran A', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (136, N'Tab Defcort 6mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (137, N'Tab Depin 5mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (138, N'Tab Depin 10mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (139, N'Tab Dolopar', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (140, N'Tab Derephyllin 150mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (141, N'Tab Deriphyllin retard 150mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (142, N'Tab Deriphyllin retard 300mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (143, N'Tab Decdan', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (144, N'Tab Domcet', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (145, N'Tab Duphaston', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (146, N'Tab Duoloton L', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (147, N'Tab Diclomol', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (148, N'Drop Domstal baby', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (149, N'Drop Delcon', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (150, N'Drop Delcon plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (151, N'Syrp Domstal', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (152, N'Syrp Defcort', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (153, N'Solution Dakson Orl', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (154, N'Syrp Delcon', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (155, N'Syrp Delcon plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (156, N'Syrp Distaclor 125mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (157, N'Syrp Diof', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (158, N'Syrp Diof ds', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (159, N'Respules Duolin', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (160, N'Tab Enzar Forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (161, N'Tab Erythromycin 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (162, N'Tab Erythromycin 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (163, N'Tab Etrobax', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (164, N'Tab Ebexid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (165, N'Tab Ecosprin 75mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (166, N'Tab Ecosprin 150mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (167, N'Tab Evion LC', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (168, N'Tab Extracef 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (169, N'Tab Extracef 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (170, N'Cap Enuff', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (171, N'Cap Evion 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (172, N'Cap Evion 400mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (173, N'Cap Evion 600mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (174, N'Drop Extracef', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (175, N'Syrp Extracef', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (176, N'Susp Enterogermina', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (177, N'Sachet Econorm', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (178, N'Tab Febrex plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (179, N'Tab Fynal Oz', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (180, N'Tab Famtac 20mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (181, N'Tab Famtac 40mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (182, N'Tab Fynal 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (183, N'Tab Flagyl 400mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (184, N'Tab Flutican 150mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (185, N'Tab Folinz', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (186, N'Tab Folvite', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (187, N'Tab Frisium 5mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (188, N'Tab Frisium 10mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (189, N'Tab Fol 123', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (190, N'Tab Flexon ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (191, N'Tab Flexon mr', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (192, N'Tab Flexilace ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (193, N'Tab Fepanil', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (194, N'Tab Fepnil 650mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (195, N'Tab Fertyl 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (196, N'Tab Fertyl super', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (197, N'Tab Flunarin 5mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (198, N'Drop Fepanil', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (199, N'Drop Febrex plus ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (200, N'Syrp Fepanil 120mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (201, N'Syrp Fepanil 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (202, N'Syrp Febrex plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (203, N'Syrp Flexon', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (204, N'Tab Glyciphage 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (205, N'Tab Glyciphage SR 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (206, N'Tab Glyciphage SR 1000mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (207, N'Tab Glyciphage 850mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (208, N'Tab Glynase MF', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (209, N'Tab Glimstar 1mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (210, N'Tab Glimstar 2mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (211, N'Tab Glimstar M 1mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (212, N'Tab Glimstar M 2mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (213, N'Tab Gynaset', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (214, N'Tab Graniforce MD', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (215, N'Tab Gudcef 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (216, N'Tab Gudcef 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (217, N'Tab Gudcef 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (218, N'Tab Gudcef cv 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (219, N'Cap Gemcal', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (220, N'Cap Gemcal DS', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (221, N'Cap Gemcal Plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (222, N'Drop Graniforce', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (223, N'Drop Gudcef 25mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (224, N'Syrp Gudcef 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (225, N'Syrp Gudcef cv 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (226, N'Syrp Gudlax plus ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (227, N'Syrp Gynovit ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (228, N'Tab Helmef P', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (229, N'Tab Histac 150mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (230, N'Tab Histac 300mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (231, N'Tab Hairbless', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (232, N'Tab Hyponidd', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (233, N'Tab Hydrox 10mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (234, N'Tab Hydrox 20mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (235, N'Tab Herpikind 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (236, N'Tab Herpikind 400mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (237, N'Tab Health OK', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (238, N'Tab Hifen 100mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (239, N'Tab Hifen 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (240, N'Tab Hifen az kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (241, N'Tab Hifen az 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (242, N'Sachet Health OK', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (243, N'Syrp Hifen 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (244, N'Syrp Hifen 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (245, N'Tab Imol plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (246, N'Tab Ibugesic plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (247, N'Tab Ibuclin Junior', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (248, N'Syrp Ibugesic ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (249, N'Syrp Ibugesic plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (250, N'Syrp Imol', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (251, N'Tab Ketrol Dt', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (252, N'Drop Kufril ls', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (253, N'Drop Keflor ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (254, N'Syrp Kufril ls', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (255, N'Syrp Keflor', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (256, N'Tab Levocet', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (257, N'Tab Levocet D', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (258, N'Tab Levocet M Kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (259, N'Tab Lyser D', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (260, N'Tab Lariago', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (261, N'Tab Limcee', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (262, N'Tab Lasma LC', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (263, N'Tab Lasma LC Kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (264, N'Tab Lanol ER', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (265, N'Tab Levogen', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (266, N'Tab Levogen Z', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (267, N'Tab Lecope', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (268, N'Tab Lecope AD', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (269, N'Tab Lecope M Kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (270, N'Tab Lornoxi 4mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (271, N'Tab Lornoxi 8mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (272, N'Tab Lornoxi P', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (273, N'Tab Laxix ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (274, N'Tab Lomofen ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (275, N'Tab Lazine D', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (276, N'Tab Lazine M', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (277, N'Tab Losar 25mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (278, N'Tab Losar 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (279, N'Tab losar H', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (280, N'Tab Lopamide ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (281, N'Cap Lactare', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (282, N'Drop Liv 52', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (283, N'Syrp Levocet ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (284, N'Syrp Levocet M', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (285, N'Syrp Lasma LC Kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (286, N'Syrp Liv 52', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (287, N'Tab Meftal 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (288, N'Tab Meftal 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (289, N'Tab Meftal P', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (290, N'Tab Meftal DS', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (291, N'Tab Meftal Spas', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (292, N'Tab Meftal Forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (293, N'Tab Meftal TX', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (294, N'Tab Meftagesic', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (295, N'Tab Myospaz ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (296, N'Tab Myospaz Forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (297, N'Tab Monticope', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (298, N'Tab Monticope Kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (299, N'Tab Monticope A', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (300, N'Tab Mefkind Forte ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (301, N'Tab Mensovit plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (302, N'Tab Maintain', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (303, N'Tab Meprate', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (304, N'Tab Metrogyl 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (305, N'Tab Metrogyl 400mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (306, N'Tab Maxical 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (307, N'Tab Moxikind Cv Kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (308, N'Tab Moxikind 375mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (309, N'Tab Moxikind 625mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (310, N'Tab Monocef 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (311, N'Tab Monocef O 100mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (312, N'Tab Monocef O 200mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (313, N'Tab Monocef O CV 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (314, N'Tab Mega Cv Kid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (315, N'Tab Mega Cv 375mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (316, N'Tab Mega Cv 625mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (317, N'Tab Mpx 375mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (318, N'Tab Mpx 625mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (319, N'Tab Mahacef 100mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (320, N'Tab Mahacef 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (321, N'Tab Mahacef Cv 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (322, N'Tab Mahacef Xl ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (323, N'Tab Mahacef Plus 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (324, N'Tab Mahacef Plus 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (325, N'Tab Mahacef OZ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (326, N'Drop Mahacef', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (327, N'Drop Maxtra ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (328, N'Drop Maxtra P', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (329, N'Drop Mega Cv ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (330, N'Drop Moxikind Cv', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (331, N'Drop Meftal Spas', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (332, N'Syrp Mahacef 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (333, N'Syrp Maxtra ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (334, N'Syrp Maxtra P', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (335, N'Syrp Monocef O 50mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (336, N'Syrp Monocef O 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (337, N'Syrp Moxikind Cv ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (338, N'Syrp Moxikind Cv Forte ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (339, N'Syrp Mega Cv ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (340, N'Syrp Mega Cv ?Forte ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (341, N'Syrp Menohelp ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (342, N'Syrp Meftal Spas', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (343, N'Syrp Macalvit', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (344, N'Syrp Metrogyl', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (345, N'Syrp Meftal P', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (346, N'Syrp Meftagesic P', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (347, N'Syrp Meftagesic Ds', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (348, N'Syrp Mahacort Dz', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (349, N'Tab Neurokind 500mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (350, N'Tab Neurokind OD', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (351, N'Tab Neurokind LC', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (352, N'Tab Neurokind G', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (353, N'Tab Neurokind Forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (354, N'Cap Neurokind Plus ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (355, N'Cap Neurokind Gold', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (356, N'Cap Nitrobact 100mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (357, N'Tab Norflox 200mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (358, N'Tab Norflox 400mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (359, N'Tab Norflox TZ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (360, N'Tab Nor-Metrogyl ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (361, N'Tab Normaxin ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (362, N'Tab Neeri ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (363, N'Tab Neurobion Forte ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (364, N'Tab Naprosyn 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (365, N'Tab Naprosyn 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (366, N'Tab Nuforce 150mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (367, N'Drop Nurokind', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (368, N'Syrp Neurokind ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (369, N'Cap Omez 20mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (370, N'Cap Omez DSR', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (371, N'Tab Omnacortil 5mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (372, N'Tab Omnacortil 10mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (373, N'Tab Omnacortil 20mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (374, N'Tab Oxalgin ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (375, N'Tab Orofer XT', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (376, N'Tab Ondem 4mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (377, N'Tab Oflox 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (378, N'Tab Oflox 400mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (379, N'Drop Ondem', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (380, N'Drop One pep', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (381, N'Syrp Omnacortil', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (382, N'Syrp Orofer XT', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (383, N'Tab Pan 40mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (384, N'Tab Pantakind 40mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (385, N'Tab Pantop 20mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (386, N'Tab Pantop 40mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (387, N'Tab Panocid 40mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (388, N'Tab P 125mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (389, N'Tab P 250mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (390, N'Tab P 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (391, N'Tab P 650mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (392, N'Tab Pregnidoxin ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (393, N'Tab Pilon', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (394, N'Tab PT 325mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (395, N'Tab Primulut N', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (396, N'Cap Pilants', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (397, N'Cap Pantop D', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (398, N'Cap Pantakind Flux', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (399, N'Cap Pan D', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (400, N'Cap Pantakind DSR', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (401, N'Cap Polybion ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (402, N'Cap Pilants', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (403, N'Drop P 125', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (404, N'Syrp P 120', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (405, N'Syrp P 250', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (406, N'Syrp Pantop MPS', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (407, N'Syrp Polybion L', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (408, N'Syrp Polybion SF', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (409, N'Tab Rantac 150mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (410, N'Tab Rantac 300mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (411, N'Tab Rantac D', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (412, N'Tab Raciper 20mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (413, N'Tab Raciper 40mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (414, N'Tab Rabikind 20mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (415, N'Tab Razo 20mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (416, N'Tab Registron ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (417, N'Tab Ranidom O', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (418, N'Tab Ranidom RD', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (419, N'Cap Raciper D 40mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (420, N'Cap Rabikind DSR', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (421, N'Cap Razo D', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (422, N'Cap Rabitrol L', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (423, N'Cap Rumex Forte ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (424, N'Cap Racigyl O', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (425, N'Syrp Racigyl O', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (426, N'Syrp Rantac ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (427, N'Syrp Ranidom RD', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (428, N'Syrp Ranidom O', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (429, N'Tab Stugeron ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (430, N'Tab Styptovit ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (431, N'Tab Sorbitrate 5mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (432, N'Tab Sorbitrate 10mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (433, N'Tab Serax ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (434, N'Tab Serax Forte', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (435, N'Tab Stamlo 2.5mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (436, N'Tab Stamlo 5mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (437, N'Tab Stamlo D', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (438, N'Tab Stamlo Beta ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (439, N'Tab Sporlac ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (440, N'Tab Somifiz', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (441, N'Tab Shelcal 250mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (442, N'Tab Shelcal 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (443, N'Tab Shelcal M', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (444, N'Tab Shelcal HD', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (445, N'Tab Susten 100mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (446, N'Tab Susten 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (447, N'Tab Supradyn', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (448, N'Tab Siphene 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (449, N'Tab Siphene 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (450, N'Tab Sinarest', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (451, N'Tab Supracal', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (452, N'Tab Supracal HD', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (453, N'Tab Sporidex 125mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (454, N'Tab Sporidex DS 250mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (455, N'Tab Spectratil 100mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (456, N'Tab Spectratil 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (457, N'Cap Sporidex 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (458, N'Cap Spasmoproxyvon ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (459, N'Drop Sinarest ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (460, N'Drop Sporidex ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (461, N'Syrp Spectratil 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (462, N'Syrp Sucral ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (463, N'Syrp Sinarest', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (464, N'Syrp Sinarest Plus', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (465, N'Syrp Sporidex Dry ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (466, N'Syrp Sporidex 125mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (467, N'Sachet Sporolac', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (468, N'Tab Texakind 500mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (469, N'Tab Texakind MF', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (470, N'Tab TusQ ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (471, N'Tab TusQ Losenzes', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (472, N'Tab Triquilar', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (473, N'Tab Topcid 20mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (474, N'Tab Topcid 40mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (475, N'Tab Terbinaforce ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (476, N'Tab Telmikind 20mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (477, N'Tab Telmikind 40mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (478, N'Tab Telmikind H', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (479, N'Tab Tegrital 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (480, N'Tab Tegrital 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (481, N'Tab Tegrital CR 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (482, N'Tab Tegrital CR 300mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (483, N'Tab Trichoton ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (484, N'Tab Trybtomer 10mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (485, N'Tab Trybtomer 25mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (486, N'Tab Telma 20mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (487, N'Tab Telma 40mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (488, N'Tab Telma H', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (489, N'Tab Telma AM', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (490, N'Tab Testovit Forte ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (491, N'Syrp Trichoton ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (492, N'Syrp Totalax NF', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (493, N'Syrp Tixylix', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (494, N'Syrp Tegrital', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (495, N'Tab Unienzyme ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (496, N'Tab Urispas ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (497, N'Sachet Urikind K', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (498, N'Syrp Urikind K', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (499, N'Tab Vertin 8mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (500, N'Tab Vertin 16mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (501, N'Tab Wysolone 5mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (502, N'Tab Wysolone 10mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (503, N'Tab Zental 400mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (504, N'Tab Zerodol P', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (505, N'Tab Zerodol SP', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (506, N'Tab Zerodol TH4', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (507, N'Tab Zerodol Spas', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (508, N'Tab Zerodol MR', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (509, N'Tab Zofer 4mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (510, N'Tab Zofer MD 4mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (511, N'Tab Zincovit ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (512, N'Tab Zincofer ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (513, N'Tab Zolfresh 5mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (514, N'Tab Zolfresh 10mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (515, N'Tab Zintac 150mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (516, N'Tab Zintac 300mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (517, N'Tab Zifi 50mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (518, N'Tab Zifi 100mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (519, N'Tab Zifi CV 200mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (520, N'Tab Zifi AZ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (521, N'Tab Zifi oZ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (522, N'Tab Zenflox 100mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (523, N'Tab Zenflox 200mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (524, N'Tab Zenflox 400mg', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (525, N'Tab Zenflox OZ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (526, N'Tab Zenflox Plus 100mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (527, N'Tab Zenflox Plus 200mg ', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (528, N'Drop Zincovit', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (529, N'Syrp Zincovit', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (530, N'Syrp Zinconia', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (531, N'Suspension Zentil', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (532, N'b', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (533, N'Tab
', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (534, N'Syrp', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (535, N'Drop', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (536, N'Cap', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (537, N'Inj', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (538, N'Lotion', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (539, N'Ointment', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (540, N'Soap', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (541, N'Cream', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (542, N'IV', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (543, N'IM', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (544, N'Fluid', N'Amoxyln', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (545, N'test', N'yod', NULL, N'yod', 1, CAST(N'2018-11-25 15:55:21.453' AS DateTime), 1, CAST(N'2018-11-25 15:55:21.453' AS DateTime))
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (546, N'test', N'tes', 1, N'tes', 1, CAST(N'2018-11-25 15:57:53.920' AS DateTime), 1, CAST(N'2018-11-25 15:57:53.920' AS DateTime))
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (547, N'Cap Augmentin 375mg', N'test', 3, N'test', 1, CAST(N'2018-11-25 16:25:21.070' AS DateTime), 1, CAST(N'2018-11-25 16:25:21.070' AS DateTime))
INSERT [dbo].[Medicine] ([MId], [MedicineName], [Formula], [DisseaseId], [Comment], [CreatedBy], [CreationDate], [UpdatedBy], [Updationdate]) VALUES (548, N'aijaz', N'testali', 1, N'testali548', 1, CAST(N'2018-11-25 16:25:54.377' AS DateTime), 1, CAST(N'2018-11-25 16:25:54.377' AS DateTime))
SET IDENTITY_INSERT [dbo].[Medicine] OFF
SET IDENTITY_INSERT [dbo].[Notepad] ON 

INSERT [dbo].[Notepad] ([TopicId], [TopicName], [TopicContent]) VALUES (1, N'Bismillah', N'<div class="row">
<div class="col-md-12" style="margin-left: 50px;"><span style="font-weight: bold; font-size: 28px; padding-left: 100px;"> DARULSHIFA POLY CLINIC </span><br /> <span style="font-weight: bold; font-size: 15px; padding-left: 20px;"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Lab and Medical Facility Available Here,</strong> </span> <span style="font-weight: bold; font-size: 15px; padding-left: 0px;"> <strong>Hno:4-18-26/A,</strong></span></div>
<div class="col-md-12" style="margin-left: 50px;"><span style="font-weight: bold; font-size: 15px; padding-left: 0px;"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Opp. Noorani Masjid,</strong> Hassan Nagar,Hyderabad.</span></div>
Bismillah</div>
<div class="row">&nbsp;</div>
<div class="row">&nbsp;</div>
<div class="row">dgdfdgsdfg</div>')
INSERT [dbo].[Notepad] ([TopicId], [TopicName], [TopicContent]) VALUES (2, N'asdf', N'<div class="row">
<div class="col-md-12" style="margin-left: 50px;"><span style="font-weight: bold; font-size: 28px; padding-left: 100px;"> DARULSHIFA POLY CLINIC </span><br /> <span style="font-weight: bold; font-size: 15px; padding-left: 20px;"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Lab and Medical Facility Available Here,</strong> </span> <span style="font-weight: bold; font-size: 15px; padding-left: 0px;"> <strong>Hno:4-18-26/A,</strong></span></div>
<div class="col-md-12" style="margin-left: 50px;"><span style="font-weight: bold; font-size: 15px; padding-left: 0px;"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Opp. Noorani Masjid,</strong> Hassan Nagar,Hyderabad.</span><br /><br /></div>
<div class="col-md-12" style="margin-left: 50px;">&nbsp;asdfasdf</div>
</div>')
INSERT [dbo].[Notepad] ([TopicId], [TopicName], [TopicContent]) VALUES (3, N'tim', N'<div class="row">
<div class="col-md-12" style="margin-left: 50px;"><span style="font-weight: bold; font-size: 28px; padding-left: 100px;"> DARULSHIFA POLY CLINIC </span><br /> <span style="font-weight: bold; font-size: 15px; padding-left: 20px;"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Lab and Medical Facility Available Here,</strong> </span> <span style="font-weight: bold; font-size: 15px; padding-left: 0px;"> <strong>Hno:4-18-26/A,</strong></span></div>
<div class="col-md-12" style="margin-left: 50px;"><span style="font-weight: bold; font-size: 15px; padding-left: 0px;"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Opp. Noorani Masjid,</strong> Hassan Nagar,Hyderabad.</span><br /><br /></div>
<div class="col-md-12" style="margin-left: 50px;">&nbsp;</div>
<div class="col-md-12" style="margin-left: 50px;">tim</div>
<div class="col-md-12" style="margin-left: 50px;">&nbsp;</div>
</div>')
SET IDENTITY_INSERT [dbo].[Notepad] OFF
SET IDENTITY_INSERT [dbo].[Patient] ON 

INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (1026, N'Huzayfa', 1, N'Dr.Jamal', N'34', N'Male', N'908765432', N'Shakker Gunj,Hyderabad', CAST(N'2018-11-18 19:46:15.020' AS DateTime), NULL, 1, 1, CAST(N'2018-11-18 19:46:15.020' AS DateTime), CAST(N'2018-11-18 19:46:15.020' AS DateTime))
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (1027, N'javed', 1, N'Dr.Jamal', N'34', N'Male', N'908765432', N'Shakker Gunj,Hyderabad', CAST(N'2018-11-19 19:47:00.333' AS DateTime), NULL, 1, 1, CAST(N'2018-11-19 19:47:00.333' AS DateTime), CAST(N'2018-11-18 19:46:15.020' AS DateTime))
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (2021, N'IBrahim', 2, N'Dr Jamal', N'23', N'Male', N'98765434', N'Hyderabad', CAST(N'2018-12-02 02:52:34.817' AS DateTime), NULL, 1, NULL, CAST(N'2018-12-02 02:52:34.817' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (3021, N'tabu', 1, N'Dr Jamal', N'33', N'Male', N'977777', N'hyd', CAST(N'2018-12-09 02:49:36.193' AS DateTime), NULL, 1, NULL, CAST(N'2018-12-09 02:49:36.193' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (3022, N'jhangir', 1, N'asdf', N'23', N'Male', N'33333', N'hyd', CAST(N'2018-12-09 05:46:25.660' AS DateTime), NULL, 1, NULL, CAST(N'2018-12-09 05:46:25.660' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (3023, N'adsf', 2, N'Dr Jamal', N'33', N'Male', N'33333', N'dfdf', CAST(N'2018-12-09 05:52:50.647' AS DateTime), NULL, 1, NULL, CAST(N'2018-12-09 05:52:50.647' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (3024, N'asdf', 2, N'Dr Jamal', N'33', N'Female', N'33333', N'dffd', CAST(N'2018-12-09 05:53:13.790' AS DateTime), NULL, 1, NULL, CAST(N'2018-12-09 05:53:13.790' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (3025, N'asdf', 2, N'Dr Jamal', N'33', N'Male', N'33333', N'ffff', CAST(N'2018-12-09 06:19:11.330' AS DateTime), NULL, 1, NULL, CAST(N'2018-12-09 06:19:11.330' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (3026, N'adsf', 1, N'asdf', N'23', N'Male', N'333', N'asdfasdf', CAST(N'2018-12-09 06:30:56.920' AS DateTime), NULL, 1, NULL, CAST(N'2018-12-09 06:30:56.920' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (3027, N'sdfg', 2, N'sdfgsd', N'21', N'Male', N'4343434343', N'sdfgsdfg', CAST(N'2019-08-17 08:42:00.427' AS DateTime), NULL, 1, NULL, CAST(N'2019-08-17 08:42:00.427' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (4027, N'asdf', 1, N'asdf', N'21', N'Male', N'23223423', N'hyd', CAST(N'2020-11-23 08:50:55.403' AS DateTime), NULL, 1, NULL, CAST(N'2020-11-23 08:50:55.403' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (4028, N'Usha', 2, N'Daya', N'25', N'Female', N'09288282', N'hyd', CAST(N'2021-11-18 06:44:13.447' AS DateTime), NULL, 1, NULL, CAST(N'2021-11-18 06:44:13.447' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (4029, N'birender', 3, N'Dr Ramesh', N'25', N'Male', N'09288282', N'asdfasdf', CAST(N'2021-11-18 07:27:31.263' AS DateTime), NULL, 1, NULL, CAST(N'2021-11-18 07:27:31.263' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (5028, N'Usha', 1, N'Daya', N'25', N'Male', N'09288282', N'2', CAST(N'2021-11-23 07:31:32.060' AS DateTime), NULL, 1, NULL, CAST(N'2021-11-23 07:31:32.060' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (5029, N'Usha', 2, N'Daya', N'25', N'Male', N'09288282', N'hyderabad', CAST(N'2022-04-15 09:19:04.553' AS DateTime), NULL, 1, NULL, CAST(N'2022-04-15 09:19:04.553' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (5030, N'Usha2', 1, N'Dr Ramesh', N'25', N'Male', N'09288282', N'sds', CAST(N'2022-04-15 09:41:09.800' AS DateTime), NULL, 1, NULL, CAST(N'2022-04-15 09:41:09.800' AS DateTime), NULL)
INSERT [dbo].[Patient] ([Pid], [PName], [PatientType], [ReferBy], [Age], [Gender], [MobileNo], [Address], [Date_of_Admission], [Date_of_DisCharge], [Createdby], [Updatedby], [CreatedDate], [UpdatetedTime]) VALUES (5031, N'kanwal', 2, N'self', N'25', N'Male', N'09288282', N'hyd', CAST(N'2022-04-15 09:46:49.777' AS DateTime), NULL, 1, NULL, CAST(N'2022-04-15 09:46:49.777' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Patient] OFF
SET IDENTITY_INSERT [dbo].[PatientTypes] ON 

INSERT [dbo].[PatientTypes] ([PTypeId], [PatientType]) VALUES (1, N'IP')
INSERT [dbo].[PatientTypes] ([PTypeId], [PatientType]) VALUES (2, N'OP')
INSERT [dbo].[PatientTypes] ([PTypeId], [PatientType]) VALUES (3, N'Casulty')
SET IDENTITY_INSERT [dbo].[PatientTypes] OFF
SET IDENTITY_INSERT [dbo].[RegisterdUsers] ON 

INSERT [dbo].[RegisterdUsers] ([UserId], [UserName], [Password], [UserTypeId], [RoleId], [EmailId], [IsActive], [CreatedBy], [CreatedDate], [Updatedby], [UpdatedDate]) VALUES (1, N'Admin', N'Admin', 1, 1, N'yawarali17@gmail.com', 1, 1, CAST(N'2018-11-18 00:00:00.000' AS DateTime), 1, CAST(N'2018-12-09 04:05:30.480' AS DateTime))
INSERT [dbo].[RegisterdUsers] ([UserId], [UserName], [Password], [UserTypeId], [RoleId], [EmailId], [IsActive], [CreatedBy], [CreatedDate], [Updatedby], [UpdatedDate]) VALUES (1004, N'Ajaz', N'2688', 25, 2, N'ajaz2688@gmail.com', 1, 1, CAST(N'2018-12-02 00:59:06.500' AS DateTime), 1, CAST(N'2018-12-09 04:06:02.503' AS DateTime))
INSERT [dbo].[RegisterdUsers] ([UserId], [UserName], [Password], [UserTypeId], [RoleId], [EmailId], [IsActive], [CreatedBy], [CreatedDate], [Updatedby], [UpdatedDate]) VALUES (1005, N'azam', N'1234', 23, 2, N'yawarali17@gmail.com', 1, 1, CAST(N'2018-12-02 00:59:48.880' AS DateTime), 1, CAST(N'2018-12-09 04:06:20.647' AS DateTime))
SET IDENTITY_INSERT [dbo].[RegisterdUsers] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (2, N'Doctor')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (3, N'Receptionist')
INSERT [dbo].[Roles] ([RoleId], [RoleName]) VALUES (4, N'Lab')
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[SettingInfo] ON 

INSERT [dbo].[SettingInfo] ([sno], [Logo], [TitleName]) VALUES (1, N'Hyder', N'
<div class="row">
<div class="col-md-12" style="margin-left: 50px;"><span style="font-weight: bold; font-size: 28px; padding-left: 100px;"> DARULSHIFA POLY CLINIC </span><br /> <span style="font-weight: bold; font-size: 15px; padding-left: 20px;"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Lab and Medical Facility Available Here,</strong> </span> <span style="font-weight: bold; font-size: 15px; padding-left: 0px;"> <strong>Hno:4-18-26/A,</strong></span></div>
<div class="col-md-12" style="margin-left: 50px;"><span style="font-weight: bold; font-size: 15px; padding-left: 0px;"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Opp. Noorani Masjid,</strong> Hassan Nagar,Hyderabad.</span><br /><br /></div>
<div class="col-md-12" style="margin-left: 50px;">&nbsp;</div>
</div>


')
SET IDENTITY_INSERT [dbo].[SettingInfo] OFF
SET IDENTITY_INSERT [dbo].[tbl_BillingMaster] ON 

INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (1, 1, CAST(200.00 AS Decimal(18, 2)), NULL, CAST(12 AS Decimal(18, 0)), CAST(130 AS Decimal(18, 0)), CAST(60 AS Decimal(18, 0)), CAST(120 AS Decimal(18, 0)), CAST(122 AS Decimal(18, 0)), 1, N'32145', 1, 2, 1, CAST(N'2021-10-03 11:11:06.837' AS DateTime), CAST(N'2021-10-16 23:18:51.287' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 2, CAST(N'2021-10-03 15:33:56.650' AS DateTime), CAST(N'2021-10-03 15:33:56.650' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 2, CAST(N'2021-10-03 16:01:08.280' AS DateTime), CAST(N'2021-10-03 16:01:08.280' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (4, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 2, CAST(N'2021-10-03 16:02:12.450' AS DateTime), CAST(N'2021-10-03 16:02:12.450' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (5, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 2, CAST(N'2021-10-03 16:05:45.620' AS DateTime), CAST(N'2021-10-03 16:05:45.620' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (6, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 2, CAST(N'2021-10-03 16:08:50.643' AS DateTime), CAST(N'2021-10-03 16:08:50.643' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (7, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 2, CAST(N'2021-10-03 16:09:42.667' AS DateTime), CAST(N'2021-10-03 16:09:42.667' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (8, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 2, CAST(N'2021-10-03 16:48:38.140' AS DateTime), CAST(N'2021-10-03 16:48:38.140' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (9, 3, CAST(0.00 AS Decimal(18, 2)), NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, NULL, 0, 2, 2, CAST(N'2021-10-02 16:50:16.383' AS DateTime), CAST(N'2021-10-02 19:19:05.247' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (10, 4, CAST(120.00 AS Decimal(18, 2)), NULL, CAST(45 AS Decimal(18, 0)), CAST(66 AS Decimal(18, 0)), CAST(5 AS Decimal(18, 0)), CAST(6 AS Decimal(18, 0)), CAST(32 AS Decimal(18, 0)), NULL, NULL, 1, 2, 2, CAST(N'2021-10-03 19:24:31.187' AS DateTime), CAST(N'2021-10-03 23:31:28.043' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (11, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 2, CAST(N'2021-10-03 23:44:02.460' AS DateTime), CAST(N'2021-10-03 23:44:02.460' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (12, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, CAST(N'2021-10-03 23:56:40.340' AS DateTime), CAST(N'2021-10-03 23:56:40.340' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (13, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1, CAST(N'2021-10-03 23:56:53.687' AS DateTime), CAST(N'2021-10-03 23:56:53.687' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (14, 6, CAST(1000.00 AS Decimal(18, 2)), NULL, CAST(10 AS Decimal(18, 0)), CAST(300 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), CAST(100 AS Decimal(18, 0)), CAST(200 AS Decimal(18, 0)), NULL, NULL, 0, 1, 2, CAST(N'2021-10-03 23:57:45.077' AS DateTime), CAST(N'2021-10-04 01:22:49.047' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (15, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 2, 2, CAST(N'2021-10-04 01:38:16.950' AS DateTime), CAST(N'2021-10-04 01:38:16.950' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (1011, 1005, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 2, 2, CAST(N'2021-10-11 03:39:43.330' AS DateTime), CAST(N'2021-10-11 03:39:43.330' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (1012, 1006, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 2, 2, CAST(N'2021-10-12 11:39:19.440' AS DateTime), CAST(N'2021-10-12 11:39:19.440' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (1013, 1007, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, N'012345', 0, 2, 2, CAST(N'2021-10-14 00:00:11.163' AS DateTime), CAST(N'2021-10-14 00:00:11.163' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (1014, 1008, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, N'11111', 0, 2, 2, CAST(N'2021-10-14 15:01:13.500' AS DateTime), CAST(N'2021-10-14 15:01:13.500' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2014, 2008, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, N'8777', 0, 2, 2, CAST(N'2021-10-16 16:31:47.970' AS DateTime), CAST(N'2021-10-16 16:31:47.970' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2015, 2008, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, N'8777', 0, 2, 2, CAST(N'2021-10-16 16:32:11.870' AS DateTime), CAST(N'2021-10-16 16:32:11.870' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2016, 2009, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, CAST(100 AS Decimal(18, 0)), 0, N'98765', 0, 2, 2, CAST(N'2021-10-16 19:14:41.657' AS DateTime), CAST(N'2021-10-16 19:14:41.657' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2017, 2010, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, CAST(1000 AS Decimal(18, 0)), 0, N'98765', 0, 2, 2, CAST(N'2021-10-16 20:38:30.520' AS DateTime), CAST(N'2021-10-16 20:38:30.520' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2018, 2010, CAST(9999.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, CAST(999 AS Decimal(18, 0)), 0, N'9999', 0, 2, 2, CAST(N'2021-10-16 20:39:40.537' AS DateTime), CAST(N'2021-10-16 20:39:40.537' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2019, 2011, CAST(9999.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, CAST(1000 AS Decimal(18, 0)), 0, N'98765', 0, 2, 2, CAST(N'2021-10-16 20:58:46.090' AS DateTime), CAST(N'2021-10-16 20:58:46.090' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2020, 1008, CAST(10000.00 AS Decimal(18, 2)), CAST(5678.00 AS Decimal(18, 2)), CAST(1000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(5000 AS Decimal(18, 0)), 0, N'012345', 1, 2, 2, CAST(N'2021-10-16 21:25:09.803' AS DateTime), CAST(N'2021-10-18 20:06:52.843' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2021, 0, CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, CAST(500 AS Decimal(18, 0)), 0, N'01234556', 0, 2, 2, CAST(N'2021-10-16 21:48:28.560' AS DateTime), CAST(N'2021-10-16 21:48:28.560' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2022, 0, CAST(900.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, CAST(66 AS Decimal(18, 0)), 0, N'012345', 0, 2, 2, CAST(N'2021-10-16 22:56:31.363' AS DateTime), CAST(N'2021-10-16 22:56:31.363' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2024, 3012, CAST(500.00 AS Decimal(18, 2)), CAST(300.00 AS Decimal(18, 2)), CAST(100 AS Decimal(18, 0)), NULL, NULL, NULL, CAST(100 AS Decimal(18, 0)), 0, N'12345', 0, 2, 2, CAST(N'2021-10-19 12:53:36.900' AS DateTime), CAST(N'2021-10-19 12:55:42.900' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3024, 4012, CAST(8888.00 AS Decimal(18, 2)), CAST(2322.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(500 AS Decimal(18, 0)), 0, N'1112', 0, 2, 2, CAST(N'2021-10-21 13:25:17.957' AS DateTime), CAST(N'2021-10-21 13:25:17.957' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3025, 0, CAST(8888.00 AS Decimal(18, 2)), CAST(9999.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(1000 AS Decimal(18, 0)), 0, N'767667', 0, 2, 2, CAST(N'2021-10-21 13:27:29.033' AS DateTime), CAST(N'2021-10-21 13:27:29.033' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3026, 4014, CAST(8888.00 AS Decimal(18, 2)), CAST(9999.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(1000 AS Decimal(18, 0)), 0, N'767667', 0, 2, 2, CAST(N'2021-10-21 13:28:56.130' AS DateTime), CAST(N'2021-10-21 13:28:56.130' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3027, 4015, CAST(8888.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(500 AS Decimal(18, 0)), 0, N'5455', 0, 2, 2, CAST(N'2021-10-21 13:32:30.030' AS DateTime), CAST(N'2021-10-21 13:32:30.030' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3028, 4016, CAST(8888.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(500 AS Decimal(18, 0)), 0, N'5455', 0, 2, 2, CAST(N'2021-10-21 13:33:00.863' AS DateTime), CAST(N'2021-10-21 13:33:00.863' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3029, 4017, CAST(8888.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(500 AS Decimal(18, 0)), 0, N'445', 0, 2, 2, CAST(N'2021-10-21 13:36:09.717' AS DateTime), CAST(N'2021-10-21 13:36:09.717' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3030, 4018, CAST(1000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(7000 AS Decimal(18, 0)), 0, N'444', 0, 2, 2, CAST(N'2021-10-21 13:39:34.910' AS DateTime), CAST(N'2021-10-21 13:39:34.910' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3031, 4017, CAST(8888.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(7000 AS Decimal(18, 0)), 0, N'12345', 0, 2, 2, CAST(N'2021-10-21 13:43:56.090' AS DateTime), CAST(N'2021-10-21 13:43:56.090' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (4024, 5012, CAST(2000.00 AS Decimal(18, 2)), CAST(88.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(1000 AS Decimal(18, 0)), 0, N'2', 0, 2, 2, CAST(N'2022-04-07 00:26:04.730' AS DateTime), CAST(N'2022-04-07 00:26:04.730' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (4025, 5013, CAST(2000.00 AS Decimal(18, 2)), CAST(88.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(1000 AS Decimal(18, 0)), 0, N'876', 0, 2, 2, CAST(N'2022-04-21 03:24:57.023' AS DateTime), CAST(N'2022-04-21 03:24:57.023' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (4026, 5014, CAST(50.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(20 AS Decimal(18, 0)), 0, N'9087', 0, 2, 2, CAST(N'2022-04-26 16:24:35.400' AS DateTime), CAST(N'2022-04-26 16:24:35.400' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (4027, 5015, CAST(50.00 AS Decimal(18, 2)), CAST(88.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(100 AS Decimal(18, 0)), 0, N'888', 0, 2, 2, CAST(N'2022-04-27 01:44:46.773' AS DateTime), CAST(N'2022-04-27 01:44:46.773' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (4028, 5016, CAST(2000.00 AS Decimal(18, 2)), CAST(1000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, CAST(1000 AS Decimal(18, 0)), 0, N'111', 0, 2, 2, CAST(N'2022-04-27 01:49:11.290' AS DateTime), CAST(N'2022-04-27 01:49:11.290' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (4029, 5017, CAST(2000.00 AS Decimal(18, 2)), CAST(1000.00 AS Decimal(18, 2)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(100 AS Decimal(18, 0)), 0, N'2222', 0, 2, 2, CAST(N'2022-04-28 00:50:41.447' AS DateTime), CAST(N'2022-05-01 05:46:43.053' AS DateTime))
INSERT [dbo].[tbl_BillingMaster] ([BilIingId], [PId], [Amount], [Paid], [Discount], [Expenses], [ReferalPercentage], [ReferalAmount], [DUE], [CollectedById], [BillNumber], [Status], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (4030, 5018, CAST(60.00 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, N'2121', 1, 2, 2, CAST(N'2022-04-30 07:01:31.630' AS DateTime), CAST(N'2022-05-01 05:49:55.710' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_BillingMaster] OFF
SET IDENTITY_INSERT [dbo].[tbl_Doctor] ON 

INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1, N'DR. ajaz Ahmed', N'Asthama', NULL, N'Kamran@gmail.com', N'MS', NULL, N'45686', N'sec1', N'sec1', N'sec1', N'mon-tue 1pm', N'345', N'789', N'mon-tue 1pm', N'mon-tue 2pm', N'mon-tue 2pm', 2, CAST(N'2021-10-03 02:16:14.927' AS DateTime), 1, CAST(N'2022-05-09 08:14:04.800' AS DateTime))
INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (2, N'DR. kamran Ahmed', N'Asthama', NULL, N'Kamran@gmail.com', N'MD', NULL, N'45686', N'sec1', N'sec1', N'sec1', N'mon-tue 1pm', N'345', N'789', N'mon-tue 1pm', N'mon-tue 2pm', N'mon-tue 2pm', 2, CAST(N'2021-10-03 02:16:32.140' AS DateTime), 2, CAST(N'2022-05-07 23:53:54.950' AS DateTime))
INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1002, N'DR. kamran Ahmed', N'Asthama', NULL, N'Kamran@gmail.com', N'MD', NULL, N'45686', N'sec1', N'sec1', N'sec1', N'mon-tue 1pm', N'345', N'789', N'mon-tue 1pm', N'mon-tue 2pm', N'mon-tue 2pm', 2, CAST(N'2021-10-03 12:04:47.843' AS DateTime), 2, CAST(N'2022-05-07 23:53:54.950' AS DateTime))
INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1004, N'DR. kamran Ahmed', N'Asthama', NULL, N'Kamran@gmail.com', N'MD', NULL, N'45686', N'sec1', N'sec1', N'sec1', N'mon-tue 1pm', N'345', N'789', N'mon-tue 1pm', N'mon-tue 2pm', N'mon-tue 2pm', 1, CAST(N'2021-10-03 23:53:49.963' AS DateTime), 2, CAST(N'2022-05-07 23:53:54.950' AS DateTime))
INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1005, N'DR. kamran Ahmed', N'Asthama', NULL, N'Kamran@gmail.com', N'MD', NULL, N'45686', N'sec1', N'sec1', N'sec1', N'mon-tue 1pm', N'345', N'789', N'mon-tue 1pm', N'mon-tue 2pm', N'mon-tue 2pm', 2, CAST(N'2021-10-04 01:26:14.770' AS DateTime), 2, CAST(N'2022-05-07 23:53:54.950' AS DateTime))
INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1006, N'DR. kamran Ahmed', N'Asthama', NULL, N'Kamran@gmail.com', N'MD', NULL, N'45686', N'sec1', N'sec1', N'sec1', N'mon-tue 1pm', N'345', N'789', N'mon-tue 1pm', N'mon-tue 2pm', N'mon-tue 2pm', 2, CAST(N'2022-05-07 13:20:49.527' AS DateTime), 2, CAST(N'2022-05-07 23:53:54.950' AS DateTime))
INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1007, N'DR. kamran Ahmed', N'Asthama', NULL, N'Kamran@gmail.com', N'MD', NULL, N'45686', N'sec1', N'sec1', N'sec1', N'mon-tue 1pm', N'345', N'789', N'mon-tue 1pm', N'mon-tue 2pm', N'mon-tue 2pm', 2, CAST(N'2022-05-07 13:22:19.057' AS DateTime), 2, CAST(N'2022-05-07 23:53:54.950' AS DateTime))
INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1008, N'DR. kamran Ahmed', N'Asthama', NULL, N'Kamran@gmail.com', N'MD', NULL, N'45686', N'sec1', N'sec1', N'sec1', N'mon-tue 1pm', N'345', N'789', N'mon-tue 1pm', N'mon-tue 2pm', N'mon-tue 2pm', 2, CAST(N'2022-05-07 13:28:56.300' AS DateTime), 2, CAST(N'2022-05-07 23:53:54.950' AS DateTime))
INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1009, N'DR. kamran Ahmed', N'Asthama', NULL, N'Kamran@gmail.com', N'MD', NULL, N'45686', N'sec1', N'sec1', N'sec1', N'mon-tue 1pm', N'345', N'789', N'mon-tue 1pm', N'mon-tue 2pm', N'mon-tue 2pm', 2, CAST(N'2022-05-07 13:39:50.973' AS DateTime), 2, CAST(N'2022-05-07 23:53:54.950' AS DateTime))
INSERT [dbo].[tbl_Doctor] ([DocId], [DoctorName], [Specilization], [Signature], [EmailId], [Qualification], [DoctorPhoto], [ContactNumber], [Address1], [Address2], [Address3], [MobileAdd1], [MobileAdd2], [MobileAdd3], [DayAndTime1], [DayAndTime2], [DayAndTime3], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1010, N'mouzam', N'bone', NULL, N'abc@gmail.com', N'mbbs', NULL, N'3456789', N'hyd1', N'hyd2', N'hyd3', N'21111', N'2111', N'21111', N'mon-tue 1pm', N'mon-tue 1pm', N'mon-tue 2pm', 2, CAST(N'2022-05-08 00:02:16.443' AS DateTime), 2, CAST(N'2022-05-08 00:02:16.443' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_Doctor] OFF
SET IDENTITY_INSERT [dbo].[tbl_UserLogin] ON 

INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (1, N'Namrata', N'n@gmail.com', N'1234', 0, N'1', N'34343', N'mbbs', N'23 dec 2022', N'2', N'1234', N'Hyderabad', N'namu', 2, 1, 1, NULL, CAST(N'2022-04-20 03:40:16.187' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (2, N'yawar', N'yawarali17@gmail.com', N'123', 1, N'hyd', N'34343', N'mbbs', N'23 dec 2022', N'2', N'1234', N'Hyderabad', N'namu', 1, 1, 1, CAST(N'2021-09-05 20:11:45.503' AS DateTime), CAST(N'2022-04-20 03:33:40.077' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (3, N'Meghna', N'Meghna@gmail.com', N'123', 1, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, 1, CAST(N'2021-09-06 02:21:23.810' AS DateTime), CAST(N'2022-05-01 06:01:53.883' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (5, N'Omer', N'Omer@gmail.com', N'123', 0, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, CAST(N'2021-10-12 12:44:24.833' AS DateTime), CAST(N'2021-10-12 12:44:24.833' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (6, N'Jiva', N'Jiva@gmail.com', N'123', 0, N'1', NULL, NULL, NULL, NULL, NULL, N'test', NULL, 1, NULL, 1, CAST(N'2021-10-12 12:45:25.533' AS DateTime), CAST(N'2022-05-08 03:49:04.810' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (13, N'mohammed asif', N'asif@gmail.com', NULL, 0, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, CAST(N'2021-10-12 13:02:40.073' AS DateTime), CAST(N'2021-10-12 13:02:40.073' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (14, N'mohammed asif', N'asif@asdfasdgmail.com', N'asdfasd', 0, N'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, CAST(N'2021-10-12 13:03:19.403' AS DateTime), CAST(N'2021-10-12 13:03:19.403' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (16, N'rabi', N'rabi@gmail.com', N'123', 1, N'hyd1', N'8967656', N'btech', N'21 dec 2022', N'2 years', N'A23342', NULL, N'rabi', 1, NULL, NULL, CAST(N'2022-04-19 02:34:59.913' AS DateTime), CAST(N'2022-04-19 02:34:59.913' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (17, N'rabi2', N'rabi2@gmail.com', N'123', 1, N'hyd1', N'8967656', N'btech', N'21 dec 2022', N'2 years', N'A23342', N'hyd', N'rabi2', 1, NULL, NULL, CAST(N'2022-04-19 02:39:55.210' AS DateTime), CAST(N'2022-04-19 02:39:55.210' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (18, N'safi', N'safi@gmail.com', N'123', 1, N'hyd', N'34343', N'mbbs', N'23 dec 2022', N'2', N'1234', N'Hyderabad', N'safi alam', 1, NULL, 1, CAST(N'2022-05-08 01:24:20.460' AS DateTime), CAST(N'2022-05-08 01:24:34.877' AS DateTime))
INSERT [dbo].[tbl_UserLogin] ([Id], [Name], [Email], [Passward], [Status], [Center], [MobileNo], [Qualification], [DOJ], [Experience], [UID], [Address], [CollectedByUser], [RoleId], [CreatedBy], [UpdatedBy], [CreatedOn], [UpdatedOn]) VALUES (19, N'Namrata kuu', N'gghgh@gmail.com', N'123', 1, NULL, NULL, NULL, NULL, NULL, NULL, N'Kalapathar', N'yawarali17@gmail.com', 0, NULL, NULL, CAST(N'2022-05-08 03:50:15.270' AS DateTime), CAST(N'2022-05-08 03:50:15.270' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_UserLogin] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [uniqueEmail]    Script Date: 09-05-2022 08:34:04 ******/
ALTER TABLE [dbo].[tbl_UserLogin] ADD  CONSTRAINT [uniqueEmail] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddBillingTransaction]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddBillingTransaction]  
(  
   
   @ReportId varchar(500),
   @Pid varchar(500),
   @CreatedBy int ,  
   @UpdatedBy int 
)  
as  
begin 
 declare  @BillID int =0;
 declare @Description nvarchar(max)=Null
   select @BillID= MAX(BilIingId) from tbl_BillingMaster --where Pid=@Pid
   print @BillID
   Select @Description=Description from tbl_ReportType where Id=@ReportId
    Insert into tbl_BillingReport   
   (
BillId,
ReportId,
Description,
CreatedBy,
UpdatedBy,
CreatedOn,
UpdatedOn)
values(
@BillID,
@ReportId,
@Description, 
@CreatedBy,
@UpdatedBy,  
getdate(),
getdate()
)  

  select cast(@BillID as int)
  
End
 

 
 


GO
/****** Object:  StoredProcedure [dbo].[GetEmployees]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetEmployees]    
as    
begin    
   select Id as Empid,Name,City,Address from tbl_doc  
End 




GO
/****** Object:  StoredProcedure [dbo].[getHeaderReciept]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[getHeaderReciept]
  As
  BEGIN
  SELECT * from SettingInfo
  End

GO
/****** Object:  StoredProcedure [dbo].[getNotepadbyId]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getNotepadbyId]
@TopicId int
As
BEGIN
select * from Notepad where TopicId=@TopicId
END

GO
/****** Object:  StoredProcedure [dbo].[sp_CreateAppointment]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE procedure [dbo].[sp_CreateAppointment]
  @DrId int
 ,@PatId int
 ,@TotalAmount float
 ,@timeAppoint varchar(50)
 ,@CreatedBy int 
 
  AS
  BEGIN
  


  insert into Account([DrId],[PatId],[TotalAmount],CreatedBy,CreatedDate) 
  values(@DrId,@PatId,@TotalAmount,@CreatedBy,convert(varchar, getdate(),13))

  Insert into Appointment(PId,Did,DateOfAppointment,TimeOfAppointment,CreatedBy,CreationDate)
  values(@PatId,@DrId,convert(varchar, getdate(),13),@timeAppoint,@CreatedBy,convert(varchar, getdate(),13))

  select @@IDENTITY as int 
  END

GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Doctor]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_Delete_Doctor]
@DoctorId int
As
Begin
Delete from Doctors where DoctorId=@DoctorId
End

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteDoctorsbyid]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DeleteDoctorsbyid]
@id int
AS
BEGIN
DELETE from Doctors WHERE DoctorId=@id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_get_CountPatientByDrId]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_CountPatientByDrId]
As
BEGIN
Select ap.Did,dr.Name,count(*) as PatientCount 
from Appointment ap left join Doctors dr
on ap.Did =dr.DoctorId
group by ap.Did,dr.Name
END


GO
/****** Object:  StoredProcedure [dbo].[sp_get_Dashboard_Detail]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sp_get_Dashboard_Detail]
As
BEGIN
--SELECT Count(*) as CurrentPatient  from Patient where  dateadd(d, datediff(d,0, CreatedDate), 0) = dateadd(d, datediff(d,0, GETDATE()), 0)
SELECT Count(*) as CurrentPatient  from Patient 

SELECT Count(*) as Appointment from Appointment where  dateadd(d, datediff(d,0, CreationDate), 0)  = dateadd(d, datediff(d,0, GETDATE()), 0)

select sum([TotalAmount]) as TotalEarning from Account where  cast(Createddate as date)=cast(GETDATE() as date)

END 


select * from account





GO
/****** Object:  StoredProcedure [dbo].[sp_get_Dashboard_GetCountAppointmentByDRId]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_get_Dashboard_GetCountAppointmentByDRId]
@Drid int=Null
,@fromdate nvarchar(50)
,@todate   nvarchar(50)
As
BEGIN
Declare @FromAppDate datetime
Declare @ToAppDate datetime

set @FromAppDate= dateadd(d, datediff(d,0,@fromdate), 0)
set @ToAppDate=dateadd(d, datediff(d,0,@todate), 0)

if not exists (Select * from Doctors where DoctorId = @Drid)
    Begin
            SELECT Count(*) as Appointment from Appointment where  dateadd(d, datediff(d,0, CreationDate), 0)
 between   @FromAppDate  and @ToAppDate
    End
Else
    Begin
           SELECT Count(*) as Appointment from Appointment where  dateadd(d, datediff(d,0, CreationDate), 0)
 between  @FromAppDate  and @ToAppDate and Did=@Drid
    End
 END 



GO
/****** Object:  StoredProcedure [dbo].[sp_get_Dissease]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_get_Dissease]
As
Begin
Select * from Diseasses
End

GO
/****** Object:  StoredProcedure [dbo].[sp_get_Dissease_ById]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_get_Dissease_ById]
@Id int 
As
Begin
Select * from Diseasses Where DiseasesId=@Id
End

GO
/****** Object:  StoredProcedure [dbo].[sp_get_Doctors]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_Doctors]

AS
BEGIN
SELECT * from Doctors    
END

GO
/****** Object:  StoredProcedure [dbo].[sp_get_Medicine]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_get_Medicine]
As
Begin
Select m.MId, m.MedicineName,m.Formula,m.Comment,m.CreatedBy,m.UpdatedBy,d.DiseasesId,d.DisseaseName from Medicine m
left join Diseasses d
on m.DisseaseId=d.DiseasesId
End

 

GO
/****** Object:  StoredProcedure [dbo].[sp_get_Patient]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE Procedure [dbo].[sp_get_Patient]
  As
  Begin
  select pat.Pid,pat.PName,pat.Age,pat.gender,pat.ReferBy,ptype.PatientType,
  Pat.MobileNo,pat.Date_of_DisCharge,pat.address,pat.createdby,pat.CreatedDate,pat.Updatedby,pat.UpdatetedTime from Patient pat left outer
  join PatientTypes ptype
  on pat.Pid=ptype.PTypeId
  End

GO
/****** Object:  StoredProcedure [dbo].[sp_get_ROLES]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  CREATE PROCEDURE [dbo].[sp_get_ROLES]
  AS
  BEGIN
  SELECT * FROM ROLES
  END


GO
/****** Object:  StoredProcedure [dbo].[sp_get_ViewLoginDetail]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[sp_get_ViewLoginDetail]
  AS
  BEGIN
  SELECT rg.UserId,rg.Password,rg.UserName,rg.RoleId,rg.IsActive,rl.RoleName,rg.CreatedDate,rg.UpdatedDate FROM RegisterdUsers rg
  LEFT JOIN Roles rl
  on rg.RoleId=rl.RoleId 
  END


GO
/****** Object:  StoredProcedure [dbo].[sp_getAppointment]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getAppointment]
As
BEGIN
SELECT apt.AppointmentId,CONVERT(datetime, apt.DateOfAppointment, 103) as 'DateOfAppointment' ,apt.TimeOfAppointment,pat.Pid,pat.PName,Dt.Name  from Patient pat
INNER JOIN Appointment apt
on pat.Pid=apt.PId
INNER JOIN Doctors Dt
on dt.DoctorId=apt.Did


 
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getAppointmentByDrId]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_getAppointmentByDrId]
@DRID Int=null
As
BEGIN
SELECT apt.AppointmentId,CONVERT(datetime, apt.DateOfAppointment, 103) as 'DateOfAppointment' ,
apt.TimeOfAppointment,pat.Pid,pat.PName,Dt.Name  from Patient pat
INNER JOIN Appointment apt
on pat.Pid=apt.PId
INNER JOIN Doctors Dt
on dt.DoctorId=apt.Did
Inner Join RegisterdUsers rg
on rg.UserTypeId=dt.DoctorId
where rg.usertypeid=@DRID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getCurrentAccountDetailsByDrId]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[sp_getCurrentAccountDetailsByDrId]
 @Drid int=null
,@fromdate nvarchar(max)=null
,@todate   nvarchar(max)=null
As
BEGIN

if(@Drid is null)
    Begin
 
            SELECT sum(TotalAmount) as TotalEarning from Account where   cast(Createddate as date)  
 between   cast(@fromdate as date)  and   cast(@todate as date)
    End
 if(@Drid is not null and cast(@fromdate as date) is not null and cast(@todate as date) is not null )
    Begin
 
           SELECT sum(TotalAmount) as TotalEarning from Account where  cast(Createddate as date)  
 between cast(@fromdate as date)  and   cast(@todate as date) and DrId=@Drid
    End
	ELSE IF(@Drid is not null and @fromdate  is null and cast(@todate as date) is null)
 BEGIN
 
           SELECT sum(TotalAmount) as TotalEarning from Account where  DrId=@Drid
		   and cast(Createddate as date)=cast(GETDATE() as date)

 
 END 
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getCurrentAppointmentByDrId]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_getCurrentAppointmentByDrId]
@DrId int 
As
Begin
  SELECT Count(*)as [CurrentAppointmentCount] from Appointment where  cast(CreationDate as date) 
     = cast(GETDATE() as date)
  and Did=@DrId
END


GO
/****** Object:  StoredProcedure [dbo].[sp_getDoctorName]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_getDoctorName]
@searchText nvarchar(100)
As
Begin
  SELECT name,Specialist FROM [HospitalManagement].[dbo].[Doctors] where name like ''+@searchText+'%'  or Specialist like ''+@searchText+'%'
END





GO
/****** Object:  StoredProcedure [dbo].[sp_getDoctorsbyid]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getDoctorsbyid]
@id int
AS
BEGIN
SELECT * from Doctors WHERE DoctorId=@id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getExistingPatientsByDrId]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_getExistingPatientsByDrId]
 @Drid int=null
,@fromdate nvarchar(max)=null
,@todate   nvarchar(max)=null
As
BEGIN

if(@Drid is null)
    Begin
	print 'Dr is null'
            SELECT Count(*) as CurrentPatient from Appointment where   cast(CreationDate as date)  
 between   cast(@fromdate as date)  and   cast(@todate as date)
    End
 if(@Drid is not null and cast(@fromdate as date) is not null and cast(@todate as date) is not null )
    Begin
	print 'ali1'
           SELECT Count(*) as CurrentPatient from Appointment where  cast(CreationDate as date)  
 between cast(@fromdate as date)  and   cast(@todate as date) and Did=@Drid
    End
	ELSE IF(@Drid is not null and @fromdate  is null and cast(@todate as date) is null)
 BEGIN
 print 'ali'
           SELECT Count(*) as CurrentPatient from Appointment where  Did=@Drid
		   and cast(CreationDate as date)  <cast(GETDATE() as date)

 
 END 
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getLogin]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_getLogin]  (  @Email varchar(50),  @Passward varchar(50)  )  as  declare @Cnt int;  begin  if exists(select * from tbl_UserLogin where Email=@Email and Passward=@Passward)   begin   select * from tbl_UserLogin where Email=@Email and Passward=@Passward end  else   begin   set @Cnt=0;   end   select @Cnt;End





GO
/****** Object:  StoredProcedure [dbo].[sp_getLoginbyId]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_getLoginbyId]  (@id int)  as   Begin   select id as EmpId,
 Name,Email as emalid
,passward as password,
 RoleId,Status, Center as centerid, qualification, Experience, MobileNo, DOJ, UID,Address, CollectedByUser  from tbl_UserLogin  where id=@id  End





GO
/****** Object:  StoredProcedure [dbo].[sp_getLoginUsers]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getLoginUsers]
@UserName nvarchar(50),
@RoleId int null,
@Password nvarchar(50)
AS
BEGIN
SELECT * FROM RegisterdUsers WHERE UserName=@UserName and Password=@Password and RoleId=@RoleId
 
END


GO
/****** Object:  StoredProcedure [dbo].[sp_getMediciine]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getMediciine]
@DisseaseId int
,@MedicineName nvarchar(max)
,@Formula nvarchar(max)
,@Content nvarchar(max)
,@Mid int
As
BEGIN
update Medicine set MedicineName=@MedicineName,Formula=@Formula,Comment=@content ,DisseaseId=@disseaseId

where MId=@Mid

END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetNotepad]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE PROCEDURE [dbo].[sp_GetNotepad]
  
  AS
  BEGIN
SELECT * From Notepad 
  END

GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Dissease]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_Insert_Dissease]
@DisseaseName nvarchar(max),
@Description nvarchar(max),
@CreatedBy int,
@UpdatedBy int
As
Begin
Insert into Diseasses(DisseaseName,Description,CreatedBy,CreationDate,UpdatedBy,UpdatedDate) values(@DisseaseName,@Description,@CreatedBy,GETDATE(),@UpdatedBy,GETDATE())
select @@IDENTITY as int
End

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_LoginUsers]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_LoginUsers]
@UserName varchar(50),
@Password varchar(50),
@RoleId int,
@UserTypeId int,
@EmailId varchar(50), 
@IsActive bit,
@CreatedBy int,

@Updatedby int

AS
BEGIN

Declare @CheckUserName varchar(50)
select @CheckUserName= Count(*)  from RegisterdUsers Where UserName=@UserName
if(@CheckUserName<1)
INSERT INTO RegisterdUsers(UserName,Password,RoleId,UserTypeId,EmailId,IsActive,CreatedBy,CreatedDate,Updatedby,UpdatedDate)
values(@UserName,@Password,@RoleId,@UserTypeId,@EmailId,@IsActive,@CreatedBy,GETDATE(),@Updatedby,GETDATE())
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Medicine]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_Insert_Medicine]
@MedicineName nvarchar(max),
@Formula nvarchar(max),
@DisseaseId int,
@Comment nvarchar(max),
@CreatedBy int,
@UpdatedBy int
As
Begin
Insert into Medicine(MedicineName,Formula,DisseaseId,Comment,CreatedBy,CreationDate,UpdatedBy,Updationdate) values(@MedicineName,@Formula,@DisseaseId,@Comment,@CreatedBy,GETDATE(),@UpdatedBy,GETDATE())
select @@IDENTITY as int
End

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_TabandDoses]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE procedure [dbo].[sp_insert_TabandDoses]
 @Pid int=null
 ,@TabNmae varchar(100)=null
 ,@Rpid int=null
 ,@Doses nvarchar(100)
 ,@createdBy int 
 ,@UpdatedBy int
 ,@CreatedDatetime datetime
 ,@UpdateDatetime datetime
  AS
  BEGIN
  INSERT INTO TabletAndDoses(pid,TabName,Rpid,Dosses,CreatedBy,UpdatedBy,CreatedDatetime,UpdatedDatetime)
  Values(@Pid,@TabNmae,@Rpid,@Doses,@createdBy,@UpdatedBy,@CreatedDatetime,@UpdateDatetime)
  END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertDoctors]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_InsertDoctors]
   @name nvarchar(50)
  ,@emailid nvarchar(50)
  ,@mobileno nvarchar(50)
  ,@gender nvarchar(50)
  ,@specialist nvarchar(50)
  ,@date_of_joining datetime
  ,@qualification nvarchar(max)
  ,@address nvarchar(max)
  ,@Timing nvarchar(50)
  ,@CreatedBy int
   ,@UpdatedBy int
   
  As
  BEGIN
  Insert into Doctors(Name,Gender,EmailId,Mobile,Qualification,Specialist,Date_of_joining,Address,Timing,CreatedBy,UpdatedBy,CreationDate,UpdationDate)values
  (@Name,@gender,@EmailId,@MobileNo,@Qualification,@Specialist,@Date_of_joining,@Address,@Timing,@CreatedBy,@UpdatedBy,GETDATE(),GETDATE())
  select @@IDENTITY as int
END


GO
/****** Object:  StoredProcedure [dbo].[sp_InsertNotepad]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE PROCEDURE [dbo].[sp_InsertNotepad]
  @TopicName nvarchar(max)
 ,@TopicContent nvarchar(max)
  AS
  BEGIN
 Insert into Notepad(TopicName,TopicContent) Values(@TopicName,@TopicContent)
 
  END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertPatient]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_InsertPatient]
   @Ptname nvarchar(50)
 
  ,@MobileNo nvarchar(50)
  ,@gender nvarchar(50)
  ,@PatientType int
  ,@Age varchar(50)
  ,@ReferBy nvarchar(50)
  ,@address nvarchar(max)
   ,@createdBy int
  
   
  As
  BEGIN
  Insert into Patient(PName,Gender,
  MobileNo,PatientType,Date_of_Admission,Address,ReferBy,age,CreatedBy,CreatedDate)values
  (@Ptname,@gender,@MobileNo,@PatientType,GETDATE(),@Address,@ReferBy,@Age,@CreatedBy,convert(varchar, getdate(), 13))
  select @@IDENTITY as int
END


GO
/****** Object:  StoredProcedure [dbo].[sp_insertPatientReport]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_insertPatientReport]
@Pid int=null,
@did int=null,
@ReferBy nvarchar(max)=null,
@PTName nvarchar(max)=null,
@Gender nvarchar(max)=null,
@HT nvarchar(max)=null,
@WT nvarchar(max)=null,
@Age nvarchar(max)=null,
@Complain nvarchar(max)=null,
@History nvarchar(max)=null,
@Dx nvarchar(max)=null,
@Investigation nvarchar(max),
@Advice nvarchar(max)=null,
@GC nvarchar(max)=null,
@Temp nvarchar(max)=null,
@PR nvarchar(max)=null,
@LR nvarchar(max)=null,
@BP nvarchar(max)=null,
@SPO2 nvarchar(max)=null,
@PA nvarchar(max)=null,
@CNS nvarchar(max)=null,
@GRBS nvarchar(max)=null,
@HR nvarchar(max)=null,
@CreatedBy nvarchar(max)=null,
@CreatedDatetime datetime=null,
@UpdatedBy int=null,
@Updateddatetime datetime=null,
@Emergency nvarchar(max)=null,
@Review nvarchar(max)=null
 
AS
BEGIN

insert into GeneralPrescriptiom(Pid,PtName,Gender,Age,Ht,Wt,ReferBy,Review,Emergency,did,Complain,History,Dx,Investigation,Advice,
GC,Temp,PR,LR,BP,SPO2,PA,CNS,GRBS,HR,CreatedBy,CreatedDatetime,UpdatedBy,Updateddatetime)
Values(@Pid,@PtName,@Gender,@Age,@Ht,@Wt,@ReferBy,@Review,@Emergency,@did,@Complain,@History,@Dx,@Investigation,@Advice,
@GC,@Temp,@PR,@LR,@BP,@SPO2,@PA,@CNS,@GRBS,@HR,@CreatedBy,@CreatedDatetime,@UpdatedBy,@Updateddatetime)

select @@IDENTITY as int 
END

GO
/****** Object:  StoredProcedure [dbo].[sp_insertTabandDoses]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_insertTabandDoses]
@pid int=null,
@TABNAME nvarchar(150)=null,
@Rpid int=null,
@Doses varchar(100)=null,
@CREATEDBY int=null,
@updatedBy int=null

AS
BEGIN
INSERT into TabletAndDoses(Pid,TabName,RpId,Dosses,CreatedBy,CreatedDatetime,UpdatedBy,UpdatedDatetime)values(@Pid,@TabName,@RpId,@Doses,@CreatedBy,GETDATE(),@updatedBy,GETDATE())
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ReferDoctorById]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ReferDoctorById] @Rid int  AS   BEGIN  SELECT *  FROM [SUNDIGNOSTIC].[dbo].tbl_Doctor     where DocId=@Rid  END

GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Dissease_ById]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[sp_Update_Dissease_ById]
@Id int,
@DisseaseName nvarchar(max),
@Description nvarchar(max),
@CreatedBy int,
@UpdatedBy int 
As
Begin
Update Diseasses set DisseaseName=@DisseaseName,Description=@Description,UpdatedBy=@UpdatedBy,UpdatedDate=GETDATE() Where DiseasesId=@Id
End

GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Doctors]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Update_Doctors]
   @name nvarchar(50)
  ,@emailid nvarchar(50)
  ,@mobileno nvarchar(50)
  ,@gender nvarchar(50)
  ,@specialist nvarchar(50)
  ,@date_of_joining datetime
  ,@qualification nvarchar(max)
  ,@address nvarchar(max)
  ,@Timing nvarchar(50)
  ,@CreatedBy int
   ,@UpdatedBy int
   ,@DoctorID int
  As
  BEGIN
  Update  Doctors set Name=@name,Gender=@gender,EmailId=@emailid,Mobile=@mobileno,Qualification=@qualification,Specialist=@specialist,Date_of_joining=@date_of_joining,Address=@address,Timing=@Timing,UpdatedBy=@UpdatedBy,UpdationDate=GETDATE() where DoctorID=@DoctorID
 
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Update_LoginUsers]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Update_LoginUsers]
@UserId int
AS
BEGIN
select * from RegisterdUsers where UserId=@UserId
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Notepad]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Update_Notepad]
 @TopicId int
,@TopicName nvarchar(max)
,@TopicContent nvarchar(max)
As
BEGIN
Update Notepad set TopicName=@TopicName,TopicContent=@TopicContent  where TopicId=@TopicId
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatebyUserId_LoginUsers]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdatebyUserId_LoginUsers]
@userId int,
@UserName varchar(50),
@Password varchar(50),
@RoleId int,
@EmailId varchar(50), 
@IsActive bit,
@UserTypeId int,
@Updatedby int

AS
BEGIN
Update  RegisterdUsers set UserName=@UserName,Password=@Password,RoleId=@RoleId,UserTypeId=@UserTypeId,EmailId=@EmailId,
IsActive=@IsActive,Updatedby=@Updatedby,UpdatedDate=GETDATE() where UserId=@userId
 
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateDoctors]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE Procedure [dbo].[sp_UpdateDoctors]
    @id int
   ,@Name nvarchar(50)
  ,@EmailId nvarchar(50)
  ,@MobileNo nvarchar(50)
  As
  BEGIN
  Update Doctors set Name=@Name,EmailId=@EmailId,Mobile=@MobileNo where DoctorId=@id
END


GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteEmployee]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DeleteEmployee]
@id int
As
BEGIN
Delete  from tbl_UserLogin where id=@id
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DoctorsInfo]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DoctorsInfo]
@DoctorName varchar(50),
@Specilization varchar(50),
@Signature varchar(50),
@Qualification varchar(50),
@CreatedBy varchar(50),
@UpdatedBy varchar(50),
@Address1 varchar(max),
@Address2 varchar(max),
@Address3 varchar(max),
@MobileAdd1 varchar(50),
@MobileAdd2 varchar(50),
@MobileAdd3 varchar(50),
@EmailId varchar(50),
@ContactNumber varchar(50),
@DayAndTime1 varchar(max),
@DayAndTime2 varchar(max),
@DayAndTime3 varchar(max),
@Docid int=0
AS
BEGIN

IF(@Docid=0)
BEGIN
insert into tbl_Doctor
(
DoctorName,
Specilization,
Signature,
Qualification,
ContactNumber,
EmailId,
Address1,
Address2,
Address3,
DayAndTime1,
DayAndTime2,
DayAndTime3,
MobileAdd1,
MobileAdd2,
MobileAdd3,
CreatedBy,
CreatedOn,
UpdatedBy,
UpdatedOn)
values
(
@DoctorName,
@Specilization,
@Signature,
@Qualification,
@ContactNumber,
@EmailId,
@Address1,
@Address2,
@Address3,
@DayAndTime1,
@DayAndTime2,
@DayAndTime3,
@MobileAdd1,
@MobileAdd2,
@MobileAdd3,
@CreatedBy,
GETDATE(),
@UpdatedBy,
GETDATE())
End
Else 
BEGIN
Update tbl_Doctor
set 
DoctorName=@DoctorName,
Specilization=@Specilization,
Signature=@Signature,
Qualification=@Qualification,
ContactNumber=@ContactNumber,
EmailId=@EmailId,
Address1=@Address1,
Address2=@Address2,
Address3=@Address3,
DayAndTime1=@DayAndTime1,
DayAndTime2=@DayAndTime2,
DayAndTime3=@DayAndTime3,
MobileAdd1=@MobileAdd1,
MobileAdd2=@MobileAdd2,
MobileAdd3=@MobileAdd3,
UpdatedBy=@UpdatedBy,
UpdatedOn=GETDATE()
where docid=@Docid
End
END

GO
/****** Object:  StoredProcedure [dbo].[usp_getDoctorsDetail]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_getDoctorsDetail]
As
BEGIN
Select
 docid,
 doctorName,
 Specilization,
 Signature,
 ContactNumber,
 createdby,
 updatedby,
 Address1,
 Address2,
 Address3,
 DayandTime1,
 DayandTime2,
 DayandTime3
 MobileAdd1,
 MobileAdd2,
 MobileAdd3,
 DoctorPhoto,
 CreatedBy,
 CreatedOn,
 UpdatedBy,
 UpdatedOn
 from [dbo].[tbl_Doctor]
 

  
 END


GO
/****** Object:  StoredProcedure [dbo].[usp_getDoctorsDetailById]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_getDoctorsDetailById]
@Docid int
As
BEGIN
Select
 docid,
 doctorName,
 Specilization,
 Signature,
 ContactNumber,
 createdby,
 updatedby,
 Address1,
 Address2,
 Address3,
 DayandTime1,
 DayandTime2,
 DayandTime3,
 MobileAdd1,
 MobileAdd2,
 MobileAdd3,
 Qualification,
 EmailId
 from [dbo].[tbl_Doctor]
 where docId=@Docid
 END


GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmployees]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[usp_GetEmployees]
As
Begin
select id as EmpId,
 Name,Email as emalid
,passward as password,
RoleId,Status,Center from tbl_UserLogin
End

GO
/****** Object:  StoredProcedure [dbo].[usp_getInsvestigation]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_getInsvestigation]
AS
BEGIN
SELECT id,Invistagation FROM [dbo].[InvestigationDetails]
  END

GO
/****** Object:  StoredProcedure [dbo].[usp_getListDoctors]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_getListDoctors]
As
BEGIN
Select
 doc.docid,
 doc.doctorName,
 doc.Specilization,
 doc.Signature,
 doc.ContactNumber,
 doc.Qualification,
 doc.createdby,
 doc.updatedby
 
 from [dbo].[tbl_Doctor] doc 
  
 END

GO
/****** Object:  StoredProcedure [dbo].[usp_getNotepad]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[usp_getNotepad]
AS
BEGIN
SELECT * FROM Notepad
END

GO
/****** Object:  StoredProcedure [dbo].[usp_getUserLogin]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_getUserLogin](@Name varchar(50),@Email varchar(50),@Passward varchar(50),@RoleId int,@Status bit,@CenterId varchar(500),@Qualification varchar(500),@Experience varchar(500),@DOJ varchar(500),@MobileNo varchar(500),@UID varchar(500),@Address  varchar(500),@CollectedByUser varchar(500))AsBegininsert into tbl_UserLogin    ([Name],	Email,	Passward,	RoleId,	Status,	Center,	Qualification,	Experience,	DOJ,	UID,	address,	MobileNo,	CreatedOn,	UpdatedOn,	CollectedByUser)	values	(@Name,	 @Email,	 @Passward,	 @RoleId,	 @Status,	 @CenterId,	@Qualification,	@Experience,	@DOJ,	@UID,	@Address,	@MobileNo,	 GETDATE(),	 GETDATE(),	@CollectedByUser		 )		 End


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateBilling]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[usp_UpdateBilling]
@BillId int,
@Amount decimal(18,2),
@Discount decimal(18,2),
@Expenses decimal(18,2),
@ReferalAmount decimal(18,2),
@ReferalPercentage decimal(18,2),
@Status bit,
@DUE decimal(18,2),
@Paid decimal(18,2),
@UpdatedBy int
As
BEGIN
UPDATE [dbo].[tbl_BillingMaster] set 
Amount=@Amount,
Discount=@Discount,
Expenses=@Expenses,
ReferalAmount=@ReferalAmount,
ReferalPercentage=@ReferalPercentage,
Due=@DUE,
status=@Status,
paid=@Paid,
UpdatedOn=GetDate(),
UpdatedBy=@UpdatedBy
where BilIingId=@BillId
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateBillingFromPatientScreen]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[usp_UpdateBillingFromPatientScreen]
@BillId int,
@Amount decimal(18,2),
@Discount decimal(18,2),
@Paid decimal(18,2),
@DUE decimal(18,2),
@UpdatedBy int
As
BEGIN
UPDATE [dbo].[tbl_BillingMaster] set 
Amount=@Amount,
Discount=@Discount,
Due=@DUE,
Paid=@Paid,
UpdatedOn=GetDate(),
UpdatedBy=@UpdatedBy
where BilIingId=@BillId
END

GO
/****** Object:  StoredProcedure [dbo].[uspAddDoctor]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAddDoctor] @DoctorName varchar(200),@CreatedBy int,@UpdatedBy int ASBEGIN	INSERT INTO  tbl_Doctor(DoctorName,	CreatedBy,	UpdatedBy,	CreatedOn,	UpdatedOn)	 values(	 @DoctorName,	 @CreatedBy,	 @UpdatedBy,	 GetDate(),	 GetDate())END


GO
/****** Object:  StoredProcedure [dbo].[uspDeleteDoctor]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspDeleteDoctor]
 @DocId int 
AS
BEGIN
	Delete from tbl_Doctor  where DocId=@DocId
END


GO
/****** Object:  StoredProcedure [dbo].[uspGetDoctotList]    Script Date: 09-05-2022 08:34:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDoctotList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tbl_Doctor
END



GO
USE [master]
GO
ALTER DATABASE [HospitalManagement] SET  READ_WRITE 
GO
