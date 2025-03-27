import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/otp_bloc/otp_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/pos_sales_history_bloc/pos_sales_history_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/sync_bloc/sync_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/vendor_bloc/bloc/vendor_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/cubit/update_invoice_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/language_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/offline_sales_cubit/offline_sales_storage_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/password_obscure_cubit/password_obscure_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/user_cubit/user_cubit.dart';
import 'package:temwin_front_app/Core/utils/hive_init_helper.dart';
import 'package:temwin_front_app/Data/Service/api_service.dart';
import 'package:temwin_front_app/Data/dataSources/Local/Auth/auth_local_data_source.dart';
import 'package:temwin_front_app/Data/dataSources/Local/Language/app_lang_local_data_source.dart';
import 'package:temwin_front_app/Data/dataSources/Local/OfflineSales/offline_sales_local_data_source.dart';
import 'package:temwin_front_app/Data/dataSources/Local/User/user_local_data_source.dart';
import 'package:temwin_front_app/Data/dataSources/Remote/Auth/auth_remote_data_source.dart';
import 'package:temwin_front_app/Data/dataSources/Remote/Vendor/vendor_remote_data_source.dart';
import 'package:temwin_front_app/Data/repo/auth_repository.dart';
import 'package:temwin_front_app/Data/repo/vendor_repository.dart';
import 'package:temwin_front_app/Domain/UseCases/Auth/auth_usecases.dart';
import 'package:temwin_front_app/Domain/UseCases/Vendor/vendor_usecases.dart';
import 'package:temwin_front_app/Domain/repo/auth_repository.dart';
import 'package:temwin_front_app/Domain/repo/vendor_repository.dart';

GetIt sl = GetIt.instance;

Future<void> resetAndSetupAgainLocator() async {
  sl.reset();
  await setupLocator();
}

Future<void> setupLocator() async {
  //externals

  sl.registerLazySingleton<HiveHelper>(() => HiveHelper()
      // ..initHive()
      // ..initAdapters()
      );
  sl.registerLazySingleton<Client>(() => Client());

//blocs

  sl.registerFactory(() => AuthBloc(
        authUsecases: sl(),
      ));

  sl.registerFactory(() => VendorBloc(
        vendorUsecases: sl(),
      ));

  sl.registerFactory(() => OtpBloc(
        vendorUsecases: sl(),
      ));

  sl.registerFactory(() => PosSalesHistoryBloc(
        vendorUsecases: sl(),
      ));

  sl.registerFactory(
      () => SyncBloc(offlineSalessLocalDataSource: sl(), vendorUsecases: sl()));

  //Cubits

  sl.registerFactory(() => PasswordObscureCubit());
  sl.registerLazySingleton(() => UserCubit(userLocalDataSource: sl()));
  sl.registerFactory(() => UpdateInvoiceCubit());
  sl.registerFactory(() => LanguageCubit(appLangLocalDataSource: sl()));
  sl.registerFactory(
      () => OfflineSalesStorageCubit(offlineSalessLocalDataSource: sl()));

  //usecases

  sl.registerLazySingleton<AuthUsecases>(
      () => AuthUsecases(authRepository: sl()));

  sl.registerLazySingleton<VendorUsecases>(
      () => VendorUsecases(vendorRepository: sl()));

  //repositories

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
      userLocalDataSource: sl()));

  sl.registerLazySingleton<VendorRepository>(() => VendorRepositoryImpl(
      vendorRemoteDataSource: sl(), authLocalDataSource: sl()));

  //Api service
  sl.registerLazySingleton<ApiService>(() => ApiService(
        httpClient: sl(),
        authLocalDataSource: sl(),
      ));

//data sources
  //remote

  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
      httpClient: sl(), authLocalDataSource: sl(), apiService: sl()));

  sl.registerLazySingleton<VendorRemoteDataSource>(() =>
      VendorRemoteDataSourceImpl(
          httpClient: sl(), authLocalDataSource: sl(), apiService: sl()));

  //local

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(hiveHelper: sl()));

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(hiveHelper: sl()));

  sl.registerLazySingleton<AppLangLocalDataSource>(
      () => AppLangLocalDataSourceImpl(hiveHelper: sl()));

  sl.registerLazySingleton<OfflineSalessLocalDataSource>(
      () => OfflineSalessLocalDataSourceImpl(hiveHelper: sl()));
}
