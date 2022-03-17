import 'dart:io';

import 'package:flutter/material.dart';

class SavedImageView extends StatefulWidget {
  const SavedImageView({Key? key, this.image}) : super(key: key);
  final File? image;
  @override
  State<SavedImageView> createState() => _SavedImageViewState();
}

class _SavedImageViewState extends State<SavedImageView> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(
                  widget.image!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(bottom: 30, right: 30, child: Icon(Icons.download)),
        ],
      )),
    );
  }
}
