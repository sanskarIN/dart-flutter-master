import 'package:flutter/services.dart';

abstract interface class NativeCapability {
  Future<String> platformName();
}

class MethodChannelNativeCapability implements NativeCapability {
  MethodChannelNativeCapability({
    MethodChannel channel = const MethodChannel('dart_flutter_master/native'),
  }) : _channel = channel;

  final MethodChannel _channel;

  @override
  Future<String> platformName() async {
    final result = await _channel.invokeMethod<String>('platformName');
    final normalized = result?.trim();
    if (normalized == null || normalized.isEmpty) {
      throw const PlatformException(
        code: 'invalid_response',
        message: 'Native platform name was empty.',
      );
    }
    return normalized;
  }
}

class SafePlatformService {
  SafePlatformService(this._capability);

  final NativeCapability _capability;

  Future<String> loadPlatformLabel() async {
    try {
      return await _capability.platformName();
    } on MissingPluginException {
      return 'Native capability is unavailable in this app shell.';
    } on PlatformException catch (error) {
      return 'Native capability failed (${error.code}).';
    }
  }
}
