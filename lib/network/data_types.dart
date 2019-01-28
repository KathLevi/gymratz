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
