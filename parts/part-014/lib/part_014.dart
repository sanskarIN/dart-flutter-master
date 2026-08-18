import 'package:flutter/material.dart';

import 'validators.dart';

typedef ProfileSubmitter = Future<void> Function({
  required String name,
  required String email,
});

class FormsMasteryApp extends StatelessWidget {
  const FormsMasteryApp({super.key, this.submitter});

  final ProfileSubmitter? submitter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileFormScreen(submitter: submitter ?? _demoSubmitter),
    );
  }

  static Future<void> _demoSubmitter({
    required String name,
    required String email,
  }) async {}
}

class ProfileFormScreen extends StatefulWidget {
  const ProfileFormScreen({required this.submitter, super.key});

  final ProfileSubmitter submitter;

  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _submitting = false;
  String? _statusMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting || !(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _submitting = true;
      _statusMessage = null;
    });

    try {
      await widget.submitter(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );
      if (!mounted) return;
      setState(() => _statusMessage = 'Profile submitted successfully.');
    } catch (_) {
      if (!mounted) return;
      setState(() => _statusMessage = 'Submission failed. Please try again.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validated Profile Form')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    key: const ValueKey('name-field'),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: validateName,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const ValueKey('email-field'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: validateEmail,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    key: const ValueKey('submit-button'),
                    onPressed: _submitting ? null : _submit,
                    child: Text(_submitting ? 'Submitting…' : 'Submit'),
                  ),
                ],
              ),
            ),
            if (_statusMessage != null) ...[
              const SizedBox(height: 16),
              Semantics(
                liveRegion: true,
                child: Text(
                  _statusMessage!,
                  key: const ValueKey('status-message'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
