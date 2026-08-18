import 'package:flutter/material.dart';

import 'native_capability.dart';

class PlatformIntegrationApp extends StatelessWidget {
  const PlatformIntegrationApp({required this.service, super.key});

  final SafePlatformService service;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NativeCapabilityScreen(service: service),
    );
  }
}

class NativeCapabilityScreen extends StatefulWidget {
  const NativeCapabilityScreen({required this.service, super.key});

  final SafePlatformService service;

  @override
  State<NativeCapabilityScreen> createState() => _NativeCapabilityScreenState();
}

class _NativeCapabilityScreenState extends State<NativeCapabilityScreen> {
  bool _busy = false;
  String _message = 'Native capability has not been requested yet.';

  Future<void> _load() async {
    if (_busy) return;
    setState(() => _busy = true);

    final message = await widget.service.loadPlatformLabel();
    if (!mounted) return;

    setState(() {
      _busy = false;
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Platform Capability Boundary')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _message,
                key: const ValueKey('platform-message'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                key: const ValueKey('load-platform'),
                onPressed: _busy ? null : _load,
                icon: const Icon(Icons.devices),
                label: Text(_busy ? 'Loading…' : 'Request platform name'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
