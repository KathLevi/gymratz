import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymratz/network/data_types.dart';

//TODO: figure out if there is a way to make this a future? Needed?

/// EXAMPLE FOR INSIDE A WIDGET OR SOMETHING
///
///   getAllRoutes().listen((data){
///    setState(() {
///     Route routes = date;
///   });
/// });

class FirestoreAPI {
  final Firestore _firestore = Firestore.instance;

  /// Routes
  Stream<List<Route>> getAllRoutes() {
    return _firestore.collection('routes').getDocuments().then((snapshot) {
      List<Route> routes = [];
      try {
        snapshot.documents.forEach((item) {
          routes.add(Route.fromSnapshot(item));
        });
        return routes;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<Route> getRouteById(id) {
    return _firestore.collection('routes').document(id).get().then((snapshot) {
      try {
        return Route.fromSnapshot(snapshot);
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<Route>> getRoutesByName(name) {
    return _firestore
        .collection('routes')
        .where('name', isEqualTo: name)
        .getDocuments()
        .then((snapshot) {
      List<Route> routes = [];
      try {
        snapshot.documents.forEach((item) {
          routes.add(Route.fromSnapshot(item));
        });
        return routes;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<Route>> getRoutesByUserId(id) {
    return _firestore
        .collection('routes')
        .where('userId', isEqualTo: id)
        .getDocuments()
        .then((snapshot) {
      List<Route> routes = [];
      try {
        snapshot.documents.forEach((item) {
          routes.add(Route.fromSnapshot(item));
        });
        return routes;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  /// Users
// This must be done every single time a new user has been registered
  //TODO: add user stream? future?
  addUser(data) {
    return _firestore.collection('users').add(data);
  }

  Stream<User> getUserById(id) {
    return _firestore.collection('users').document(id).get().then((snapshot) {
      try {
        return User.fromSnapshot(snapshot);
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<User>> getAllUsers() {
    return _firestore.collection('users').getDocuments().then((snapshot) {
      List<User> users = [];
      try {
        snapshot.documents.forEach((item) {
          users.add(User.fromSnapshot(item));
        });
        return users;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<User>> getUserByName(username) {
    return _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments()
        .then((snapshot) {
      List<User> users = [];
      try {
        snapshot.documents.forEach((item) {
          users.add(User.fromSnapshot(item));
        });
        return users;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }
  //todo: favorite route getters

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

  //TODO: only load active gyms
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

  Stream<List<Gym>> loadGymByName(name) {
    return _firestore
        .collection('gyms')
        .where('name', isEqualTo: name)
        .getDocuments()
        .then((snapshot) {
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
}
