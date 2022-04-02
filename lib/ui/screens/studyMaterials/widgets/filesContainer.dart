import 'package:eschool_teacher/ui/widgets/dismissibleBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/dismissibleSecondaryBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/downloadFileButton.dart';
import 'package:eschool_teacher/ui/widgets/shareButton.dart';
import 'package:flutter/material.dart';

class FilesContainer extends StatefulWidget {
  FilesContainer({Key? key}) : super(key: key);

  @override
  State<FilesContainer> createState() => _FilesContainerState();
}

class _FilesContainerState extends State<FilesContainer> {
  Widget _buildFileDetailsContainer() {
    return Dismissible(
      key: Key("File title/name"),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          print("Delete");
        } else if (direction == DismissDirection.startToEnd) {
          print("Edit");
        }
        return Future.value(false);
      },
      background: DismissibleBackgroundContainer(),
      secondaryBackground: DismissibleSecondaryBackgroundContainer(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                offset: Offset(5, 5),
                blurRadius: 10,
                spreadRadius: 0)
          ],
        ),
        height: 90,
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return Row(
            children: [
              SizedBox(
                width: boxConstraints.maxWidth * (0.6),
                child: Text(
                  "Chapter 1 : Organic chemsitry,  carbon and its compounds",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0),
                ),
              ),
              Spacer(),
              DownloadFileButton(),
              SizedBox(
                width: boxConstraints.maxWidth * (0.05),
              ),
              ShareButton(),
            ],
          );
        }),
        width: MediaQuery.of(context).size.width * (0.85),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildFileDetailsContainer()],
    );
  }
}
