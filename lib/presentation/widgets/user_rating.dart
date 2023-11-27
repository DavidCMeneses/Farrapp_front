
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserRating extends StatelessWidget {

  final int userRating;
  final String establishmentId;
  final Function(String, int) onChange;

  const UserRating({
    super.key,
    required this.userRating,
    required this.establishmentId,
    required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: userRating > -1 ? userRating.toDouble() : 3.0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) => onChange(establishmentId, rating.floor()),
    );
  }
}