///Default sizes of application.
/// * zero = 0
/// * extraSmall = 2
/// * verySmall = 4
/// * small = 8
/// * almostNormal = 12
/// * normal = 16
/// * almostBig = 20
/// * big = 24
/// * veryBig = 32
/// * almostLarge = 36
/// * large = 48
/// * veryLarge = 64
/// * almostHuge = 80
/// * huge = 96
/// * veryHuge = 128
/// * extraHuge = 192
/// * extraExtraHuge = 360
enum Sizes {
  /// value = 0
  zero,

  /// value = 2
  extraSmall,

  /// value = 4
  verySmall,

  small,

  /// value = 12
  almostNormal,

  /// value = 16
  normal,

  /// value = 20
  almostBig,

  /// value = 24
  big,

  /// value = 32
  veryBig,

  /// value = 36
  almostLarge,

  /// value = 48
  large,

  /// value = 64
  veryLarge,

  /// value = 80
  almostHuge,

  /// value = 96
  huge,

  /// value = 128
  veryHuge,

  /// value = 192
  extraHuge,

  /// value = 360
  extraExtraHuge,
}

extension SizesExtension on Sizes {
  double rawValue() {
    switch (this) {
      case Sizes.zero:
        return 0;
      case Sizes.extraSmall:
        return 2;
      case Sizes.verySmall:
        return 4;
      case Sizes.small:
        return 8;
      case Sizes.almostNormal:
        return 12;
      case Sizes.normal:
        return 16;
      case Sizes.almostBig:
        return 20;
      case Sizes.big:
        return 24;
      case Sizes.veryBig:
        return 32;
      case Sizes.almostLarge:
        return 36;
      case Sizes.large:
        return 48;
      case Sizes.veryLarge:
        return 64;
      case Sizes.almostHuge:
        return 80;
      case Sizes.huge:
        return 96;
      case Sizes.veryHuge:
        return 128;
      case Sizes.extraHuge:
        return 192;
      case Sizes.extraExtraHuge:
        return 360;
    }
  }
}
