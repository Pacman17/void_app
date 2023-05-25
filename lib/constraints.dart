import 'package:helpers/helpers.dart';
import 'package:flutter/material.dart';

const double kButtonHeight = 48;
const double kCardAspectRatio = 0.75;

const double kPadding = 20;
const double kSectionPadding = 40;
const Margin kAllPadding = Margin.all(kPadding); // margin dependent on helpers
const Margin kAllSectionPadding = Margin.all(kSectionPadding);

enum MatchStyle { card, page }

class Match {
  const Match({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.league,
    //required this.sources,
    //this.isFavorite = false,
  });

  final String id, thumbnail, title, league;
  //final List<Source> sources;
//final bool isFavorite;
}

class Source {
  const Source({
    required this.url,
    required this.headers,
});
  final String url;
  final Map<String,String> headers;
}

const BorderRadius kAllBorderRadius = BorderRadius.all(
  Radius.circular(kPadding),
);