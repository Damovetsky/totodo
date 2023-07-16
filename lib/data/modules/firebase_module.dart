import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../firebase_options.dart';
import '../../logger.dart';

@module
abstract class FirebaseModule {
  @preResolve
  Future<FirebaseApp> get firebaseApp async {
    logger.d('Firebase initialization started');

    final firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    logger.d('Firebase initialized');

    _initCrashlytics();

    return firebaseApp;
  }

  FirebaseRemoteConfig get firebaseRemoteConfig {
    final config = FirebaseRemoteConfig.instance;
    //TODO: change minimum fetch interval to a larger duration after homework check
    unawaited(config.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 3),
        minimumFetchInterval: const Duration(seconds: 5),
      ),
    ));
    return config;
  }

  void _initCrashlytics() async {
    FlutterError.onError = (errorDetails) {
      logger.d('Caught error in FlutterError.onError');
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      logger.d('Caught error in PlatformDispatcher.onError');
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );
      return true;
    };
    logger.d('Crashlytics initialized');
  }
}
