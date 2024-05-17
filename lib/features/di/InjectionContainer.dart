import 'package:elemoment/features/data/api/api_client.dart';
import 'package:elemoment/features/data/repositories/auth_repo.dart';
import 'package:elemoment/features/data/repositories/message_repo.dart';
import 'package:elemoment/features/data/repositories/room_repo.dart';
import 'package:elemoment/features/data/repositories/splash_repo.dart';
import 'package:elemoment/features/presentation/blocs/room/room_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../core/env/config.dart';
import '../presentation/blocs/auth/auth_bloc.dart';
import '../presentation/blocs/home/home_bloc.dart';
import '../presentation/blocs/splash/splash_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

///[NOTE] : input for [Global] data state
final sl = GetIt.instance;

Future<void> init() async {
  final config = Config.getInstance();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  /// [Flavor]
  /// [Implementation] flavor with different [Environm Env] both ios and android
  sl.registerLazySingleton(() => config);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => ApiClient(sharedPreferences: sl()));

  ///[Core]
  ///

  ///sentry client
  ///

  ///[External]
  ///

  ///[Bloc]
  ///
  sl.registerFactory(() => SplashBloc());
  sl.registerFactory(() => AuthBloc(repo: sl()));
  sl.registerFactory(() => HomeBloc(roomRepo: sl()));
  sl.registerFactory(() => RoomBloc(messageRepo: sl()));

  ///[Repository]
  sl.registerFactory(() => SplashRepo(apiClient: sl(), sharedPreferences: sl()));
  sl.registerFactory(() => AuthRepo(apiClient: sl(), sharedPreferences: sl()));
  sl.registerFactory(() => RoomRepo(apiClient: sl(), sharedPreferences: sl()));
  sl.registerFactory(() => MessageRepo(apiClient: sl(), sharedPreferences: sl()));
}
