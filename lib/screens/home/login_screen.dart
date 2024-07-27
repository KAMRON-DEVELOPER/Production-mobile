import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mobile/bloc/authentication/authentication_bloc.dart';
import 'package:mobile/bloc/authentication/authentication_event.dart';
import 'package:mobile/bloc/authentication/authentication_state.dart';
import 'package:mobile/provider/toggle_settings_provider.dart';
import 'package:mobile/utilities/realtime_validators.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../provider/theme_provider.dart';
import '../../services/validator_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? usernameError;
  String? passwordError;
  final _formKey = GlobalKey<FormState>();
  ValidateApiService validateUsersService = ValidateApiService();
  double socialAuthIconSize = 48;
  final String currentTheme =
      Hive.box('settingsBox').get('theme', defaultValue: 'blue');

  bool hasAnyError(String? usernameError, String? passwordError) {
    return usernameError != null || passwordError != null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    bool hasError = hasAnyError(
      usernameError,
      passwordError,
    );
    String twitterxIcon = currentTheme == 'white'
        ? 'assets/icons/twitterxIcon1.svg'
        : 'assets/icons/twitterxIcon.svg';
    String githubIcon = currentTheme == 'white'
        ? 'assets/icons/githubIcon1.svg'
        : 'assets/icons/githubIcon.svg';

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print('STATE LISTENER >> $state');
        if (state is AuthenticationSuccess) {
          Provider.of<ToggleSettingsProvider>(context, listen: false)
              .closeSettings();
          //! get profile data from fetchVerify and give to home_screen
          Navigator.pushNamed(
            context,
            '/home',
            arguments: state.loginSuccessData,
          );
        } else if (state == const AuthenticationFailure()) {
          print('ERROR OCCURRED');
        }
      },
      builder: (context, state) {
        AuthenticationState authState = state;
        return Scaffold(
          backgroundColor: theme.background1,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 48),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'one more step and everything is ready! enter your username and password for login.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  Form(
                    key: _formKey,
                    onChanged: () {
                      print(
                          '_usernameController >> ${_usernameController.text}');
                      print(
                          '_passwordController >> ${_passwordController.text}');
                    },
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            usernameError =
                                loginUsernameValidator(value.trim());
                            setState(() {});
                          },
                          controller: _usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'username',
                            errorText: usernameError,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintStyle: const TextStyle(color: Colors.white),
                            counterStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value) {
                            passwordError =
                                realtimePasswordValidator(value.trim());
                            setState(() {});
                          },
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'password',
                            errorText: passwordError,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintStyle: const TextStyle(color: Colors.white),
                            counterStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: const Text(
                          'Reset password',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () => print('FORGOT PASSWORD!!!'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!hasError) {
                          print('NOT ANY ERROR >>');
                          final User loginData = User(
                            username: _usernameController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                          context.read<AuthenticationBloc>().add(
                                LoginSubmitEvent(loginData: loginData),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                      child: authState == AuthenticationLoading()
                          ? const Text(
                              "Loading...",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.white70),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or continue with',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/googleIcon.svg',
                        width: socialAuthIconSize,
                        height: socialAuthIconSize,
                      ),
                      SvgPicture.asset(
                        twitterxIcon,
                        width: socialAuthIconSize,
                        height: socialAuthIconSize,
                      ),
                      SvgPicture.asset(
                        'assets/icons/linkedinIcon.svg',
                        width: socialAuthIconSize,
                        height: socialAuthIconSize,
                      ),
                      SvgPicture.asset(
                        githubIcon,
                        width: socialAuthIconSize,
                        height: socialAuthIconSize,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () =>
                            Navigator.pushNamed(context, '/home/register'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
