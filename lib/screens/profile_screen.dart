import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projects/core/theme/theme_controller.dart';
import 'package:projects/core/widgets/custom_svg_image.dart';
import 'package:projects/screens/user_details_screen.dart';
import 'package:projects/screens/welcome_screen.dart';
import '../core/services/preferences_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "Guest";
  late String motivationQuote;
  String? userImagePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      username = PreferencesManager().getString("username") ?? "Guest";
      motivationQuote = PreferencesManager().getString("motivationQuote") ?? "One task at a time. One step closer.";
      userImagePath = PreferencesManager().getString("user_image");
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "My Profile",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: userImagePath != null
                                ? FileImage(File(userImagePath!))
                                : null,
                            child: userImagePath == null
                                ? ClipOval(
                                    child: SvgPicture.asset(
                                      'assets/images/default_avatar.svg',
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  )
                                : null,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showImageSourceDialog(
                                  context,
                                  (XFile file) {
                                    _saveImage(file);
                                    setState(() {
                                      userImagePath = file.path;
                                    });
                                  }
                              );
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                              child: Icon(Icons.camera_alt, size: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: 4),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 24),
          Text("Profile Info", style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: 24),
          ListTile(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserDetailsScreen()),
              );

              if (result == true && result != null) {
                _loadData();
              }
            },
            contentPadding: EdgeInsets.zero,
            title: Text(
              "User Details",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: CustomSvgImage(img: 'assets/images/user_details.svg'),
            trailing: CustomSvgImage(img: 'assets/images/right_arrow.svg'),
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Dark Mode",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: CustomSvgImage(img: 'assets/images/dark_mode.svg'),
            trailing: ValueListenableBuilder(
              valueListenable: ThemeController.themeNotifier,
              builder: (BuildContext context, ThemeMode value, Widget? child) {
                return Switch(
                  value: value == ThemeMode.dark,
                  onChanged: (bool value) {
                    ThemeController.themeToggle();
                  },
                );
              },
            ),
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          ListTile(
            onTap: () async {
              PreferencesManager().remove('username');
              PreferencesManager().remove('tasks');
              PreferencesManager().remove('motivationQuote');

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false,
              );
            },
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Log Out",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: CustomSvgImage(img: 'assets/images/log_out.svg'),
            trailing: CustomSvgImage(img: 'assets/images/right_arrow.svg'),
          ),
        ],
      ),
    );
  }

  void _saveImage(XFile file) async{
    final appDir = await getApplicationCacheDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString('user_image', newFile.path);
  }
}

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          'Select Image Source',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(16.0),
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 16),
                Text('Camera'),
              ],
            ),
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(16.0),
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedFile(image);
              }
            },
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 16),
                Text('Gallery'),
              ],
            ),
          ),
        ],
      );
    },
  );
}
