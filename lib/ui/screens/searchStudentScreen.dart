import 'package:eschool_teacher/data/models/student.dart';
import 'package:eschool_teacher/ui/widgets/svgButton.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchStudentScreen extends StatefulWidget {
  final List<Student> students;
  final bool fromAttendanceScreen;
  SearchStudentScreen(
      {Key? key, required this.fromAttendanceScreen, required this.students})
      : super(key: key);

  @override
  State<SearchStudentScreen> createState() => _SearchStudentScreenState();

  static Route<SearchStudentScreen> route(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments as Map<String, dynamic>;
    return CupertinoPageRoute(
        builder: (_) => SearchStudentScreen(
              fromAttendanceScreen: arguments['fromAttendanceScreen'],
              students: arguments['students'],
            ));
  }
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  late final TextEditingController searchQueryTextEditingController =
      TextEditingController();

  // Timer? waitForNextSearchRequestTimer;

  // int waitForNextRequestSearchQueryTimeInMilliSeconds = 500;

  /*
  void searchQueryTextControllerListener() {
    waitForNextSearchRequestTimer?.cancel();
    setWaitForNextSearchRequestTimer();
  }

  
  void setWaitForNextSearchRequestTimer() {
    if (waitForNextRequestSearchQueryTimeInMilliSeconds != 400) {
      waitForNextRequestSearchQueryTimeInMilliSeconds = 400;
    }
    waitForNextSearchRequestTimer =
        Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (waitForNextRequestSearchQueryTimeInMilliSeconds == 0) {
        timer.cancel();
        if (searchQueryTextEditingController.text.trim().isNotEmpty) {
          print(
              "Call search student api : ${searchQueryTextEditingController.text}");
        }
      } else {
        waitForNextRequestSearchQueryTimeInMilliSeconds =
            waitForNextRequestSearchQueryTimeInMilliSeconds - 100;
      }
    });
  }
  */

  @override
  void dispose() {
    searchQueryTextEditingController.dispose();
    super.dispose();
  }

  Widget _buildSearchTextField() {
    return TextField(
      controller: searchQueryTextEditingController,
      autofocus: true,
      cursorColor: Theme.of(context).scaffoldBackgroundColor,
      style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
      decoration: InputDecoration(
          hintStyle:
              TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
          border: InputBorder.none,
          hintText: "Search student"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              iconSize: 26,
              color: Theme.of(context).scaffoldBackgroundColor,
              onPressed: () {
                searchQueryTextEditingController.clear();
              },
              icon: Icon(Icons.clear))
        ],
        title: _buildSearchTextField(),
        leading: Padding(
          padding: const EdgeInsets.all(17),
          child: SvgButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              svgIconUrl: UiUtils.getBackButtonPath(context)),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
