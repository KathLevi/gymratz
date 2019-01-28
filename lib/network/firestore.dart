import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymratz/network/data_types.dart';

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

  /// Routes
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

  /// Users
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
  //TODO: figure out if there is a way to make this a future? Needed?
  /// Gyms
  Stream<Gym> loadGymById(id) {
    return _firestore.collection('gyms').document(id).get().then((snapshot) {
      try {
        return Gym.fromSnapshot(snapshot);
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<Gym>> loadAllGyms() {
    return _firestore.collection('gyms').getDocuments().then((snapshot) {
      List<Gym> gyms = [];
      try {
        snapshot.documents.forEach((item) {
          gyms.add(Gym.fromSnapshot(item));
        });
        return gyms;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  getGymsByName(name) {
    return _firestore
        .collection('gyms')
        .where('name', isEqualTo: name)
        .snapshots();
  }
}
