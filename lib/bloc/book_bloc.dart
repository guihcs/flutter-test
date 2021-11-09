import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookBloc extends Cubit<List<Book>?> {
  BookBloc() : super(null) {
    FirebaseFirestore.instance.collection('books').snapshots().listen((event) {
      List<Book> bookList = event.docs.map((e){
        dynamic json = e.data();
        json['id'] = e.id;
        return Book.fromJson(json);
      }).toList();

      emit(bookList);
    });
  }


  addBook(Book book) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc()
        .set(book.toJson());
  }

  void edit(Book b) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc(b.id)
        .set(b.toJson());
  }
}
