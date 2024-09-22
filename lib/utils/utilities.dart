import 'dart:math';

class Utilities {
  static String getInitials(String name) {
    if (!name.contains(" ")) {
      return name[0].toUpperCase();
    }
    final names = name.trim().split(" ");
    final name1Initial = names.length > 1 ? names[0][0] : names[0];
    final name2Initial = names.length > 1 ? names[names.length - 1][0] : "";
    return "$name1Initial$name2Initial".toUpperCase();
  }

  static String generateRandomColor() {
    const predefinedColours = [
      '0xFFF44336', //red
      '0xFFE91E63', //pink
      '0xFFFF9800', //orange
      '0xFFFF5722', //deepOrange
      '0xFF4CAF50', //green
      '0xFF009688', //teal
      '0xFF2196F3', //blue
      // 0xFF607D8B, //blueGrey
      '0xFF03A9F4', //lightBlue
      // 0xFF3F51B5, //indigo
      '0xFF9C27B0', //purple
      '0xFF00BCD4', //cyan
      // 0xFF9E9E9E, //grey
      '0xFF673AB7', //deepPurple
      // 0xFF795548, //brown
      '0xFFFFC107', //amber
      // 0xFF8BC34A, //lightGreen
    ];
    Random random = Random();
    return predefinedColours[random.nextInt(predefinedColours.length)];
  }
}
