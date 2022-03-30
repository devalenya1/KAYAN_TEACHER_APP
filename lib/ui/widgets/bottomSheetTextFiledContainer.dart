import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class BottomSheetTextFieldContainer extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Alignment? contentAlignment;
  final EdgeInsets? contentPadding;
  final double? height;
  final int? maxLines;

  const BottomSheetTextFieldContainer(
      {Key? key,
      required this.hintText,
      required this.maxLines,
      required this.textEditingController,
      this.height,
      this.contentAlignment,
      this.contentPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: contentAlignment ?? Alignment.center,
      padding: contentPadding ?? EdgeInsets.only(left: 20.0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: height,
    );
  }
}
