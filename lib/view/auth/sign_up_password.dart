import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:case_study/providers/auth.dart';
import 'package:case_study/utilities/functions.dart';
import 'package:case_study/view/auth/log_in.dart';
import 'package:case_study/view/menu/menu.dart';

class SignUpPasswordScreen extends StatefulWidget {
  static const route = '/sign_up_password';
  const SignUpPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SignUpPasswordScreen> createState() => _SignUpPasswordScreenState();
}

class _SignUpPasswordScreenState extends State<SignUpPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';
  var hidePasswordText = true;
  var hideConfirmPasswordText = true;
  var passwordStrength = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    email = ModalRoute.of(context)!.settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const Text('Create a new account',
                  style: TextStyle(
                    fontSize: 19,
                    color: Color(0xff787878),
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 52),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      obscureText: hidePasswordText,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(hidePasswordText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () => setState(
                              () => hidePasswordText = !hidePasswordText),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          passwordStrength =
                              Functions.calculatePasswordStrength(val);
                        });
                      },
                      validator: (_val) {
                        password = _val ?? '';
                        if (password.isEmpty) {
                          return 'Your account needs a password';
                        }
                        if (passwordStrength < 0.5) {
                          return 'Please use a stronger password';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbColor: Colors.transparent,
                              disabledActiveTrackColor: passwordStrength > 0.5
                                  ? Colors.green
                                  : Colors.orange,
                              thumbShape: SliderComponentShape.noThumb,
                            ),
                            child: Slider(
                                value: passwordStrength, onChanged: null),
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Password strength',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      obscureText: hideConfirmPasswordText,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(hideConfirmPasswordText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () => setState(() =>
                              hideConfirmPasswordText =
                                  !hideConfirmPasswordText),
                        ),
                      ),
                      validator: (_val) {
                        var val = _val ?? '';
                        if (val.isEmpty) {
                          return 'You need to confirm the password';
                        }

                        if (val != password) {
                          return 'The passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        child: Provider.of<AuthProvider>(context)
                                    .registeredState ==
                                AuthState.Authenticating
                            ? const Center(
                                child: SizedBox.square(
                                dimension: 24,
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ))
                            : const Text('Sign up'),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Provider.of<AuthProvider>(context, listen: false)
                                .register(email, password);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MenuScreen.route, (_) => false);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 8),
              SizedBox(
                height: 58,
                child: OutlinedButton(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                              image: AssetImage('assets/images/google.png')),
                        ),
                        Expanded(
                            child: Center(
                                child: Text('Sign up with Google',
                                    style:
                                        TextStyle(color: Color(0xff787878))))),
                      ],
                    ),
                  ),
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .loginWithGoogle();
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Already a user? "),
                    const SizedBox(width: 2),
                    TextButton(
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(LogInScreen.route);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
