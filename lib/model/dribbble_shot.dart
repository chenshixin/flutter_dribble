import 'package:flutter_drib/model/dribbble_image.dart';
import 'package:flutter_drib/model/dribbble_user.dart';

class DribbbleShot {

  final String title;
  final num id;
  final DribbbleImage images;
  final DribbbleUser user;
  final String description;
  final int likesCount;
  final int viewsCount;
  final int bucketCount;
  final int commentsCount;
  final bool animated;
  final List<String> tags;


  DribbbleShot(this.title, this.id, this.images, this.user, this.description,
      this.likesCount, this.viewsCount, this.bucketCount, this.commentsCount,
      this.animated, this.tags);

  static DribbbleShot fromJson(Map<String, dynamic> json) {
    var title = json['title'];
    var id = json['id'];
    var images = DribbbleImage.fromJson(json['images']);
    var user = DribbbleUser.fromJson(json['user']);
    var description = json['description'];
    var likesCount = json['likes_count'];
    var viewsCount = json['views_count'];
    var bucketCount = json['bucket_count'];
    var commentsCount = json['comments_count'];
    var animated = json['animated'];
    var tags = json['tags'];
    return new DribbbleShot(
        title,
        id,
        images,
        user,
        description,
        likesCount,
        viewsCount,
        bucketCount,
        commentsCount,
        animated,
        tags);
  }

  @override
  String toString() {
    return 'DribbbleShot{title: $title, id: $id, images: $images, user: $user, description: $description, likesCount: $likesCount, viewsCount: $viewsCount, bucketCount: $bucketCount, commentsCount: $commentsCount, animated: $animated}';
  }


}