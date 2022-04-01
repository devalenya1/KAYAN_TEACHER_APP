import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/ui/widgets/downloadFileButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssignmentDetailsBottomsheetContainer extends StatefulWidget {
  const AssignmentDetailsBottomsheetContainer({Key? key}) : super(key: key);

  @override
  State<AssignmentDetailsBottomsheetContainer> createState() =>
      _AssignmentDetailsBottomsheetContainerState();
}

class _AssignmentDetailsBottomsheetContainerState
    extends State<AssignmentDetailsBottomsheetContainer> {
  TextStyle _getAssignmentDetailsLabelValueTextStyle() {
    return TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  TextStyle _getAssignmentDetailsLabelTextStyle() {
    return TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 12,
        fontWeight: FontWeight.w400);
  }

  Widget _buildAssignmentDetailBackgroundContainer(Widget child) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        width: MediaQuery.of(context).size.width,
        child: child,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  Widget _buildAssignmentSubjectNameContainer() {
    return _buildAssignmentDetailBackgroundContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            UiUtils.getTranslatedLabel(context, subjectNameKey),
            style: _getAssignmentDetailsLabelTextStyle(),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Maths",
            style: _getAssignmentDetailsLabelValueTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentAssignedDateContainer() {
    return _buildAssignmentDetailBackgroundContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            UiUtils.getTranslatedLabel(context, assignedDateKey),
            style: _getAssignmentDetailsLabelTextStyle(),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Due, 16 Feb, 2020, 1:30 PM",
            style: _getAssignmentDetailsLabelValueTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentDueDateContainer() {
    return _buildAssignmentDetailBackgroundContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            UiUtils.getTranslatedLabel(context, dueDateKey),
            style: _getAssignmentDetailsLabelTextStyle(),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Due, 16 Feb, 2020, 1:30 PM",
            style: _getAssignmentDetailsLabelValueTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentPointsContainer() {
    return _buildAssignmentDetailBackgroundContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            UiUtils.getTranslatedLabel(context, pointsKey),
            style: _getAssignmentDetailsLabelTextStyle(),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "25",
            style: _getAssignmentDetailsLabelValueTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentInstructionsContainer() {
    return _buildAssignmentDetailBackgroundContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            UiUtils.getTranslatedLabel(context, instructionsKey),
            style: _getAssignmentDetailsLabelTextStyle(),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Submit Assignment only in pdf format",
            style: _getAssignmentDetailsLabelValueTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentReferenceMaterialsContainer() {
    return _buildAssignmentDetailBackgroundContainer(
      LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              UiUtils.getTranslatedLabel(context, referenceMaterialsKey),
              style: _getAssignmentDetailsLabelTextStyle(),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: boxConstraints.maxWidth * (0.7),
                  child: Text(
                    "Test paper.pdf",
                    style: _getAssignmentDetailsLabelValueTextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                DownloadFileButton(),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: boxConstraints.maxWidth * (0.7),
                  child: Text(
                    "Test paper.pdf",
                    style: _getAssignmentDetailsLabelValueTextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                      UiUtils.getImagePath("download_icon.svg")),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildLateSubmissionToggleContainer() {
    return _buildAssignmentDetailBackgroundContainer(
        LayoutBuilder(builder: (context, boxConstraints) {
      return Row(
        children: [
          Flexible(
            child: SizedBox(
              width: boxConstraints.maxWidth * (0.8),
              child: Text(
                UiUtils.getTranslatedLabel(context, lateSubmissionKey),
                style: _getAssignmentDetailsLabelValueTextStyle(),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: 30,
            child: Transform.scale(
                scale: 0.6,
                child: CupertinoSwitch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: true,
                    onChanged: (_) {})),
          )
        ],
      );
    }));
  }

  //Add
  Widget _buildReSubmissionOfRejectedASsignmentToggleContainer() {
    return _buildAssignmentDetailBackgroundContainer(
        LayoutBuilder(builder: (context, boxConstraints) {
      return Row(
        children: [
          Flexible(
            child: SizedBox(
              width: boxConstraints.maxWidth * (0.825),
              child: Text(
                UiUtils.getTranslatedLabel(
                    context, resubmissionOfRejectedAssignmentKey),
                style: _getAssignmentDetailsLabelValueTextStyle(),
              ),
            ),
          ),
          SizedBox(
            width: boxConstraints.maxWidth * (0.075),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: boxConstraints.maxWidth * (0.1),
            child: Transform.scale(
                scale: 0.6,
                child: CupertinoSwitch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: true,
                    onChanged: (_) {})),
          )
        ],
      );
    }));
  }

  Widget _buildExtraDayForRejectedAssignmentContainer() {
    return _buildAssignmentDetailBackgroundContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            UiUtils.getTranslatedLabel(
                context, extraDaysForRejectedAssignmentKey),
            style: _getAssignmentDetailsLabelTextStyle(),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "5",
            style: _getAssignmentDetailsLabelValueTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteAndEditButtonContainer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomRoundedButton(
              maxLines: 1,
              height: 35,
              radius: 10,
              textSize: 13,
              widthPercentage: 0.35,
              backgroundColor: Theme.of(context).colorScheme.primary,
              buttonTitle: UiUtils.getTranslatedLabel(context, editKey),
              showBorder: false),
          SizedBox(
            width: MediaQuery.of(context).size.width * (0.05),
          ),
          CustomRoundedButton(
              maxLines: 1,
              height: 35,
              radius: 10,
              textSize: 13,
              widthPercentage: 0.35,
              backgroundColor: Theme.of(context).colorScheme.primary,
              buttonTitle: UiUtils.getTranslatedLabel(context, deleteKey),
              showBorder: false),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(UiUtils.bottomSheetTopRadius),
          topRight: Radius.circular(UiUtils.bottomSheetTopRadius),
        ),
      ),
      padding:
          EdgeInsets.only(top: UiUtils.bottomSheetHorizontalContentPadding),
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * (0.875)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5)))),
            padding: EdgeInsets.symmetric(
                horizontal: UiUtils.bottomSheetHorizontalContentPadding),
            child: LayoutBuilder(builder: (context, boxConstraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: boxConstraints.maxWidth * (0.75),
                      child: Text(
                        "Integration and Diffraction",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "View",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      )),
                ],
              );
            }),
          ),

          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: UiUtils.bottomSheetHorizontalContentPadding),
            children: [
              SizedBox(
                height: UiUtils.bottomSheetHorizontalContentPadding,
              ),
              _buildAssignmentSubjectNameContainer(),
              _buildAssignmentAssignedDateContainer(),
              _buildAssignmentDueDateContainer(),
              _buildAssignmentInstructionsContainer(),
              _buildAssignmentReferenceMaterialsContainer(),
              _buildAssignmentPointsContainer(),
              _buildLateSubmissionToggleContainer(),
              _buildReSubmissionOfRejectedASsignmentToggleContainer(),
              _buildExtraDayForRejectedAssignmentContainer(),
              _buildDeleteAndEditButtonContainer(),
              SizedBox(
                height: UiUtils.bottomSheetHorizontalContentPadding,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
