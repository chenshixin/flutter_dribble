class DribbbleUser {

  final num id;
  final String name;
  final String avatarUrl;
  final String bio;
  final String location;

  DribbbleUser(this.id, this.name, this.avatarUrl, this.bio, this.location);

  static DribbbleUser fromJson(Map<String, dynamic> json) {
    var id = json["id"];
    var name = json["name"];
    var avatarUrl = json["avatar_url"];
    var bio = json["bio"];
    var location = json["location"];
    return new DribbbleUser(id, name, avatarUrl, bio, location);
  }

  @override
  String toString() {
    return 'DribbbleUser{id: $id, name: $name, avatarUrl: $avatarUrl, bio: $bio, location: $location}';
  }

}