class DribbbleLinks {

  final String web;
  final String twitter;

  DribbbleLinks(this.web, this.twitter);

  @override
  String toString() {
    return 'DribbbleLinks{web: $web, twitter: $twitter}';
  }

  static DribbbleLinks fromJson(Map<String, dynamic> json) {
    var web = json["web"];
    var twitter = json["twitter"];
    return new DribbbleLinks(web, twitter);
  }

}