import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pregnancy_app/src/const.dart';

import '../models/quotes.dart';

class QuoteCard extends StatefulWidget {
  const QuoteCard({Key? key, required this.quote, required this.author})
      : super(key: key);
  final String quote, author;
  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  @override
  Widget build(BuildContext context) {
    return (widget.quote.isEmpty)
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("“${widget.quote}”", style: thirdcardone),
                Text(widget.author, style: thirdcardtwo),
              ],
            ),
          );
  }
}
