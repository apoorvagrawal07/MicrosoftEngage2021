import 'package:WayUp/Screens/StudentScreen.dart';
import 'package:flutter/material.dart';
import './FacultyScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool fac = true;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // _imageUrlFocusNode.addListener((_updateImageUrl));
    super.initState();
    _check();
  }

  _check() async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('Faculty').doc(uid).get();

    this.setState(() {
      fac = ds.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fac) return FacultyScreen();
    return StudentScreen();
  }
}
