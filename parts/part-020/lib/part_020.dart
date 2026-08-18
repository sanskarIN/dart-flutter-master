import 'dart:math' as math;

import 'package:flutter/material.dart';

class MotionMasteryApp extends StatelessWidget {
  const MotionMasteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MotionDemoScreen(),
    );
  }
}

class MotionDemoScreen extends StatefulWidget {
  const MotionDemoScreen({super.key});

  @override
  State<MotionDemoScreen> createState() => _MotionDemoScreenState();
}

class _MotionDemoScreenState extends State<MotionDemoScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _play() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Motion & Custom Painting')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _curve,
              builder: (context, child) {
                return Semantics(
                  label: 'Animation progress ${(_curve.value * 100).round()} percent',
                  child: CustomPaint(
                    key: const ValueKey('progress-paint'),
                    size: const Size.square(180),
                    painter: ProgressRingPainter(
                      progress: _curve.value,
                      color: colors.primary,
                      trackColor: colors.surfaceContainerHighest,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              key: const ValueKey('play-motion'),
              onPressed: _play,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Play finite animation'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressRingPainter extends CustomPainter {
  const ProgressRingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
  });

  final double progress;
  final Color color;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 10;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2 * progress.clamp(0.0, 1.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressRingPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        color != oldDelegate.color ||
        trackColor != oldDelegate.trackColor;
  }
}
