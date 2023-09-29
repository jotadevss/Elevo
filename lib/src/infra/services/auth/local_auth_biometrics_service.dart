import 'package:local_auth/local_auth.dart';

class LocalAuthBiometricsService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    return canAuthenticateWithBiometrics && await _auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    return await _auth.authenticate(localizedReason: "Please, authenticate to access");
  }
}
