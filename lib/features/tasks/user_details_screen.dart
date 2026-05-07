import 'package:flutter/material.dart';
import 'package:projects/core/widgets/custom_elevated_button.dart';
import 'package:projects/core/widgets/custom_text_form_field.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController motivationQuoteController =
      TextEditingController();

  String username = "Guest";
  String motivationQuote = "One task at a time. One step closer.";

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      username = PreferencesManager().getString(StorageKey.username) ?? "Guest";
      userNameController.text = username;
      motivationQuote =
          PreferencesManager().getString(StorageKey.motivationQuote) ??
          "One task at a time. One step closer.";
      motivationQuoteController.text = motivationQuote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Details",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: userNameController,
                    hintText: username,
                    title: 'User Name',
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    controller: motivationQuoteController,
                    title: 'Motivation Quote',
                    hintText: motivationQuote,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: CustomElevatedButton(
                onPressed: () async {
                  PreferencesManager().setString(
                    StorageKey.username,
                    userNameController.text,
                  );
                  PreferencesManager().setString(
                    StorageKey.motivationQuote,
                    motivationQuoteController.text,
                  );
                  Navigator.pop(context, true);
                },
                title: 'Save Changes',
                width: MediaQuery.of(context).size.width,
                height: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
