import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload Post

  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String profileImage
      ) async {
    String res = 'Some error occured';

    try{
      String photoUrl = await StorageService().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePosted: DateTime.now(),
        postUrl: photoUrl,
        profileImage: profileImage,
        likes: []
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";

      return res;
    }catch(e){
      res = e.toString();
      return res;
    }
  }
}

