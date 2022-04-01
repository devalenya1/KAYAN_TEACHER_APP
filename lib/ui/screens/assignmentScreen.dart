import 'package:flutter/material.dart';

class AssignmentScreen extends StatefulWidget {
  AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [ExpansionTile(title: Text("Assignment data"))],
      ),
    );
  }
}
