import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:raise_ticket/api/db.dart';
import 'package:raise_ticket/login.dart';
import 'package:raise_ticket/raiseticket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
    final String usercode;
     DashboardPage({Key? key, required this.usercode}) : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
List<Map<String,dynamic>> info=[];
int status=0;
  int id=0;
  File? _imgFile;
  XFile? image;
  String? _selectedStatus;
  final picker = ImagePicker();
    SharedPreferences? pref;  
  @override
  void initState() {
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mororra Ticket Management System'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Sanal Das T')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Sign Out')),
          ),
        ],
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
              leading: const Icon(Icons.wysiwyg_rounded),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Dashboard Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OverviewCard(title: 'Total Tickets', count: '99', color: Colors.blue),
                OverviewCard(title: 'Open Tickets', count: '65', color: Colors.green),
                OverviewCard(title: 'Closed Tickets', count: '34', color: Colors.orange),
                OverviewCard(title: 'OverDue Tickets', count: '3', color: Colors.red),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Overdue Tickets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  TicketRow(ticketNo: '#10004', subject: 'Issue with login', status: 'Open', priority: 'High', assignee: 'Sanal Das T', dueDate: '2024-07-10'),
                  TicketRow(ticketNo: '#10018', subject: 'Issue with login', status: 'Open', priority: 'High', assignee: 'Dinan V P', dueDate: '2024-07-08'),
                  TicketRow(ticketNo: '#10035', subject: 'Issue with login', status: 'Open', priority: 'High', assignee: 'Amal P', dueDate: '2024-07-08'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

class OverviewCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  OverviewCard({required this.title, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            count,
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class TicketRow extends StatelessWidget {
  final String ticketNo;
  final String subject;
  final String status;
  final String priority;
  final String assignee;
  final String dueDate;

  TicketRow({
    required this.ticketNo,
    required this.subject,
    required this.status,
    required this.priority,
    required this.assignee,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: Text(ticketNo)),
          Expanded(child: Text(subject)),
          Expanded(child: Text(status)),
          Expanded(child: Text(priority)),
          Expanded(child: Text(assignee)),
          Expanded(child: Text(dueDate)),
        ],
      ),
    );
  }
}
