import 'package:flutter/material.dart';

import 'api_controller.dart';
import 'api_transport.dart';
import 'app.dart';

void main() {
  runApp(
    ApiExplorerApp(
      controller: ApiController(transport: const DemoApiTransport()),
    ),
  );
}
