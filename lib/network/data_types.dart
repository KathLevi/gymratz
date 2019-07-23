import 'package:cloud_firestore/cloud_firestore.dart';
// set map is used for adding data to a collection
// from snapshot is used for getting data and converting it into an object for ease of use

class Gym {
  String id;
  String name;
  String address;
  String bgImage;
  String image;
  String logo;
  String description;
  String website;
  List<String> features = new List<String>();
  List<String> hours = new List<String>();
  List<String> rates = new List<String>();

  Gym(this.id, this.name, this.address, this.bgImage, this.image, this.logo,
      this.description, this.website, this.features, this.hours, this.rates);

  Gym.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        name = snapshot['name'],
        address = snapshot['address'],
        bgImage = snapshot['backgroundImage'],
        image = snapshot['image'],
        logo = snapshot['logo'],
        description = snapshot['description'],
        website = snapshot['website'],
        features = snapshot['features'] != null
            ? List.from(snapshot['features'])
            : null,
        hours = snapshot['hours'] != null ? List.from(snapshot['hours']) : null,
        rates = snapshot['rates'] != null ? List.from(snapshot['rates']) : null;
}

enum Role { admin, moderator, user }

class User {
  String id;
  String username;
  List<dynamic> completed;
  List<dynamic> gyms;
  List<dynamic> todo;
  dynamic homeGym;

  User(this.id);

  User.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        completed = snapshot['completed'],
        gyms = snapshot['gyms'],
        todo = snapshot['todo'],
        homeGym = snapshot['homeGym'],
        username = snapshot['username'];
}

enum RouteTypes { boulder, rope, lead }

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
  List<Comment> comments;

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

class Comment {
  String id;
  String comment;
  DateTime date;
  dynamic userId;

  Comment(this.comment, this.userId, this.date);

  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        comment = snapshot['comment'],
        date = snapshot['date'].toDate(),
        userId = snapshot['userId'];

  Map<String, dynamic> setMap() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['userId'] = this.userId;
    data['date'] = this.date;
    return data;
  }
}

class Rating {
  String id;
  int rate;
  DateTime date;
  dynamic userId;

  Rating(this.rate, this.userId, this.date);

  Rating.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        rate = snapshot['rate'],
        date = snapshot['date'].toDate(),
        userId = snapshot['userId'];

  Map<String, dynamic> setMap() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['userId'] = this.userId;
    data['date'] = this.date;
    return data;
  }
}
