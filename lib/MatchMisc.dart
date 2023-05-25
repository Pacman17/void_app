import 'constraints.dart';
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';


class MatchImage extends StatelessWidget {
  const MatchImage(this.match, {Key? key}) : super(key: key);

  final Match match;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: match.title + "Thumbnail",
      child: ClipRRect(
        borderRadius: kAllBorderRadius,
        child: Image.network(match.thumbnail,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Image.asset(
                  'assets/Images/football.png'); // Specify the path to your default image asset
            }
        ),
      ),
    );
  }
}

class MatchTitle extends StatelessWidget {
  const MatchTitle(
      this.match, {
        Key? key,
        this.type = MatchStyle.card,
      }) : super(key: key);

  final Match match;
  final MatchStyle type;

  @override
  Widget build(BuildContext context) {
    TextStyle? style;

    if (type == MatchStyle.page) {
      style = TextStyle(color: context.textTheme.bodyLarge?.color);
    }

    return Hero(
      tag: match.title + "Title",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Headline4(match.title, style: style),
          Subtitle1(match.league, style: style),
        ],
      ),
    );
  }
}