import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/show_user_details_bottomsheet.dart';
import 'package:school_match/util/functions.dart';

class UserCard extends StatefulWidget {
  final UserProfileModel candidate;

  const UserCard({Key? key, required this.candidate}) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  int photoIndex = 0;

  void nextPhoto() {
    setState(() {
      photoIndex = (photoIndex + 1) % widget.candidate.images.length;
    });
  }

  void previousPhoto() {
    setState(() {
      photoIndex = (photoIndex - 1 + widget.candidate.images.length) %
          widget.candidate.images.length;
    });
  }

  Widget _buildPhotoIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.candidate.images.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: photoIndex == i ? Colors.white : Colors.grey[400],
          ),
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: indicators,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.candidate.images.isEmpty) {
      // Handle the case where there are no images.
      return Container(
        child: Text("No images available"),
        alignment: Alignment.center,
      );
    }
    final Uint8List imageBytes =
        base64Decode(widget.candidate.images[photoIndex]!);

    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final double position = details.globalPosition.dx;
        if (position < screenWidth / 2) {
          previousPhoto();
        } else {
          nextPhoto();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(imageBytes),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 0.2),
                      end: Alignment(0.0, -1),
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: _buildPhotoIndicator(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: 20,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        isScrollControlled: true,
                        context: context,
                        enableDrag: true,
                        showDragHandle: true,
                        builder: (BuildContext context) {
                          return ShowUserDetailsBottomsheet(
                              candidate: widget.candidate);
                        });
                  },
                  child: Icon(Icons.arrow_upward, color: Colors.black),
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${widget.candidate.firstName} ${widget.candidate.lastName}",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white, fontSize: 30)),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.school, color: Colors.white),
                        SizedBox(width: 10),
                        Text(widget.candidate.course.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.cake, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                            '${Functions.calculateAge(widget.candidate.birthDate!)} anos',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
