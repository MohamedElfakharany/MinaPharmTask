class MovieDataModel {
  String? title ;
  String? poster;

  MovieDataModel.fromJson(Map<String, dynamic> json){
    title = json['title'];
    poster = json['poster'];
  }

}