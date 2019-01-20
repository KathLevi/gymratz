import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * EXAMPLE for inside a widget or something:
   getAllRoutes().listen((data){  
      if (data.documents.length>0){ 
        print(data.documents[0].documentID);
      }
    });
 */

class FirestoreAPI {
  final Firestore _firestore = Firestore.instance;

// route getters
  getAllRoutes() {
    return _firestore.collection('routes').snapshots();
  }

  getRouteById(id) {
    return _firestore.collection('routes').document(id).snapshots();
  }

  getRoutesByName(name) {
    return _firestore
        .collection('routes')
        .where('name', isEqualTo: name)
        .snapshots();
  }

  getRoutesByUserId(userId) {
    return _firestore
        .collection('routes')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

// user setters
/**
 * This must be done every single time a new user has been registered
 */
  addUser(data) {
    return _firestore.collection('users').add(data);
  }

// user getters
  getUserById(id) {
    return _firestore.collection('users').document(id).snapshots();
  }

  getAllUsers() {
    return _firestore.collection('users').snapshots();
  }

  getUsersByUserName(username) {
    return _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .snapshots();
  }

//todo getters

//favorite route getters

// gym getters
  getGymById(id) {
    return _firestore.collection('gyms').document(id).snapshots();
  }

  getAllGyms() {
    return _firestore.collection('gyms').snapshots();
  }

  getGymsByName(name) {
    return _firestore
        .collection('gyms')
        .where('name', isEqualTo: name)
        .snapshots();
  }
}
