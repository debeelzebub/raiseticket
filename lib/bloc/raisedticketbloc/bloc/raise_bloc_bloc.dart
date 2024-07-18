import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raise_ticket/api/api.dart';
import 'package:raise_ticket/api/request.dart';
import 'package:raise_ticket/model/raisefileupload.dart';
import 'package:raise_ticket/model/raiseticketmodel.dart';
part 'raise_bloc_event.dart';
part 'raise_bloc_state.dart';

class RaiseBlocBloc extends Bloc<RaiseBlocEvent, RaiseBlocState> {
  ApiService apiService = ApiService();
  RaiseBlocBloc() : super(RaiseBlocInitial());
   Stream<RaiseBlocState> mapEventToState(RaiseBlocEvent event) async* {
    if (event is RaisedTicketEvent) {
      yield* raisedticketevent(action: event.action, createdBy: event.createdBy, token: event.token);
         }
   

  }

   Stream<RaiseBlocState> raisedticketevent({ 
  required String action,
  required String createdBy,
  required String token, 
    }
  ) async* {
      yield RaiseBlocLoading();

        final response = await apiService.getmaster(
         MasterRequest(action: action, createdBy: createdBy, token: token)
         );
      if(response != null){
        yield RaiseBlocSuccess(response.companyMaster,response.departmentMaster,response.employeeMaster,response.issueMaster,response.issueTypeMaster,response.priorityMaster,response.roleMaster,response.statusmaster);
      } else {
        yield RaiseBlocFailure("NO data get");
      }
    }
  
}
