import 'package:flutter/material.dart';
import 'package:flutter_boiler/share/utils/app_localizations.dart';
import 'package:flutter_boiler/share/utils/size_config.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// app translate
  t(String key) => AppLocalizations.of(this).translate(key);

  /// size config
  SizeConfig get s => SizeConfig();
}
