import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

  late Animation<double> _patterntAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.0, 0.5, curve: Curves.easeInOut)));

  late Animation<double> _formAnimation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildUpperPattern() {
    return Align(
      alignment: Alignment.topRight,
      child: FadeTransition(
        opacity: _patterntAnimation,
        child: SlideTransition(
            position: _patterntAnimation.drive(
                Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)),
            child: Image.asset(UiUtils.getImagePath("upper_pattern.png"))),
      ),
    );
  }

  Widget _buildLowerPattern() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: FadeTransition(
        opacity: _patterntAnimation,
        child: SlideTransition(
            position: _patterntAnimation.drive(
                Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)),
            child: Image.asset(UiUtils.getImagePath("lower_pattern.png"))),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Align(
      alignment: Alignment.topLeft,
      child: FadeTransition(
        opacity: _formAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * (0.075),
              right: MediaQuery.of(context).size.width * (0.075),
              top: MediaQuery.of(context).size.height * (0.3)),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  UiUtils.getTranslatedLabel(context, letsSignInKey),
                  style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: UiUtils.getColorScheme(context).secondary),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${UiUtils.getTranslatedLabel(context, welcomeBackKey)}, \n${UiUtils.getTranslatedLabel(context, youHaveBeenMissedKey)}",
                  style: TextStyle(
                      fontSize: 24.0,
                      height: 1.5,
                      color: UiUtils.getColorScheme(context).secondary),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: UiUtils.getColorScheme(context).secondary)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            UiUtils.getImagePath("mail_icon.svg"),
                            color: UiUtils.getColorScheme(context).secondary,
                          ),
                        ),
                        hintStyle: TextStyle(
                            color: UiUtils.getColorScheme(context).secondary),
                        hintText: UiUtils.getTranslatedLabel(context, emailKey),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: UiUtils.getColorScheme(context).secondary)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            UiUtils.getImagePath("password.svg"),
                            color: UiUtils.getColorScheme(context).secondary,
                          ),
                        ),
                        hintStyle: TextStyle(
                            color: UiUtils.getColorScheme(context).secondary),
                        hintText:
                            UiUtils.getTranslatedLabel(context, passwordKey),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: CustomRoundedButton(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(Routes.home);
                    },
                    widthPercentage: 0.8,
                    backgroundColor: UiUtils.getColorScheme(context).primary,
                    buttonTitle: UiUtils.getTranslatedLabel(context, signInKey),
                    titleColor: Theme.of(context).scaffoldBackgroundColor,
                    showBorder: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildUpperPattern(),
          _buildLowerPattern(),
          _buildLoginForm(),
        ],
      ),
    );
  }
}
