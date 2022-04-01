import 'package:eschool_teacher/ui/screens/assignments/widgets/assignmentDetailsBottomsheetContainer.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class AssignmentContainer extends StatefulWidget {
  AssignmentContainer({Key? key}) : super(key: key);

  @override
  State<AssignmentContainer> createState() => _AssignmentContainerState();
}

class _AssignmentContainerState extends State<AssignmentContainer> {
  void showAssignmentBottomSheet() {
    showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(UiUtils.bottomSheetTopRadius),
          topRight: Radius.circular(UiUtils.bottomSheetTopRadius),
        )),
        context: context,
        builder: (_) => AssignmentDetailsBottomsheetContainer());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          showAssignmentBottomSheet();
        },
        child: Dismissible(
          confirmDismiss: (direction) {
            if (direction == DismissDirection.endToStart) {
              print("Delete");
            } else if (direction == DismissDirection.startToEnd) {
              print("Edit");
            }
            return Future.value(false);
          },
          background: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                Spacer(),
                Icon(
                  Icons.delete,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Delete",
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary),
          ),
          key: Key("1"),
          child: Container(
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.05),
                      offset: Offset(2.5, 2.5),
                      blurRadius: 10,
                      spreadRadius: 0)
                ],
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width * (0.85),
            padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 17.5),
            child: LayoutBuilder(builder: (context, boxConstraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assignment name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Due, 16 Feb, 2020, 1:30 PM",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                          fontSize: 11.0))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
