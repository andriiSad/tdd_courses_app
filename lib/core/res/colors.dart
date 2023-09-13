import 'dart:ui';

class Colours {
  const Colours._(); // Private constructor to prevent instantiation.

  /// Gradient colors: EDF8FF, FDC1E8, FDFAE1, FFFFFF
  static const gradient = [
    Color(0xFFEDF8FF),
    Color(0xFFFDC1E8),
    Color(0xFFFFFFFF),
    Color(0xFFFDFAE1),
  ];

  /// Primary color: 458CFF
  static const primaryColour = Color(0xFF458CFF);

  /// Neutral text color: 757C8E
  static const neutralTextColour = Color(0xFF757C8E);

  /// Physics tile color: 0305FE
  static const physicsTileColour = Color(0xFF0305FE);

  /// Science tile color: FFEFDA
  static const scienceTileColour = Color(0xFFFFEFDA);

  /// Chemistry tile color: FFE4F1
  static const chemistryTileColour = Color(0xFFFFE4F1);

  /// Biology tile color: CFE5FC
  static const biologyTileColour = Color(0xFFCFE5FC);

  /// Math tile color: DAFFD6
  static const mathTileColour = Color(0xFFDAFFD6);

  /// Language tile color: 05BEFB
  static const languageTileColour = Color(0xFF05BEFB);

  /// Literature tile color: FF5C5C1
  static const literatureTileColour = Color(0xFFFF5C5C);

  /// Green color: 28CA6C
  static const greenColour = Color(0xFF28CA6C);

  /// Chat field color: F4F5F6
  static const chatFieldColour = Color(0xFFF4F5F6);

  /// Darker chat field color: E8E9EA
  static const chatFieldColourDarker = Color(0xFFE8E9EA);

  /// Current user chat bubble color: 2196F3
  static const currentUserChatBubbleColour = Color(0xFF2196F3);

  /// Other user chat bubble color: EEEEEE
  static const otherUserChatBubbleColour = Color(0xFFEEEEEE);

  /// Darker current user chat bubble color: 197602
  static const currentUserChatBubbleColourDarker = Color(0xFF197602);

  /// Darker other user chat bubble color: E0E0E0
  static const otherUserChatBubbleColourDarker = Color(0xFFE0E0E0);
}
