import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/bloc/book_bloc.dart';
import 'package:firebase_test/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAuth extends StatefulWidget {
  const HomeAuth({Key? key}) : super(key: key);

  @override
  _HomeAuthState createState() => _HomeAuthState();
}

class _HomeAuthState extends State<HomeAuth> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Book? book = await Navigator.of(context).pushNamed('add', arguments: Book.empty()) as Book?;

            if (book != null) {
              BlocProvider.of<BookBloc>(context).addBook(book);
            }
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Livro'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamed('login');
              },
            )
          ],
        ),
        body: BlocBuilder<BookBloc, List<Book>?>(
          builder: (context, state) {
            if (state == null) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                Book book = state[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  trailing: Text(book.edition),
                  onTap: () async {
                    Book? b = await Navigator.of(context).pushNamed('add', arguments: book) as Book?;

                    if (b != null) {
                      BlocProvider.of<BookBloc>(context).edit(b);
                    }
                  },
                );
              },
            );
          },
        ));
  }
}
