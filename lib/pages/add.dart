

import 'package:firebase_test/models/book.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {


  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  late Book _book;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _book = ModalRoute.of(context)!.settings.arguments as Book;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
        actions: [IconButton(
          onPressed: (){
            Navigator.of(context).pop(_book);
          },
          icon: Icon(Icons.check),
        )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: _book.title,
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              onChanged: (text) {
                _book.title = text;
              },
            ),
            TextFormField(
              initialValue: _book.author,
              decoration: InputDecoration(
                  labelText: 'Author'
              ),
              onChanged: (qwe){
                _book.author = qwe;
              },
            ),
            TextFormField(
              initialValue: _book.date,
              decoration: InputDecoration(
                  labelText: 'Date'
              ),
              onChanged: (text){
                _book.date = text;
              },
            ),
            TextFormField(
              initialValue: _book.edition,
              decoration: InputDecoration(
                  labelText: 'Edition'
              ),
              onChanged: (text){
                _book.edition = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
