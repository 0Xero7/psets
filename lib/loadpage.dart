import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:psettracker/static/problemstore.dart';
import 'package:psettracker/static/usermodel.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class LoadPage extends StatefulWidget {

  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {

  Future _loadUsers() async {
    await UserModel.loadUser();
  }

  Future _loadProblems() async {
    await ProblemStore.loadProblemsets();
  }
  
  Future _updateVisits() async {
    //var res = await Firestore.instance.document('/stats/visits').get();
    //int visits = res['visit_count'];
    //await Firestore.instance.document('/stats/visits').setData({'visit_count': visits + 1});
  }

  @override
  void initState() {
    super.initState();
    print("loading...");
    
    _loadUsers().then((value) {
      _loadProblems().then((value) {
        _updateVisits().then((value) {
          Navigator.popAndPushNamed(context, '/dashboard');
        });
      });
    });
      
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: PageWrapper(
        child: Stack(
          children: [
            Positioned(
              bottom: 50,
              right: 50,
              child: SpinKitPulse(color: Colors.cyan, size: 70,)
            ),
            Positioned(
              bottom: 20,
              right: 57,
              child: Text('Loading')
            ),
          ]
        ),
      ),
    );
  }
}