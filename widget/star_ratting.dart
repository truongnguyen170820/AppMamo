import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamo/widget/global.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color color;
  final double size;
  final RatingChangeCallback onRatingChanged;

  StarRating(
      {this.starCount = 5,
        this.onRatingChanged,
        this.rating = .0,
        this.color,
        this.size = 20});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border_outlined,
        color: Colors.amber,
        size: setWidth(size),
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Colors.black26,
        size: setWidth(size),
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
        size: setWidth(size),
      );
    }
    return new InkResponse(
      onTap:
      onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children:
        new List.generate(starCount, (index) => buildStar(context, index)));
  }
}
