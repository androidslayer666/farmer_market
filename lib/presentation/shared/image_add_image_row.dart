import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'icon_gradient_button.dart';


class ImageAddImageRow extends StatefulWidget {
  const ImageAddImageRow(
      {Key? key, this.isImageLoading, this.image, required this.addImageFromGallery, required this.addImageFromCamera})
      : super(key: key);

  final bool? isImageLoading;
  final Uint8List? image;
  final Function addImageFromGallery;
  final Function addImageFromCamera;

  @override
  State<ImageAddImageRow> createState() => _ImageAddImageRowState();
}

class _ImageAddImageRowState extends State<ImageAddImageRow> {

  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isImageLoading == true) {
      return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50, minWidth: 50),
          child:
          CircularProgressIndicator(color: Theme
              .of(context)
              .primaryColor));
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.image == null)
            IconGradientButton(
              color: Theme
                  .of(context)
                  .primaryColor,
              onPressed: () {
                setState(() {
                  showOptions = !showOptions;
                });
              },
              size: 40,
              iconData: Icons.add_a_photo,
            ),
          if (widget.image != null)
            GestureDetector(
                onTap: () {
                  setState(() {
                    showOptions = !showOptions;
                  });
                },
                child: ConstrainedBox(
                  constraints:
                  const BoxConstraints(maxHeight: 50, minWidth: 50),
                  child: CircleAvatar(
                    backgroundImage: MemoryImage(widget.image!),
                    radius: 50,
                  ),
                )),
          if (showOptions) const SizedBox(width: 30),
          if (showOptions)
            IconGradientButton(
              color: Theme
                  .of(context)
                  .primaryColor,
              onPressed: () {
                widget.addImageFromGallery();
              },
              iconData: Icons.image_search,
              size: 30,
            ),
          if (showOptions) const SizedBox(width: 30),
          if (showOptions)
            IconGradientButton(
              color: Theme
                  .of(context)
                  .primaryColor,
              onPressed: () {
                widget.addImageFromCamera();
              },
              iconData: Icons.camera_alt,
              size: 30,
            ),
        ],
      );
    }
  }
}
