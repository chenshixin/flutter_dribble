class DribbbleImage {


  final String hidpi;
  final String normal;
  final String teaser;

  DribbbleImage(this.hidpi, this.normal, this.teaser);

  static DribbbleImage fromJson(Map<String, dynamic> json) {
    var hidpi = json['hidpi'];
    var normal = json['normal'];
    var teaser = json['teaser'];
    return new DribbbleImage(hidpi, normal, teaser);
  }

  @override
  String toString() {
    return 'DribbbleImage{hidpi: $hidpi, normal: $normal, teaser: $teaser}';
  }

}