import 'dart:io';

import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/custom_text_field.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  static const route = '/EditProfile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final user = Account.currentUser;

  File _image;

  _EditProfileScreenState() {
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
          if (state is UserUpdated) {
            successSnackBar('User has been updated.', context);
            Navigator.pop(context);
          }
          if (state is UserUpdateFailure) {
            failureSnackBar(state.apiError.message, context);
          }
        }, builder: (context, state) {
          if (state is UserUpdating) {
            return CustomProgressIndicator();
          }
          return Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: CircleAvatar(
                                  radius: 55,
                                  child: _image != null
                                      // if image is not null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.file(
                                            _image,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      // else
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          width: 120,
                                          height: 120,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              user.fullName,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ],
                        ),
                      ),
                      spacer(),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                hintText: 'Enter your First Name',
                                labelText: 'First Name',
                                obscureText: false,
                                prefixIcon: Icons.person,
                                textFieldController: firstNameController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'First Name can\'t be empty';
                                  }
                                  if (value.length < 3) {
                                    return 'Enter a valid First Name';
                                  }

                                  user.firstName = value;
                                  return null;
                                },
                              ),
                              spacer(),
                              CustomTextField(
                                hintText: 'Enter your Last Name',
                                labelText: 'Last Name',
                                obscureText: false,
                                prefixIcon: Icons.person,
                                textFieldController: lastNameController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Last Name can\'t be empty';
                                  }
                                  if (value.length < 3) {
                                    return 'Enter a valid Last Name';
                                  }

                                  user.lastName = value;
                                  return null;
                                },
                              ),
                              spacer(height: 30),
                              mainBtn(
                                'Save',
                                () {
                                  // Local user validate
                                  final valid = formKey.currentState.validate();
                                  if (!valid) return;

                                  BlocProvider.of<UserBloc>(context)
                                      .add(UserUpdate(user, newImage: _image));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  // image picker from famera
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

// image picker from image gallery
  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

// show bottom sheet action fot upload image options
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
