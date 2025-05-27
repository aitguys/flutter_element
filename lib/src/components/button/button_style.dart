/// The shape of the button.
/// 
/// This enum defines the different shape options available for [EButton].
enum EButtonShape {
  /// Default shape with slightly rounded corners.
  defaultShape,

  /// Circular shape, typically used for icon-only buttons.
  circle,

  /// Fully rounded shape with pill-like appearance.
  round
}

/// The type of loading indicator to display on the button.
/// 
/// This enum defines the different loading indicator styles available for [EButton].
enum EButtonLoadingType {
  /// A spinning loading indicator.
  spinner,

  /// An icon-based loading indicator.
  icon
}

/// The current state of the button.
/// 
/// This enum defines the different states a button can be in.
enum EButtonStatus {
  /// The default state of the button.
  normal,

  /// The state when the button is being hovered over.
  hover,

  /// The state when the button is being pressed.
  active,

  /// The state when the button is disabled.
  disabled
}

/// The visual variant of the button.
/// 
/// This enum defines the different color schemes available for [EButton].
enum EButtonVariant {
  /// Default button style with neutral colors.
  defaultVariant,

  /// Primary button style with brand colors.
  primaryVariant,

  /// Success button style with green colors.
  successVariant,

  /// Warning button style with yellow/orange colors.
  warningVariant,

  /// Danger button style with red colors.
  dangerVariant,

  /// Info button style with blue colors.
  infoVariant,

  /// Text-only button style with no background or border.
  textVariant
}
