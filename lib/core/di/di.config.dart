// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_core/firebase_core.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i5;
import 'package:totodo/data/modules/firebase_module.dart' as _i12;
import 'package:totodo/data/modules/isar_module.dart' as _i13;
import 'package:totodo/data/modules/shared_preferences_module.dart' as _i14;
import 'package:totodo/data/services/tasks_db/tasks_db.dart' as _i6;
import 'package:totodo/data/services/tasks_server/tasks_server.dart' as _i9;
import 'package:totodo/domain/repositories/tasks_repository.dart' as _i10;
import 'package:totodo/view/navigation/tasks_route_information_parser.dart'
    as _i7;
import 'package:totodo/view/navigation/tasks_router_deligate.dart' as _i8;
import 'package:totodo/view/providers/tasks.dart' as _i11;

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
    await gh.factoryAsync<_i3.FirebaseApp>(
      () => firebaseModule.firebaseApp,
      preResolve: true,
    );
    await gh.factoryAsync<_i4.Isar>(
      () => isarModule.isar,
      preResolve: true,
    );
    await gh.factoryAsync<_i5.SharedPreferences>(
      () => sharedPreferencesModule.pref,
      preResolve: true,
    );
    gh.factory<_i6.TasksDB>(() => _i6.IsarService(gh<_i4.Isar>()));
    gh.factory<_i7.TasksRouteInformationParser>(
        () => _i7.TasksRouteInformationParser());
    gh.lazySingleton<_i8.TasksRouterDeligate>(() => _i8.TasksRouterDeligate());
    gh.factory<_i9.TasksServer>(
        () => _i9.TasksServerImpl(gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i10.TasksRepository>(() => _i10.TasksRepositoryImpl(
          prefs: gh<_i5.SharedPreferences>(),
          server: gh<_i9.TasksServer>(),
          db: gh<_i6.TasksDB>(),
        ));
    gh.lazySingleton<_i11.Tasks>(() => _i11.Tasks(gh<_i10.TasksRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i12.FirebaseModule {}

class _$IsarModule extends _i13.IsarModule {}

class _$SharedPreferencesModule extends _i14.SharedPreferencesModule {}
