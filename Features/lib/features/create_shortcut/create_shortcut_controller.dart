import 'dart:developer';

import 'package:flutkit_feature/features/firebase/views/login_screen.dart';
import 'package:flutkit_feature/features/firebase/views/register_screen.dart';
import 'package:flutkit_feature/features/firebase/views/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:quick_actions/quick_actions.dart';

class Controller extends FxController {
  late QuickActions quickActions;

  Controller() {
    save = false;

    quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      if (shortcutType == "action_two") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FirebaseRegisterScreen()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FirebaseLoginScreen()));
      }
    });
  }

  createShortcuts() async {
    try {
      log("ee");

      await quickActions.setShortcutItems(<ShortcutItem>[
        // NOTE: This first action icon will only work on iOS.
        // In a real world project keep the same file name for both platforms.
        const ShortcutItem(
          type: 'action_one',
          localizedTitle: 'Login',
          icon: 'AppIcon',
        ),
        // NOTE: This second action icon will only work on Android.
        // In a real world project keep the same file name for both platforms.
        const ShortcutItem(
            type: 'action_two',
            localizedTitle: 'Register',
            icon: 'ic_launcher'),
      ]);
    } catch (e) {
      log(e.toString());
    }

    showSnackBar('Shortcut is created');
  }

  deleteShortcuts() async {
    await quickActions.clearShortcutItems();
    showSnackBar('Shortcut is deleted');
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  String getTag() {
    return "create_shortcut_controller";
  }
}
