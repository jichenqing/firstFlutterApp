import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/settings/settings_controller.dart';

/// provides the theme controller to any page of your app
class SettingsControllerProvider extends InheritedWidget {
  const SettingsControllerProvider(
      {required Key key, required this.controller, required Widget child})
      : super(key: key, child: child);

  final SettingsController controller;

  @override
  bool updateShouldNotify(SettingsControllerProvider oldWidget) =>
      controller != oldWidget.controller;
}
