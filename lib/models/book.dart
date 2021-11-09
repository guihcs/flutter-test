

class Book {
  String title = '';
  String author = '';
  String date = '';
  String edition = '';
  String id = '';

  Book.empty();

  Book(this.title, this.author, this.date, this.edition);

  Book.fromJson(dynamic json){
    title = json['title'];
    author = json['author'];
    date = json['date'];
    edition = json['edition'];
    id = json['id'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};

    json['title'] = title;
    json['author'] = author;
    json['date'] = date;
    json['edition'] = edition;

    return json;
  }


}