import 'package:flutter/material.dart';

import 'native_capability.dart';
import 'part_019.dart';

void main() {
  runApp(
    PlatformIntegrationApp(
      service: SafePlatformService(MethodChannelNativeCapability()),
    ),
  );
}
