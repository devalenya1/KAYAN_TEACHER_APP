import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrEditTopicScreen extends StatefulWidget {
  AddOrEditTopicScreen({Key? key}) : super(key: key);

  static Route<dynamic> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) =>
            MultiBlocProvider(providers: [], child: AddOrEditTopicScreen()));
  }

  @override
  State<AddOrEditTopicScreen> createState() => _AddOrEditTopicScreenState();
}

class _AddOrEditTopicScreenState extends State<AddOrEditTopicScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox());
  }
}
