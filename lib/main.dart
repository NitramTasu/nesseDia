import 'package:flutter/material.dart';
import 'package:nesse_dia/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => initializeDateFormatting("fr_FR", null)
    .then((_) => runApp(ModularApp(module: AppModule())));
