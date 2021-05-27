class FavouritesModel {
  bool status;
  String message;

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
