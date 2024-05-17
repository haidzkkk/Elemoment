import 'package:elemoment/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:elemoment/features/presentation/blocs/auth/auth_event.dart';
import 'package:elemoment/features/presentation/blocs/splash/splash_event.dart';
import 'package:elemoment/features/presentation/blocs/splash/splash_state.dart';
import 'package:elemoment/features/presentation/components/utility/color_resource.dart';
import 'package:elemoment/features/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../di/InjectionContainer.dart';
import '../../blocs/splash/splash_bloc.dart';
import '../../components/utility/images.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorResources.getPrimaryColor(),// Change to your desired color
    ));
    return Scaffold(
      backgroundColor: ColorResources.getPrimaryColor(),
      body: BlocProvider(
        create: (context) => sl<SplashBloc>()..add(LoadingEvent()),
        child: BlocListener<SplashBloc,SplashState>(
          listener: (context,state){
            if(state is Success){
              Get.off(() => const HomeScreen());
              context.read<AuthBloc>().add(GetCurrentUser());
            }else if(state is Failure){
              Get.off(() => const LoginScreen());
            }else{
              Get.off(() => const LoginScreen());
            }
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 40),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Image.asset(Images.logo),
            ),
          ),
        ),
      )
    );
  }
}
