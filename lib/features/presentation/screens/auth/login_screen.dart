
import 'package:elemoment/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:elemoment/features/presentation/blocs/auth/auth_event.dart';
import 'package:elemoment/features/presentation/blocs/auth/auth_state.dart';
import 'package:elemoment/features/presentation/components/utility/snackbar.dart';
import 'package:elemoment/features/presentation/components/widget/button_border.dart';
import 'package:elemoment/features/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../blocs/status.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameTextCtrl = TextEditingController();
  TextEditingController passwordTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, state) {
          switch(state.status[AuthStatus.Login]){
            case Status.success: {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen()
                  )
              );
              break;
            }
            case Status.failure: {
              showCustomSnackBar("Đăng nhập thất bại");
              break;
            }
            default:{

            }
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      const Text("Welcome back!", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 30,),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text("When your conversatios live")
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: usernameTextCtrl,
                        decoration: const InputDecoration(
                            hintText: "Username/Email/Phone"
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: passwordTextCtrl,
                        decoration: const InputDecoration(
                          hintText: "Password"
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text("Forgot password", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w600, fontSize: 16),),
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.teal
                          ),
                          onPressed: (){
                            context.read<AuthBloc>().add(LoginWithEmailAuthEvent(
                                email: usernameTextCtrl.text,
                                password: passwordTextCtrl.text
                            ));
                          },
                          child: const Text("Next", style: TextStyle(color: Colors.white),)
                      ),
                      const SizedBox(height: 30,),
                      const Text("Or", style: TextStyle(fontSize: 18, color: Colors.grey),),
                      const SizedBox(height: 30,),
                      ButtonBorder(
                        icon: const FaIcon(FontAwesomeIcons.google, size: 20,),
                        title: "Continue with Google",
                        color: Colors.grey,
                        onPress: (){
                        },
                      ),
                      const SizedBox(height: 10,),
                      ButtonBorder(
                        icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue, size: 20,),
                        title: "Continue with Facebook",
                        color: Colors.grey,
                        onPress: (){
                        },
                      ),
                      const SizedBox(height: 10,),
                      ButtonBorder(
                        icon: const FaIcon(FontAwesomeIcons.github, size: 20,),
                        title: "Continue with Github",
                        color: Colors.grey,
                        onPress: (){
                        },
                      ),
                      const SizedBox(height: 10,),
                      ButtonBorder(
                        icon: const FaIcon(FontAwesomeIcons.gitlab, color: Colors.orange, size: 20,),
                        title: "Continue with Gitlab",
                        color: Colors.grey,
                        onPress: (){
                        },
                      ),
                      const SizedBox(height: 10,),
                      ButtonBorder(
                        icon: const FaIcon(FontAwesomeIcons.apple, size: 20,),
                        title: "Continue with Apple",
                        color: Colors.grey,
                        onPress: (){
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state){
                if(state.status[AuthStatus.Login]?.isLoading == false) return const SizedBox();

                return Container(
                  color: Colors.white.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
