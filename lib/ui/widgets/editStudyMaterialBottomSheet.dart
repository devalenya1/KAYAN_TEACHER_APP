import 'package:dotted_border/dotted_border.dart';
import 'package:eschool_teacher/data/models/studyMaterial.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTopBarMenu.dart';
import 'package:eschool_teacher/ui/widgets/bottomsheetAddFilesDottedBorderContainer.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/ui/widgets/defaultDropDownLabelContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

//TODO: Create api for editing study material
class EditStudyMaterialBottomSheet extends StatefulWidget {
  final StudyMaterial studyMaterial;
  EditStudyMaterialBottomSheet({Key? key, required this.studyMaterial})
      : super(key: key);

  @override
  State<EditStudyMaterialBottomSheet> createState() =>
      _EditStudyMaterialBottomSheetState();
}

class _EditStudyMaterialBottomSheetState
    extends State<EditStudyMaterialBottomSheet> {
  late TextEditingController _studyMaterialNameEditingController =
      TextEditingController(text: widget.studyMaterial.fileName);

  late TextEditingController _youtubeLinkEditingController =
      TextEditingController(
          text: widget.studyMaterial.studyMaterialType ==
                  StudyMaterialType.youtubeVideo
              ? widget.studyMaterial.fileUrl
              : null);

  PlatformFile? addedFile; //if studymaterial type is fileUpload
  PlatformFile?
      addedVideoThumbnailFile; //if studymaterial type is not fileUpload
  PlatformFile? addedVideoFile; //if studymaterial type is videoUpload

  Future<bool> _isPermissionGiven() async {
    bool permissionGiven = (await Permission.storage.status).isGranted;
    if (!permissionGiven) {
      permissionGiven = (await Permission.storage.request()).isGranted;
    }
    return permissionGiven;
  }

  void showErrorMessage(String messageKey) {
    UiUtils.showErrorMessageContainer(
        context: context,
        errorMessage: UiUtils.getTranslatedLabel(context, messageKey),
        backgroundColor: Theme.of(context).colorScheme.error);
  }

  void addStudyMaterial() {
    if (_studyMaterialNameEditingController.text.trim().isEmpty) {
      showErrorMessage(pleaseEnterStudyMaterialNameKey);
      return;
    }

    if (widget.studyMaterial.studyMaterialType == StudyMaterialType.file &&
        addedFile == null) {
      showErrorMessage(pleaseSelectFileKey);
      return;
    }

    if (widget.studyMaterial.studyMaterialType != StudyMaterialType.file &&
        addedVideoThumbnailFile == null) {
      showErrorMessage(pleaseSelectThumbnailImageKey);
      return;
    }

    if (widget.studyMaterial.studyMaterialType ==
            StudyMaterialType.youtubeVideo &&
        _youtubeLinkEditingController.text.trim().isEmpty) {
      showErrorMessage(pleaseEnterYoutubeLinkKey);
      return;
    }

    if (widget.studyMaterial.studyMaterialType ==
            StudyMaterialType.uploadedVideoUrl &&
        addedVideoFile == null) {
      showErrorMessage(pleaseSelectVideoKey);
      return;
    }

    //TODO: edit study material
    Navigator.of(context).pop();
  }

  Widget _buildAddedFileContainer(PlatformFile file, Function onTap) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: [10, 10],
        radius: Radius.circular(10.0),
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 10),
          child: Row(
            children: [
              SizedBox(
                width: boxConstraints.maxWidth * (0.75),
                child: Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    onTap();
                  },
                  icon: Icon(Icons.close)),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetTopBarMenu(
                    onTapCloseButton: () {
                      Navigator.of(context).pop();
                    },
                    title: UiUtils.getTranslatedLabel(
                        context, editStudyMaterialKey)),
                Padding(
                    child: Column(
                      children: [
                        LayoutBuilder(builder: (context, boxConstraints) {
                          //Study material type dropdown list
                          return DefaultDropDownLabelContainer(
                              titleLabelKey:
                                  UiUtils.getStudyMaterialTypeLabelByEnum(
                                      widget.studyMaterial.studyMaterialType,
                                      context),
                              width: boxConstraints.maxWidth);
                        }),
                        BottomSheetTextFieldContainer(
                            margin: EdgeInsets.only(bottom: 25),
                            hintText: UiUtils.getTranslatedLabel(
                                context, studyMaterialNameKey),
                            maxLines: 1,
                            textEditingController:
                                _studyMaterialNameEditingController),

                        //
                        //if file or images has been picked then show the pickedFile name and remove button
                        //else show file picker option
                        //
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: addedFile != null
                              ? _buildAddedFileContainer(addedFile!, () {
                                  addedFile = null;
                                  setState(() {});
                                })
                              : addedVideoThumbnailFile != null
                                  ? _buildAddedFileContainer(
                                      addedVideoThumbnailFile!, () {
                                      addedVideoThumbnailFile = null;
                                      setState(() {});
                                    })
                                  : BottomsheetAddFilesDottedBorderContainer(
                                      onTap: () async {
                                        if (await _isPermissionGiven()) {
                                          final pickedFile = await FilePicker
                                              .platform
                                              .pickFiles(
                                                  type: widget.studyMaterial
                                                              .studyMaterialType ==
                                                          StudyMaterialType.file
                                                      ? FileType.any
                                                      : FileType.image);
                                          //
                                          //
                                          if (pickedFile != null) {
                                            //if current selected study material type is file
                                            if (widget.studyMaterial
                                                    .studyMaterialType ==
                                                StudyMaterialType.file) {
                                              addedFile =
                                                  pickedFile.files.first;
                                            } else {
                                              addedVideoThumbnailFile =
                                                  pickedFile.files.first;
                                            }

                                            setState(() {});
                                          }
                                        } else {
                                          showErrorMessage(
                                              permissionToPickFileKey);
                                        }
                                      },
                                      title: widget.studyMaterial
                                                  .studyMaterialType ==
                                              StudyMaterialType.file
                                          ? UiUtils.getTranslatedLabel(
                                              context, selectFileKey)
                                          : UiUtils.getTranslatedLabel(
                                              context, selectThumbnailKey)),
                        ),

                        widget.studyMaterial.studyMaterialType ==
                                StudyMaterialType.youtubeVideo
                            ? BottomSheetTextFieldContainer(
                                margin: EdgeInsets.only(bottom: 25),
                                hintText: UiUtils.getTranslatedLabel(
                                    context, youtubeLinkKey),
                                maxLines: 2,
                                textEditingController:
                                    _youtubeLinkEditingController)
                            : widget.studyMaterial.studyMaterialType ==
                                    StudyMaterialType.uploadedVideoUrl
                                ? addedVideoFile != null
                                    ? _buildAddedFileContainer(addedVideoFile!,
                                        () {
                                        addedVideoFile = null;
                                        setState(() {});
                                      })
                                    : BottomsheetAddFilesDottedBorderContainer(
                                        onTap: () async {
                                          if (await _isPermissionGiven()) {
                                            final pickedFile = await FilePicker
                                                .platform
                                                .pickFiles(
                                                    type: FileType.video);

                                            if (pickedFile != null) {
                                              addedVideoFile =
                                                  pickedFile.files.first;
                                              setState(() {});
                                            }
                                          } else {
                                            showErrorMessage(
                                                permissionToPickFileKey);
                                          }
                                        },
                                        title: widget.studyMaterial
                                                    .studyMaterialType ==
                                                StudyMaterialType.file
                                            ? UiUtils.getTranslatedLabel(
                                                context, selectFileKey)
                                            : UiUtils.getTranslatedLabel(
                                                context, selectVideoKey))
                                : SizedBox(),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            UiUtils.bottomSheetHorizontalContentPadding)),
                CustomRoundedButton(
                    onTap: () {},
                    height: UiUtils.bottomSheetButtonHeight,
                    widthPercentage: UiUtils.bottomSheetButtonWidthPercentage,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    buttonTitle: UiUtils.getTranslatedLabel(context, submitKey),
                    showBorder: false),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          return Future.value(true);
        });
  }
}
