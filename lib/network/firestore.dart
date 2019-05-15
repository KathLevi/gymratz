import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gymratz/models/user.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/main.dart';
import 'dart:io';

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
  User user;

  FirestoreAPI();

  /// Routes
  Stream<List<ClimbingRoute>> getAllRoutes() {
    return _firestore.collection('routes').getDocuments().then((snapshot) {
      List<ClimbingRoute> routes = [];
      try {
        snapshot.documents.forEach((item) {
          routes.add(ClimbingRoute.fromSnapshot(item));
        });
        return routes;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  // I'm not too familiar with streams. Can we us a stream for this?
  Future addRoute(ClimbingRoute route, File image) async {
    storageAPI
        .uploadImage(image, route.gymId, route.name)
        .then((String urlString) {
      final TransactionHandler createTransaction = (Transaction tx) async {
        final DocumentSnapshot ds =
            await tx.get(Firestore.instance.collection('routes').document());
        var dataMap = new Map<String, dynamic>();
        dataMap['name'] = route.name;
        dataMap['color'] = route.color;
        dataMap['type'] = route.type;
        dataMap['grade'] = route.grade;
        dataMap['gymId'] = route.gymId;
        dataMap['description'] = route.description;
        dataMap['pictureUrl'] = urlString;
        await tx.set(ds.reference, dataMap);

        return dataMap;
      };
      return Firestore.instance.runTransaction(createTransaction);
    });
  }

  Stream<ClimbingRoute> getRouteById(id) {
    return _firestore.collection('routes').document(id).get().then((snapshot) {
      try {
        return ClimbingRoute.fromSnapshot(snapshot);
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<ClimbingRoute>> getBoulderRoutesByGymId(gymId) {
    return _firestore
        .collection('routes')
        .where('gymId', isEqualTo: gymId)
        .where('type', isEqualTo: 'boulder')
        .getDocuments()
        .then((snapshot) {
      List<ClimbingRoute> routes = [];
      try {
        snapshot.documents.forEach((item) {
          routes.add(ClimbingRoute.fromSnapshot(item));
        });
        return routes;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<ClimbingRoute>> getTopRopeRoutesByGymId(gymId) {
    return _firestore
        .collection('routes')
        .where('gymId', isEqualTo: gymId)
        .where('type', isEqualTo: 'rope')
        .getDocuments()
        .then((snapshot) {
      List<ClimbingRoute> routes = [];
      try {
        snapshot.documents.forEach((item) {
          routes.add(ClimbingRoute.fromSnapshot(item));
        });
        return routes;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  //   Stream<List<Gym>> loadAllGyms() {
  //   return _firestore.collection('gyms').getDocuments().then((snapshot) {
  //     List<Gym> gyms = [];
  //     try {
  //       snapshot.documents.forEach((item) {
  //         gyms.add(Gym.fromSnapshot(item));
  //       });
  //       return gyms;
  //     } catch (e) {
  //       print(e);
  //       return null;
  //     }
  //   }).asStream();
  // }

  Stream<List<ClimbingRoute>> getRoutesByName(name) {
    return _firestore
        .collection('routes')
        .where('name', isEqualTo: name)
        .getDocuments()
        .then((snapshot) {
      List<ClimbingRoute> routes = [];
      try {
        snapshot.documents.forEach((item) {
          routes.add(ClimbingRoute.fromSnapshot(item));
        });
        return routes;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<ClimbingRoute>> getRoutesByUserId(id) {
    return _firestore
        .collection('routes')
        .where('userId', isEqualTo: id)
        .getDocuments()
        .then((snapshot) {
      List<ClimbingRoute> routes = [];
      try {
        snapshot.documents.forEach((item) {
          routes.add(ClimbingRoute.fromSnapshot(item));
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

  bool isClimbToDo(String id) {
    DocumentReference ref = _firestore.collection('routes').document(id);
    return !(user.todo.indexOf(ref) == -1);
  }

  void markClimbAsToDo(ClimbingRoute climb) {
    print('adding climb');
    String id = authAPI.user.uid;
    DocumentReference ref = _firestore.collection('routes').document(climb.id);
    _firestore.collection('users').document(id).updateData({
      "todo": FieldValue.arrayUnion([ref])
    }).then((n) {
      this.updateGlobalUser();
    });
  }

  void unmarkClimbAsToDo(ClimbingRoute climb) {
    print('removing climb');
    String id = authAPI.user.uid;
    DocumentReference ref = _firestore.collection('routes').document(climb.id);
    _firestore.collection('users').document(id).updateData({
      "todo": FieldValue.arrayRemove([ref])
    }).then((n) {
      this.updateGlobalUser();
    });
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

  updateGlobalUser() {
    if (authAPI.user != null) {
      String id = authAPI.user.uid;
      _firestore.collection('users').document(id).get().then((snapshot) {
        user = User.fromSnapshot(snapshot);
      });
    }
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
  Stream<List<Gym>> loadAllGyms([String filter]) {
    return _firestore.collection('gyms').getDocuments().then((snapshot) {
      List<Gym> gyms = [];
      try {
        snapshot.documents.forEach((item) {
          if (Gym.fromSnapshot(item)
              .name
              .toLowerCase()
              .contains(filter.toLowerCase())) {
            gyms.add(Gym.fromSnapshot(item));
          }
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
