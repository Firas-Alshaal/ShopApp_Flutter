import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopCubit.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopState.dart';
import 'package:shop_app/shared/Components/component.dart';

class Setting extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = ShopCubit.get(context).userModel.data.name;
        emailController.text = ShopCubit.get(context).userModel.data.email;
        phoneController.text = ShopCubit.get(context).userModel.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name mast not be empty';
                          }
                        },
                        label: 'name',
                        prefix: Icons.person,
                        theme: Theme.of(context).textTheme.bodyText1,
                        colorIcon: Theme.of(context).iconTheme.color),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'email mast not be empty';
                          }
                        },
                        label: 'Email Address',
                        theme: Theme.of(context).textTheme.bodyText1,
                        prefix: Icons.email,
                        colorIcon: Theme.of(context).iconTheme.color),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone mast not be empty';
                          }
                        },
                        label: 'Phone',
                        theme: Theme.of(context).textTheme.bodyText1,
                        prefix: Icons.phone,
                        colorIcon: Theme.of(context).iconTheme.color),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'update'),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'log out'),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
