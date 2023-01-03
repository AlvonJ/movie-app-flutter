import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  final String? defaultImage;
  const UserImagePicker(this.imagePickFn, {super.key, this.defaultImage});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    if (pickedImage == null) return;

    final pickedImageFile = File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });

    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_pickedImage != null)
          CircleAvatar(
            radius: 46,
            backgroundColor: Colors.grey,
            backgroundImage: FileImage(_pickedImage!),
          ),
        if (_pickedImage == null && widget.defaultImage == null)
          const CircleAvatar(
            radius: 46,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('./assets/img/profile.jpg'),
          ),
        if (_pickedImage == null && widget.defaultImage != null)
          CircleAvatar(
            radius: 46,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage('${widget.defaultImage}'),
          ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
