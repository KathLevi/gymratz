import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/star_display.dart';

class CommentsOverlay extends ModalRoute<void> {
  final ClimbingRoute route;
  final Rating myRating;
  CommentsOverlay({this.route, this.myRating});

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.75);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  TextEditingController _newCommentCtrl = new TextEditingController();
  FocusNode _newCommentFocusNode = new FocusNode();
  int rating = 0;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    rating = myRating == null ? 0 : myRating.rate;
    return Material(
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.close, size: xsIcon),
                    onPressed: () => Navigator.of(context).pop()),
                Text(
                  'Add Comment',
                  style: TextStyle(
                      fontWeight: FontWeight.w300, fontSize: subheaderFont),
                )
              ],
            ),
            FlatButton(
                child: Text(
                  'Post',
                  style: TextStyle(color: teal, fontSize: subheaderFont),
                ),
                onPressed: () {
                  if (myRating == null && rating > 0) {
                    // only add a rating if there wasn't already one for that climb AND if rating > 0
                    fsAPI.addClimbRating(route, rating);
                  } else if (myRating != null && rating != myRating.rate) {
                    // update the rating if one existed and it changed
                    myRating.rate = rating;
                    fsAPI.updateClimbRating(route, myRating);
                  }
                  // only add a comment if the text field has something in it
                  if (_newCommentCtrl.text.trim().length != 0) {
                    fsAPI.addCommentToClimb(_newCommentCtrl.text, route);
                  }
                  Navigator.of(context).pop();
                })
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Text(
                route.name + ', ',
                style: TextStyle(fontSize: subheaderFont),
              ),
              Text(
                route.grade,
                style: TextStyle(fontSize: subheaderFont),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: StatefulBuilder(
            builder: (context, setState) {
              return StarDisplay(
                onChanged: (index) {
                  setState(() {
                    rating = index;
                  });
                },
                value: rating,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add Comment',
                hintStyle: TextStyle(
                    fontSize: subheaderFont, fontWeight: FontWeight.w300)),
            controller: _newCommentCtrl,
            textCapitalization: TextCapitalization.sentences,
            focusNode: _newCommentFocusNode,
            onSubmitted: (str) {
              _newCommentFocusNode.unfocus();
            },
            textInputAction: TextInputAction.done,
            maxLines: null,
          ),
        ),
        Expanded(
          child: InkWell(
              child: Container(),
              onTap: () =>
                  FocusScope.of(context).requestFocus(_newCommentFocusNode)
              // onTap: () => _newCommentFocusNode.requestFocus(),
              ),
        )
      ],
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
