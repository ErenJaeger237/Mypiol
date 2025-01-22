import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _cardHolderName = prefs.getString('ff_cardHolderName') ?? _cardHolderName;
    });
    _safeInit(() {
      _cardName = prefs.getString('ff_cardName') ?? _cardName;
    });
    _safeInit(() {
      _zipCode = prefs.getString('ff_zipCode') ?? _zipCode;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _cardHolderName = '';
  String get cardHolderName => _cardHolderName;
  set cardHolderName(String value) {
    _cardHolderName = value;
    prefs.setString('ff_cardHolderName', value);
  }

  String _cardName = '';
  String get cardName => _cardName;
  set cardName(String value) {
    _cardName = value;
    prefs.setString('ff_cardName', value);
  }

  String _zipCode = '';
  String get zipCode => _zipCode;
  set zipCode(String value) {
    _zipCode = value;
    prefs.setString('ff_zipCode', value);
  }

  String _avatar =
      'https://www.bing.com/images/search?view=detailV2&ccid=hZAW1qjM&id=C08F5C563203D13853B0C90EAD038DF720B61E50&thid=OIP.hZAW1qjMuXkTFEdJkFcDTQHaHa&mediaurl=https%3a%2f%2fchcclynden.org%2fwp-content%2fuploads%2f2014%2f03%2fplaceholder-person.png&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.859016d6a8ccb979131447499057034d%3frik%3dUB62IPeNA60OyQ%26pid%3dImgRaw%26r%3d0&exph=1024&expw=1024&q=placeholder+image&simid=608015959599886023&FORM=IRPRST&ck=B7B40543AF41B03A40577F2E6BCB0728&selectedIndex=5&itb=1';
  String get avatar => _avatar;
  set avatar(String value) {
    _avatar = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
