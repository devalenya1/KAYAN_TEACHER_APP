import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTopBarMenu.dart';
import 'package:eschool_teacher/ui/widgets/bottomsheetAddFilesDottedBorderContainer.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AddStudyMaterialBottomsheet extends StatefulWidget {
  final Function onTapAddFile;
  final bool editFileDetails;
  final int? fileIndex;
  AddStudyMaterialBottomsheet({
    Key? key,
    this.fileIndex,
    required this.editFileDetails,
    required this.onTapAddFile,
  }) : super(key: key);

  @override
  State<AddStudyMaterialBottomsheet> createState() =>
      _AddStudyMaterialBottomsheetState();
}

class _AddStudyMaterialBottomsheetState
    extends State<AddStudyMaterialBottomsheet> {
  late String currentSelectedItem =
      UiUtils.getTranslatedLabel(context, fileUploadKey);

  late TextEditingController _fileNameEditingController =
      TextEditingController();

  late TextEditingController _youtubeLinkEditingController =
      TextEditingController();

  @override
  void dispose() {
    _fileNameEditingController.dispose();
    _youtubeLinkEditingController.dispose();
    super.dispose();
  }

  Future<bool> _isPermissionGiven() async {
    bool permissionGiven = (await Permission.storage.status).isGranted;
    if (!permissionGiven) {
      permissionGiven = (await Permission.storage.request()).isGranted;
    }
    return permissionGiven;
  }

  File? addedFile;
  File? addedVideoThumbnailFile;
  File? addedVideoFile;

  Widget _buildAddedFileContainer(File file, Function onTap) {
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
                  file.path,
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
                        context, addStudyMaterialKey)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: UiUtils.bottomSheetHorizontalContentPadding),
                  child: Column(
                    children: [
                      LayoutBuilder(builder: (context, boxConstraints) {
                        return CustomDropDownMenu(
                            onChanged: (value) {
                              setState(() {
                                currentSelectedItem = value!;
                                addedFile = null;
                                addedVideoFile = null;
                                addedVideoThumbnailFile = null;
                              });
                            },
                            textStyle: TextStyle(
                                color: hintTextColor,
                                fontSize: UiUtils.textFieldFontSize),
                            borderRadius: 10,
                            height: 50,
                            width: boxConstraints.maxWidth,
                            menu: [
                              UiUtils.getTranslatedLabel(
                                  context, fileUploadKey),
                              UiUtils.getTranslatedLabel(
                                  context, youtubeLinkKey),
                              UiUtils.getTranslatedLabel(
                                  context, videoUploadKey)
                            ],
                            currentSelectedItem: currentSelectedItem);
                      }),
                      BottomSheetTextFieldContainer(
                          margin: EdgeInsets.only(bottom: 25),
                          hintText:
                              UiUtils.getTranslatedLabel(context, fileNameKey),
                          maxLines: 1,
                          textEditingController: _fileNameEditingController),

                      //if selected file is not null
                      addedFile != null
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
                                      final pickedFile =
                                          await FilePicker.platform.pickFiles(
                                              type: currentSelectedItem ==
                                                      UiUtils
                                                          .getTranslatedLabel(
                                                              context,
                                                              fileUploadKey)
                                                  ? FileType.any
                                                  : FileType.image);
                                      //
                                      //
                                      if (pickedFile != null) {
                                        //if current selected study material type is file
                                        if (currentSelectedItem ==
                                            UiUtils.getTranslatedLabel(
                                                context, fileUploadKey)) {
                                          addedFile =
                                              File(pickedFile.files.first.name);
                                        } else {
                                          addedVideoThumbnailFile =
                                              File(pickedFile.files.first.name);
                                        }

                                        setState(() {});
                                      }
                                    } else {
                                      print("Please give permission");
                                    }
                                  },
                                  title: currentSelectedItem ==
                                          UiUtils.getTranslatedLabel(
                                              context, fileUploadKey)
                                      ? UiUtils.getTranslatedLabel(
                                          context, selectFileKey)
                                      : UiUtils.getTranslatedLabel(
                                          context, selectThumbnailKey)),

                      SizedBox(
                        height: 25,
                      ),

                      currentSelectedItem ==
                              UiUtils.getTranslatedLabel(
                                  context, youtubeLinkKey)
                          ? BottomSheetTextFieldContainer(
                              margin: EdgeInsets.only(bottom: 25),
                              hintText: UiUtils.getTranslatedLabel(
                                  context, youtubeLinkKey),
                              maxLines: 1,
                              textEditingController:
                                  _youtubeLinkEditingController)
                          : currentSelectedItem ==
                                  UiUtils.getTranslatedLabel(
                                      context, videoUploadKey)
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
                                              .pickFiles(type: FileType.video);

                                          if (pickedFile != null) {
                                            addedVideoFile = File(
                                                pickedFile.files.first.name);
                                            setState(() {});
                                          }
                                        } else {
                                          print("Please give permission");
                                        }
                                      },
                                      title: currentSelectedItem ==
                                              UiUtils.getTranslatedLabel(
                                                  context, fileUploadKey)
                                          ? UiUtils.getTranslatedLabel(
                                              context, selectFileKey)
                                          : UiUtils.getTranslatedLabel(
                                              context, selectVideoKey))
                              : SizedBox(),

                      SizedBox(
                        height: 25,
                      ),

                      CustomRoundedButton(
                          onTap: () {},
                          height: UiUtils.bottomSheetButtonHeight,
                          widthPercentage:
                              UiUtils.bottomSheetButtonWidthPercentage,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          buttonTitle:
                              UiUtils.getTranslatedLabel(context, submitKey),
                          showBorder: false),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
        onWillPop: () => Future.value(true));
  }
}
