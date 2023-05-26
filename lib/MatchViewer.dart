import 'constraints.dart';
import 'package:flutter/material.dart';
//import 'package:better_player/better_player.dart';
//import 'package:video_viewer/video_viewer.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

final pb = PocketBase('http://192.168.1.113:8090');
late ResultList<RecordModel> d;



class MatchViewer extends StatefulWidget {
  const MatchViewer(this.match,  {Key? key, this.DB=false}) : super(key: key);

  final Match match;
  final bool DB;


  @override
  _MatchViewerState createState() => _MatchViewerState();
}

class _MatchViewerState extends State<MatchViewer> {


  //Future<void> initializePlayer() async {}
  // nxt try yoyo player
  // https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8
  // static final VideoViewerController controller = VideoViewerController();

  // declare video player controllers
  static late final VideoPlayerController videoPlayerController; //= VideoPlayerController.network(dataSource);
  late Chewie playerWidget;
  late ChewieController chewieController;

  late RecordModel initial;
  late String link;
  String dropdownValue ="";
  late ResultList<RecordModel> sources;



  @override
  void initState() {
    super.initState();

    updateMatchSources();
    dropdownValue = "Link 1";
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    Map<String, String> headers = {};
    late String url;
    if (sources.totalItems > 0) {
       url = sources.items.first.getStringValue('url');
      headers['User-Agent'] = sources.items.first.getStringValue('user_agent');
      headers['Referer'] = sources.items.first.getStringValue('referer');
    }
    else {
    url = "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8";
    }

    videoPlayerController = VideoPlayerController.network(url, httpHeaders: headers);
    await videoPlayerController.initialize();
    print("Player initialization");
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController
    );
    playerWidget = Chewie(
        controller: chewieController
    );
  }
  Widget linkbuttons(){
    List<String> menuItems = [];
    int index = 1;
    for(int i =1; i <= sources.totalItems; i++) {
      menuItems.add("Link $i");
    }

    if (menuItems.length == 0) {
      menuItems.add("No links found");
    }

    return DropdownButton<String>(
      hint: Text("Select Link"),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        print("He4e");
        onLinkSelection(menuItems.indexWhere((element) => element == dropdownValue));
        // onLinkSelection(widget.match.sources.entries.firstWhere((element) => element.key == dropdownValue));
      },
      items: menuItems
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  void onLinkSelection(int index) async { // previously Map<String, String> entry
    //final String linkName = entry.key;
    /*if (link != linkName) {
      //final String qualities = entry.value;
      final String url = entry.value;

      late Map<String, VideoSource> sources;

      if (url.contains("m3u8")) {
        sources = await VideoSource.fromM3u8PlaylistUrl(url);
      } else {
        sources = VideoSource.fromNetworkVideoSources(url);
      }

      final MapEntry<String, VideoSource> video = sources.entries.first;

      controller.closeSettingsMenu();

      await controller.changeSource(
        inheritPosition: false, //RESET SPEED TO NORMAL AND POSITION TO ZERO
        source: video.value,
        name: video.key,
      );

      link = linkName;
      controller.source = sources;
      setState(() {});
    } else {
      controller.closeSettingsMenu();
    } */
    String url = sources.items.elementAt(index).getStringValue('url');
    Map<String, String> headers = {};
    headers['User-Agent'] = sources.items.elementAt(index).getStringValue('user_agent');
    headers['Referer'] = sources.items.elementAt(index).getStringValue('referer');

    videoPlayerController = VideoPlayerController.network(url, httpHeaders: headers);
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController
    );
    playerWidget = Chewie(
        controller: chewieController
    );


  }

  void updateMatchSources() async {
    final id = widget.match.id;
    final events = await pb.collection('stream_data').getList(
        page: 1,
        perPage: 50,
        filter: 'event_id = $id'
    );
    sources = events;
  }

  @override
  void dispose() async {
    await videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
    //await _videoViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializePlayer();
    return widget.DB ? linkbuttons() : playerWidget;

  }
}