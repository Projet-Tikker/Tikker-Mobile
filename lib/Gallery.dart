import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:transparent_image/transparent_image.dart';

class MyGallery extends StatefulWidget {
  List<dynamic> images;
  MyGallery({super.key, required this.images});

  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Gallery'),
      ),
      body: GridView.builder(
        itemCount: widget.images[0]['files'].length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.pop(
            context,
            {
              'path': widget.images[0]['files'][index],
            },
          ),
          child: Container(
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: FileImage(
                File(
                  widget.images[0]['files'][index],
                ),
              ),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
