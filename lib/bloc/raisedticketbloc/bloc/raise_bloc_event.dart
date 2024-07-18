part of 'raise_bloc_bloc.dart';

abstract class RaiseBlocEvent extends Equatable {
   const RaiseBlocEvent();

  @override
  List<Object> get props => [];
}

class RaisedTicketEvent extends RaiseBlocEvent {
  final String action;
  final String createdBy;
  final String token;
  RaisedTicketEvent({
    required this.action,
    required this.createdBy,
    required this.token,
  });
}
class RaisedTicketSubmitEvent extends RaiseBlocEvent {
  String transdate;
  String issuetype;
  String? other;
  String remark;
  String timedate;
  List<Fileupload> Filelist;
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
  RaisedTicketSubmitEvent({
     this.action=1,
     this.createdBy=1,
     this.other=null,
     required this.Filelist,
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
     required this.transdate,  });
}

