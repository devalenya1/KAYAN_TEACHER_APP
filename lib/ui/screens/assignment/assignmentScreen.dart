import 'package:eschool_teacher/ui/screens/assignment/widgets/acceptAssignmentBottomsheetContainer.dart';
import 'package:eschool_teacher/ui/screens/assignment/widgets/rejectAssignmentBottomsheetContainer.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/downloadFileBottomsheetContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class AssignmentScreen extends StatefulWidget {
  AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  late String _currentlySelectedAssignmentFilter = allKey;

  final List<String> _assignmentFilters = [
    allKey,
    submittedKey,
    acceptedKey,
    rejectedKey,
    pendingKey
  ];

  void openRejectAssignmentBottomsheet() {
    UiUtils.showBottomSheet(
        child: RejectAssignmentBottomsheetContainer(), context: context);
  }

  void openAcceptAssignmentBottomsheet() {
    UiUtils.showBottomSheet(
        child: AcceptAssignmentBottomsheetContainer(), context: context);
  }

  void openDownloadAssignmentBottomsheet() {
    UiUtils.showBottomSheet(
        child: DownloadFileBottomsheetContainer(), context: context);
  }

  void openViewAssignmentBottomsheet() {
    //TODO: implement view facility
    //if assignemnt is downloaded then direct view the file using open package
    //else download the assignment first and then open file
    UiUtils.showBottomSheet(
        child: DownloadFileBottomsheetContainer(), context: context);
  }

  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child:
          CustomAppBar(title: "Assignment name and it is long name my friend"),
    );
  }

  Widget _buildAssignmentFilterContainer(String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentlySelectedAssignmentFilter = title;
        });
      },
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        margin: EdgeInsets.only(right: 5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: _currentlySelectedAssignmentFilter == title
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              UiUtils.getTranslatedLabel(context, title),
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: _currentlySelectedAssignmentFilter == title
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).colorScheme.primary),
            ),
            SizedBox(
              width: 2.5,
            ),
            Text(
              "(1)",
              style: TextStyle(
                  fontSize: 11.5,
                  color: _currentlySelectedAssignmentFilter == title
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentSubmissionFilters() {
    return Transform.translate(
      offset: Offset(0, -5),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * (0.05)),
          itemCount: _assignmentFilters.length,
          itemBuilder: (context, index) {
            return _buildAssignmentFilterContainer(_assignmentFilters[index]);
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  //to display rejected, accepted,view and download
  Widget _buildStudentAssignmentActionButton(
      {required String title,
      required double rightMargin,
      required double width,
      required Function onTap,
      required Color backgroundColor}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        margin: EdgeInsets.only(right: rightMargin),
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0), color: backgroundColor),
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          UiUtils.getTranslatedLabel(context, title),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 10, color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
    );
  }

  Widget _buildStudentAssignmentDetailsContainer(
      {required String assignmentFilterType}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.75)),
                  height: boxConstraints.maxWidth * (0.175),
                  width: boxConstraints.maxWidth * (0.175),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.05),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Vicki R. Schendel",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0),
                        textAlign: TextAlign.left),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      "Submitted on 21 - March-2022, 11:30AM",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                          fontSize: 11.0),
                    ),
                  ],
                ),
              ],
            ),
            assignmentFilterType == rejectedKey
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: boxConstraints.maxWidth * (0.25),
                    ),
                    child: Text("Not Done Properly, Do it Again 2 time.",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0),
                        textAlign: TextAlign.left),
                  )
                : SizedBox(),
            assignmentFilterType == acceptedKey
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: boxConstraints.maxWidth * (0.25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Not Done Properly, Do it Again 2 time.",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 5,
                        ),
                        Text(UiUtils.getTranslatedLabel(context, pointsKey),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                            textAlign: TextAlign.left),
                        Text("20/25",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: assignmentFilterType == acceptedKey
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                assignmentFilterType == acceptedKey
                    ? SizedBox()
                    : _buildStudentAssignmentActionButton(
                        rightMargin: boxConstraints.maxWidth * (0.05),
                        width: boxConstraints.maxWidth * (0.2),
                        title: UiUtils.getTranslatedLabel(context, acceptKey),
                        onTap: () {
                          openAcceptAssignmentBottomsheet();
                        },
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary),
                assignmentFilterType == acceptedKey
                    ? SizedBox()
                    : _buildStudentAssignmentActionButton(
                        rightMargin: boxConstraints.maxWidth * (0.05),
                        width: boxConstraints.maxWidth * (0.2),
                        title: UiUtils.getTranslatedLabel(context, rejectKey),
                        onTap: () {
                          openRejectAssignmentBottomsheet();
                        },
                        backgroundColor: Theme.of(context).colorScheme.error),
                _buildStudentAssignmentActionButton(
                    rightMargin: boxConstraints.maxWidth * (0.05),
                    width: boxConstraints.maxWidth * (0.2),
                    title: UiUtils.getTranslatedLabel(context, viewKey),
                    onTap: () {
                      openViewAssignmentBottomsheet();
                    },
                    backgroundColor: assignmentViewButtonColor),
                _buildStudentAssignmentActionButton(
                    rightMargin: boxConstraints.maxWidth * (0.05),
                    width: boxConstraints.maxWidth * (0.2),
                    title: UiUtils.getTranslatedLabel(context, downloadKey),
                    onTap: () {
                      openDownloadAssignmentBottomsheet();
                    },
                    backgroundColor: assignmentDownloadButtonColor),
              ],
            )
          ],
        );
      }),
      width: MediaQuery.of(context).size.width * (0.85),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15)),
    );
  }

  Widget _buildAssignments() {
    if (_currentlySelectedAssignmentFilter == allKey) {
      return Column(
        children: [
          _buildStudentAssignmentDetailsContainer(
              assignmentFilterType: acceptedKey),
          _buildStudentAssignmentDetailsContainer(
              assignmentFilterType: subjectNameKey),
          _buildStudentAssignmentDetailsContainer(
              assignmentFilterType: rejectedKey),
          _buildStudentAssignmentDetailsContainer(
              assignmentFilterType: rejectedKey),
        ],
      );
    }
    if (_currentlySelectedAssignmentFilter == acceptedKey) {
      return Column(
        children: [
          _buildStudentAssignmentDetailsContainer(
              assignmentFilterType: acceptedKey),
        ],
      );
    }
    if (_currentlySelectedAssignmentFilter == rejectedKey) {
      return Column(
        children: [
          _buildStudentAssignmentDetailsContainer(
              assignmentFilterType: rejectedKey),
        ],
      );
    }
    if (_currentlySelectedAssignmentFilter == submittedKey) {
      return Column(
        children: [
          _buildStudentAssignmentDetailsContainer(
              assignmentFilterType: submittedKey),
        ],
      );
    }

    return Column(
      children: [
        //
      ],
    );
  }

  Widget _buildAssignmentListWithFiltersContainer() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: UiUtils.getScrollViewTopPadding(
              context: context,
              appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
      child: Column(
        children: [
          _buildAssignmentSubmissionFilters(),
          SizedBox(
            height: 20,
          ),
          _buildAssignments()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAssignmentListWithFiltersContainer(),
          _buildAppbar(),
        ],
      ),
    );
  }
}
