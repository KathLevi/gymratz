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
    backgroundColor: teal,
    centerTitle: true,
    title: Text('GYMRATZ',
        style: TextStyle(color: Colors.white, fontSize: subheaderFont)),
    bottom: controller == null
        ? null
        : !profile
            ? TabBar(
                controller: controller,
                tabs: myTabs,
                indicatorColor: Colors.white,
                indicatorWeight: 4.0)
            : PreferredSize(
                preferredSize: Size.fromHeight(150.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              getImage();
                            },
                            child: authAPI.user?.photoUrl == null
                                ? CircleAvatar(
                                    minRadius: 35.0,
                                    maxRadius: 35.0,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      user_icon,
                                      color: lightGrey,
                                      size: 30.0,
                                    ),
                                  )
                                : CircleAvatar(
                                    minRadius: 35.0,
                                    maxRadius: 35.0,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        NetworkImage(authAPI.user.photoUrl),
                                  )),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(authAPI.user.displayName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: headerFont,
                                      fontWeight: FontWeight.w300)),
                              Text('12 friends',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: subheaderFont,
                                      fontWeight: FontWeight.w300))
                            ],
                          ),
                        ),
                      ],
                    ),
                    TabBar(
                        controller: controller,
                        tabs: myTabs,
                        unselectedLabelStyle:
                            TextStyle(fontWeight: FontWeight.w300),
                        indicatorColor: teal,
                        indicatorWeight: 4.0)
                  ],
                )),
  );
}
