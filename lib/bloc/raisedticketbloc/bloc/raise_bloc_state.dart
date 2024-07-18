part of 'raise_bloc_bloc.dart';


abstract class RaiseBlocState extends Equatable {
   const RaiseBlocState();

  @override
  List<Object> get props => [];
}

final class RaiseBlocInitial extends RaiseBlocState {}
class RaiseBlocLoading extends RaiseBlocState {}

class RaiseBlocSuccess extends RaiseBlocState {
   List<CompanyMaster>? companyMaster=[];
   List<DepartmentMaster>? departmentMaster=[];
   List<EmployeeMaster>? employeeMaster=[];
   List<IssueTypeMaster>? issueTypeMaster=[];
   List<IssueMaster>? issueMaster=[];
   List<PriorityMaster>? priorityMaster=[];
   List<StatusMaster>? statusMaster=[];
   List<RoleMaster>? roleMaster=[];

  RaiseBlocSuccess(this.companyMaster,this.departmentMaster,this.employeeMaster,this.issueMaster,this.issueTypeMaster,this.priorityMaster,this.roleMaster,this.statusMaster);

}

class RaiseBlocFailure extends RaiseBlocState {
  final String error;

  const RaiseBlocFailure(this.error);
}
final class RaiseticketBlocInitial extends RaiseBlocState {}
class RaiseticketBlocLoading extends RaiseBlocState {}

class RaiseticketBlocSuccess extends RaiseBlocState {
   final String message;

  const RaiseticketBlocSuccess({required this.message});

}

class RaiseticketBlocFailure extends RaiseBlocState {
  final String error;

  const RaiseticketBlocFailure(this.error);
}