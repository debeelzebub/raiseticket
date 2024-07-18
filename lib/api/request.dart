import 'package:raise_ticket/model/raisefileupload.dart';

class     LoginRequest {
  final String employeeCode;
  final String password;
  final String mobileLogin;
  final String imeiNumber;
  final int validationOnly;
  final String sessionID;

  LoginRequest({
    required this.employeeCode,
    required this.password,
    required this.mobileLogin,
    required this.imeiNumber,
    required this.validationOnly,
    required this.sessionID,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeCode': employeeCode,
      'password': password,
      'mobileLogin': mobileLogin,
      'imeiNumber': imeiNumber,
      'validationOnly': validationOnly,
      'sessionID': sessionID,
    };
  }
}

class   MasterRequest {
  final String action;
  final String createdBy;
  final String token;

    MasterRequest({
    required this.action,
    required this.createdBy,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'createdBy': createdBy,
      'token': token,
    };
  }
}

class RaisedSubmit {
  String transdate;
  String issuetype;
  String? other;
  String remark;
  String timedate;
  List<Fileupload> fileList;
  final int? action;
  final int? ticketid;
  final int idIssueType;
  final int idcompany;
  final int idPriority;
  final int idDepartment;
  final int idIssue;
  final int idrole;
  final int idEmployee;
  final int idstatus;
  final int? createdBy;

  RaisedSubmit({
    this.action = 1,
    this.createdBy = 1,
    this.other,
    required this.fileList,
    required this.idDepartment,
    required this.idEmployee,
    required this.idIssue,
    required this.idIssueType,
    required this.idPriority,
    required this.idcompany,
    required this.idrole,
    required this.idstatus,
    required this.issuetype,
    required this.remark,
    required this.ticketid,
    required this.timedate,
    required this.transdate,
  });

  Map<String, dynamic> toJson() {
    return {
      "TranDate": transdate,
      "idTicket": ticketid ?? 0,
      "idIssueType": idIssueType,
      "idCompany": idcompany,
      "idPriority": idPriority,
      "idDepartment": idDepartment,
      "idIssue": idIssue,
      "idRole": idrole,
      "idEmployee": idEmployee,
      "IssueType": issuetype,
      "idStatus": idstatus,
      "Others": other,
      "Remarks": remark,
      "TargetDateTime": timedate,
      "Action": action,
      "CreatedBy": createdBy,
      "FilesList": fileList.map((file) => file.toJson()).toList(),
    };
  }
}

class Fileuploads {
  int idTicket;
  int idComplaintsTracker;
  int slNo;
  String fileName;
  String fileType;
  int idTypeImageStaorage;
  String fileLocation;
  String document;

  Fileuploads({
    required this.idTicket,
    required this.idComplaintsTracker,
    required this.slNo,
    required this.fileName,
    required this.fileType,
    required this.idTypeImageStaorage,
    required this.fileLocation,
    required this.document,
  });

  Map<String, dynamic> toJson() {
    return {
      "idTicket": idTicket,
      "idComplaintsTracker": idComplaintsTracker,
      "SlNo": slNo,
      "FileName": fileName,
      "FileType": fileType,
      "idTypeImageStaorage": idTypeImageStaorage,
      "FileLocation": fileLocation,
      "Document": document,
    };
  }
}


