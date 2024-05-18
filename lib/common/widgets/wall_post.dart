import 'package:kaizenmaster/common/helpers/helper_methods.dart';
import 'package:kaizenmaster/common/widgets/comment.dart';
import 'package:kaizenmaster/common/widgets/comment_button.dart';
import 'package:kaizenmaster/common/widgets/delete_button.dart';
import 'package:kaizenmaster/common/widgets/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final commentController = TextEditingController();

  @override
  void initState() {
    isLiked = widget.likes.contains(currentUser.email);
    super.initState();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection("user posts").doc(widget.postId);

    if (isLiked) {
      postRef.update({
        "Likes": FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        "Likes": FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String comment) {
    FirebaseFirestore.instance
        .collection("user posts")
        .doc(widget.postId)
        .collection('comments')
        .add({
      'commentText': comment,
      'commentedBy': currentUser.email,
      'commentTime': Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Comment"),
            content: TextField(
              controller: commentController,
              decoration: const InputDecoration(hintText: "Write a comment"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  commentController.clear();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  addComment(commentController.text);
                  commentController.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  void deletePost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Post"),
            content: const Text("Are you sure you want to Delete this Post?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final commentDocs = await FirebaseFirestore.instance
                      .collection('user posts')
                      .doc(widget.postId)
                      .collection('comments')
                      .get();

                  for (var doc in commentDocs.docs) {
                    await FirebaseFirestore.instance
                        .collection('user posts')
                        .doc(widget.postId)
                        .collection('comments')
                        .doc(doc.id)
                        .delete();
                  }

                  await FirebaseFirestore.instance
                      .collection('user posts')
                      .doc(widget.postId)
                      .delete()
                      .then((value) => print("post deleted"))
                      .catchError((error) => print("Failed to delete post"));

                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.user.split("@")[0],
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                ],
              ),
              if (widget.user == currentUser.email)
                DeleteButton(
                  onTap: deletePost,
                )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(widget.message),
          const SizedBox(
            height: 8,
          ),
          Container(
            // This is the empty container where you want to add an image
            height: 200, // Set the desired height of the container
            width:
                double.infinity, // Make the container fill the available width
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/your_image.png'), // Replace 'your_image.png' with your image asset path
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
          ),
          Row(
            children: [
              LikeButton(isLiked: isLiked, onTap: toggleLike),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.likes.length.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              CommentButton(onTap: showCommentDialog),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.likes.length.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('user posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .orderBy('commentTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((e) {
                    final commentData = e.data() as Map<String, dynamic>;
                    return Comment(
                      text: commentData['commentText'],
                      user: commentData['commentedBy'],
                      time: formatdate(commentData['commentTime']),
                    );
                  }).toList(),
                );
              })
        ],
      ),
    );
  }
}
