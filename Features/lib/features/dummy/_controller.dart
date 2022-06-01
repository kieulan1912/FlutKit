import 'dart:developer';

import 'package:flutkit_feature/features/firebase/views/login_screen.dart';
import 'package:flutkit_feature/features/firebase/views/register_screen.dart';
import 'package:flutkit_feature/features/firebase/views/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:quick_actions/quick_actions.dart';

class Controller extends FxController {

  Controller() {
    save = false;

  }

  @override
  String getTag() {
    return "_controller";
  }
}
