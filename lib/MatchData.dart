import 'constraints.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://127.0.0.1:8090');
final Map<String, List<Match>> leagues = {};


Future<void> getMatches() async {
    // fetch a paginated records list
  final now = DateTime.now();
  final date = now.year.toString() + '-' + now.month.toString() + '-' + now.day.toString();
  final events = await pb.collection('events').getList(
    page: 1,
    perPage: 50,
    filter: 'created >= "$date 00:00:00"'
  );
  events.items.forEach((element) {
    final league = element.getStringValue('league');
    if(!leagues.containsKey(league)) {
      leagues[league] = [];
    }
    leagues[league]?.add(Match(
      id: element.id,
      thumbnail: "thumbnail",
      title: element.getStringValue('event'),
      league: element.getStringValue('league'),
    ));

  });
  /*final data = events.toJson();
  data.entries.forEach((entry) {
    String event = entry['event'];
    String type = entry['type'];
    String league = entry['league'];
    String home = entry['home'];
    String away = entry['away'];
  })
*/
}





