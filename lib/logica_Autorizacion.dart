import 'package:local_auth/local_auth.dart';

class LAutorizacion{
  static final _autorizar = LocalAuthentication();
  static Future<bool> _canAutorizar() async => await _autorizar.canCheckBiometrics || await _autorizar.isDeviceSupported();

  static Future<bool> autenticar()async{
    try{
      if(!await _canAutorizar()) return false;
      return await _autorizar.authenticate(localizedReason: 'Necesito tu confirmacion');
    }catch(e){
      print (e);
      return false;
    }
  }
}