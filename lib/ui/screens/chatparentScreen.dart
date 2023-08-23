import 'package:eschool_teacher/cubits/appConfigurationCubit.dart';
import 'package:eschool_teacher/cubits/timeTableCubit.dart';
import 'package:eschool_teacher/data/repositories/teacherRepository.dart';
import 'package:eschool_teacher/ui/screens/home/widgets/appUnderMaintenanceContainer.dart';
import 'package:eschool_teacher/ui/screens/home/widgets/bottomNavigationItemContainer.dart';
import 'package:eschool_teacher/ui/screens/home/widgets/forceUpdateDialogContainer.dart';
import 'package:eschool_teacher/ui/screens/home/widgets/homeContainer.dart';
import 'package:eschool_teacher/ui/screens/home/widgets/profileContainer.dart';
import 'package:eschool_teacher/ui/screens/home/widgets/timeTableContainer.dart';
import 'package:eschool_teacher/ui/screens/home/widgets/settingsContainer.dart';

import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';


class ChatparentScreen extends StatefulWidget {
  ChatparentScreen({Key? key}) : super(key: key);

  @override
  State<ChatparentScreen> createState() => _ChatparentScreenState();

  static Route route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider<AppSettingsCubit>(
              create: (context) => AppSettingsCubit(SystemRepository()),
              child: ChatparentScreen(),
            ),);
  }
}


class _ChatparentScreenState extends State<ChatparentScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          CustomAppBar(title: const Text('Chat'),),
         //appBar: AppBar(title: const Text('Chat'),),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: ('https://kayan-bh.com/chat/chat-teacher/user.php?email=${context.read<AuthCubit>().getTeacherDetails().email}'),

            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          );
        }));
  }


}
