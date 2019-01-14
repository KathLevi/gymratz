import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * EXAMPLE for inside a widget or something:
   getAllRoutes().listen((data){  
      if (data.documents.length>0){ 
        print(data.documents[0].documentID);
      }
    });
 */

// route getters
getAllRoutes() {
  return Firestore.instance.collection('routes').snapshots();
}

getRouteById(id) {
  return Firestore.instance.collection('routes').document(id).snapshots();
}

getRoutesByName(name) {
  return Firestore.instance
      .collection('routes')
      .where('name', isEqualTo: name)
      .snapshots();
}

getRoutesByUserId(userId) {
  return Firestore.instance
      .collection('routes')
      .where('userId', isEqualTo: userId)
      .snapshots();
}

// user getters
getUserById(id) {
  return Firestore.instance.collection('users').document(id).snapshots();
}

getAllUsers() {
  return Firestore.instance.collection('users').snapshots();
}

getUsersByUserName(username) {
  return Firestore.instance
      .collection('users')
      .where('username', isEqualTo: username)
      .snapshots();
}

//todo getters

//favorite route getters

// gym getters
getGymById(id) {
  return Firestore.instance.collection('gyms').document(id).snapshots();
}

getAllGyms() {
  return Firestore.instance.collection('gyms').snapshots();
}

getGymsByName(name) {
  return Firestore.instance
      .collection('gyms')
      .where('name', isEqualTo: name)
      .snapshots();
}
