

// ignore_for_file: non_constant_identifier_names

class FavoriteModel{
  dynamic status;
  dynamic message;
  FavoriteModel.fromjson(Map<String, dynamic>json){
    status= json['status'];
    message= json['message'];
  }

}



