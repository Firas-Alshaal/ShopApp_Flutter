import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/lauout/shoping_app/cubit/shopState.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/favoutites_model.dart';
import 'package:shop_app/models/shop_app/getFavourites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/categories/category.dart';
import 'package:shop_app/modules/shop_app/favourite/favourite.dart';
import 'package:shop_app/modules/shop_app/products/product.dart';
import 'package:shop_app/modules/shop_app/settings/setting.dart';
import 'package:shop_app/shared/Components/component.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/end_point.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    Products(),
    Category(),
    Favourite(),
    Setting(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favourites.addAll({
          element.id: element.inFavourite,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(url: CATEGORIES).then((value) {
      /*ليس شرطا استخدام Token لانني استخدم GET*/
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }

  Map<int, bool> favourites = {};
  FavouritesModel favouritesModel;

  void postChangeFavourite(int productId) {
    favourites[productId] = !favourites[productId];
    emit(ShopChangeFavouriteDataState());

    DioHelper.postData(
            url: FAVOURITES,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);

      if (!favouritesModel.status) {
        favourites[productId] = !favourites[productId];
      } else {
        getFavourite();
      }

      emit(ShopSuccessFavouriteDataState(favouritesModel));
    }).catchError((error) {
      favourites[productId] = !favourites[productId];

      emit(ShopErrorFavouriteDataState(error));
      print(error.toString());
    });
  }

  GetFavouriteData getFavouriteModel;

  void getFavourite() {
    emit(ShopLoadingGetFavouritesState());
    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      /*شرط استخدام Token لانني استخدم ال favourite  الخاصة بي*/
      getFavouriteModel = GetFavouriteData.fromJson(value.data);
      emit(ShopSuccessGetFavouritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavouritesState(error.toString()));
    });
  }

  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingGetUserState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      /*شرط استخدام Token لانني استخدم ال favourite  الخاصة بي*/
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserState(userModel));
    }).catchError((error) {
      emit(ShopErrorGetUserState(error.toString()));
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateState());
    DioHelper.putData(url: UPDATE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      /*شرط استخدام Token لانني استخدم ال favourite  الخاصة بي*/
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateState(error.toString()));
    });
  }

  void changeMode(context) {
    if (AppCubit.get(context).isDark){
      emit(AppChangeStates());}
    else {
      emit(AppChangeStates());
    }
  }
}
