import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:case_study/providers/auth.dart';
import 'package:case_study/view/auth/sign_up.dart';
import 'package:case_study/view/menu/menu.dart';

class LogInScreen extends StatefulWidget {
  static const route = '/login';
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  var hideText = true;
  var email = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const Text(
                'Log into your account',
                style: TextStyle(
                  fontSize: 19,
                  color: Color(0xff787878),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 52),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: 'janet.weaver@reqres.in',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      toolbarOptions:
                          const ToolbarOptions(selectAll: true, paste: true),
                      validator: (val) {
                        if (val?.isEmpty ?? true) {
                          return 'Please what is your email address?';
                        }
                        email = val!;
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      obscureText: hideText,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(hideText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () => setState(() => hideText = !hideText),
                        ),
                      ),
                      validator: (_val) {
                        var val = _val ?? '';
                        if (val.isEmpty) {
                          return 'Please input your password';
                        }
                        password = val;
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
                        child:
                            Provider.of<AuthProvider>(context).loggedInState ==
                                    AuthState.Authenticating
                                ? const Center(
                                    child: SizedBox.square(
                                    dimension: 24,
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ))
                                : const Text('Login'),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .login(email, password);
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
                          child: Text('Continue with Google',
                              style: TextStyle(color: Color(0xff787878))),
                        )),
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
                    const Text("Don't have an account? "),
                    const SizedBox(width: 2),
                    TextButton(
                      child: const Text('Sign Up'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignUpScreen.route);
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
