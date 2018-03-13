import 'package:flutter_drib/model/dribbble_links.dart';

class DribbbleUser {

  final num id;
  final String name;
  final String avatarUrl;
  final String bio;
  final String location;
  final DribbbleLinks links;

  DribbbleUser(this.id, this.name, this.avatarUrl, this.bio, this.location, this.links);

  static DribbbleUser fromJson(Map<String, dynamic> json) {
    var id = json["id"];
    var name = json["name"];
    var avatarUrl = json["avatar_url"];
    var bio = json["bio"];
    var location = json["location"];
    var links = DribbbleLinks.fromJson(json['links']);
    return new DribbbleUser(id, name, avatarUrl, bio, location, links);
  }

  @override
  String toString() {
    return 'DribbbleUser{id: $id, name: $name, avatarUrl: $avatarUrl, bio: $bio, location: $location, links: $links}';
  }


}