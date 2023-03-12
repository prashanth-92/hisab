import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  static LocalAuthentication auth = LocalAuthentication();

  static Future authenticate() async {
    final bool isBiometricsAvailable = await auth.isDeviceSupported();
    if (!isBiometricsAvailable) return false;
    try {
      return await auth.authenticate(
        localizedReason: 'Scan Fingerprint To Enter Vault',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return;
    }
  }
}
