import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EvidenceSelector extends StatefulWidget {
  const EvidenceSelector({super.key});

  @override
  State<EvidenceSelector> createState() => _EvidenceSelectorState();
}

class _EvidenceSelectorState extends State<EvidenceSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          //Title
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 4, 8),
                child: Text(
                  "Evidence",
                  //AppLocalizations.of(context)!.attachments,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(bottom: 8),
              //   child: Text(
              //     ' ( Max 5 documents )',
              //     style: TextStyle(color: Colors.black54, fontSize: 13),
              //   ),
              // ),
            ],
          ),
          DottedBorder(
            dashPattern: const [5, 5],
            color: Colors.indigo,
            strokeWidth: 2.3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.add_a_photo,
                        color: Colors.grey.withOpacity(0.6)),
                    onPressed: () {},
                  ),
                  // or
                  Text(
                    "/",
                    style: TextStyle(color: Colors.grey.withOpacity(0.6)),
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.add_photo_alternate,
                        color: Colors.grey.withOpacity(0.6)),
                    onPressed: () {},
                  ),
                  Text(
                    "/",
                    style: TextStyle(color: Colors.grey.withOpacity(0.6)),
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.videocam,
                        color: Colors.grey.withOpacity(0.6)),
                    onPressed: () {},
                  ),
                  Text(
                    "/",
                    style: TextStyle(color: Colors.grey.withOpacity(0.6)),
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.video_library,
                        color: Colors.grey.withOpacity(0.6)),
                    onPressed: () {},
                  ),
                  Text(
                    "/",
                    style: TextStyle(color: Colors.grey.withOpacity(0.6)),
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.attach_file,
                        color: Colors.grey.withOpacity(0.6)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "max",
                  //AppLocalizations.of(context)!.maxAttachments,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: Localizations.localeOf(context) ==
                              const Locale('es', 'ES')
                          ? 12
                          : 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       'Video: ( Max Duration: 10 sec )',
          //       style: TextStyle(color: Colors.black54, fontSize: 13),
          //     ),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Text(
          //       'Documents: ( Max 5 documents )',
          //       style: TextStyle(color: Colors.black54, fontSize: 13),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
