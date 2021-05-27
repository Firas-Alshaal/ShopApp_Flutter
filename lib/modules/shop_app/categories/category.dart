import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopCubit.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopState.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/shared/Components/component.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildCatItem(cubit.categoriesModel.data.data[index],context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.categoriesModel.data.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model,context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 120.0,
              width: 120.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
