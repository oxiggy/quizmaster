import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/design/images.dart';

class Avatar {
  final String key;
  final SvgPicture image;

  Avatar({required this.key, required this.image});
}

final Map<String, Avatar> avatars = {
  'purpleGreen': Avatar(
    key: 'purpleGreen',
    image: purpleGreenAvatarImage,
  ),
  'red': Avatar(
    key: 'red',
    image: redAvatarImage,
  ),
  'green': Avatar(
    key: 'green',
    image: greenAvatarImage,
  ),
};