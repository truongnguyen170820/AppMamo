//
// //typedef void RatingChangeCallback(double rating);
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';
//
// class StarRating extends StatelessWidget {
//   final int starCount;
//   final double rating;
//   final RatingChangeCallback onRatingChanged;
//   final Color color;
//
//   StarRating({this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});
//
//   Widget buildStar(BuildContext context, int index) {
//     Icon icon;
//     if (index >= rating) {
//       icon = new Icon(
//         Icons.star_border,
//         color: Colors.yellow,
//       );
//     }
//     else if (index > rating - 1 && index < rating) {
//       icon = new Icon(
//         Icons.star_half,
//         color: color ?? Colors.black26,
//       );
//     } else {
//       icon = new Icon(
//         Icons.star,
//         color: color ?? Theme.of(context).primaryColor,
//       );
//     }
//     return new InkResponse(
//       onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
//       child: icon,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Row(children: new List.generate(starCount, (index) => buildStar(context, index)));
//   }
// }