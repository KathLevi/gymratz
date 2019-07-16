import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/add_comment_overlay.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/icon_button.dart';

class RouteScreen extends StatefulWidget {
  RouteScreen({Key key, this.climbingRoute});
  final ClimbingRoute climbingRoute;

  @override
  State<StatefulWidget> createState() {
    return RouteScreenState();
  }
}

class RouteScreenState extends State<RouteScreen> {
  var currentUser;
  bool istodo = false;
  bool isCompleted = false;
  Rating rate;
  ClimbingRoute currentRoute;
  TextEditingController _newCommentCtrl;

  @override
  void initState() {
    _newCommentCtrl = new TextEditingController();
    currentRoute = widget.climbingRoute;
    currentRoute.comments = [];

    getComments();
    super.initState();
  }

  void getComments() {
    if (fsAPI.user != null) {
      istodo = fsAPI.isClimbToDo(widget.climbingRoute.id);
      isCompleted = fsAPI.isClimbCompleted(widget.climbingRoute.id);
      fsAPI.getClimbRating(widget.climbingRoute.id).listen((data) {
        setState(() {
          rate = data;
        });
      });
    }
    fsAPI.getCommentsByClimbId(currentRoute.id).listen((data) {
      setState(() {
        currentRoute.comments = data;
      });
    });
  }

  @override
  void dispose() {
    _newCommentCtrl.dispose();
    super.dispose();
  }

  // todo KL: on iamge tap enable full screen image (scrollable as well)
  theImage() {
    if (currentRoute.pictureUrl != null) {
      return InkWell(
        onTap: () => print('please make me full screen'),
        child: Image.network(currentRoute.pictureUrl, fit: BoxFit.cover),
      );
    } else {
      return Text("No Image");
    }
  }

  //todo KL: get more than one image (maybe a scrollable carousel)
  images() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 150.0,
          width: MediaQuery.of(context).size.width * 0.45,
          child: theImage(),
        ),
        Container(
          height: 150.0,
          width: MediaQuery.of(context).size.width * 0.45,
          child: theImage(),
        )
      ],
    );
  }

  String getUser(String userId) {
    print(authAPI.user.uid);
    if (userId == authAPI.user.uid) {
      return 'Me';
    } else {
      return 'Someone Else';
    }
    //todo KL: figure out how to get the display name of other users if they aren't stored in the user table
    fsAPI.getUserById(userId).first.then((user) {
      return user.id;
    });
    return '';
  }

  String getDate(DateTime date) {
    var day, month, year, hour;
    DateTime today = DateTime.now();

    if (date != null) {
      day = date.day;
      month = date.month;
      year = date.year;
      hour = date.hour;

      // this year
      if (today.year == year) {
        // this month of this year
        if (today.month == month) {
          //this day of this month
          if (today.day == day) {
            // hours since the post has been made
            if (today.hour == hour) {
              return 'now';
            } else {
              return (today.hour - hour).toString() + ' hr';
            }
          } else {
            return (today.day - day).toString() + ' days';
          }
        } else {
          return (today.month - month).toString() + ' mo';
        }
      } else {
        return (today.year - year).toString() + ' yr';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context, profile: false),
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        currentRoute.name,
                        style: TextStyle(
                            fontSize: titleFont, fontWeight: FontWeight.w300),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'favorites',
                            style: TextStyle(
                              fontSize: subheaderFont,
                            ),
                          ),
                          Text(
                            '(20)',
                            style: TextStyle(
                                fontSize: subheaderFont,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                      width: 60.0,
                      height: 60.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: teal,
                          borderRadius: BorderRadius.circular(1000.0)),
                      child: Text(currentRoute.grade,
                          style: TextStyle(
                              color: currentRoute.color == 'white'
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: subheaderFont)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: images(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  iconButton(
                      icon: todo_icon,
                      title: 'To Do',
                      function: () {
                        fsAPI.markToDoClimb(widget.climbingRoute, istodo);
                        setState(() {
                          istodo = !istodo;
                        });
                      },
                      invert: istodo,
                      inactive: authAPI.user == null),
                  iconButton(
                      icon: check_icon,
                      title: 'Completed',
                      function: () {
                        fsAPI.markCompletedClimb(
                            widget.climbingRoute, isCompleted);
                        setState(() {
                          isCompleted = !isCompleted;
                        });
                      },
                      invert: isCompleted,
                      inactive: authAPI.user == null),
                  iconButton(
                      icon: star_icon,
                      title: 'Rate',
                      function: () => Navigator.of(context)
                              .push(CommentsOverlay(
                                  route: widget.climbingRoute, myRating: rate))
                              .then((_) {
                            getComments();
                          }),
                      inactive: authAPI.user == null,
                      invert: rate != null),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.all(20.0),
                color: teal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description',
                      style:
                          TextStyle(color: Colors.white, fontSize: headerFont),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        currentRoute.description,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: subheaderFont,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Comments',
                      style: TextStyle(fontSize: headerFont),
                    ),
                    currentRoute.comments.length == 0
                        ? Container(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              'So sad, no comments.',
                              style: TextStyle(
                                  fontSize: subheaderFont,
                                  fontWeight: FontWeight.w300),
                            ))
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                currentRoute.comments.length, (index) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        getUser(currentRoute
                                                .comments[index].userId) +
                                            ', ' +
                                            getDate(currentRoute
                                                .comments[index].date),
                                        style: TextStyle(
                                            fontSize: subheaderFont,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        currentRoute.comments[index].comment,
                                        style: TextStyle(
                                            fontSize: bodyFont,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ));
                            }),
                          ),
                    authAPI.user == null
                        ? Container()
                        : InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text('Add Comment',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: subheaderFont,
                                          color: grey)),
                                ),
                                Container(
                                  color: grey,
                                  height: 1.0,
                                ),
                              ],
                            ),
                            onTap: () => Navigator.of(context)
                                .push(CommentsOverlay(
                                    route: widget.climbingRoute,
                                    myRating: rate))
                                .then((_) {
                              getComments();
                            }),
                          )
                  ],
                )),
          ],
        )));
  }
}
