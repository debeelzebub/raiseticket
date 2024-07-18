class LoginDetails {
  int status;
  String statusMsg;
  String employeeCode;
  String employeeName;
  int idBranch;
  String branchName;
  String departmentName;
  String department;
  int idState;
  int idDistrict;
  int idCompany;
  String companyName;
  String companyLogo;
  String marquee;
  bool isPrinterHP;
  int isMISEmployee;
  String defaultPage;
  String actionmethod;
  int idEmployee;
  int isMAAgent;
  String trandate;
  int userLevel;

  LoginDetails({
    required this.status,
    required this.statusMsg,
    required this.employeeCode,
    required this.employeeName,
    required this.idBranch,
    required this.branchName,
    required this.departmentName,
    required this.department,
    required this.idState,
    required this.idDistrict,
    required this.idCompany,
    required this.companyName,
    required this.companyLogo,
    required this.marquee,
    required this.isPrinterHP,
    required this.isMISEmployee,
    required this.defaultPage,
    required this.actionmethod,
    required this.idEmployee,
    required this.isMAAgent,
    required this.trandate,
    required this.userLevel,
  });

  factory LoginDetails.fromJson(Map<String, dynamic> json) {
    return LoginDetails(
      status: json['status'],
      statusMsg: json['statusMsg'],
      employeeCode: json['employeeCode'],
      employeeName: json['employeeName'],
      idBranch: json['idBranch'],
      branchName: json['branchName'],
      departmentName: json['departmentName'],
      department: json['department'],
      idState: json['idState'],
      idDistrict: json['idDistrict'],
      idCompany: json['idCompany'],
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
      marquee: json['marquee'],
      isPrinterHP: json['isPrinterHP'],
      isMISEmployee: json['isMISEmployee'],
      defaultPage: json['defaultPage'],
      actionmethod: json['actionmethod'],
      idEmployee: json['idEmployee'],
      isMAAgent: json['isMAAgent'],
      trandate: json['trandate'],
      userLevel: json['userLevel'],
    );
  }
}

class BranchDetails {
  String employeeCode;
  int idBranch;
  String branchShortName;
  String branchName;
  int idArea;

  BranchDetails({
    required this.employeeCode,
    required this.idBranch,
    required this.branchShortName,
    required this.branchName,
    required this.idArea,
  });

  factory BranchDetails.fromJson(Map<String, dynamic> json) {
    return BranchDetails(
      employeeCode: json['employeeCode'],
      idBranch: json['idBranch'],
      branchShortName: json['branchShortName'],
      branchName: json['branchName'],
      idArea: json['idArea'],
    );
  }
}

class ResponseData {
  List<LoginDetails> loginDetails;
  List<BranchDetails> branchDetails;

  ResponseData({
    required this.loginDetails,
    required this.branchDetails,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    var loginDetailsFromJson = json['data']['loginDetails'] as List;
    List<LoginDetails> loginDetailsList = loginDetailsFromJson.map((i) => LoginDetails.fromJson(i)).toList();

    var branchDetailsFromJson = json['data']['branchDetails'] as List;
    List<BranchDetails> branchDetailsList = branchDetailsFromJson.map((i) => BranchDetails.fromJson(i)).toList();

    return ResponseData(
      loginDetails: loginDetailsList,
      branchDetails: branchDetailsList,
    );
  }
}
