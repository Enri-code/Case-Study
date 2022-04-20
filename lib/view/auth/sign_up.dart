import 'package:flutter/material.dart';
import 'package:case_study/view/auth/log_in.dart';
import 'package:case_study/view/auth/sign_up_password.dart';

class SignUpScreen extends StatefulWidget {
  static const route = '/sign_up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  var hideText = true;
  var firstName = '', lastName = '', email = '', number = '';

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
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'First name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      toolbarOptions:
                          const ToolbarOptions(selectAll: true, paste: true),
                      validator: (_val) {
                        var val = (_val ?? '').trim();
                        if (val.isEmpty) {
                          return 'Please what is your first name?';
                        }
                        firstName = val;
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Last name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      toolbarOptions:
                          const ToolbarOptions(selectAll: true, paste: true),
                      validator: (_val) {
                        var val = (_val ?? '').trim();
                        if (val.isEmpty) {
                          return 'Please what is your last name?';
                        }
                        lastName = val;
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      toolbarOptions:
                          const ToolbarOptions(selectAll: true, paste: true),
                      validator: (_val) {
                        var val = (_val ?? '').trim();
                        if (val.isEmpty) {
                          return 'Please what is your email address?';
                        }
                        email = val;
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      toolbarOptions:
                          const ToolbarOptions(selectAll: true, paste: true),
                      validator: (_val) {
                        var val = (_val ?? '').trim();
                        if (val.isNotEmpty && val.length < 11) {
                          return 'Invalid phone number';
                        }
                        number = val;
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
                        child: const Text('Continue'),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context).pushNamed(
                                SignUpPasswordScreen.route,
                                arguments: email);
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
                              style: TextStyle(color: Color(0xff787878))),
                        )),
                      ],
                    ),
                  ),
                  onPressed: () {
                    //
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
                        Navigator.of(context)
                            .popAndPushNamed(LogInScreen.route);
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
