import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/widgets/loading_spinner.dart';
import 'package:movie_app/widgets/user_image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final formKey = GlobalKey<FormState>();

  Map<String, dynamic> profileData = {
    'name': '',
    'phone': '',
    'address': '',
  };

  File? _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    FirebaseStorage storage = FirebaseStorage.instance;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(size: 26, color: Colors.white),
          elevation: 0,
          title: const Text(
            "Edit Profile",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<DocumentSnapshot>(
                    future: users.doc(user?.uid).get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return Form(
                          key: formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    data['image_url'] == null ||
                                            data['image_url'] == ''
                                        ? UserImagePicker(_pickedImage)
                                        : UserImagePicker(
                                            _pickedImage,
                                            defaultImage: data['image_url'],
                                          ),
                                  ],
                                ),
                                const SizedBox(height: 40),
                                TextFormField(
                                  initialValue: data['email'] ?? '',
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  cursorColor: Theme.of(context).primaryColor,
                                  enabled: false,
                                  style: const TextStyle(
                                      color: Colors.white38, fontSize: 18),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) =>
                                      email != null && email.isEmpty
                                          ? 'Email can\'t be empty'
                                          : null,
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      floatingLabelStyle: const TextStyle(
                                          color: Colors.white54, fontSize: 22),
                                      labelStyle: const TextStyle(
                                          color: Colors.white38,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white24),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white24),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white70),
                                          borderRadius: BorderRadius.circular(16))),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  initialValue: data['name'] ?? '',
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  cursorColor: Theme.of(context).primaryColor,
                                  onSaved: (value) {
                                    profileData['name'] = value!.trim();
                                  },
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 18),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (name) =>
                                      name != null && name.isEmpty
                                          ? 'Name can\'t be empty'
                                          : null,
                                  decoration: InputDecoration(
                                      labelText: "Name",
                                      floatingLabelStyle: const TextStyle(
                                          color: Colors.white54, fontSize: 22),
                                      labelStyle: const TextStyle(
                                          color: Colors.white38,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white24),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white70),
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  initialValue: data['phone'] ?? '',
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Theme.of(context).primaryColor,
                                  onSaved: (value) {
                                    profileData['phone'] = value!.trim();
                                  },
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 18),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (phone) {
                                    if (phone != null && phone.isEmpty) {
                                      return 'Phone number can\'t be empty';
                                    } else if (num.tryParse(phone!) == null) {
                                      return 'Phone number must be a number';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Phone Number",
                                      floatingLabelStyle: const TextStyle(
                                          color: Colors.white54, fontSize: 22),
                                      labelStyle: const TextStyle(
                                          color: Colors.white38,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white24),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white70),
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  initialValue: data['address'] ?? '',
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.streetAddress,
                                  cursorColor: Theme.of(context).primaryColor,
                                  onSaved: (value) {
                                    profileData['address'] = value!.trim();
                                  },
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 18),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (address) =>
                                      address != null && address.isEmpty
                                          ? 'Address can\'t be empty'
                                          : null,
                                  decoration: InputDecoration(
                                      labelText: "Address",
                                      floatingLabelStyle: const TextStyle(
                                          color: Colors.white54, fontSize: 22),
                                      labelStyle: const TextStyle(
                                          color: Colors.white38,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white24),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white70),
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                                const SizedBox(height: 40),
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        final isValid =
                                            formKey.currentState!.validate();

                                        if (!isValid) return;

                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )));
                                        formKey.currentState!.save();

                                        try {
                                          final ref = storage
                                              .ref()
                                              .child('user_image')
                                              .child('${user!.uid}.jpg');

                                          if (_userImageFile != null) {
                                            await ref.putFile(_userImageFile!);

                                            final url =
                                                await ref.getDownloadURL();

                                            profileData['image_url'] = url;
                                          }

                                          await users
                                              .doc(user.uid)
                                              .update(profileData);

                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          context.goNamed('profile');
                                        } on FirebaseException catch (e) {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();

                                          showTopSnackBar(
                                              Overlay.of(context)
                                                  as OverlayState,
                                              CustomSnackBar.error(
                                                  message: e.toString()));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(180, 50)),
                                      child: const Text(
                                        'Save Changes',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                )
                              ]),
                        );
                      } else {
                        return const LoadingSpinner();
                      }
                    })),
          ],
        ));
  }
}
