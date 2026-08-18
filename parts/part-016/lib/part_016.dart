import 'package:flutter/material.dart';

import 'counter_controller.dart';
import 'counter_state.dart';

class StateManagementApp extends StatelessWidget {
  const StateManagementApp({required this.controller, super.key});

  final CounterController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(controller: controller),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({required this.controller, super.key});

  final CounterController controller;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('State Management Architecture')),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final state = widget.controller.state;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.phase == CounterPhase.loading)
                    const CircularProgressIndicator()
                  else ...[
                    Text('Count: ${state.count}', key: const ValueKey('count-text')),
                    const SizedBox(height: 16),
                    FilledButton(
                      key: const ValueKey('increment-button'),
                      onPressed: widget.controller.increment,
                      child: const Text('Increment'),
                    ),
                  ],
                  if (state.message != null) ...[
                    const SizedBox(height: 16),
                    Semantics(
                      liveRegion: true,
                      child: Text(state.message!, key: const ValueKey('state-message')),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
