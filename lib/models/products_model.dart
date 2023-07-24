// ignore_for_file: non_constant_identifier_names





class ProductsData{
  dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic image;
  dynamic product;
  dynamic name;
  dynamic description;
  dynamic images;
  dynamic in_favorites;
  dynamic in_cart;
  dynamic discount;

  ProductsData.fromjson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
    discount = json['discount'];
  }

}

class BannersData{
  dynamic id;
  dynamic image;
  dynamic category;
  dynamic product;

  BannersData.fromjson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

}



class HomeDataModel{
  dynamic banners = [];
  dynamic products = [];
  dynamic ad;

  HomeDataModel.fromjson(Map<String, dynamic> json){

    json['banners'].forEach((element) {
      banners.add(BannersData.fromjson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsData.fromjson(element));
    });

    ad = json['ad'];
  }

}


class HomeModel {
  dynamic status;
  HomeDataModel? data;

  HomeModel.fromjson(Map<String, dynamic> json){
    status = json['status'];
    data = json['data'] != null? HomeDataModel.fromjson(json['data']):null;
  }
}