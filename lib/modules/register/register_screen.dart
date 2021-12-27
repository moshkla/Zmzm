import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/layout/home_layout.dart';
import 'package:zmzm/modules/login/shop_login_screen.dart';
import 'package:zmzm/modules/register/cubit/cubit.dart';
import 'package:zmzm/modules/register/cubit/states.dart';
import 'package:zmzm/shared/components/components.dart';
import 'package:zmzm/shared/components/constants.dart';
import 'package:zmzm/shared/network/local/cashe_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              CasheHelper.saveData(
                  key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, ShopLayout());
                showToast(
                    msg: state.loginModel.message!, state: ToastStates.SUCCESS);
              });
            } else {
              showToast(
                  msg: state.loginModel.message!, state: ToastStates.ERROR);
              print(state.loginModel.message);
            }
          }

        },
        builder: (context, state) {
          var cubit=ShopRegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                            },
                            label: 'Name',
                            prefix: Icons.person,
                            onTap: () {
                              print('name taped');
                            }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            onTap: () {
                              print('email taped');
                            }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outlined,
                            suffix: Icons.visibility_outlined,
                            suffixPressed: () {},
                            onTap: () {
                              print('password taped');
                            }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Phone';
                              }
                            },
                            label: 'Phone Number',
                            prefix: Icons.phone,
                            onTap: () {
                              print('phone taped');
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! ShopRegisterLoadingState,
                          builder: (context) {
                            return defaultButton(
                                btnText: 'Register',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                toUppercase: true);
                          },
                          fallback: (context) =>
                              Center(child: const CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('I Have Account'),
                            defaultTextButton(
                                text: 'LOGIN',
                                function: () {
                                  navigateTo(context, ShopLoginScreen());
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
