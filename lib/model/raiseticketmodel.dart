
class DataModel {
  List<CompanyMaster>? companyMaster;
  List<DepartmentMaster>? departmentMaster;
  List<EmployeeMaster>? employeeMaster;
  List<IssueMaster>? issueMaster;
  List<IssueTypeMaster>? issueTypeMaster;
  List<PriorityMaster>? priorityMaster;
  List<RoleMaster>? roleMaster;
  List<StatusMaster>? statusmaster;

  DataModel({
    this.companyMaster,
    this.departmentMaster,
    this.employeeMaster,
    this.issueMaster,
    this.issueTypeMaster,
    this.priorityMaster,
    this.roleMaster,
    this.statusmaster
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      companyMaster: List<CompanyMaster>.from(json['data']['companyMaster']?.map((x) => CompanyMaster.fromJson(x)) ?? []),
      departmentMaster: List<DepartmentMaster>.from(json['data']['departmentMaster']?.map((x) => DepartmentMaster.fromJson(x)) ?? []),
      employeeMaster: List<EmployeeMaster>.from(json['data']['employeeMaster']?.map((x) => EmployeeMaster.fromJson(x)) ?? []),
      issueMaster: List<IssueMaster>.from(json['data']['issueMaster']?.map((x) => IssueMaster.fromJson(x)) ?? []),
      issueTypeMaster: List<IssueTypeMaster>.from(json['data']['issueTypeMaster']?.map((x) => IssueTypeMaster.fromJson(x)) ?? []),
      priorityMaster: List<PriorityMaster>.from(json['data']['priorityMaster']?.map((x) => PriorityMaster.fromJson(x)) ?? []),
      roleMaster: List<RoleMaster>.from(json['data']['roleMaster']?.map((x) => RoleMaster.fromJson(x)) ?? []),
      statusmaster: List<StatusMaster>.from(json['data']['statusMaster']?.map((x) => StatusMaster.fromJson(x)) ?? []),
    );
  }
}

class CompanyMaster {
  int? idCompany;
  String? companyName;
  DateTime? startedDate;
  DateTime? expiryDate;
  String? dateFormat;
  String? companyLogo;
  bool? isCustomerApprovalNeeded;
  String? smsUrl1;
  bool? isActive;
  String? ipAddress;
  int? idPackage;

  CompanyMaster({
    this.idCompany,
    this.companyName,
    this.startedDate,
    this.expiryDate,
    this.dateFormat,
    this.companyLogo,
    this.isCustomerApprovalNeeded,
    this.smsUrl1,
    this.isActive,
    this.ipAddress,
    this.idPackage,
  });

  factory CompanyMaster.fromJson(Map<String, dynamic> json) {
    return CompanyMaster(
      idCompany: json['idCompany'],
      companyName: json['companyName'],
      startedDate: json['startedDate'] != null ? DateTime.parse(json['startedDate']) : null,
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
      dateFormat: json['dateFormat'],
      companyLogo: json['companyLogo'],
      isCustomerApprovalNeeded: json['isCustomerApprovalNeeded'],
      smsUrl1: json['smsUrl1'],
      isActive: json['isActive'],
      ipAddress: json['ipAddress'],
      idPackage: json['idPackage'],
    );
  }
}

class DepartmentMaster {
  int? idDepartment;
  String? department;
  int? idDepartmentHead;
  bool? isActive;
  int? idCompany;

  DepartmentMaster({
    this.idDepartment,
    this.department,
    this.idDepartmentHead,
    this.isActive,
    this.idCompany,
  });

  factory DepartmentMaster.fromJson(Map<String, dynamic> json) {
    return DepartmentMaster(
      idDepartment: json['idDepartment'],
      department: json['department'],
      idDepartmentHead: json['idDepartmentHead'],
      isActive: json['isActive'],
      idCompany: json['idCompany'],
    );
  }
}

class EmployeeMaster {
  int? idEmployee;
  String? employeeCode;
  String? firstName;
  String? middleName;
  String? lastName;
  int? idReportingOfficer;
  int? idDepartment;
  int? idRole;
  int? idBranch;
  int? idEmployeeStatus;
  String? password;
  int? idCompany;

  EmployeeMaster({
    this.idEmployee,
    this.employeeCode,
    this.firstName,
    this.middleName,
    this.lastName,
    this.idReportingOfficer,
    this.idDepartment,
    this.idRole,
    this.idBranch,
    this.idEmployeeStatus,
    this.password,
    this.idCompany,
  });

  factory EmployeeMaster.fromJson(Map<String, dynamic> json) {
    return EmployeeMaster(
      idEmployee: json['idEmployee'],
      employeeCode: json['employeeCode'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      idReportingOfficer: json['idReportingOfficer'],
      idDepartment: json['idDepartment'],
      idRole: json['idRole'],
      idBranch: json['idBranch'],
      idEmployeeStatus: json['idEmployeeStatus'],
      password: json['password'],
      idCompany: json['idCompany'],
    );
  }
}

class IssueMaster {
  int? idIssue;
  String? issue;
  int? idIssueType;
  int? idPriority;
  int? idDepartment;
  int? idEmployee;
  String? taTinHours;
  bool? isAllowedForEditAssign;
  bool? isAllowedForEditTAT;
  bool? isAutoEscalateToNextLevelAfterTAT;
  int? idEscalationMatrix;
  int? idCompany;

  IssueMaster({
    this.idIssue,
    this.issue,
    this.idIssueType,
    this.idPriority,
    this.idDepartment,
    this.idEmployee,
    this.taTinHours,
    this.isAllowedForEditAssign,
    this.isAllowedForEditTAT,
    this.isAutoEscalateToNextLevelAfterTAT,
    this.idEscalationMatrix,
    this.idCompany,
  });

  factory IssueMaster.fromJson(Map<String, dynamic> json) {
    return IssueMaster(
      idIssue: json['idIssue'],
      issue: json['issue'],
      idIssueType: json['idIssueType'],
      idPriority: json['idPriority'],
      idDepartment: json['idDepartment'],
      idEmployee: json['idEmployee'],
      taTinHours: json['taTinHours'],
      isAllowedForEditAssign: json['isAllowedForEditAssign'],
      isAllowedForEditTAT: json['isAllowedForEditTAT'],
      isAutoEscalateToNextLevelAfterTAT: json['isAutoEscalateToNextLevelAfterTAT'],
      idEscalationMatrix: json['idEscalationMatrix'],
      idCompany: json['idCompany'],
    );
  }
}

class IssueTypeMaster {
  int? idIssueType;
  String? issueType;
  bool? isActive;
  int? idCompany;

  IssueTypeMaster({
    this.idIssueType,
    this.issueType,
    this.isActive,
    this.idCompany,
  });

  factory IssueTypeMaster.fromJson(Map<String, dynamic> json) {
    return IssueTypeMaster(
      idIssueType: json['idIssueType'],
      issueType: json['issueType'],
      isActive: json['isActive'],
      idCompany: json['idCompany'],
    );
  }
}

class PriorityMaster {
  int? idPriority;
  String? priority;
  bool? isActive;
  int? idCompany;

  PriorityMaster({
    this.idPriority,
    this.priority,
    this.isActive,
    this.idCompany,
  });

  factory PriorityMaster.fromJson(Map<String, dynamic> json) {
    return PriorityMaster(
      idPriority: json['idPriority'],
      priority: json['priority'],
      isActive: json['isActive'],
      idCompany: json['idCompany'],
    );
  }
}

class RoleMaster {
  int? idRole;
  String? role;
  bool? isActive;
  int? idCompany;

  RoleMaster({
    this.idRole,
    this.role,
    this.isActive,
    this.idCompany,
  });

  factory RoleMaster.fromJson(Map<String, dynamic> json) {
    return RoleMaster(
      idRole: json['idRole'],
      role: json['role'],
      isActive: json['isActive'],
      idCompany: json['idCompany'],
    );
  }
}

class StatusMaster {
  int? idStatus;
  String? status;
  bool? isActive;

  StatusMaster({
    this.idStatus,
    this.status,
    this.isActive,
  });

  factory StatusMaster.fromJson(Map<String, dynamic> json) {
    return StatusMaster(
      idStatus: json['idStatus'],
      status: json['sgtatus'],
      isActive: json['isActive'],
    );
  }
}


