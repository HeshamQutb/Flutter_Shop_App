




class CategoryModel{
  dynamic status;
  CategoryDataModel? data;

  CategoryModel.fromjson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoryDataModel.fromjson(json['data']);
  }


}

class CategoryDataModel{
  dynamic currentPage;
  List<DataModel> data = [];

  CategoryDataModel.fromjson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromjson(element));
    });

  }


}

class DataModel{
  dynamic id;
  dynamic name;
  dynamic image;

  DataModel.fromjson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}