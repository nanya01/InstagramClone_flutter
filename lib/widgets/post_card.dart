import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: mobileBackgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
            // HEADER SECTION
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                          .copyWith(right: 0),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                          snap["profileImage"]
                    )),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snap['username'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ]))),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                  child: ListView(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shrinkWrap: true,
                                      children: ['Delete']
                                          .map((e) => InkWell(
                                              onTap: () {},
                                              child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                                  child: Text(e))))
                                          .toList())));
                        },
                        icon: Icon(Icons.more_vert))
                  ])),

              //IMAGE SECTION
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(
                    snap['postUrl'],
                    fit: BoxFit.cover),
              ),

              //LIKE, COMMENT SECTION
              Row(children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite, color: Colors.red)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.comment_outlined,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                    )),
                Expanded(
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.bookmark_border))))
              ]),
              // DESCRIPTION AND NUMBER OF COMMENTS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.w600),
                      child: Text(
                        '${snap['likes'].length} likes',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 0, left:10),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: primaryColor),
                          children: [
                        TextSpan(
                            text: snap['username'],
                            style:
                                TextStyle(fontWeight: FontWeight.bold)),

                        TextSpan(
                            text: snap['description'],
                            ),
                      ]))),
              InkWell(
                onTap: (){},
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text('View all 200 comments',
                        style: TextStyle(fontSize: 16, color: secondaryColor))),
              ),
              InkWell(
                onTap: (){},
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal:8),
                    child: Text(DateFormat.yMMMd().format(
                            snap['datePosted'].toDate(),)
                    )),
              ),

            ]));

  }
}
