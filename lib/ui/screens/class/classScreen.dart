import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/cubits/studentsByClassSectionCubit.dart';
import 'package:eschool_teacher/cubits/subjectsOfClassSectionCubit.dart';
import 'package:eschool_teacher/data/models/classSectionDetails.dart';
import 'package:eschool_teacher/data/repositories/studentRepository.dart';
import 'package:eschool_teacher/data/repositories/teacherRepository.dart';
import 'package:eschool_teacher/ui/screens/class/widgets/studentsContainer.dart';
import 'package:eschool_teacher/ui/screens/class/widgets/subjectsContainer.dart';
import 'package:eschool_teacher/ui/widgets/appBarTitleContainer.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customTabBarContainer.dart';
import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/svgButton.dart';
import 'package:eschool_teacher/ui/widgets/tabBarBackgroundContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ClassScreen extends StatefulWidget {
  final bool isClassTeacher;
  final ClassSectionDetails classSection;
  ClassScreen(
      {Key? key, required this.isClassTeacher, required this.classSection})
      : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();

  static Route<ClassScreen> route(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments as Map<String, dynamic>;
    return CupertinoPageRoute(
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      SubjectsOfClassSectionCubit(TeacherRepository()),
                ),
                BlocProvider(
                  create: (context) =>
                      StudentsByClassSectionCubit(StudentRepository()),
                ),
              ],
              child: ClassScreen(
                classSection: arguments['classSection'],
                isClassTeacher: arguments['isClassTeacher'],
              ),
            ));
  }
}

class _ClassScreenState extends State<ClassScreen> {
  late final ScrollController _scrollController = ScrollController()
    ..addListener(_studentsScrollListener);

  void _studentsScrollListener() {
    if (!widget.isClassTeacher) {
      return;
    }
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      if (context.read<StudentsByClassSectionCubit>().hasMore()) {
        context.read<StudentsByClassSectionCubit>().fetchMoreStudents(
              classSectionId: widget.classSection.id,
            );
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context
          .read<SubjectsOfClassSectionCubit>()
          .fetchSubjects(widget.classSection.id);
      if (widget.isClassTeacher) {
        context
            .read<StudentsByClassSectionCubit>()
            .fetchStudents(classSectionId: widget.classSection.id);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_studentsScrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  late String _selectedTabTitle = studentsKey;
  Widget _buildAppbar() {
    return widget.isClassTeacher
        ? Align(
            alignment: Alignment.topCenter,
            child: ScreenTopBackgroundContainer(
              child: LayoutBuilder(builder: (context, boxConstraints) {
                return Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        child: SvgButton(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            svgIconUrl: UiUtils.getImagePath("back_icon.svg")),
                        padding: EdgeInsets.only(
                            left: UiUtils.screenContentHorizontalPadding),
                      ),
                    ),
                    AppBarTitleContainer(
                        boxConstraints: boxConstraints,
                        title:
                            "${UiUtils.getTranslatedLabel(context, classKey)} ${widget.classSection.classDetails.name} - ${widget.classSection.sectionDetails.name}"),
                    AnimatedAlign(
                      curve: UiUtils.tabBackgroundContainerAnimationCurve,
                      duration: UiUtils.tabBackgroundContainerAnimationDuration,
                      alignment: _selectedTabTitle == studentsKey
                          ? AlignmentDirectional.centerStart
                          : AlignmentDirectional.centerEnd,
                      child: TabBackgroundContainer(
                          boxConstraints: boxConstraints),
                    ),
                    CustomTabBarContainer(
                        boxConstraints: boxConstraints,
                        alignment: AlignmentDirectional.centerStart,
                        isSelected: _selectedTabTitle == studentsKey,
                        onTap: () {
                          setState(() {
                            _selectedTabTitle = studentsKey;
                          });
                        },
                        titleKey: studentsKey),
                    CustomTabBarContainer(
                        boxConstraints: boxConstraints,
                        alignment: AlignmentDirectional.centerEnd,
                        isSelected: _selectedTabTitle == subjectsKey,
                        onTap: () {
                          setState(() {
                            _selectedTabTitle = subjectsKey;
                          });
                        },
                        titleKey: subjectsKey),
                  ],
                );
              }),
            ),
          )
        : Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
                subTitle: UiUtils.getTranslatedLabel(context, subjectsKey),
                title:
                    "${UiUtils.getTranslatedLabel(context, classKey)} ${widget.classSection.classDetails.name} - ${widget.classSection.sectionDetails.name}"),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isClassTeacher
          ? FloatingActionButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  UiUtils.getImagePath("take_attendance.svg"),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.takeAttendance);
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
            )
          : SizedBox(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * (0.075),
                  right: MediaQuery.of(context).size.width * (0.075),
                  top: UiUtils.getScrollViewTopPadding(
                      context: context,
                      appBarHeightPercentage:
                          UiUtils.appBarBiggerHeightPercentage)),
              child: widget.isClassTeacher
                  ? _selectedTabTitle == subjectsKey
                      ? SubjectsContainer(
                          classSectionDetails: widget.classSection,
                        )
                      : StudentsContainer(
                          classSectionDetails: widget.classSection,
                        )
                  : SubjectsContainer(
                      classSectionDetails: widget.classSection,
                    ),
            ),
          ),
          _buildAppbar(),
        ],
      ),
    );
  }
}
