import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projects/core/widgets/custom_svg_image.dart';
import 'package:projects/core/widgets/custom_text_form_field.dart';
import 'package:projects/screens/main_screen.dart';
import '../core/services/preferences_manager.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgImage.withoutColor(
                      img: 'assets/images/logo.svg',
                    ),
                    // SvgPicture.asset(
                    //   "assets/images/logo.svg",
                    //   width: 42.0,
                    //   height: 42.0,
                    // ),
                    SizedBox(width: 16.0),
                    Text(
                      "Tasky",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 150.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(width: 8.0),
                    CustomSvgImage.withoutColor(
                      img: "assets/images/waving_hand.svg",
                                         ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  "Your productivity journey starts here.",
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 16.0),
                ),
                SizedBox(height: 24.0),
                SvgPicture.asset(
                  "assets/images/welcome_img.svg",
                  width: 215.0,
                  height: 205.0,
                ),
                SizedBox(height: 28.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: controller,
                        title: 'Full Name',
                        hintText: 'e.g. Mohammed Elshafey',
                        maxLines: 1,
                        validator: (value) {
                          if (value?.trim().isEmpty ?? false) {
                            return "Please enter your name";
                          }
                          print(value);
                        },
                      ),
                      SizedBox(height: 34.0),
                      ElevatedButton(
                        onPressed: () async {
                          _key.currentState?.validate();
                          if (controller.text.trim().isNotEmpty) {
                            PreferencesManager().setString(
                              "username",
                              controller.text,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff15B86C),
                          foregroundColor: Color(0xffFFFCFC),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40.0,
                          ),
                        ),
                        child: Text(
                          'Let’s Get Started',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFFFCFC),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
