import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/Screens/cubit.dart';

import '../../shared/cubit/Screens/states.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var emailController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context,state){},
        builder: (context,state){

          var cubit = ShopCubit.get(context).userData;
          var formKey = GlobalKey<FormState>();
          emailController.text = cubit?.data?.email;
          nameController.text = cubit?.data?.name;
          phoneController.text = cubit?.data?.phone;
          return ConditionalBuilder(
              condition: ShopCubit.get(context).userData != null,
              builder: (context)=> Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is ShopUpdateUserDataLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Name Must not be Empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefixIcon: Icons.person
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Email Address Must not be Empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefixIcon: Icons.email
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Phone Must not be Empty';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefixIcon: Icons.phone
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(function: (){
                        if(formKey.currentState!.validate()){
                          ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                          );
                        }
                      },
                          text: 'update'
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(function: (){
                        signOut(context);
                      },
                          text: 'Logout'
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context)=> const Center(child: CircularProgressIndicator())
          );
        });
  }
}
