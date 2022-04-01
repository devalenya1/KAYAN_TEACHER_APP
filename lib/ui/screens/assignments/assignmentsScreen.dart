import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/ui/screens/assignments/widgets/assignmentContainer.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customFloatingActionButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class AssignmentsScreen extends StatefulWidget {
  AssignmentsScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  List<String> _classes = ["Class"];

  late String _selectedClass = _classes.first;

  List<String> _divisions = ["Division"];

  late String _selectedDivision = _divisions.first;

  List<String> _subjects = ["Subject"];

  late String _selectedSubject = _subjects.first;

  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          title: UiUtils.getTranslatedLabel(context, assignmentsKey)),
    );
  }

  Widget _buildAssignmentFilters() {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomDropDownMenu(
                  width: boxConstraints.maxWidth * (0.45),
                  menu: _classes,
                  currentSelectedItem: _selectedClass),
              CustomDropDownMenu(
                  width: boxConstraints.maxWidth * (0.45),
                  menu: _divisions,
                  currentSelectedItem: _selectedDivision),
            ],
          ),
          CustomDropDownMenu(
              width: boxConstraints.maxWidth,
              menu: _subjects,
              currentSelectedItem: _selectedSubject),
        ],
      );
    });
  }

  Widget _buildAssignmentList() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * (0.075),
          right: MediaQuery.of(context).size.width * (0.075),
          top: UiUtils.getScrollViewTopPadding(
              context: context,
              appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
      child: Column(
        children: [
          _buildAssignmentFilters(),
          SizedBox(
            height: 10,
          ),
          //TODO : add assignment with given filters
          AssignmentContainer()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionAddButton(
        onTap: () {
          //
        },
      ),
      body: Stack(
        children: [
          _buildAssignmentList(),
          _buildAppbar(),
        ],
      ),
    );
  }
}
