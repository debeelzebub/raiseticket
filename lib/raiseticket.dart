import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raise_ticket/api/api.dart';
import 'package:raise_ticket/api/db.dart';
import 'package:raise_ticket/bloc/raisedticketbloc/bloc/raise_bloc_bloc.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_ticket/homepage.dart';
import 'package:raise_ticket/login.dart';
import 'package:raise_ticket/model/loginmodel.dart';
import 'package:raise_ticket/model/raisefileupload.dart';
import 'package:raise_ticket/model/raiseticketmodel.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RaiseTicketForm extends StatefulWidget {
  final String usercode;
  RaiseTicketForm({Key? key, required this.usercode}) : super(key: key);
  @override
  _RaiseTicketFormState createState() => _RaiseTicketFormState(
  );
}

class _RaiseTicketFormState extends State<RaiseTicketForm> {
  final _formKey = GlobalKey<FormState>();
  SharedPreferences? pref;
  List<CompanyMaster>? companyMaster = [];
  List<DepartmentMaster>? departmentMaster = [];
  List<DepartmentMaster>? filtereddepartment = [];
  List<EmployeeMaster>? employeeMaster = [];
  List<EmployeeMaster>? filteremployee = [];
  List<IssueTypeMaster>? issueTypeMaster = [];
  List<IssueMaster>? issueMaster = [];
  List<IssueMaster>? filteredIssues = [];
  List<PriorityMaster>? priorityMaster = [];
  List<PriorityMaster>? filterpriority = [];
  List<StatusMaster>? statusMaster = [];
  List<StatusMaster>? filterstatus = [];
  List<RoleMaster>? roleMaster = [];
  List<RoleMaster>? filterrole = [];
  DateTime? tranDate;
  String? selectedIssueType;
  String? selectedIssue;
  String? others;
  String? selectedDepartment;
  String? selectedRole;
  String? selectedEmployee;
  String? selectedPriority;
  String? _selectedStatus;
  String? remarks;
  int status=0;
  int id=0;
  bool isenable = true;
  DateTime? targetDateTime;
  List<File> images = [];
  String? employeerole;
  String? employeer;
  String? department;
  String? prority;
  bool? submit=false;
  String? issue;
  String? type;
  String? company;
  ResponseData? userlist;   
  final picker = ImagePicker();
  XFile? image;
  ApiService apidata=ApiService();
  List list=[];
  String tandate="";
  String newdate="";
  String _dateTimeController="";
  bool tat=false;
  File? _imgFile;
   List<Map<String,dynamic>> info=[];
  Future<void> _pickTranDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != tranDate)
      setState(() {
        targetDateTime=null;
        tranDate = picked;
        // DateTime newDate = picked.add(Duration(hours: 4));
        DateTime now = DateTime.now();
    DateTime newDateTime = now.add(Duration(hours: 4));
  // Format the new DateTime object to the desired string format
  DateFormat newDateFormat = DateFormat("dd/MM/yyyy hh:mm a");
  DateFormat newDateFormat1 = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  String newDateString = newDateFormat.format(newDateTime);
  newdate = newDateFormat1.format(newDateTime);
  tandate=newDateString;
  // Print the new date and time
  print("attiem$newDateString");
      });
  }
  Future<void> _pickTargetDateTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != targetDateTime) {
      final DateTime currentTime = DateTime.now();
      final String formattedTime = DateFormat('HH:mm:ss').format(currentTime);

      final String targetDateTimeString =
          "${DateFormat('yyyy-MM-dd').format(picked)}T$formattedTime";
      setState(() {
        DateTime _targetDateTime = DateTime.parse(targetDateTimeString);
         _dateTimeController =
            DateFormat('yyyy-MM-dd HH:mm a').format(_targetDateTime);
        targetDateTime =DateTime.parse(targetDateTimeString) ;
        print(targetDateTime);
      });

    }
  }
   Future<void> _pickImageFromGallery() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      for (var file in pickedFiles) {
        File compressedImage = await _compressImage(File(file.path));
        setState(() {
          images.add(compressedImage);
        });
      }
    }
  }
   void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File compressedImage = await _compressImage(File(pickedFile.path));
      setState(() {
        images.add(compressedImage);
      });
    }
  }
   Future<File> _compressImage(File file) async {
    final bytes = file.readAsBytesSync();
    img.Image? image = img.decodeImage(bytes);
    if (image != null) {
      final compressedBytes = img.encodeJpg(image, quality: 70);
      final compressedFile = File(file.path + '_compressed.jpg')
        ..writeAsBytesSync(compressedBytes);
      return compressedFile;
    }
    return file;
  }


  @override
  void initState() {
    context.read<RaiseBlocBloc>().add(RaisedTicketEvent(
        action:"1",
        createdBy:"1",
        token:"AxhRTcds3526RgTZ"));
     _fetchDataFromDB();
    super.initState();
  }
 void _fetchDataFromDB() async {
    final data = await SQlHelper.readData(id:1);
      info=data;
      print("....${info[0]["empname"]}");
       pref = await SharedPreferences.getInstance();
     status=pref!.getInt("status")??0;
     id=pref!.getInt("${widget.usercode}")??0;
     print("gfcg $id");
     setState((){});
  }

  void filterIssues(String? issueTypeId) {
    setState(() {
      type = issueTypeId;
      filteredIssues!.clear();
      filteredIssues = issueMaster!
          .where((issue) => issue.idIssueType.toString() == issueTypeId)
          .toList();
    });
  }

  void filterdata(String? issueid) {
    filtereddepartment!.clear();
    filteremployee!.clear();
    filterpriority!.clear();
    filterrole!.clear();
    issue = issueid;
    setState(() {
      List<IssueMaster> filteredIssuess = filteredIssues!
          .where((issue) => issue.idIssue.toString() == issueid)
          .toList();
      print("issue id ${filteredIssuess[0].issue}");
      // Use sets to track unique department and employee IDs
      Set<int> uniqueDepartmentIds = {};
      Set<int> uniqueEmployeeIds = {};
      Set<int> uniquepriortyIds = {};
      Set<int> uniqueroleids = {};

      // Iterate through departmentMaster to find matching departments
      for (int i = 0; i < departmentMaster!.length; i++) {
        for (int j = 0; j < filteredIssuess.length; j++) {
          if (departmentMaster![i].idDepartment ==
              filteredIssuess[j].idDepartment) {
            department = filteredIssues![j].idDepartment.toString();
            company = filteredIssues![j].idCompany.toString();
           
            // Add department to filtereddepartment if its ID hasn't been added yet
            if (!uniqueDepartmentIds
                .contains(departmentMaster![i].idDepartment)) {
              filtereddepartment!.add(departmentMaster![i]);
              uniqueDepartmentIds.add(departmentMaster![i].idDepartment!);
              break; // Exit inner loop once a department is added
            }
          }
        }
      }
      // Iterate through employeeMaster to find matching employees
      for (int i = 0; i < employeeMaster!.length; i++) {
        for (int j = 0; j < filteredIssuess.length; j++) {
          if (employeeMaster![i].idEmployee == filteredIssuess[j].idEmployee) {
            employeer = filteredIssues![j].idEmployee.toString();
            // Add employee to filteremployee if their ID hasn't been added yet
            if (!uniqueEmployeeIds.contains(employeeMaster![i].idEmployee)) {
              print("enterrredddddd ${employeeMaster![i].employeeCode}");
              filteremployee!.add(employeeMaster![i]);
              uniqueEmployeeIds.add(employeeMaster![i].idEmployee!);
              break; // Exit inner loop once an employee is added
            }
          }
        }
      }
      for (int i = 0; i < priorityMaster!.length; i++) {
        for (int j = 0; j < filteredIssuess.length; j++) {
          if (priorityMaster![i].idPriority == filteredIssuess[j].idPriority) {
            prority = filteredIssues![j].idPriority.toString();
            // Add employee to filteremployee if their ID hasn't been added yet
            if (!uniquepriortyIds.contains(priorityMaster![i].idPriority)) {
              print("enterrredddddd ${priorityMaster![i].idPriority}");
              filterpriority!.add(priorityMaster![i]);
              uniquepriortyIds.add(priorityMaster![i].idPriority!);
              break; // Exit inner loop once an employee is added
            }
          }
        }
      }
      for (int i = 0; i < roleMaster!.length; i++) {
        for (int j = 0; j < filteremployee!.length; j++) {
          if (roleMaster![i].idRole == filteremployee![j].idRole) {
            employeerole = filteremployee![j].idRole.toString();
            // Add employee to filteremployee if their ID hasn't been added yet
            if (!uniqueroleids.contains(roleMaster![i].idRole)) {
              print("enterrredddddd ${roleMaster![i].idRole}");
              filterrole!.add(roleMaster![i]);
              uniqueroleids.add(roleMaster![i].idRole!);
              break; // Exit inner loop once an employee is added
            }
          }
        }
      }

      isenable = filteredIssuess[0].isAllowedForEditAssign!;
       tat=filteredIssues![0].isAllowedForEditTAT!;
       _dateTimeController=tandate;
       DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
        
  DateTime dateTime = format.parse(newdate);
       targetDateTime= dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              accountName: Text(info.isNotEmpty?info[0]["empname"]:"Admin"),
              accountEmail: Text(info.isNotEmpty?info[0]["branchName"]:"branch"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "S",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.open_in_new),
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Status'),
                   Text(status==1?"Open":"Close"),
                ],
              ),
              onTap: () {
                showDialog(
              context: context,
              builder: (BuildContext cntx) {
                return AlertDialog(
                  title: Text('Branch Status'),
                  content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          DropdownButtonFormField<String>(
                            value: _selectedStatus,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedStatus = newValue;
                              });
                            },
                            items: <String>['Open', 'Close']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Status',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Pick Image:'),
                                  IconButton(
                                    icon: Icon(Icons.camera_alt),
                                    onPressed: () async {
                                      final XFile? pickedImage = await picker.pickImage(
                                        source: ImageSource.camera,
                                      );
                                      if (pickedImage != null) {
                                        setState(() {
                                          _imgFile = File(pickedImage.path);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              _imgFile != null
                                  ? Image.file(_imgFile!)
                                  : Text("Image not clicked"),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_imgFile != null && _selectedStatus != null) {
                          final bytes = _imgFile!.readAsBytesSync();
                          final base64data = base64Encode(bytes);
                          final response = await poststatus(
                            image: base64data,
                            status: _selectedStatus == "Open" ? 1 : 0,
                          );
                          print("response: $response");
                          // if (response == "Success") {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            setState(() {
                              status= _selectedStatus == "Open" ? 1 : 0;
                              _imgFile = null;
                            });
                            
                          // } 
                          // else {
                          //   Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Status change")),
                            );
                          // }
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                );
              },
            ); },
            ),
           ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard Home'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPage(usercode: widget.usercode)));
              },
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text('Overdue Tickets'),
              onTap: () {
                // Handle navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.wysiwyg_outlined),
              title: const Text('RaiseTicket'),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>RaiseTicketForm(usercode: widget.usercode)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                SQlHelper.deletedb();
                pref = await SharedPreferences.getInstance();
                await pref!.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyLogin()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<RaiseBlocBloc, RaiseBlocState>(
        builder: (context, state) {
          if (state is RaiseBlocLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RaiseBlocSuccess) {
            issueMaster = state.issueMaster;
            departmentMaster = state.departmentMaster;
            employeeMaster = state.employeeMaster;
            roleMaster = state.roleMaster;
            priorityMaster = state.priorityMaster;
            statusMaster = state.statusMaster;
            return info.isNotEmpty? SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text('Raise Ticket',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                              child: Divider(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color:tranDate == null?Color.fromARGB(255, 180, 178, 178) :Colors.red),
                              ),
                              child: ListTile(
                                title: const Text('Transaction Date'),
                                subtitle: Text(tranDate == null
                                    ? 'Select Date'
                                    : tranDate!
                                        .toLocal()
                                        .toString()
                                        .split(' ')[0]),
                                onTap: _pickTranDate,
                                trailing: const Icon(Icons.calendar_month,
                                    color: Colors.red),
                              ),
                            ),
                            const SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              value: selectedIssueType,
                              hint: const Text('Select Issue Type'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedIssueType = newValue;
                                  selectedIssue = null;
                                  selectedDepartment = null;
                                  selectedEmployee = null;
                                  selectedRole = null;
                                  selectedPriority = null;
                                  filterIssues(newValue);
                                  tat=true;
                                  print("issuetype $selectedIssueType");
                                });
                              },
                              items: state.issueTypeMaster!
                                  .map<DropdownMenuItem<String>>(
                                      (IssueTypeMaster value) {
                                return DropdownMenuItem<String>(
                                  value: value.idIssueType.toString(),
                                  child: Text(value.issueType!),
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an issue type';
                                }
                                return null;
                              },
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:selectedIssueType == null? Color.fromARGB(255, 180, 178, 178):Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            selectedIssueType == '3'
                                ? TextFormField(
                                    autofocus: true,
                                    maxLines: 3,
                                    decoration:  InputDecoration(
                                      labelText: 'Specify Issue',
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color:others ==null? Color.fromARGB(255, 180, 178, 178):Colors.red),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      others = value;
                                    },
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 5,
                            ),

                            DropdownButtonFormField<String>(
                              value: selectedIssue,
                              hint: const Text('Select Issue'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedIssue = newValue;
                                  filterdata(selectedIssue);
                                  
                                  // Update selected department based on issue change
                                  if (selectedIssueType != '3') {
                                    // Filter and set the appropriate department value
                                    selectedDepartment = filtereddepartment!
                                        .firstWhere(
                                          (department) =>
                                              department.idDepartment ==
                                              filteredIssues!
                                                  .firstWhere(
                                                    (issue) =>
                                                        issue.idIssue
                                                            .toString() ==
                                                        selectedIssue,
                                                    orElse: () => IssueMaster(),
                                                  )
                                                  .idDepartment,
                                          orElse: () => DepartmentMaster(),
                                        )
                                        .department;
                                    selectedEmployee = filteremployee!
                                        .firstWhere(
                                          (department) =>
                                              department.idEmployee ==
                                              filteredIssues!
                                                  .firstWhere(
                                                    (issue) =>
                                                        issue.idIssue
                                                            .toString() ==
                                                        selectedIssue,
                                                    orElse: () => IssueMaster(),
                                                  )
                                                  .idEmployee,
                                          orElse: () => EmployeeMaster(),
                                        )
                                        .firstName;

                                    print(
                                        "selectedrole $employeerole,$selectedRole");
                                    selectedRole = filterrole!
                                        .firstWhere(
                                          (department) =>
                                              department.idRole ==
                                              filteremployee!
                                                  .firstWhere(
                                                    (issue) =>
                                                        issue.idRole
                                                            .toString() ==
                                                        employeerole,
                                                    orElse: () =>
                                                        EmployeeMaster(),
                                                  )
                                                  .idRole,
                                          orElse: () => RoleMaster(),
                                        )
                                        .role;
                                  } else {
                                    // Use state to set the department based on the issue
                                    selectedDepartment = state.departmentMaster!
                                        .firstWhere(
                                          (department) =>
                                              department.idDepartment ==
                                              state.issueMaster!
                                                  .firstWhere(
                                                    (issue) =>
                                                        issue.idIssue
                                                            .toString() ==
                                                        selectedIssue,
                                                    orElse: () => IssueMaster(),
                                                  )
                                                  .idDepartment,
                                          orElse: () => DepartmentMaster(),
                                        )
                                        .department;
                                    selectedEmployee = state.employeeMaster!
                                        .firstWhere(
                                          (department) =>
                                              department.idEmployee ==
                                              state.issueMaster!
                                                  .firstWhere(
                                                    (issue) =>
                                                        issue.idIssue
                                                            .toString() ==
                                                        selectedIssue,
                                                    orElse: () => IssueMaster(),
                                                  )
                                                  .idEmployee,
                                          orElse: () => EmployeeMaster(),
                                        )
                                        .firstName;
                                  }
                                  selectedRole = state.roleMaster!
                                      .firstWhere(
                                        (department) =>
                                            department.idRole ==
                                            state.employeeMaster!
                                                .firstWhere(
                                                  (issue) =>
                                                      issue.idRole.toString() ==
                                                      employeerole,
                                                  orElse: () =>
                                                      EmployeeMaster(),
                                                )
                                                .idRole,
                                        orElse: () => RoleMaster(),
                                      )
                                      .role;
                                  selectedPriority = state.priorityMaster!
                                      .firstWhere(
                                        (department) =>
                                            department.idPriority ==
                                            state.issueMaster!
                                                .firstWhere(
                                                  (issue) =>
                                                      issue.idIssue
                                                          .toString() ==
                                                      selectedIssue,
                                                  orElse: () => IssueMaster(),
                                                )
                                                .idPriority,
                                        orElse: () => PriorityMaster(),
                                      )
                                      .priority;
                                });
                              },
                              items: selectedIssueType != '3'
                                  ? filteredIssues!
                                      .map<DropdownMenuItem<String>>(
                                          (IssueMaster value) {
                                      return DropdownMenuItem<String>(
                                        // enabled: isenable,
                                        value: value.idIssue.toString(),
                                        child: SizedBox(
                                            width: 270,
                                            child: Text(value.issue!,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                      );
                                    }).toList()
                                  : list
                                      .map<DropdownMenuItem<String>>(
                                          ( value) {
                                      return DropdownMenuItem<String>(
                                        enabled: false,
                                        value: value,
                                        child: SizedBox(
                                            width: 270,
                                            child: Text(value.issue!,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                      );
                                    }).toList(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an issue';
                                }
                                return null;
                              },
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:selectedIssue==null?Color.fromARGB(255, 180, 178, 178) : Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),

                            DropdownButtonFormField<String>(
                              value: selectedDepartment,
                              hint: const Text('Select department'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDepartment = newValue;
                                });
                              },
                              items: selectedIssueType != '3'
                                  ? filtereddepartment!
                                      .map<DropdownMenuItem<String>>(
                                          (DepartmentMaster value) {
                                      return DropdownMenuItem<String>(
                                        enabled: isenable,
                                        value: value.department,
                                        child: Text(value.department!),
                                      );
                                    }).toList()
                                  : null,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an department';
                                }
                                return null;
                              },
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: selectedDepartment==null?Color.fromARGB(255, 180, 178, 178) :Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              value: selectedEmployee,
                              hint: const Text('Select employee'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedEmployee = newValue;
                                });
                              },
                              items: selectedIssueType != '3'
                                  ? filteremployee!
                                      .map<DropdownMenuItem<String>>(
                                          (EmployeeMaster value) {
                                      return DropdownMenuItem<String>(
                                        enabled: isenable,
                                        value: value.firstName,
                                        child: Text(
                                            "${value.firstName}${value.middleName}${value.lastName}"),
                                      );
                                    }).toList()
                                  : null,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an employee';
                                }
                                return null;
                              },
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:selectedEmployee==null? Color.fromARGB(255, 180, 178, 178) :Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              value: selectedRole,
                              hint: const Text('Select Role'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedRole = newValue;
                                });
                              },
                              items: selectedIssueType != '3'
                                  ? filterrole!.map<DropdownMenuItem<String>>(
                                      (RoleMaster value) {
                                      return DropdownMenuItem<String>(
                                        enabled: isenable,
                                        value: value.role,
                                        child: Text(value.role!),
                                      );
                                    }).toList()
                                  : null,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an Role';
                                }
                                return null;
                              },
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:selectedRole ==null?Color.fromARGB(255, 180, 178, 178) : Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              value: selectedPriority,
                              hint: const Text('Select priority'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedPriority = newValue;
                                });
                              },
                              items: selectedIssueType != '3'
                                  ? filterpriority!
                                      .map<DropdownMenuItem<String>>(
                                          (PriorityMaster value) {
                                      return DropdownMenuItem<String>(
                                        enabled: isenable,
                                        value: value.priority,
                                        child: Text(value.priority!),
                                      );
                                    }).toList()
                                  : null,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an Priority';
                                }
                                return null;
                              },
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:selectedPriority==null?Color.fromARGB(255, 180, 178, 178) : Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration:  InputDecoration(
                                labelText: 'Remarks',
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:remarks==null?Color.fromARGB(255, 180, 178, 178) : Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              maxLines: 3,
                              onChanged: (value) {
                                remarks = value;
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color:_dateTimeController==""?Color.fromARGB(255, 180, 178, 178) : Colors.red)),
                              child: ListTile(
                                title: const Text('Target Date Time'),
                                subtitle: Text(_dateTimeController == ""
                                    ? 'Select Date'
                                    : _dateTimeController),
                                onTap:tat==true? _pickTargetDateTime:null,
                                trailing: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _pickImages,
                              child: const Text('Upload Images/Docs',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                            ),
                             images.isNotEmpty
                ? Wrap(
                    spacing: 10,
                    children: images.asMap().entries.map((entry) {
                      int index = entry.key;
                      File image = entry.value;
                      return Stack(
                        children: [
                          Image.file(
                            image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () => _removeImage(index),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  )
                : Text('No images selected'),
                            ElevatedButton(
                              onPressed: () async {
                                // if (_formKey.currentState!.validate()) {
                               int departmentidd =department!=null? int.parse(department!):0;
                               int rrroleid =employeerole!=null? int.parse(employeerole!):0;
                               int employyer =employeer!=null? int.parse(employeer!):0;
                               int prorityid =prority!=null? int.parse(prority!):0;
                               int issueeid =issue!=null? int.parse(issue!):0;
                               int typeidd = type!=null?int.parse(type!):0;
                               int companyyid =company!=null? int.parse(company!):0;
                                List<Fileupload> fileList = images.map((file) {
    final bytes = file.readAsBytesSync();
    final base64data = base64Encode(bytes);
    final filename = file.path.split('/').last;
    final filetype = file.path.split('.').last;
    return Fileupload(filename: filename, base64: base64data, filetype: filetype);
  }).toList();
                                    if(type !=null && remarks!=null && tandate !=null&& tranDate!=null){
                                      submit=true;
                                      setState(() {
                                        
                                      });
                                final response = await postraiseticket(
                                    idrole: rrroleid,
                                    idstatus: 1,
                                    transdate: DateFormat('yyyy-MM-dd')
                                        .format(tranDate!),
                                    issuetypes: selectedIssueType!,
                                    other: others == "" ? null : others,
                                    remark: remarks!,
                                    timedate: DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(targetDateTime!),
                                    idDepartment:departmentidd,
                                    idEmployee: employyer,
                                    idIssue: issueeid,
                                    idIssueType:typeidd ,
                                    idPriority: prorityid,
                                    idcompany: companyyid,
                                    fileList: fileList,
                                    );
                                if (response == "Success") {
                                submit=false;
                                setState(() {
                                  
                                });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RaiseTicketForm(usercode: widget.usercode,)));
                                  print('Form Submitted');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Your ticket raised")));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RaiseTicketForm(usercode: widget.usercode,)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Your ticket raised failed")));
                                              submit=false;
                                setState(() {
                                  
                                });
                                }
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Please fill the fields.")));
                                    }
                                // }
                              },
                              child:submit==false? const Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ):SpinKitThreeBounce(
                                color: Colors.white,
                                size: 12.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                            ),
                            // Add other form fields or widgets here
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ):Center(child:CircularProgressIndicator(),);
          } else if (state is RaiseBlocFailure) {
            return Center(child: Text('Failed to load data: ${state.error}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
  Future<void> _pickImages() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Future<String> postraiseticket(
      {
      required List<Fileupload> fileList,
      required String? other,
      required int idDepartment,
      required int idEmployee,
      required int idIssue,
      required int idIssueType,
      required int idPriority,
      required int idcompany,
      required int idrole,
      required int idstatus,
      required String issuetypes,
      required String remark,
      required String timedate,
      required String transdate}) async {
        List<Map<String, dynamic>> files = fileList.map((file) => file.toJson()).toList();
    Map data = {
      "TranDate": transdate,
      "idTicket": 0,
      "idIssueType": idIssueType,
      "idCompany": idcompany,
      "idPriority": idPriority,
      "idDepartment": idDepartment,
      "idIssue": idIssue,
      "idRole": idrole,
      "idEmployee": idEmployee,
      "IssueType": issuetypes,
      "idStatus": idstatus,
      "Others": others,
      "Remarks": remark,
      "TargetDateTime": timedate,
      "Action": 1,
      "CreatedBy": 1,
      "FilesList": files
    };
    String body = json.encode(data);
    var url = Uri.parse('http://111.92.96.90:86/api/LoginUser/RaiseTicket');

    final response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print("respondsssss ${response.body}");
    if (response.statusCode == 200) {
      return "Success";
    } else {
      return "failed";
    }
  }
  Future<String> poststatus(
      {
      required String image,
      required int status,}) async {
        print("id ${info[0]["idBranch"]}");
        int id=info[0]["idBranch"];
        int cid = info[0]["cid"];
    Map data = {
"Action":1,
"idCompany":cid,
"CreatedBy":"1",
"Image":image,
"idBranch":id,
"idBranchStatus":status
};
    String body = json.encode(data);
    var url = Uri.parse('http://111.92.96.90:86/api/LoginUser/DailyBranchStatus');

    final response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print("respondsssss ${response.body}");
    if (response.statusCode == 200) {
      pref = await SharedPreferences.getInstance();
      pref!.setInt('status',status);
      return "Success";
    } else {
      return "failed";
    }
  }
 
}
