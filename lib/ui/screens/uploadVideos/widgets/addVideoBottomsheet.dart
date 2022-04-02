import 'package:eschool_teacher/data/studyMaterials/models/video.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTopBarMenu.dart';
import 'package:eschool_teacher/ui/widgets/bottomsheetAddFilesDottedBorderContainer.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class AddVideoBottomSheet extends StatefulWidget {
  final Function onTapAddVideo;
  final bool editVideoDetails;
  final Video? video;
  final int? videoIndex;

  AddVideoBottomSheet({
    Key? key,
    required this.editVideoDetails,
    required this.onTapAddVideo,
    this.video,
    this.videoIndex,
  }) : super(key: key);

  @override
  State<AddVideoBottomSheet> createState() => _AddVideoBottomSheetState();
}

class _AddVideoBottomSheetState extends State<AddVideoBottomSheet> {
  late TextEditingController _videoTitleEditingController =
      TextEditingController(text: widget.video?.title);

  late TextEditingController _videoDescriptionEditingController =
      TextEditingController(text: widget.video?.description);

  late TextEditingController _youtubeLinkEditingController =
      TextEditingController(text: widget.video?.youTubeLink);

  final double _textFieldBottomMargin = 20;

  final List<String> _chapters = ["Carbon and it's bonds", "Atom Theory"];

  late String _selectedChapter =
      widget.editVideoDetails ? widget.video!.chapterId : _chapters.first;

  final List<String> _subjects = ["Chemistry"];

  late String _selectedSubject =
      widget.editVideoDetails ? widget.video!.subjectId : _subjects.first;

  final List<String> _classAndDivisions = ["Class 10 - A"];

  late String _selectedClassDivison = widget.editVideoDetails
      ? widget.video!.classDivisonId
      : _classAndDivisions.first;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                BottomSheetTopBarMenu(
                    onTapCloseButton: () {
                      Navigator.of(context).pop();
                    },
                    title: UiUtils.getTranslatedLabel(context, addVideoKey)),

                Padding(
                    child: Column(
                      children: [
                        //
                        BottomSheetTextFieldContainer(
                            margin:
                                EdgeInsets.only(bottom: _textFieldBottomMargin),
                            hintText: UiUtils.getTranslatedLabel(
                                context, videoTitleKey),
                            maxLines: 1,
                            textEditingController:
                                _videoTitleEditingController),

                        BottomSheetTextFieldContainer(
                            margin:
                                EdgeInsets.only(bottom: _textFieldBottomMargin),
                            hintText: UiUtils.getTranslatedLabel(
                                context, videoDescriptionKey),
                            maxLines: 3,
                            textEditingController:
                                _videoDescriptionEditingController),

                        LayoutBuilder(builder: (context, boxConstraints) {
                          return CustomDropDownMenu(
                              onChanged: (value) {
                                setState(() {
                                  _selectedClassDivison =
                                      value ?? _selectedClassDivison;
                                });
                              },
                              textStyle: TextStyle(
                                  color: hintTextColor,
                                  fontSize: UiUtils.textFieldFontSize),
                              borderRadius: 10,
                              height: 50,
                              width: boxConstraints.maxWidth,
                              menu: _classAndDivisions,
                              currentSelectedItem: _selectedClassDivison);
                        }),
                        LayoutBuilder(builder: (context, boxConstraints) {
                          return CustomDropDownMenu(
                              onChanged: (value) {
                                setState(() {
                                  _selectedSubject = value ?? _selectedSubject;
                                });
                              },
                              textStyle: TextStyle(
                                  color: hintTextColor,
                                  fontSize: UiUtils.textFieldFontSize),
                              borderRadius: 10,
                              height: 50,
                              width: boxConstraints.maxWidth,
                              menu: _subjects,
                              currentSelectedItem: _selectedSubject);
                        }),
                        LayoutBuilder(builder: (context, boxConstraints) {
                          return CustomDropDownMenu(
                              onChanged: (value) {
                                setState(() {
                                  _selectedChapter = value ?? _selectedChapter;
                                });
                              },
                              textStyle: TextStyle(
                                  color: hintTextColor,
                                  fontSize: UiUtils.textFieldFontSize),
                              borderRadius: 10,
                              height: 50,
                              width: boxConstraints.maxWidth,
                              menu: _chapters,
                              currentSelectedItem: _selectedChapter);
                        }),

                        BottomSheetTextFieldContainer(
                            margin:
                                EdgeInsets.only(bottom: _textFieldBottomMargin),
                            hintText: UiUtils.getTranslatedLabel(
                                context, videoYoutubeLinkKey),
                            maxLines: 1,
                            textEditingController:
                                _youtubeLinkEditingController),

                        BottomsheetAddFilesDottedBorderContainer(
                          onTap: () {},
                          title: UiUtils.getTranslatedLabel(
                              context, videoThumbnailImageKey),
                        ),

                        SizedBox(
                          height: _textFieldBottomMargin,
                        ),

                        CustomRoundedButton(
                            onTap: () {
                              Video video = Video(
                                  chapterId: _selectedChapter,
                                  classDivisonId: _selectedClassDivison,
                                  description:
                                      _videoDescriptionEditingController.text
                                          .trim(),
                                  subjectId: _selectedSubject,
                                  thumbnailImageUrl: "thumbnailImageUrl",
                                  title: _videoTitleEditingController.text,
                                  youTubeLink: _youtubeLinkEditingController
                                      .text
                                      .trim());
                              if (widget.editVideoDetails) {
                                widget.onTapAddVideo(widget.videoIndex!, video);
                              } else {
                                widget.onTapAddVideo(video);
                              }
                              Navigator.of(context).pop();
                            },
                            height: UiUtils.bottomSheetButtonHeight,
                            widthPercentage:
                                UiUtils.bottomSheetButtonWidthPercentage,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            buttonTitle: UiUtils.getTranslatedLabel(
                                context, addVideoKey),
                            showBorder: false),

                        SizedBox(
                          height: _textFieldBottomMargin,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: UiUtils.bottomSheetHorizontalContentPadding,
                    )),
              ],
            ),
          ),
        ),
        onWillPop: () {
          return Future.value(true);
        });
  }
}
