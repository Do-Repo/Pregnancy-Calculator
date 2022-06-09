import 'package:flutter/material.dart';

class Quotes with ChangeNotifier {
  String quote;
  String author;
  int id;
  Quotes(this.quote, this.author, this.id);
}
