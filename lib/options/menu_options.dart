/// Menu items available
enum MenuItem {
  undo,
  redo,
  zoomIn,
  zoomOut,
  fitCameraToArea,
  search,
  divider,
}

/// Class that defines customization options for the context menu in the `PolarisMapEditor`.
class MenuOptions {
  /// Whether the context menu is enabled.
  final bool enabled;

  /// List of menu items available.
  final List<MenuItem> items;

  /// Creates a `MenuOptions` object with the specified `enabled` value.
  /// Default constructor for `MenuOptions`.
  const MenuOptions({
    required this.enabled,
    this.items = const [
      MenuItem.undo,
      MenuItem.redo,
      MenuItem.divider,
      MenuItem.zoomOut,
      MenuItem.zoomIn,
      MenuItem.divider,
      MenuItem.fitCameraToArea,
      MenuItem.search
    ],
  });
}
