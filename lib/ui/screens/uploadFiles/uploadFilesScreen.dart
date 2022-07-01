import 'package:eschool_teacher/data/models/studyFile.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customFloatingActionButton.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class UploadFilesScreen extends StatefulWidget {
  UploadFilesScreen({Key? key}) : super(key: key);

  @override
  State<UploadFilesScreen> createState() => _UploadFilesScreenState();
}

class _UploadFilesScreenState extends State<UploadFilesScreen> {
  late List<StudyFile> _addedFiles = [];

  void _addFile(StudyFile studyFile) {
    setState(() {
      _addedFiles.add(studyFile);
    });
  }

  void _editFile(int fileIndex, StudyFile studyFile) {
    setState(() {
      _addedFiles[fileIndex] = studyFile;
    });
  }

  void _removeFile(int fileIndex) {
    setState(() {
      _addedFiles.removeAt(fileIndex);
    });
  }

  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          title: UiUtils.getTranslatedLabel(context, uploadFilesKey)),
    );
  }

  //
  Widget _buildAddedVideoActionButton(
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
              fontSize: 13.5, color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
    );
  }

  Widget _buildAddedFileContainer(int fileIndex, StudyFile file) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(file.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
                textAlign: TextAlign.left),

            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: boxConstraints.maxWidth * (0.45)),
                  child: Text(
                    file.classDivisonId,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.7),
                        fontSize: 14),
                  ),
                ),
                Container(
                  width: boxConstraints.maxWidth * (0.1),
                  child: CircleAvatar(
                    radius: 3.5,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: boxConstraints.maxWidth * (0.45)),
                  child: Text(
                    file.subjectId,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.7),
                        fontSize: 14),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                file.chapterId,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.7),
                    fontSize: 14),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            //TODO: confirm the alignemnt of this buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildAddedVideoActionButton(
                    rightMargin: 15,
                    width: boxConstraints.maxWidth * (0.3),
                    title: UiUtils.getTranslatedLabel(context, editKey),
                    onTap: () {
                      // UiUtils.showBottomSheet(
                      //     child: AddFileBottomsheet(
                      //         editFileDetails: true,
                      //         fileIndex: fileIndex,
                      //         studyFile: _addedFiles[fileIndex],
                      //         onTapAddFile: _editFile),
                      //     context: context);
                    },
                    backgroundColor: Theme.of(context).colorScheme.onPrimary),
                _buildAddedVideoActionButton(
                    rightMargin: 0,
                    width: boxConstraints.maxWidth * (0.3),
                    title: UiUtils.getTranslatedLabel(context, deleteKey),
                    onTap: () {
                      _removeFile(fileIndex);
                    },
                    backgroundColor: Theme.of(context).colorScheme.error),
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

  List<Widget> _buildAddedFiles() {
    final List<Widget> children = [];

    for (var i = 0; i < _addedFiles.length; i++) {
      children.add(_buildAddedFileContainer(i, _addedFiles[i]));
    }

    return children;
  }

  Widget _buildUploadFilesContainer() {
    return _addedFiles.isEmpty
        ? Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: TextButton(
              onPressed: () {},
              child: Text(
                UiUtils.getTranslatedLabel(context, "addFileKey"),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0),
              ),
            ),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * (0.075),
              left: MediaQuery.of(context).size.width * (0.075),
              bottom: UiUtils.getScrollViewBottomPadding(context),
              top: UiUtils.getScrollViewTopPadding(
                  context: context,
                  appBarHeightPercentage:
                      UiUtils.appBarSmallerHeightPercentage),
            ),
            child: Column(
              children: [
                ..._buildAddedFiles(),
                CustomRoundedButton(
                    height: UiUtils.bottomSheetButtonHeight,
                    widthPercentage: UiUtils.bottomSheetButtonWidthPercentage,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    buttonTitle:
                        UiUtils.getTranslatedLabel(context, uploadFilesKey),
                    showBorder: false),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionAddButton(onTap: () {}),
      body: Stack(
        children: [
          _buildUploadFilesContainer(),
          _buildAppBar(),
        ],
      ),
    );
  }
}
