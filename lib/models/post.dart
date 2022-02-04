import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? description;
  final String? uid;
  final String? username;
  final String? postId;
  final DateTime datePosted;
  final String? postUrl;
  final String? profileImage;
  final likes;

  Post({required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePosted,
    required this.postUrl,
    required this.profileImage,
    required this.likes});

  Map<String, dynamic> toJson() =>
      {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePosted": datePosted,
        "profileImage": profileImage,
        "likes": likes,
        "postUrl": postUrl
      };

  static Post fromSnap(DocumentSnapshot snapshot) {
    var snapshots = snapshot.data() as Map<String, dynamic>;

    return Post(
        description: snapshots['description'],
        uid: snapshots['uid'],
        username: snapshots['username'],
        postId: snapshots['postId'],
        datePosted: snapshots['datePosted'],
        profileImage: snapshots['profileImage'],
        likes: snapshots['likes'],
        postUrl: snapshots['postUrl']);
    }

  @override
  String toString() {
    return '{'
        'userName: $username, description: $description, uid: $uid, postUrl: $postUrl, datePosted: $datePosted'
        '}';
  }
}
