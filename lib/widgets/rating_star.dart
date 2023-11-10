import 'package:flutter/material.dart';

class RatingStars extends StatefulWidget {
  final int starCount;
  final double rating;
  final Color color;
  final double size;
  final ValueChanged<double>? onRatingChanged;

  RatingStars({
    required this.starCount,
    required this.rating,
    this.color = Colors.orange,
    this.size = 30.0,
    this.onRatingChanged,
  });

  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  double _currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        double starValue = index + 1;

        return GestureDetector(
          onTap: () {
            double newRating = starValue == _currentRating ? 0.0 : starValue;
            if (widget.onRatingChanged != null) {
              widget.onRatingChanged!(newRating);
            }
            setState(() {
              _currentRating = newRating;
            });
          },
          child: Icon(
            starValue <= _currentRating ? Icons.star : Icons.star_border,
            color: starValue <= _currentRating ? widget.color : widget.color.withOpacity(0.5),
            size: widget.size,
          ),
        );
      }),
    );
  }
}
