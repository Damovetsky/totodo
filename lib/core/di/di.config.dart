// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import 'package:totodo/data/modules/isar_module.dart' as _i11;
import 'package:totodo/data/modules/shared_preferences_module.dart' as _i12;
import 'package:totodo/data/services/tasks_db/tasks_db.dart' as _i5;
import 'package:totodo/data/services/tasks_server/tasks_server.dart' as _i8;
import 'package:totodo/domain/repositories/tasks_repository.dart' as _i9;
import 'package:totodo/view/navigation/tasks_route_information_parser.dart'
    as _i6;
import 'package:totodo/view/navigation/tasks_router_deligate.dart' as _i7;
import 'package:totodo/view/providers/tasks.dart' as _i10;

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
    final isarModule = _$IsarModule();
    final sharedPreferencesModule = _$SharedPreferencesModule();
    await gh.factoryAsync<_i3.Isar>(
      () => isarModule.isar,
      preResolve: true,
    );
    await gh.factoryAsync<_i4.SharedPreferences>(
      () => sharedPreferencesModule.pref,
      preResolve: true,
    );
    gh.factory<_i5.TasksDB>(() => _i5.IsarService(gh<_i3.Isar>()));
    gh.factory<_i6.TasksRouteInformationParser>(
        () => _i6.TasksRouteInformationParser());
    gh.lazySingleton<_i7.TasksRouterDeligate>(() => _i7.TasksRouterDeligate());
    gh.factory<_i8.TasksServer>(
        () => _i8.TasksServerImpl(gh<_i4.SharedPreferences>()));
    gh.lazySingleton<_i9.TasksRepository>(() => _i9.TasksRepositoryImpl(
          prefs: gh<_i4.SharedPreferences>(),
          server: gh<_i8.TasksServer>(),
          db: gh<_i5.TasksDB>(),
        ));
    gh.lazySingleton<_i10.Tasks>(() => _i10.Tasks(gh<_i9.TasksRepository>()));
    return this;
  }
}

class _$IsarModule extends _i11.IsarModule {}

class _$SharedPreferencesModule extends _i12.SharedPreferencesModule {}
