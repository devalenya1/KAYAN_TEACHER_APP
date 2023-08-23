import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/cubits/authCubit.dart';
import 'package:eschool_teacher/ui/screens/home/widgets/profileContainer.dart';
import 'package:eschool_teacher/cubits/studentMoreDetailsCubit.dart';
import 'package:eschool_teacher/data/models/guardianDetails.dart';
import 'package:eschool_teacher/data/models/student.dart';
import 'package:eschool_teacher/ui/widgets/customCircularProgressIndicator.dart';
import 'package:eschool_teacher/ui/widgets/errorContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
//import 'package:webview_flutter_android/webview_flutter_android.dart';
//import 'package:file_picker/file_picker.dart';
//import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class StudentDetailsContainer extends StatefulWidget {
  final Student student;

  const StudentDetailsContainer({Key? key, required this.student})
      : super(key: key);

  @override
  State<StudentDetailsContainer> createState() =>
      _StudentDetailsContainerState();
}



// class YourWebView extends StatelessWidget {
//    String url;
//    YourWebView(this.url);
   

//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: const Text('Flutter WebView example'),
//         // ),
//         body: Builder(builder: (BuildContext context) {
//           return WebView(
//             initialUrl: url,
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController webViewController) {
//               _controller.complete(webViewController);
//             },
//             // navigationDelegate: (NavigationRequest request) {
//             //   if (request.url.startsWith('https://www.youtube.com/')) {
//             //     print('blocking navigation to $request}');
//             //     return NavigationDecision.prevent;
//             //   }
//             //   print('allowing navigation to $request');
//             //   return NavigationDecision.navigate;
//             // },
//             onPageStarted: (String url) {
//               print('Page started loading: $url');
//             },
//             onPageFinished: (String url) {
//               print('Page finished loading: $url');
//             },
//             gestureNavigationEnabled: true,
//           );
//         }));
//  
// }

class _StudentDetailsContainerState extends State<StudentDetailsContainer> {
  final double _detailsInBetweenPadding = 8.5;

  TextStyle _getLabelValueTextStyle() {
    return TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle _getLabelTextStyle() {
    return TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontSize: 11,
      fontWeight: FontWeight.w400,
    );
  }

  Widget _buildDetailBackgroundContainer(Widget child) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 12.50, vertical: 15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: child,
      ),
    );
  }

  Widget _buildValueWithTitle({
    required String title,
    required String value,
    required double titleWidthPercentage,
    required double width,
    required valueWidthPercentage,
  }) {
    return Row(
      children: [
        SizedBox(
          width: width * titleWidthPercentage,
          child: Text(
            UiUtils.getTranslatedLabel(context, title),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _getLabelTextStyle(),
          ),
        ),
        SizedBox(
          width: width * valueWidthPercentage,
          child: Text(
            ":  $value",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _getLabelTextStyle(),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget _buildStudentInformationContainer() {
    return _buildDetailBackgroundContainer(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(widget.student.image),
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (context, boxConstraints) {
                const leftSideTitleWidthPercentage = 0.37;
                const rightSideTitleWidthPercentage = 0.5;
                final widthOfDetialsContainer = boxConstraints.maxWidth * (0.5);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.student.getFullName(),
                      style: _getLabelValueTextStyle(),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            _buildValueWithTitle(
                              title: rollNoKey,
                              value: widget.student.rollNumber.toString(),
                              width: widthOfDetialsContainer,
                              titleWidthPercentage:
                                  leftSideTitleWidthPercentage,
                              valueWidthPercentage:
                                  1.0 - leftSideTitleWidthPercentage,
                            ),
                            _buildValueWithTitle(
                              title: classKey,
                              value: widget.student.classSectionName,
                              width: widthOfDetialsContainer,
                              titleWidthPercentage:
                                  leftSideTitleWidthPercentage,
                              valueWidthPercentage:
                                  1.0 - leftSideTitleWidthPercentage,
                            ),
                            _buildValueWithTitle(
                              width: widthOfDetialsContainer,
                              title: dobKey,
                              value:
                                  UiUtils.formatStringDate(widget.student.dob),
                              titleWidthPercentage:
                                  leftSideTitleWidthPercentage,
                              valueWidthPercentage:
                                  1.0 - leftSideTitleWidthPercentage,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            _buildValueWithTitle(
                              title: genderKey,
                              value: widget.student.gender,
                              width: widthOfDetialsContainer,
                              titleWidthPercentage:
                                  rightSideTitleWidthPercentage,
                              valueWidthPercentage:
                                  1.0 - rightSideTitleWidthPercentage,
                            ),
                            _buildValueWithTitle(
                              title: bloodGrpKey,
                              value: widget.student.bloodGroup,
                              width: widthOfDetialsContainer,
                              titleWidthPercentage:
                                  rightSideTitleWidthPercentage,
                              valueWidthPercentage:
                                  1.0 - rightSideTitleWidthPercentage,
                            ),
                            _buildValueWithTitle(
                              title: grNoKey,
                              value: widget.student.admissionNo,
                              width: widthOfDetialsContainer,
                              titleWidthPercentage:
                                  rightSideTitleWidthPercentage,
                              valueWidthPercentage:
                                  1.0 - rightSideTitleWidthPercentage,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: widthOfDetialsContainer *
                              (leftSideTitleWidthPercentage + 0.05),
                          child: Text(
                            UiUtils.getTranslatedLabel(context, addressKey),
                            style: _getLabelTextStyle(),
                          ),
                        ),
                        Text(
                          ":  ${widget.student.currentAddress}",
                          style: _getLabelTextStyle(),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuardianDetailsContainer({
    required String guardianRole,
    required GuardianDetails guardianDetails,
  }) { 


     // _launchURLTwitter() {
     //    Navigator.push(
     //       context,
     //          MaterialPageRoute(
     //             builder: (context) => YourWebView('https://kayan-bh.com/chat/chat-teacher/chat.php?user_id=${guardianDetails.email}&email=${teacher.email}&image=${guardianDetails.image}')));
     // }
     _launchURLTwitter() async {
         var url = Uri.parse("https://kayan-bh.com/chat/chat-teacher/chat.php?user_id=${guardianDetails.email}&email=${teacher.email}&image=${guardianDetails.image}");
            if (await canLaunchUrl(url)) {
                await launchUrl(url);
            } else {
                throw 'Could not launch $url';
            }
     }


    return _buildDetailBackgroundContainer(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primary,
            backgroundImage: CachedNetworkImageProvider(guardianDetails.image),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: InkWell(
            child: LayoutBuilder(
              builder: (context, boxConstraints) {
                const titleWidthPercentage = 0.28;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guardianDetails.getFullName(),
                      style: _getLabelValueTextStyle(),
                    ),
                    Text(
                      guardianRole,
                      style: _getLabelTextStyle(),
                    ),
                    _buildValueWithTitle(
                      title: UiUtils.getTranslatedLabel(context, occupationKey),
                      value: guardianDetails.occupation,
                      titleWidthPercentage: titleWidthPercentage,
                      width: boxConstraints.maxWidth,
                      valueWidthPercentage: 1.0 - titleWidthPercentage,
                    ),
                    _buildValueWithTitle(
                      title: UiUtils.getTranslatedLabel(
                        context,
                        UiUtils.getTranslatedLabel(context, phoneKey),
                      ),
                      value: guardianDetails.mobile,
                      titleWidthPercentage: titleWidthPercentage,
                      width: boxConstraints.maxWidth,
                      valueWidthPercentage: 1.0 - titleWidthPercentage,
                    ),
                    _buildValueWithTitle(
                      title: UiUtils.getTranslatedLabel(context, emailKey),
                      value: guardianDetails.email,
                      titleWidthPercentage: titleWidthPercentage,
                      width: boxConstraints.maxWidth,
                      valueWidthPercentage: 1.0 - titleWidthPercentage,
                    ),
                  ],
                );
              },
            ),
                 onTap: _launchURLTwitter,
                 //onPressed: _launchURLTwitter,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceSummaryContainer({
    required int totalPresent,
    required int totalAbsent,
    required String todayAttendance,
  }) {
    return _buildDetailBackgroundContainer(
      LayoutBuilder(
        builder: (context, boxConstraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    UiUtils.getTranslatedLabel(context, todayAttendanceKey),
                    style: _getLabelValueTextStyle(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: boxConstraints.maxWidth * (0.02),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 2.5,
                    ),
                  ),
                  Text(
                    todayAttendance,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _detailsInBetweenPadding * (2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    width: boxConstraints.maxWidth * (0.47),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          UiUtils.getTranslatedLabel(context, totalPresentKey),
                          style: _getLabelTextStyle(),
                        ),
                        Text(
                          totalPresent.toString(),
                          style: _getLabelValueTextStyle(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    width: boxConstraints.maxWidth * (0.47),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          UiUtils.getTranslatedLabel(context, totalAbsentKey),
                          style: _getLabelTextStyle(),
                        ),
                        Text(
                          totalAbsent.toString(),
                          style: _getLabelValueTextStyle(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  _buildViewResultContainer() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.resultList,
          arguments: {
            'studentId': widget.student.id,
            'studentName':
                '${widget.student.firstName} ${widget.student.lastName}'
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        alignment: AlignmentDirectional.center,
        width: MediaQuery.of(context).size.width * (0.85),
        height: MediaQuery.of(context).size.width * (0.15),
        child: Text(
          UiUtils.getTranslatedLabel(context, viewResultKey),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * (0.075),
          right: MediaQuery.of(context).size.width * (0.075),
          top: UiUtils.getScrollViewTopPadding(
            context: context,
            appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage,
          ),
        ),
        child: Column(
          children: [
            //
            _buildStudentInformationContainer(),

            BlocBuilder<StudentMoreDetailsCubit, StudentMoreDetailsState>(
              builder: (context, state) {
                if (state is StudentMoreDetailsFetchSuccess) {
                  return Column(
                    children: [
                      _buildGuardianDetailsContainer(
                        guardianDetails: state.fatherDetails,
                        guardianRole:
                            UiUtils.getTranslatedLabel(context, fatherKey),
                      ),
                      _buildGuardianDetailsContainer(
                        guardianDetails: state.motherDetails,
                        guardianRole:
                            UiUtils.getTranslatedLabel(context, motherKey),
                      ),
                      state.guardianDetails.id != 0
                          ? _buildGuardianDetailsContainer(
                              guardianRole: UiUtils.getTranslatedLabel(
                                context,
                                guardianKey,
                              ),
                              guardianDetails: state.guardianDetails,
                            )
                          : const SizedBox(),
                      _buildAttendanceSummaryContainer(
                        todayAttendance: state.todayAttendance,
                        totalAbsent: state.totalAbsent,
                        totalPresent: state.totalPresent,
                      ),
                    ],
                  );
                }
                if (state is StudentMoreDetailsFetchFailure) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * (0.1),
                    ),
                    child: Center(
                      child: ErrorContainer(
                        onTapRetry: () {
                          context
                              .read<StudentMoreDetailsCubit>()
                              .fetchStudentMoreDetails(
                                studentId: widget.student.id,
                              );
                        },
                        errorMessageCode: state.errorMessage,
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (0.125),
                    bottom: MediaQuery.of(context).size.height * (0.125),
                  ),
                  child: Center(
                    child: CustomCircularProgressIndicator(
                      indicatorColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              },
            ),

            _buildViewResultContainer(),
          ],
        ),
      ),
    );
  }
}
