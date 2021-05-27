import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopCubit.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopState.dart';
import 'package:shop_app/modules/shop_app/search/search.dart';
import 'package:shop_app/shared/Components/component.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        bool change = AppCubit.get(context).isDark;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Market',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, Search());
                  }),
              Switch(
                value: !change,
                onChanged: (bool value) {
                  if (!change) {
                    AppCubit.get(context).isDark = value;
                    ShopCubit.get(context).changeMode(context);
                    AppCubit.get(context).changeModeApp();
                  } else {
                    AppCubit.get(context).isDark = value;
                    ShopCubit.get(context).changeMode(context);
                    AppCubit.get(context).changeModeApp();
                  }
                },
                activeColor: HexColor('7E7E7E'),
                activeTrackColor: Colors.white,
                inactiveTrackColor: HexColor('7E7E7E'),
                inactiveThumbColor: Colors.white,

                //activeTrackColor: Colors.red,
              )
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
