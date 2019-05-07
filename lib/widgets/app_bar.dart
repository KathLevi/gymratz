import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

/// example without tabs::  appBar(context, null, null);
/// example with tabs::   appBar(context, TabController, List<Tab>);

Widget appBar(BuildContext context, TabController controller, List<Tab> myTabs,
    String image, String user) {
//  Future getImage() async {
//    var _image = await ImagePicker.pickImage(
//        source: ImageSource.camera, maxWidth: 1080.0, maxHeight: 1920.0);
//    print(_image);
//    if (_image != null) {
//      storageAPI.uploadProfileImage(_image, authAPI.user.uid).then((imageURL) {
//        UserUpdateInfo updateUser = new UserUpdateInfo();
//        updateUser.photoUrl = imageURL;
//        authAPI.updateFirebaseAuthProfile(updateUser).then((updatedUser) {
//          // TODO: set state with the new user;
//        });
//      });
//    }
//  }

  return AppBar(
    backgroundColor: Colors.black,
    title: Row(
      children: <Widget>[
        //TODO: replace with logo image
        Text(
          'GYM',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: mediumFont),
        ),
        Text(
          'RATZ',
          style: TextStyle(color: Colors.white, fontSize: mediumFont),
        ),
      ],
    ),
    bottom: controller == null
        ? null
        : image == null
            ? TabBar(
                controller: controller,
                tabs: myTabs,
                indicatorColor: teal,
                indicatorWeight: 4.0)
            : PreferredSize(
                preferredSize: Size.fromHeight(150.0),
                child: Column(
                  children: <Widget>[
                    //todo: add image not text
//                    InkWell(
//                        onTap: () {
//                          getImage();
//                        },
//                        child: CircleAvatar(
//                          minRadius: 30.0,
//                          maxRadius: 30.0,
//                          backgroundColor: Colors.white,
//                          backgroundImage: NetworkImage(authAPI.user.photoUrl),
//                        )),
                    Text(user == null ? 'Guest User' : user,
                        style: TextStyle(color: teal, fontSize: smallFont)),
                    TabBar(
                        controller: controller,
                        tabs: myTabs,
                        indicatorColor: teal,
                        indicatorWeight: 4.0)
                  ],
                )),
  );
}
