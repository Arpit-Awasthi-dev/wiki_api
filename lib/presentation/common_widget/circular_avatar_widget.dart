import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import '../../core/wiki_colors.dart';

class CircularAvatarWidget extends StatelessWidget {
  final String name;
  final String? networkImage;
  final double radius;

  const CircularAvatarWidget({
    required this.name,
    required this.radius,
    this.networkImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProfileAvatar(
      networkImage ?? '',
      radius: radius,
      backgroundColor: _setColor(name),
      initialsText: _buildText(),
      cacheImage: true,
      imageFit: BoxFit.cover,
      animateFromOldImageOnUrlChange: true,
      showInitialTextAbovePicture: false,
    );
  }

  Text _buildText() {
    return Text(
      getInitials(name),
      style: TextStyle(color: Colors.white, fontSize: radius * 0.6),
    );
  }

  String getInitials(String? nameString) {
    if (nameString == null || nameString.isEmpty) return " ";

    final List<String> nameArray =
    nameString.trim().replaceAll(RegExp(r"\s+\b|\b\s"), " ").split(" ");
    final String initials = ((nameArray[0])[0]) +
        (nameArray.length == 1 ? " " : (nameArray[nameArray.length - 1])[0]);
    return initials;
  }

  Color _setColor(String? name) {
    if (name != null && name.isNotEmpty) {
      final int index = _alphabet.indexOf(name[0]);
      final int colorIndex = index % 8;
      return _colors[colorIndex];
    } else {
      return Colors.orange;
    }
  }

  static const _alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  /// A list of colors used for avatar backgrounds
  static const _colors = [
    WikiColors.avatar1,
    WikiColors.avatar2,
    WikiColors.avatar3,
    WikiColors.avatar4,
    WikiColors.avatar5,
    WikiColors.avatar6,
    WikiColors.avatar7,
    WikiColors.avatar8
  ];
}