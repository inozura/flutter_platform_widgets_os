/*
 * flutter_platform_widgets
 * Copyright (c) 2021 Lance Johnstone. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart'
    show CupertinoButton, CupertinoColors, CupertinoTheme;
import 'package:flutter/material.dart'
    show ButtonStyle, MaterialStatesController, TextButton;
import 'package:flutter/widgets.dart';

import 'package:flutter_platform_widgets_os/src/platform.dart';
import 'package:flutter_platform_widgets_os/src/widget_base.dart';

const double _kMinInteractiveDimensionCupertino = 44;

abstract class _BaseData {
  _BaseData({
    this.widgetKey,
    this.child,
    this.onPressed,
  });

  final Key? widgetKey;
  final Widget? child;
  final VoidCallback? onPressed;
}

class MaterialTextButtonData extends _BaseData {
  MaterialTextButtonData({
    super.widgetKey,
    super.child,
    super.onPressed,
    this.onLongPress,
    this.focusNode,
    this.style,
    this.autofocus,
    this.clipBehavior,
    this.icon,
    this.onHover,
    this.onFocusChange,
    this.statesController,
    this.isSemanticButton,
  });

  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final ButtonStyle? style;
  final bool? autofocus;
  final Clip? clipBehavior;
  final Widget? icon;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final MaterialStatesController? statesController;
  final bool? isSemanticButton;
}

class CupertinoTextButtonData extends _BaseData {
  CupertinoTextButtonData({
    super.widgetKey,
    super.child,
    super.onPressed,
    this.color,
    this.padding,
    this.disabledColor,
    this.borderRadius,
    this.minSize,
    this.pressedOpacity,
    this.alignment,
    this.originalStyle = false,
  });

  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Color? disabledColor;
  final BorderRadius? borderRadius;
  final double? minSize;
  final double? pressedOpacity;
  final AlignmentGeometry? alignment;

  // If true will use the filled style rather than the text style
  final bool originalStyle;
}

class FluentTextButtonData extends _BaseData {
  FluentTextButtonData({
    super.widgetKey,
    super.child,
    super.onPressed,
    this.onLongPress,
    this.focusNode,
    this.style,
    this.autofocus,
    this.clipBehavior,
    this.icon,
    this.onHover,
    this.onFocusChange,
    this.statesController,
  });

  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final fluent.ButtonStyle? style;
  final bool? autofocus;
  final Clip? clipBehavior;
  final Widget? icon;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final MaterialStatesController? statesController;
}

class PlatformTextButton extends PlatformWidgetBase<TextButton, Widget,
    fluent.Button, Widget, TextButton, TextButton, TextButton> {
  const PlatformTextButton({
    super.key,
    this.widgetKey,
    this.onPressed,
    this.child,
    this.padding,
    this.alignment,
    this.color,
    this.material,
    this.cupertino,
    this.windows,
    this.macos,
    this.linux,
    this.fuchsia,
    this.web,
  });
  final Key? widgetKey;

  final VoidCallback? onPressed;
  final Widget? child;

  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Color? color;

  final PlatformBuilder<MaterialTextButtonData>? material;
  final PlatformBuilder<CupertinoTextButtonData>? cupertino;
  final PlatformBuilder<FluentTextButtonData>? windows;
  final PlatformBuilder<MaterialTextButtonData>? macos;
  final PlatformBuilder<MaterialTextButtonData>? linux;
  final PlatformBuilder<MaterialTextButtonData>? fuchsia;
  final PlatformBuilder<MaterialTextButtonData>? web;

  @override
  TextButton createMaterialWidget(BuildContext context) {
    final data = material?.call(context, platform(context));

    final icon = data?.icon;

    if (icon != null) {
      return TextButton.icon(
        key: data?.widgetKey ?? widgetKey,
        label: data?.child ?? child!,
        icon: icon,
        onPressed: data?.onPressed ?? onPressed,
        onLongPress: data?.onLongPress,
        autofocus: data?.autofocus ?? false,
        clipBehavior: data?.clipBehavior ?? Clip.none,
        focusNode: data?.focusNode,
        style: data?.style ??
            TextButton.styleFrom(
              backgroundColor: color,
              padding: padding,
              alignment: alignment,
            ),
        onHover: data?.onHover,
        onFocusChange: data?.onFocusChange,
        statesController: data?.statesController,
      );
    }

    return TextButton(
      key: data?.widgetKey ?? widgetKey,
      onPressed: data?.onPressed ?? onPressed,
      onLongPress: data?.onLongPress,
      autofocus: data?.autofocus ?? false,
      clipBehavior: data?.clipBehavior ?? Clip.none,
      focusNode: data?.focusNode,
      style: data?.style ??
          TextButton.styleFrom(
            backgroundColor: color,
            padding: padding,
            alignment: alignment,
          ),
      onHover: data?.onHover,
      onFocusChange: data?.onFocusChange,
      statesController: data?.statesController,
      isSemanticButton: data?.isSemanticButton ?? true,
      child: child!,
    );
  }

  @override
  Widget createCupertinoWidget(BuildContext context) {
    final data = cupertino?.call(context, platform(context));

    if (data?.originalStyle ?? false) {
      final button = CupertinoButton.filled(
        key: data?.widgetKey ?? widgetKey,
        onPressed: data?.onPressed ?? onPressed,
        borderRadius:
            data?.borderRadius ?? const BorderRadius.all(Radius.circular(8)),
        minSize: data?.minSize ?? _kMinInteractiveDimensionCupertino,
        padding: data?.padding ?? padding,
        pressedOpacity: data?.pressedOpacity ?? 0.4,
        disabledColor:
            data?.disabledColor ?? CupertinoColors.quaternarySystemFill,
        alignment: data?.alignment ?? alignment ?? Alignment.center,
        child: data?.child ?? child!,
      );
      if (color != null) {
        final themeData = CupertinoTheme.of(context);
        return CupertinoTheme(
          data: themeData.copyWith(primaryColor: color),
          child: button,
        );
      }
      return button;
    } else {
      return CupertinoButton(
        key: data?.widgetKey ?? widgetKey,
        onPressed: data?.onPressed ?? onPressed,
        borderRadius:
            data?.borderRadius ?? const BorderRadius.all(Radius.circular(8)),
        minSize: data?.minSize ?? _kMinInteractiveDimensionCupertino,
        padding: data?.padding ?? padding,
        pressedOpacity: data?.pressedOpacity ?? 0.4,
        disabledColor:
            data?.disabledColor ?? CupertinoColors.quaternarySystemFill,
        alignment: data?.alignment ?? alignment ?? Alignment.center,
        color: data?.color ?? color,
        child: data?.child ?? child!,
      );
    }
  }

  @override
  fluent.Button createWindowsWidget(BuildContext context) {
    final data = windows?.call(context, platform(context));

    final icon = data?.icon;

    assert(icon != null || data?.child != null || child != null);
    return fluent.Button(
      key: data?.widgetKey ?? widgetKey,
      onPressed: data?.onPressed ?? onPressed,
      onLongPress: data?.onLongPress,
      autofocus: data?.autofocus ?? false,
      focusNode: data?.focusNode,
      style: data?.style,
      child: (icon != null) ? icon : data?.child ?? child!,
    );
  }

  //Todo(mehul): change themes here
  @override
  Widget createMacosWidget(BuildContext context) =>
      createCupertinoWidget(context);

  @override
  TextButton createLinuxWidget(BuildContext context) =>
      createMaterialWidget(context);

  @override
  TextButton createFuchsiaWidget(BuildContext context) =>
      createMaterialWidget(context);

  @override
  TextButton createWebWidget(BuildContext context) =>
      createMaterialWidget(context);
}
