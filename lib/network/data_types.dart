import 'package:cloud_firestore/cloud_firestore.dart';

class Gym {
  String id;
  String name;
  String address;
  String bgImage;
  String image;
  String logo;
  String description;
  List<String> features = new List<String>();
  List<String> hours = new List<String>();
  List<String> rates = new List<String>();

  Gym(this.id, this.name, this.address, this.bgImage, this.image, this.logo,
      this.description, this.features, this.hours, this.rates);

  Gym.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        name = snapshot['name'],
        address = snapshot['address'],
        bgImage = snapshot['backgroundImage'],
        image = snapshot['image'],
        logo = snapshot['logo'],
        description = snapshot['description'],
        features = snapshot['features'] != null
            ? List.from(snapshot['features'])
            : null,
        hours = snapshot['hours'] != null ? List.from(snapshot['hours']) : null,
        rates = snapshot['rates'] != null ? List.from(snapshot['rates']) : null;
}

enum Role { admin, moderator, user }

class User {
  String id;
  String userId;
  int role;
  String displayName;
  List<dynamic> completed;
  List<dynamic> gyms;
  dynamic homeGym;
  List<dynamic> todo;

  User(this.id, this.userId, this.role, this.displayName);

  User.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        userId = snapshot['userId'],
        role = snapshot['role'],
        displayName = snapshot['displayName'],
        completed = snapshot['completed'],
        homeGym = snapshot['homeGym'],
        gyms = snapshot['gyms'],
        todo = snapshot['todo'];
}

enum RouteTypes { boulder, toprope, lead }

class ClimbingRoute {
  String id;
  String name;
  String color;
  String description;
  String grade;
  String gymId;
  String pictureUrl;
  String type;
  int rating;
  String userId;

  ClimbingRoute(this.name, this.color, this.description, this.grade, this.gymId,
      this.type, this.userId);

  ClimbingRoute.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        name = snapshot['name'],
        color = snapshot['color'],
        description = snapshot['description'],
        grade = snapshot['grade'],
        gymId = snapshot['gymId'],
        pictureUrl = snapshot['pictureUrl'],
        rating = snapshot['rating'],
        type = snapshot['string'],
        userId = snapshot['userId'];
}
