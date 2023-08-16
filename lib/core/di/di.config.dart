// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_analytics/firebase_analytics.dart' as _i3;
import 'package:firebase_core/firebase_core.dart' as _i4;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i7;
import 'package:totodo/data/modules/firebase_module.dart' as _i16;
import 'package:totodo/data/modules/isar_module.dart' as _i17;
import 'package:totodo/data/modules/shared_preferences_module.dart' as _i18;
import 'package:totodo/data/services/analitics/analitics.dart' as _i11;
import 'package:totodo/data/services/tasks_db/tasks_db.dart' as _i8;
import 'package:totodo/data/services/tasks_server/tasks_server.dart' as _i10;
import 'package:totodo/domain/repositories/config_repository.dart' as _i12;
import 'package:totodo/domain/repositories/tasks_repository.dart' as _i13;
import 'package:totodo/view/navigation/tasks_route_information_parser.dart'
    as _i9;
import 'package:totodo/view/navigation/tasks_router_deligate.dart' as _i14;
import 'package:totodo/view/providers/tasks.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    final isarModule = _$IsarModule();
    final sharedPreferencesModule = _$SharedPreferencesModule();
    gh.factory<_i3.FirebaseAnalytics>(() => firebaseModule.firebaseAnalytics);
    await gh.factoryAsync<_i4.FirebaseApp>(
      () => firebaseModule.firebaseApp,
      preResolve: true,
    );
    gh.factory<_i5.FirebaseRemoteConfig>(
        () => firebaseModule.firebaseRemoteConfig);
    await gh.factoryAsync<_i6.Isar>(
      () => isarModule.isar,
      preResolve: true,
    );
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => sharedPreferencesModule.pref,
      preResolve: true,
    );
    gh.factory<_i8.TasksDB>(() => _i8.IsarService(gh<_i6.Isar>()));
    gh.factory<_i9.TasksRouteInformationParser>(
        () => _i9.TasksRouteInformationParser());
    gh.factory<_i10.TasksServer>(
        () => _i10.TasksServerImpl(gh<_i7.SharedPreferences>()));
    gh.factory<_i11.Analytics>(
        () => _i11.AnaliticsService(gh<_i3.FirebaseAnalytics>()));
    gh.lazySingleton<_i12.ConfigRepository>(
        () => _i12.ConfigRepository(gh<_i5.FirebaseRemoteConfig>()));
    gh.lazySingleton<_i13.TasksRepository>(() => _i13.TasksRepositoryImpl(
          prefs: gh<_i7.SharedPreferences>(),
          server: gh<_i10.TasksServer>(),
          db: gh<_i8.TasksDB>(),
        ));
    gh.lazySingleton<_i14.TasksRouterDeligate>(
        () => _i14.TasksRouterDeligate(gh<_i11.Analytics>()));
    gh.lazySingleton<_i15.Tasks>(() => _i15.Tasks(
          gh<_i13.TasksRepository>(),
          gh<_i11.Analytics>(),
        ));
    return this;
  }
}

class _$FirebaseModule extends _i16.FirebaseModule {}

class _$IsarModule extends _i17.IsarModule {}

class _$SharedPreferencesModule extends _i18.SharedPreferencesModule {}
