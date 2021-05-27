import 'package:shop_app/models/shop_app/favoutites_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

// Home Screen

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

// Categories
class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {
  final String error;

  ShopErrorCategoriesDataState(this.error);
}

// Favourite

class ShopChangeFavouriteDataState extends ShopStates {}

class ShopSuccessFavouriteDataState extends ShopStates {
  final FavouritesModel model;

  ShopSuccessFavouriteDataState(this.model);
}

class ShopErrorFavouriteDataState extends ShopStates {
  final String error;

  ShopErrorFavouriteDataState(this.error);
}

// Get Favourite

class ShopLoadingGetFavouritesState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {
  final String error;

  ShopErrorGetFavouritesState(this.error);
}

// Get Profile User

class ShopLoadingGetUserState extends ShopStates {}

class ShopSuccessGetUserState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessGetUserState(this.loginModel);
}

class ShopErrorGetUserState extends ShopStates {
  final String error;

  ShopErrorGetUserState(this.error);
}

// Update

class ShopLoadingUpdateState extends ShopStates {}

class ShopSuccessUpdateState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateState(this.loginModel);
}

class ShopErrorUpdateState extends ShopStates {
  final String error;

  ShopErrorUpdateState(this.error);
}


class AppChangeStates extends ShopStates {}