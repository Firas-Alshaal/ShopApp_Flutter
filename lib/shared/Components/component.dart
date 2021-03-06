import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopCubit.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/Styles/Colors.dart';
import 'package:shop_app/shared/Styles/themes.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  TextStyle style,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  TextStyle theme,
  Color colorIcon,
  Function suffixPressed,
  bool isClickable = true,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    onTap: onTap,
    style: style,
    enabled: isClickable,
    validator: validate,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: theme, // dark
        prefixIcon: Icon(prefix,color: colorIcon,),
        suffixIcon: suffix != null
            ? IconButton(icon: Icon(suffix), onPressed: suffixPressed)
            : null,
        border: OutlineInputBorder()),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );


void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({
  @required String text,
  @required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.red;
      break;
    case ToastState.ERROR:
      color = Colors.lightBlueAccent;
      break;
  }
  return color;
}

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

Widget buildListProduct(model, context,{bool oldPrice = true}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0),
              if (model.discount != 0 && oldPrice)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(height:1.3 ,fontSize: 16.0),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          color: defaultColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0 && oldPrice)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor:
                            ShopCubit.get(context).favourites[model.id]
                                ? defaultColor
                                : Colors.grey,
                        radius: 15.0,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        ShopCubit.get(context).postChangeFavourite(model.id);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

String token = '';
