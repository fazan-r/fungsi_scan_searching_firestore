import 'package:aqs_final_project/reusable_widget/alert.dart';
import 'package:aqs_final_project/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showingAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure want to log out?',
      cancelActiontext: 'Cancel',
      defaultActionText: 'Logout',
    );

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  String userName, employeeID, companyName, companyLocation;

  getUserName (userName) { this.userName = userName;}
  getEmployeeID (employeeID) { this.employeeID = employeeID;}
  getCompanyName (companyName) { this.companyName = companyName;}
  getCompanyLocation (companyLocation) { this.companyLocation = companyLocation;}

  int _userType = 0;
  String typeCategory;

  void _handleUserType(int value){
    setState(() {
      _userType = value;
      switch(_userType){
        case 1:
          typeCategory = 'Supplier';
          break;
        case 2:
          typeCategory = 'Producer';
          break;
        case 3:
          typeCategory = 'Distributor';
          break;
        case 4:
          typeCategory = 'Retailer';
          break;
      }
    });
  }
  
  createUserInfo(){
    DocumentReference ds = Firestore.instance.collection('users').doc(employeeID);
    Map<String, dynamic> category = {
      "User Name" : userName,
      "Employee ID" : employeeID,
      "Company Name" : companyName,
      "Company Location" : companyLocation,
      "Role" : typeCategory,
    };
  ds.set(category).whenComplete(
          (){print('Completed');}
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Colors.amber,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[900], Colors.orangeAccent],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              )
          ),
        ),
        title: Text('User Information'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 554,
            child: ListView(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  onChanged: (String name) {
                    getUserName(name);
                  },
                  decoration: InputDecoration(labelText: "User Name"),
                ),),
                Padding(padding: EdgeInsets.only(left: 16, right: 16),
                  child: TextField(
                    onChanged: (String name) {
                      getEmployeeID(name);
                    },
                    decoration: InputDecoration(labelText: "Employee ID"),
                  ),),
                Padding(padding: EdgeInsets.only(left: 16, right: 16),
                  child: TextField(
                    onChanged: (String name) {
                      getCompanyName(name);
                    },
                    decoration: InputDecoration(labelText: "Company Name"),
                  ),),
                Padding(padding: EdgeInsets.only(left: 16, right: 16),
                  child: TextField(
                    onChanged: (String name) {
                      getCompanyLocation(name);
                    },
                    decoration: InputDecoration(labelText: "Company Location"),
                  ),),

                SizedBox( height: 10,),
                Center(
                  child: Text('Select User Role'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _userType,
                          onChanged: _handleUserType,
                          activeColor: Colors.orange,
                        ),
                        Text('Supplier'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _userType,
                          onChanged: _handleUserType,
                          activeColor: Colors.orange,
                        ),
                        Text('Producer'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _userType,
                          onChanged: _handleUserType,
                          activeColor: Colors.orange,
                        ),
                        Text('Distributor'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: _userType,
                          onChanged: _handleUserType,
                          activeColor: Colors.orange,
                        ),
                        Text('Retailer'),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                        onPressed: (){
                          createUserInfo();
                        },
                        child: Text('Submit'),
                      color: Colors.orange,
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}


