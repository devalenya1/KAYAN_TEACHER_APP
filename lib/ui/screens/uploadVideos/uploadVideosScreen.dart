import 'package:eschool_teacher/data/studyMaterials/models/video.dart';
import 'package:eschool_teacher/ui/screens/uploadVideos/widgets/addVideoBottomsheet.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customFloatingActionButton.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class UploadVideosScreen extends StatefulWidget {
  UploadVideosScreen({Key? key}) : super(key: key);

  @override
  State<UploadVideosScreen> createState() => _UploadVideosScreenState();
}

class _UploadVideosScreenState extends State<UploadVideosScreen> {
  late List<Video> _addedVideos = [];

  void addVideo(Video video) {
    setState(() {
      _addedVideos.add(video);
    });
  }

  void _editVideo(int videoIndex, Video video) {
    setState(() {
      _addedVideos[videoIndex] = video;
    });
  }

  void _removeVideo(int videoIndex) {
    setState(() {
      _addedVideos.removeAt(videoIndex);
    });
  }

  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
        title: UiUtils.getTranslatedLabel(
            context, UiUtils.getTranslatedLabel(context, uploadVideosKey)),
      ),
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

  Widget _buildAddedVideoContainer(int videoIndex, Video video) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
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
                  height: 60,
                  width: boxConstraints.maxWidth * (0.25),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.05),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(video.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          textAlign: TextAlign.left),

                      //TODO: Add read more or open bottom sheet
                      Text(
                        video.description,
                        maxLines: 2,
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: boxConstraints.maxWidth * (0.45)),
                  child: Text(
                    video.classDivisonId,
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
                    video.subjectId,
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
                video.chapterId,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.7),
                    fontSize: 14),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                video.youTubeLink,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0),
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
                      UiUtils.showBottomSheet(
                          child: AddVideoBottomSheet(
                            video: video,
                            videoIndex: videoIndex,
                            editVideoDetails: true,
                            onTapAddVideo: _editVideo,
                          ),
                          context: context);
                    },
                    backgroundColor: Theme.of(context).colorScheme.onPrimary),
                _buildAddedVideoActionButton(
                    rightMargin: 0,
                    width: boxConstraints.maxWidth * (0.3),
                    title: UiUtils.getTranslatedLabel(context, deleteKey),
                    onTap: () {
                      _removeVideo(videoIndex);
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

  List<Widget> _buildAddedVideos() {
    final List<Widget> children = [];

    for (var i = 0; i < _addedVideos.length; i++) {
      children.add(_buildAddedVideoContainer(i, _addedVideos[i]));
    }

    return children;
  }

  Widget _buildUploadVideosContainer() {
    return _addedVideos.isEmpty
        ? Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: TextButton(
              onPressed: () {
                UiUtils.showBottomSheet(
                    child: AddVideoBottomSheet(
                      editVideoDetails: false,
                      onTapAddVideo: addVideo,
                    ),
                    context: context);
              },
              child: Text(
                UiUtils.getTranslatedLabel(context, addVideoKey),
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
                ..._buildAddedVideos(),
                CustomRoundedButton(
                    height: UiUtils.bottomSheetButtonHeight,
                    widthPercentage: UiUtils.bottomSheetButtonWidthPercentage,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    buttonTitle:
                        UiUtils.getTranslatedLabel(context, uploadVideosKey),
                    showBorder: false),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionAddButton(onTap: () {
        UiUtils.showBottomSheet(
            child: AddVideoBottomSheet(
              editVideoDetails: false,
              onTapAddVideo: addVideo,
            ),
            context: context);
      }),
      body: Stack(
        children: [
          _buildUploadVideosContainer(),
          _buildAppBar(),
        ],
      ),
    );
  }
}
