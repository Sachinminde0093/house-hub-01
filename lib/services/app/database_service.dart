//Package Dependancy
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:house_hub/core/hiveKeys/hive_keys.dart';
import 'package:house_hub/models/user.dart';

final databaseServiceProvider = Provider((ref) => DatabaseService().init());

class DatabaseService {

  // final PreferenceKeys _hiveKeys;

  // DatabaseService(){
  //   init();
  // }

  // DatabaseService({required hiveKeys}): _hiveKeys= hiveKeys ;
  
  // Future<DatabaseService> init() async {
  //   await Hive.initFlutter();
  //   await _openBoxes();
  //   return this;
  // }

  // Future<void> _openBoxes() async {
  //   _preferenceBox = await Hive.openBox(_preference);
  //   _globalPreferenceBox = await Hive.openBox(_globalPreference);
  //   // _cacheBox = await Hive.openBox(_cache);
  // }

  late PreferenceKeys _hiveKeys;

  // DatabaseService({required hiveKeys}) : _hiveKeys = hiveKeys;

  late Box _preferenceBox;
  late Box _globalPreferenceBox;

  Future<DatabaseService> init() async {
    _hiveKeys = PreferenceKeys();
    await Hive.initFlutter();
    await _openBoxes();
    return this;
  }

  Future<void> _openBoxes() async {
    _preferenceBox = await Hive.openBox(_preference);
    _globalPreferenceBox = await Hive.openBox(_globalPreference);
    // _cacheBox = await Hive.openBox(_cache);
  }
  // late Box _preferenceBox;
  // late Box _globalPreferenceBox;
  // late Box _cacheBox;

  Future<void> putPref(key, value) async {
    await _preferenceBox.put(key, value);
  }

  getPref(key) {
    return _preferenceBox.get(key);
  }

  bool checkKeyPref(key) {
    return _preferenceBox.containsKey(key);
  }

  Future<int> clearPreference() async {
    return await _preferenceBox.clear();
  }

  // Be Cautious while using these
  // Global Preference
  
  Future<void> putGlobalPref(key, value) async {
    await _globalPreferenceBox.put(key, value);
  }

  getGlobalPref(key) {
    return _globalPreferenceBox.get(key);
  }

  bool checkKeyGlobalPref(key) {
    return _globalPreferenceBox.containsKey(key);
  }

  Future<int> clearGlobalPreference() async {
    return await _globalPreferenceBox.clear();
  }

  Future<void> putCustomServerURL(String? value) async => await putGlobalPref(_hiveKeys.customServerURL, value);
  String? get customServerURL => getGlobalPref(_hiveKeys.customServerURL) as String?;

  Future<void> putCustomAccessToken(String? value) async => await putGlobalPref(_hiveKeys.customAccessToken, value);
  String? get customAccessToken => getGlobalPref(_hiveKeys.customAccessToken) as String?;

  static const String _hasAcceptedTerms = 'hasAcceptedTerms';
  Future<void> putHasAcceptedTerms(bool value) async => await putPref(_hasAcceptedTerms, value);
  bool? get hasAcceptedTerms => getPref(_hasAcceptedTerms) as bool?;

  // static const String _isSignedIn = 'isSignedIn';
  // Future<void> putIsSignedIn(bool value) async => await putPref(_isSignedIn, value);
  // bool? get isSignedIn => getPref(_isSignedIn) as bool?;

  Future<void> putAccessToken(String value) async => await putPref(_hiveKeys.accessToken, value);
  String? get accessToken => getPref(_hiveKeys.accessToken) as String?;

  Future<void> putUser(UserModel value) async => await putPref(_hiveKeys.user, value.toRawJson());
  UserModel? get user => getPref(_hiveKeys.user) == null ? null : UserModel.fromRawJson(getPref(_hiveKeys.user));

  Future<void> putIsLocationScreenShown(bool value) async => await putPref(_hiveKeys.isLocationScreenShown, value);
  bool? get isLocationScreenShown => getPref(_hiveKeys.isLocationScreenShown) as bool?;

  Future<void> putLastKnownLocation(String value) async => await putPref(_hiveKeys.lastKnownLocation, value);
  String? get lastKnownLocation => getPref(_hiveKeys.lastKnownLocation) as String?;

  static const String _preference = 'preference21';
  static const String _globalPreference = 'globalPreference';
  // static const String _cache = 'cache';

}

