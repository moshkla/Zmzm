import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/layout/cubit/cubit.dart';
import 'package:zmzm/layout/cubit/states.dart';
import 'package:zmzm/shared/components/components.dart';
import 'package:zmzm/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);

        nameController.text = cubit.userDataModel!.data!.name!;
        emailController.text = cubit.userDataModel!.data!.email!;
        phoneController.text = cubit.userDataModel!.data!.phone!;
        return ConditionalBuilder(
          condition: cubit.userDataModel != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: Formkey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                    LinearProgressIndicator(),
                    SizedBox(height: 20.0,),
                    const Text(
                      'Your Profile',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      label: 'Name',
                      onTap: () {
                        print('name tapped');
                      },
                      onSubmit: () {
                        print('submitted');
                      },
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.text,
                      onTap: () {
                        print('email tapped');
                      },
                      onSubmit: () {
                        print('submitted');
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      onTap: () {
                        print('phone tapped');
                      },
                      onSubmit: () {
                        print('submitted');
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Phone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        btnText: 'UPDATE',
                        function: () {
                          cubit.updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        btnText: 'LogOut',
                        function: () {
                          signOut(context);
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
