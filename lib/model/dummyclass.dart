class CompanyMaster {
  int idCompany;
  String companyName;
  DateTime startedDate;
  DateTime? expiryDate;
  String dateFormat;
  String? companyLogo;
  bool? isCustomerApprovalNeeded;
  String? smsUrl1;
  bool isActive;
  String? ipAddress;
  int? idPackage;

  CompanyMaster({
    required this.idCompany,
    required this.companyName,
    required this.startedDate,
    this.expiryDate,
    required this.dateFormat,
    this.companyLogo,
    this.isCustomerApprovalNeeded,
    this.smsUrl1,
    required this.isActive,
    this.ipAddress,
    this.idPackage,
  });
}

class DepartmentMaster {
  int idDepartment;
  String department;
  int idDepartmentHead;
  bool isActive;
  int idCompany;

  DepartmentMaster({
    required this.idDepartment,
    required this.department,
    required this.idDepartmentHead,
    required this.isActive,
    required this.idCompany,
  });
}

class EmployeeMaster {
  int idEmployee;
  String employeeCode;
  String firstName;
  String middleName;
  String lastName;
  int idReportingOfficer;
  int idDepartment;
  int idRole;
  int idBranch;
  int idEmployeeStatus;
  String password;
  int idCompany;

  EmployeeMaster({
    required this.idEmployee,
    required this.employeeCode,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.idReportingOfficer,
    required this.idDepartment,
    required this.idRole,
    required this.idBranch,
    required this.idEmployeeStatus,
    required this.password,
    required this.idCompany,
  });
}

class IssueMaster {
  int idIssueType;
  String issueType;
  bool isActive;
  int idCompany;

  IssueMaster({
    required this.idIssueType,
    required this.issueType,
    required this.isActive,
    required this.idCompany,
  });
}

class PriorityMaster {
  int idIssue;
  String issue;
  int idIssueType;
  int idPriority;
  int idDepartment;
  int idEmployee;
  int? taTinHours;
  bool isAllowedForEditAssign;
  bool isAllowedForEditTAT;
  bool isAutoEscalateToNextLevelAfterTAT;
  int idEscalationMatrix;
  int idCompany;

  PriorityMaster({
    required this.idIssue,
    required this.issue,
    required this.idIssueType,
    required this.idPriority,
    required this.idDepartment,
    required this.idEmployee,
    this.taTinHours,
    required this.isAllowedForEditAssign,
    required this.isAllowedForEditTAT,
    required this.isAutoEscalateToNextLevelAfterTAT,
    required this.idEscalationMatrix,
    required this.idCompany,
  });
}

class StatusMaster {
  int idPriority;
  String priority;
  bool isActive;
  int idCompany;

  StatusMaster({
    required this.idPriority,
    required this.priority,
    required this.isActive,
    required this.idCompany,
  });
}

void main() {
  List<CompanyMaster> companyMasterList = [
    CompanyMaster(
      idCompany: 1,
      companyName: "ABC PVT LTD",
      startedDate: DateTime(2024, 1, 1),
      expiryDate: null,
      dateFormat: "dd-mm-yyyy",
      companyLogo: null,
      isCustomerApprovalNeeded: null,
      smsUrl1: null,
      isActive: true,
      ipAddress: null,
      idPackage: null,
    ),
  ];

  List<DepartmentMaster> departmentMasterList = [
    DepartmentMaster(
      idDepartment: 1,
      department: "Warehouse",
      idDepartmentHead: 1,
      isActive: true,
      idCompany: 1,
    ),
    DepartmentMaster(
      idDepartment: 2,
      department: "Sales",
      idDepartmentHead: 2,
      isActive: true,
      idCompany: 1,
    ),
  ];

  List<EmployeeMaster> employeeMasterList = [
    EmployeeMaster(
      idEmployee: 1,
      employeeCode: "1001",
      firstName: "SANAL",
      middleName: "DAS",
      lastName: "T",
      idReportingOfficer: 1,
      idDepartment: 1,
      idRole: 1,
      idBranch: 1,
      idEmployeeStatus: 1,
      password: "1234",
      idCompany: 1,
    ),
  ];

  List<IssueMaster> issueMasterList = [
    IssueMaster(
      idIssueType: 1,
      issueType: "Software Issue",
      isActive: true,
      idCompany: 1,
    ),
    IssueMaster(
      idIssueType: 2,
      issueType: "Infra Related",
      isActive: true,
      idCompany: 1,
    ),
  ];

  List<PriorityMaster> priorityMasterList = [
    PriorityMaster(
      idIssue: 1,
      issue: "Ticketing Mobile App Not working",
      idIssueType: 1,
      idPriority: 1,
      idDepartment: 1,
      idEmployee: 1,
      taTinHours: null,
      isAllowedForEditAssign: true,
      isAllowedForEditTAT: true,
      isAutoEscalateToNextLevelAfterTAT: true,
      idEscalationMatrix: 1,
      idCompany: 1,
    ),
  ];

  List<StatusMaster> statusMasterList = [
    StatusMaster(
      idPriority: 1,
      priority: "High",
      isActive: true,
      idCompany: 1,
    ),
    StatusMaster(
      idPriority: 2,
      priority: "Medium",
      isActive: true,
      idCompany: 1,
    ),
    StatusMaster(
      idPriority: 3,
      priority: "Low",
      isActive: true,
      idCompany: 1,
    ),
  ];

  // Example of how to access these lists
  print(companyMasterList[0].companyName); // Output: ABC PVT LTD
  print(departmentMasterList[1].department); // Output: Sales
  print(employeeMasterList[0].firstName); // Output: SANAL
}
