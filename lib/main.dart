import 'package:bloc_rxdart/src/config/router/app_service.dart';
import 'package:bloc_rxdart/src/presentation/blocs/combined/combined_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'src/config/themes/app_theme.dart';
import 'src/core/di/dependency_injection.dart';
import 'src/presentation/blocs/auth/auth_bloc.dart';
import 'src/presentation/blocs/photo/photo_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //! khai báo ở cấp cao nhất
      //! đối với Bloc nào không cần thiết thì có thể dùng BlocProvider khai báo ở phạm vi Ui cần dùng là đụ
      providers: [
        BlocProvider(create: (_) => GetIt.I<AuthBloc>()),
        BlocProvider(create: (_) => GetIt.I<PhotoBloc>()),
        BlocProvider(create: (_) => GetIt.I<CombinedBloc>())
      ],
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        routerConfig: AppServices.router,
      ),
    );
  }
}
