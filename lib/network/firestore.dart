import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';

/// EXAMPLE FOR INSIDE A WIDGET OR SOMETHING
///
///   getAllRoutes().listen((data){
///    setState(() {
///     Route routes = date;
///   });
/// });

class Collections {
  String ratings = 'ratings';
  String routes = 'routes';
  String users = 'users';
  String comments = 'comments';
  String gyms = 'gyms';
}

Collections collections = new Collections();

class FirestoreAPI {
  final Firestore _firestore = Firestore.instance;
  User user;

  FirestoreAPI();

  /// Users
// This must be done every single time a new user has been registered
  //TODO: add user stream? future?
  addUser(uid, username) async {
    final CollectionReference userRef = Firestore.instance.collection('/users');

    // Post post = new Post(postID, "title", "content");
    // Map<String, dynamic> postData = post.toJson();
    await userRef.document(uid).setData({username: username});

    // return _firestore.collection('users').add(data);
  }

  updateUser(uid, username) async {
    final CollectionReference userRef = Firestore.instance.collection('/users');
    await userRef.document(uid).updateData({username: username});
  }

  Stream<User> getUserById(id) {
    return _firestore
        .collection(collections.users)
        .document(id)
        .get()
        .then((snapshot) {
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
      _firestore
          .collection(collections.users)
          .document(id)
          .get()
          .then((snapshot) {
        user = User.fromSnapshot(snapshot);
      });
    } else {
      user = null;
    }
  }

  Stream<List<User>> getAllUsers() {
    return _firestore
        .collection(collections.users)
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

  Stream<List<User>> getUserByName(username) {
    return _firestore
        .collection(collections.users)
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

  /// CLIMBS / ROUTES
  Future addClimb(ClimbingRoute route, File image) async {
    storageAPI
        .uploadImage(image, route.gymId, route.name)
        .then((String urlString) {
      final TransactionHandler createTransaction = (Transaction tx) async {
        final DocumentSnapshot ds = await tx
            .get(Firestore.instance.collection(collections.routes).document());
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

  Stream<ClimbingRoute> getClimbById(id) {
    return _firestore
        .collection(collections.routes)
        .document(id)
        .get()
        .then((snapshot) async {
      try {
        return ClimbingRoute.fromSnapshot(snapshot);
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<Comment>> getCommentsByClimbId(id) {
    return _firestore
        .collection(collections.routes)
        .document(id)
        .collection(collections.comments)
        .getDocuments()
        .then((snapshot) {
      List<Comment> comments = [];
      try {
        snapshot.documents.forEach((item) {
          comments.add(Comment.fromSnapshot(item));
        });
        return comments;
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  Stream<List<ClimbingRoute>> getClimbsForGymByType(gymId, type) {
    return _firestore
        .collection(collections.routes)
        .where('gymId', isEqualTo: gymId)
        .where('type', isEqualTo: type)
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

  Stream<List<ClimbingRoute>> getClimbsByUserId(id) {
    return _firestore
        .collection(collections.routes)
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

  void addCommentToClimb(String comment, ClimbingRoute climb) {
    Comment myComment = Comment(comment, user.id, DateTime.now());
    _firestore
        .collection(collections.routes)
        .document(climb.id)
        .collection(collections.comments)
        .add(myComment.setMap());
  }

  void addClimbRating(ClimbingRoute climb, int rating) {
    Rating myRating = Rating(rating, user.id, DateTime.now());
    _firestore
        .collection(collections.routes)
        .document(climb.id)
        .collection(collections.ratings)
        .add(myRating.setMap());
  }

  void updateClimbRating(ClimbingRoute climb, Rating rating) {
    _firestore
        .collection(collections.routes)
        .document(climb.id)
        .collection(collections.ratings)
        .document(rating.id)
        .setData(rating.setMap());
  }

  Stream<Rating> getClimbRating(String id) {
    return _firestore
        .collection(collections.routes)
        .document(id)
        .collection(collections.ratings)
        .where('userId', isEqualTo: user.id)
        .getDocuments()
        .then((snapshot) {
      try {
        if (snapshot.documents.length > 1) {
          print('ERROR: user has multiple ratings for this climb');
          return null;
        }
        return Rating.fromSnapshot(snapshot.documents[0]);
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  bool isClimbToDo(String id) {
    DocumentReference ref =
        _firestore.collection(collections.routes).document(id);
    if (user.todo != null) {
      return !(user.todo.indexOf(ref) == -1);
    } else {
      return false;
    }
  }

  bool isClimbCompleted(String id) {
    DocumentReference ref =
        _firestore.collection(collections.routes).document(id);
    if (user.completed != null) {
      return !(user.completed.indexOf(ref) == -1);
    }
    return false;
  }

  void markToDoClimb(ClimbingRoute climb, bool isToDo) {
    print('TO DO CLIMB' + isToDo.toString());
    String id = authAPI.user.uid;
    DocumentReference ref =
        _firestore.collection(collections.routes).document(climb.id);
    if (!isToDo) {
      _firestore.collection(collections.users).document(id).updateData({
        "todo": FieldValue.arrayUnion([ref])
      }).then((n) {
        this.updateGlobalUser();
      });
    } else {
      _firestore.collection(collections.users).document(id).updateData({
        "todo": FieldValue.arrayRemove([ref])
      }).then((n) {
        this.updateGlobalUser();
      });
    }
  }

  void markCompletedClimb(ClimbingRoute climb, bool isCompleted) {
    print('TO DO Completed' + isCompleted.toString());

    String id = authAPI.user.uid;
    DocumentReference ref =
        _firestore.collection(collections.routes).document(climb.id);
    if (!isCompleted) {
      _firestore.collection(collections.users).document(id).updateData({
        "completed": FieldValue.arrayUnion([ref])
      }).then((n) {
        this.updateGlobalUser();
      });
    } else {
      _firestore.collection(collections.users).document(id).updateData({
        "completed": FieldValue.arrayRemove([ref])
      }).then((n) {
        this.updateGlobalUser();
      });
    }
  }

  /// Gyms
  Stream<Gym> loadGymById(id) {
    return _firestore
        .collection(collections.gyms)
        .document(id)
        .get()
        .then((snapshot) {
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
    return _firestore
        .collection(collections.gyms)
        .getDocuments()
        .then((snapshot) {
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
        .collection(collections.gyms)
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

  bool isFavoriteGym(String id) {
    DocumentReference ref =
        _firestore.collection(collections.gyms).document(id);
    if (user?.gyms != null) {
      return !(user.gyms.indexOf(ref) == -1);
    } else {
      return false;
    }
  }

  void favoriteGym(Gym gym, bool favorite) {
    String id = authAPI.user.uid;
    DocumentReference ref =
        _firestore.collection(collections.gyms).document(gym.id);
    if (favorite) {
      _firestore.collection(collections.users).document(id).updateData({
        "gyms": FieldValue.arrayRemove([ref])
      }).then((n) {
        this.updateGlobalUser();
      });
    } else {
      _firestore.collection(collections.users).document(id).updateData({
        "gyms": FieldValue.arrayUnion([ref])
      }).then((n) {
        this.updateGlobalUser();
      });
    }
  }
}
