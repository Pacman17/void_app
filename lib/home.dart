import 'package:void_app/MatchCards.dart';
import 'package:flutter/material.dart';
import 'constraints.dart';
import 'package:helpers/helpers.dart';
import 'package:void_app/MatchData.dart';
import 'package:flutter/services.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> children = [
      //SizedBox(height: kSectionPadding),
      //Headline5("Premier League"),
      //MatchCardSlider(Premier),
      //SizedBox(height: kSectionPadding),
      //Headline5("La Liga"),
      //MatchCardSlider(LaLiga),
    ];
    leagues.entries.forEach((element) {
      children.add(SizedBox(height: kSectionPadding));
      children.add(Headline5(element.key)); // key is league
      children.add(MatchCardSlider(element.value));
    });

        children.map((element) => element is MatchCardSlider
        ? element
        : Padding(
      padding: const Margin.horizontal(kSectionPadding),
      child: element,
    ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Headline4("VOID"),
        backgroundColor: Color(0xff000000),
        centerTitle: true,
        //backwardsCompatibility: true,
        //shadowColor: Color(0xFF77FFD6),
      ),
      body: SafeArea(
        child: ListView(
          padding: const Margin.vertical(kPadding),
          physics: const BouncingScrollPhysics(),
          children: children,
        ),
      ),
    );
  }
}