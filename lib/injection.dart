import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logistics_app/features/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:logistics_app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:logistics_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:logistics_app/features/dashboard/domain/usecases/get_dashboard_data_use_case.dart';
import 'package:logistics_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:logistics_app/features/profile/data/data_source/employee_profile_data_source.dart';
import 'package:logistics_app/features/profile/data/repositories/employee_profile_repository_impl.dart';
import 'package:logistics_app/features/profile/domain/repositories/employee_repository.dart';
import 'package:logistics_app/features/profile/domain/usecases/get_employee_profile.dart';
import 'package:logistics_app/features/profile/presentation/bloc/employee_profile_bloc.dart';
import 'package:logistics_app/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:logistics_app/features/requests/data/data_source/categories_data_source.dart';
import 'package:logistics_app/features/requests/data/data_source/user_requests_data_source.dart';
import 'package:logistics_app/features/requests/data/repositories/categories_repository_impl.dart';
import 'package:logistics_app/features/requests/data/repositories/user_requests_repository_impl.dart';
import 'package:logistics_app/features/requests/domain/repositories/request_repository.dart';
import 'package:logistics_app/features/requests/domain/usecases/create_request_usecase.dart';
import 'package:logistics_app/features/requests/domain/usecases/get_categories.dart';
import 'package:logistics_app/features/requests/domain/usecases/get_user_requests.dart';
import 'package:logistics_app/features/requests/presentation/bloc/categories_with_types/categories_bloc.dart';
import 'package:logistics_app/features/requests/presentation/bloc/create_request/create_request_bloc.dart';
import 'package:logistics_app/features/requests/presentation/bloc/user_requests_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/auth/login/data/datasources/auth_date_source.dart';
import 'features/auth/login/data/repositories/auth_repositories_impl.dart';
import 'features/auth/login/domain/repositories/auth_repositories.dart';
import 'features/auth/login/domain/usecases/post_login_use_case.dart';
import 'features/auth/login/presentation/bloc/login/login_bloc.dart';
import 'features/requests/data/data_source/create_request_data_source.dart';
import 'features/requests/domain/repositories/categories_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features
  /// Auth
  // Bloc
  sl.registerFactory(() => LoginBloc(postLoginUseCase: sl()));

  // Use Case
  sl.registerLazySingleton(() => PostLoginUseCase(authRepositories: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepositories>(
        () => AuthRepositoriesImpl(networkInfo: sl(), authDataSource: sl()),
  );

  // DataSource
  sl.registerLazySingleton<AuthDataSource>(
        () => AuthDataSourceImpl(client: sl()),
  );

  /// Dashboard
  // Bloc
  sl.registerFactory(() => DashboardBloc(getDashboardDataUseCase: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetDashboardDataUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<DashboardRepository>(
        () => DashboardRepositoryImpl(networkInfo: sl(), dashboardDataSource: sl()),
  );

  // DataSource
  sl.registerLazySingleton<DashboardDataSource>(
        () => DashboardDataSourceImpl(client: sl()),
  );

  /// My Requests
  // Bloc
  sl.registerFactory(() => UserRequestsBloc(getUserRequestsUseCase: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetUserRequestsUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<RequestRepository>(
        () => UserRequestsRepositoryImpl(
      networkInfo: sl(),
      userRequestsDataSource: sl(),
      createRequestDataSource: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<UserRequestsDataSource>(
        () => UserRequestsDataSourceImpl(client: sl()),
  );

  /// Create Request
  // Bloc
  sl.registerFactory(() => CreateRequestBloc(createRequestUseCase: sl()));

  // UseCase
  sl.registerLazySingleton(() => CreateRequestUseCase(repository: sl()));

  // DataSource
  sl.registerLazySingleton<CreateRequestDataSource>(
        () => CreateRequestDataSourceImpl(client: sl()),
  );

  /// Categories WIth Types
  // Bloc
  sl.registerFactory(() => CategoriesBloc(getCategoriesWithTypes: sl()));

  // UseCase
  sl.registerLazySingleton(() => GetCategoriesWithTypes(repository: sl()));

  // Repository
  sl.registerLazySingleton<CategoriesRepository>(
        () => CategoriesRepositoryImpl(networkInfo: sl(), dataSource: sl()),
  );

  // Data Source
  sl.registerLazySingleton<CategoriesDataSource>(
        () => CategoriesDataSourceImpl(client: sl()),
  );

  /// Profile
  // Bloc
  sl.registerFactory(
        () => EmployeeProfileBloc(getEmployeeProfileUseCase: sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => GetEmployeeProfileUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<EmployeeRepository>(
        () => EmployeeRepositoryImpl(
      networkInfo: sl(),
      employeeProfileDataSource: sl(),
    ),
  );

  /// Reports
  // Bloc
  sl.registerFactory(()=> ReportsBloc(getDashboardDataUseCase: sl()));

  // Data Source
  sl.registerLazySingleton<EmployeeProfileDataSource>(
        () => EmployeeRemoteDataSourceImpl(client: sl()),
  );

  /// Core
  // Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Shared Preference
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Http
  sl.registerLazySingleton(() => http.Client());

  // Internet Connection
  sl.registerLazySingleton(() => InternetConnection());
}
