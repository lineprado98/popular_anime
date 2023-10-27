import 'package:flutter/material.dart';
import 'package:popular_anime/app/core/utils/service_locator.dart';

import 'app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.setup();
  runApp(const MyApp());
}
