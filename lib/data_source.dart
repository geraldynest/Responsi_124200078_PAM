//isinya data match yang ada di api untuk memanggilnya
import 'base_network.dart';

class ListMatchesSource {
  static ListMatchesSource instance = ListMatchesSource();
  Future<List<dynamic>> loadMatches() {
    return BaseNetwork.getList("matches");
  }
}

class DetailListMatchesSource {
  static DetailListMatchesSource instance = DetailListMatchesSource();
  Future<Map<String, dynamic>> loadDetailMatches(String id) {
    return BaseNetwork.get("matches/${id}");
  }
}