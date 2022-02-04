import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? email;
  final String? uid;
  final String? photoUrl;
  final String? username;
  final String? bio;
  final List followers;
  final List following;

  const Users(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following
      };

  static Users fromSnap(DocumentSnapshot snapshot) {
    var snapshots = snapshot.data() as Map<String, dynamic>;

    return Users(
        username: snapshots['username'],
        uid: snapshots['uid'],
        email: snapshots['email'],
        photoUrl: snapshots['photoUrl'],
        bio: snapshots['bio'],
        followers: snapshots['followers'],
        following: snapshots['following'],);
  }

  @override
  String toString() {
    return '{'
        'userName: $username, email: $email, bio: $bio, photoUrl: $photoUrl, followers: ${followers.length}, following: ${following.length}'
        '}';
  }
}
