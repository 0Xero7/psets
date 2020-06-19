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

  @override
  void initState() {
    super.initState();
    _loadUsers().then((value) {
      _loadProblems().then((value) {
        Navigator.popAndPushNamed(context, '/dashboard');
      });
    });
      
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
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
    );
  }
}