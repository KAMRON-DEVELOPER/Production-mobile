import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mobile/utilities/realtime_validators.dart';
import 'package:provider/provider.dart';
import '../../hive/users_model.dart';
import '../../provider/theme_provider.dart';
import '../../services/validator_api.dart';
import '../../widgets/auth_field.dart';
import '../../widgets/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final usersBox = Hive.box<UsersModel>('usersBox');
  ValidateApiService validateUsersService = ValidateApiService();
  double socialAuthIconSize = 48;

  @override
  void initState() {
    super.initState();
    validateUsersService.fetchAndStoreUserData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    String twitterxIcon = theme == CustomTheme.lightTheme
        ? 'assets/icons/twitterxIcon1.svg'
        : 'assets/icons/twitterxIcon.svg';
    String githubIcon = theme == CustomTheme.lightTheme
        ? 'assets/icons/githubIcon1.svg'
        : 'assets/icons/githubIcon.svg';

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
                const SizedBox(height: 10),
                const Text(
                  'one more step and everything is ready! enter your username and password for login',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                AuthField(
                  labelText: "username",
                  controller: _usernameController,
                  realtimeValidator: realtimeUsernameValidator,
                ),
                const SizedBox(height: 20),
                AuthField(
                  labelText: "password",
                  controller: _passwordController,
                  realtimeValidator: realtimePasswordValidator,
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
                const AuthButton(text: "LOGIN"),
                const SizedBox(height: 30),
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
      ),
    );
  }
}
