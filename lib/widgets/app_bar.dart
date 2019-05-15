import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:image_picker/image_picker.dart';

/// example without tabs::  appBar(context, null, null);
/// example with tabs::   appBar(context, TabController, List<Tab>);

Widget appBar(
    {@required BuildContext context,
    TabController controller,
    List<Tab> myTabs,
    @required bool profile}) {
  Future getImage() async {
    var _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 1080.0, maxHeight: 1920.0);
    print(_image);
    if (_image != null) {
      storageAPI.uploadProfileImage(_image, authAPI.user.uid).then((imageURL) {
        UserUpdateInfo updateUser = new UserUpdateInfo();
        updateUser.photoUrl = imageURL;
        authAPI.updateFirebaseAuthProfile(updateUser).then((updatedUser) {
          // TODO: set state with the new user;
        });
      });
    }
  }

  return AppBar(
    backgroundColor: Colors.black,
    centerTitle: true,
    title: Text(
      'GYMRATZ',
      style: TextStyle(color: Colors.white, fontSize: headerFont),
    ),
    bottom: controller == null
        ? null
        : !profile
            ? TabBar(
                controller: controller,
                tabs: myTabs,
                indicatorColor: teal,
                indicatorWeight: 4.0)
            : PreferredSize(
                preferredSize: Size.fromHeight(150.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: authAPI.user?.photoUrl == null
                            ? CircleAvatar(
                                minRadius: 30.0,
                                maxRadius: 30.0,
                                backgroundColor: grey,
                                child: Icon(
                                  user_icon,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                              )
                            : CircleAvatar(
                                minRadius: 30.0,
                                maxRadius: 30.0,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(authAPI.user.photoUrl),
                              )),
                    Text(authAPI.user.displayName,
                        style: TextStyle(color: teal, fontSize: headerFont)),
                    TabBar(
                        controller: controller,
                        tabs: myTabs,
                        indicatorColor: teal,
                        indicatorWeight: 4.0)
                  ],
                )),
  );
}
