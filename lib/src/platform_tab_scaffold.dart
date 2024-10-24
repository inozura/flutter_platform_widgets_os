/*
 * flutter_platform_widgets
 * Copyright (c) 2018 Lance Johnstone. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:fluent_ui/fluent_ui.dart'
    show NavigationAppBar, NavigationPane, NavigationPaneItem, NavigationView, PaneItem, PaneItemSeparator, ScaffoldPage;
import 'package:flutter/cupertino.dart'
    show
        CupertinoPageScaffold,
        CupertinoTabBar,
        CupertinoTabController,
        CupertinoTabScaffold,
        CupertinoTabView,
        ObstructingPreferredSizeWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'
    show
        DrawerCallback,
        FloatingActionButtonAnimator,
        FloatingActionButtonLocation,
        Material,
        Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets_os/src/extensions.dart';
import 'package:flutter_platform_widgets_os/src/platform.dart';
import 'package:flutter_platform_widgets_os/src/platform_app_bar.dart';
import 'package:flutter_platform_widgets_os/src/platform_nav_bar.dart';
import 'package:flutter_platform_widgets_os/src/platform_provider.dart';
import 'package:flutter_platform_widgets_os/src/widget_base.dart';

abstract class _BaseData {
  const _BaseData({
    this.widgetKey,
    this.backgroundColor,
  });

  final Color? backgroundColor;
  final Key? widgetKey;
}

class MaterialTabScaffoldData extends _BaseData {
  const MaterialTabScaffoldData({
    super.backgroundColor,
    super.widgetKey,
    this.bodyBuilder,
    this.appBarBuilder,
    this.controller,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.primary,
    this.bottomSheet,
    this.drawerDragStartBehavior,
    this.extendBody,
    this.resizeToAvoidBottomInset,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.extendBodyBehindAppBar,
    this.tabsBackgroundColor,
    this.drawerEnableOpenDragGesture,
    this.endDrawerEnableOpenDragGesture,
    this.restorationId,
    this.onDrawerChanged,
    this.onEndDrawerChanged,
    this.persistentFooterAlignment,
    this.height,
  });

  final Widget Function(BuildContext context, int index)? bodyBuilder;
  final MaterialTabController? controller;
  final PreferredSizeWidget? Function(BuildContext context, int index)?
      appBarBuilder;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? persistentFooterButtons;
  final bool? primary;
  final Widget? bottomSheet;
  final DragStartBehavior? drawerDragStartBehavior;
  final bool? extendBody;
  final bool? resizeToAvoidBottomInset;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool? extendBodyBehindAppBar;
  final Color? tabsBackgroundColor;
  final bool? drawerEnableOpenDragGesture;
  final bool? endDrawerEnableOpenDragGesture;
  final String? restorationId;
  final DrawerCallback? onDrawerChanged;
  final DrawerCallback? onEndDrawerChanged;
  final AlignmentDirectional? persistentFooterAlignment;
  final double? height;
}

class CupertinoTabViewData {
  const CupertinoTabViewData({
    this.defaultTitle,
    this.navigatorKey,
    this.navigatorObservers,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.routes,
  });

  final String? defaultTitle;
  final GlobalKey<NavigatorState>? navigatorKey;
  final List<NavigatorObserver>? navigatorObservers;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final Map<String, WidgetBuilder>? routes;
}

class CupertinoTabScaffoldData extends _BaseData {
  const CupertinoTabScaffoldData({
    super.backgroundColor,
    super.widgetKey,
    this.items,
    this.bodyBuilder,
    this.appBarBuilder,
    this.tabViewDataBuilder,
    this.useCupertinoTabView = true,
    this.resizeToAvoidBottomInset,
    this.resizeToAvoidBottomInsetTab,
    this.tabsBackgroundColor,
    this.controller,
    this.restorationId,
    this.restorationScopeIdTabView,
    this.navBarHeight,
  });

  final List<BottomNavigationBarItem>? items;

  final CupertinoTabViewData Function(BuildContext context, int index)?
      tabViewDataBuilder;

  final Widget Function(BuildContext context, int index)? bodyBuilder;
  final ObstructingPreferredSizeWidget? Function(
    BuildContext context,
    int index,
  )? appBarBuilder;
  final bool? resizeToAvoidBottomInset;
  final bool? resizeToAvoidBottomInsetTab;
  final Color? tabsBackgroundColor;
  final CupertinoTabController? controller;
  final bool? useCupertinoTabView;
  final String? restorationId;
  final String? restorationScopeIdTabView;
  final double? navBarHeight;
}

class FluentTabScaffoldData extends _BaseData {
  final Widget Function(BuildContext context, int index)? bodyBuilder;
  final FluentTabController? controller;
  final NavigationAppBar? Function(BuildContext context, int index)?
      appBarBuilder;
  final bool? extendBodyBehindAppBar;
  final Color? tabsBackgroundColor;
  final double? height;

  /// Remaps the last [remapToFooterItemsIndex] items from [bodyBuilder] as fixed footer items with a separator
  final int remapToFooterItemsIndex;

  const FluentTabScaffoldData({
    super.backgroundColor,
    super.widgetKey,
    this.bodyBuilder,
    this.appBarBuilder,
    this.controller,
    this.extendBodyBehindAppBar,
    this.tabsBackgroundColor,
    this.height,
    this.remapToFooterItemsIndex = 0,
  });
}

class PlatformTabScaffold extends PlatformWidgetBase<Widget, Widget, Widget,
    Widget, Widget, Widget, Widget> {
  final Key? widgetKey;

  final PlatformBuilder<MaterialTabScaffoldData>? material;
  final PlatformIndexBuilder<MaterialTabScaffoldData>? materialBuilder;

  final PlatformBuilder<MaterialNavBarData>? materialTabs;
  final PlatformBuilder<MaterialNavigationBarData>? material3Tabs;

  final PlatformBuilder<CupertinoTabScaffoldData>? cupertino;
  final PlatformIndexBuilder<CupertinoTabScaffoldData>? cupertinoBuilder;

  final PlatformBuilder<CupertinoTabBarData>? cupertinoTabs;

  final PlatformBuilder<FluentTabScaffoldData>? windows;
  final PlatformIndexBuilder<FluentTabScaffoldData>? windowsBuilder;
  final PlatformBuilder<FluentTabBarData>? windowsTabs;

  final bool iosContentPadding;
  final bool iosContentBottomPadding;

  final PlatformTabController? tabController;

  final List<BottomNavigationBarItem>? items;

  final PlatformAppBar? Function(BuildContext context, int index)?
      appBarBuilder;
  final Widget Function(BuildContext context, int index)? bodyBuilder;
  final Color? pageBackgroundColor;
  final Color? tabsBackgroundColor;
  final void Function(int index)? itemChanged;

  final String? restorationId;
  final double? navBarHeight;

  const PlatformTabScaffold({
    super.key,
    this.widgetKey,
    this.items,
    this.bodyBuilder,
    this.pageBackgroundColor,
    this.tabsBackgroundColor,
    this.appBarBuilder,
    this.tabController,
    this.itemChanged,
    this.iosContentPadding = false,
    this.iosContentBottomPadding = false,
    this.restorationId,
    this.navBarHeight,
    this.material,
    this.materialBuilder,
    this.materialTabs,
    this.material3Tabs,
    this.cupertino,
    this.cupertinoBuilder,
    this.cupertinoTabs,
    this.windows,
    this.windowsBuilder,
    this.windowsTabs,
  })  : assert(
          (material != null && materialBuilder == null) || material == null,
        ),
        assert(
          (material == null && materialBuilder != null) ||
              materialBuilder == null,
        ),
        assert(
          (cupertino != null && cupertinoBuilder == null) || cupertino == null,
        ),
        assert(
          (cupertino == null && cupertinoBuilder != null) ||
              cupertinoBuilder == null,
        ),
        assert(
          (windows != null && windowsBuilder == null) || windows == null,
        ),
        assert(
          (windows == null && windowsBuilder != null) || windowsBuilder == null,
        );

  @override
  Widget createMaterialWidget(BuildContext context) {
    final data = material?.call(context, platform(context));

    final controller = data?.controller ?? tabController?._material(context);

    assert(controller != null, '''
MaterialTabController cannot be null.
    Either have material: (_, __) => MaterialTabScaffoldData(controller: controller) or
    PlatformTabScaffold(tabController: controller) ''');

    return AnimatedBuilder(
      animation: controller!,
      builder: (context, _) => _buildMaterial(
        context,
        materialBuilder?.call(context, platform(context), controller.index) ??
            data,
        controller,
      ),
    );
  }

  Widget _buildMaterial(
    BuildContext context,
    MaterialTabScaffoldData? data,
    MaterialTabController controller,
  ) {
    final platformNavBar = PlatformNavBar(
      items: items,
      backgroundColor: data?.tabsBackgroundColor ?? tabsBackgroundColor,
      currentIndex: controller.index,
      material: materialTabs,
      itemChanged: (int index) {
        controller.index = index;
        itemChanged?.call(index);
      },
      height: data?.height ?? navBarHeight,
      material3: material3Tabs,
    );
    final tabBar = platformNavBar.createMaterialWidget(context);

    final child = data?.bodyBuilder?.call(context, controller.index) ??
        bodyBuilder?.call(context, controller.index);

    final appBar = data?.appBarBuilder?.call(context, controller.index) ??
        appBarBuilder
            ?.call(context, controller.index)
            ?.createMaterialWidget(context);

    return Scaffold(
      key: data?.widgetKey ?? widgetKey,
      backgroundColor: data?.backgroundColor ?? pageBackgroundColor,
      body: child,
      appBar: appBar,
      bottomNavigationBar: tabBar,
      drawer: data?.drawer,
      endDrawer: data?.endDrawer,
      floatingActionButton: data?.floatingActionButton,
      floatingActionButtonAnimator: data?.floatingActionButtonAnimator,
      floatingActionButtonLocation: data?.floatingActionButtonLocation,
      persistentFooterButtons: data?.persistentFooterButtons,
      primary: data?.primary ?? true,
      bottomSheet: data?.bottomSheet,
      drawerDragStartBehavior:
          data?.drawerDragStartBehavior ?? DragStartBehavior.start,
      extendBody: data?.extendBody ?? false,
      resizeToAvoidBottomInset: data?.resizeToAvoidBottomInset,
      drawerScrimColor: data?.drawerScrimColor,
      drawerEdgeDragWidth: data?.drawerEdgeDragWidth,
      extendBodyBehindAppBar: data?.extendBodyBehindAppBar ?? false,
      drawerEnableOpenDragGesture: data?.drawerEnableOpenDragGesture ?? true,
      endDrawerEnableOpenDragGesture:
          data?.endDrawerEnableOpenDragGesture ?? true,
      onDrawerChanged: data?.onDrawerChanged,
      onEndDrawerChanged: data?.onEndDrawerChanged,
      restorationId: data?.restorationId ?? restorationId,
      persistentFooterAlignment:
          data?.persistentFooterAlignment ?? AlignmentDirectional.centerEnd,
    );
  }

  @override
  Widget createCupertinoWidget(BuildContext context) {
    final data = cupertino?.call(context, platform(context));

    final controller = data?.controller ?? tabController?._cupertino(context);

    assert(controller != null, '''
CupertinoTabController cannot be null.
    Either have material: (_, __) => CupertinoTabScaffoldData(cntroller: controller) or
    PlatformTabScaffold(tabController: controller) ''');

    if (cupertinoBuilder == null) {
      return _buildCupertino(
        context,
        data,
        controller!,
      );
    } else {
      return AnimatedBuilder(
        animation: controller!,
        builder: (context, _) => _buildCupertino(
          context,
          cupertinoBuilder?.call(context, platform(context), controller.index),
          controller,
        ),
      );
    }
  }

  Widget _buildCupertino(
    BuildContext context,
    CupertinoTabScaffoldData? data,
    CupertinoTabController controller,
  ) {
    final navBar = PlatformNavBar(
      items: items,
      backgroundColor: tabsBackgroundColor,
      currentIndex: controller.index,
      itemChanged: itemChanged,
      cupertino: cupertinoTabs,
      height: data?.navBarHeight ?? navBarHeight,
      // key: Not used ignore
      // widgetKey: Not used ignore
      // material: Not used ignore
    );
    final tabBar = navBar.createCupertinoWidget(context);

    final providerState = PlatformProvider.of(context);
    final useLegacyMaterial =
        providerState?.settings.legacyIosUsesMaterialWidgets ?? false;
    final useMaterial = providerState?.settings.iosUsesMaterialWidgets ?? false;

    final result = CupertinoTabScaffold(
      key: widgetKey,
      tabBar: tabBar,
      controller: controller,
      backgroundColor: data?.tabsBackgroundColor,
      resizeToAvoidBottomInset: data?.resizeToAvoidBottomInset ?? true,
      tabBuilder: (context, index) {
        if (data?.useCupertinoTabView ?? false) {
          return CupertinoTabView(
            // key Not used
            defaultTitle:
                data?.tabViewDataBuilder?.call(context, index).defaultTitle,
            navigatorKey:
                data?.tabViewDataBuilder?.call(context, index).navigatorKey,
            navigatorObservers: data?.tabViewDataBuilder
                    ?.call(context, index)
                    .navigatorObservers ??
                const <NavigatorObserver>[],
            onGenerateRoute:
                data?.tabViewDataBuilder?.call(context, index).onGenerateRoute,
            onUnknownRoute:
                data?.tabViewDataBuilder?.call(context, index).onUnknownRoute,
            routes: data?.tabViewDataBuilder?.call(context, index).routes,
            builder: (context) {
              return _buildCupertinoPageScaffold(
                context,
                index,
                data,
                tabBar,
                useMaterial,
              );
            },
            restorationScopeId: data?.restorationScopeIdTabView,
          );
        }

        return _buildCupertinoPageScaffold(
          context,
          index,
          data,
          tabBar,
          useMaterial,
        );
      },
      restorationId: data?.restorationId ?? restorationId,
    );

    // Ensure that there is Material widget at the root page level
    // as there can be Material widgets used on ios
    return result.withMaterial(
      useLegacyMaterial &&
          context.findAncestorWidgetOfExactType<Material>() == null,
    );
  }

  CupertinoPageScaffold _buildCupertinoPageScaffold(
    BuildContext context,
    int index,
    CupertinoTabScaffoldData? data,
    CupertinoTabBar tabBar,
    bool useMaterial,
  ) {
    final appBar = data?.appBarBuilder?.call(context, index) ??
        appBarBuilder?.call(context, index)?.createCupertinoWidget(context);

    final child = data?.bodyBuilder?.call(context, index) ??
        bodyBuilder?.call(context, index);

    assert(child != null);

    return CupertinoPageScaffold(
      //key Not used
      navigationBar: appBar,
      backgroundColor: data?.backgroundColor ?? pageBackgroundColor,
      resizeToAvoidBottomInset: data?.resizeToAvoidBottomInset ?? true,
      child: iosContentPad(
        context,
        child!.withMaterial(useMaterial),
        appBar,
        tabBar,
      ),
    );
  }

  Widget iosContentPad(
    BuildContext context,
    Widget child,
    ObstructingPreferredSizeWidget? navigationBar,
    CupertinoTabBar tabBar,
  ) {
    final existingMediaQuery = MediaQuery.of(context);

    if (!iosContentPadding && !iosContentBottomPadding) {
      return child;
    }

    var top = 0.0;
    var bottom = 0.0;

    if (iosContentPadding && navigationBar != null) {
      final topPadding =
          navigationBar.preferredSize.height + existingMediaQuery.padding.top;

      final obstruct = navigationBar.shouldFullyObstruct(context);

      top = obstruct ? 0.0 : topPadding;
    }

    if (iosContentBottomPadding) {
      bottom = existingMediaQuery.padding.bottom;
    }

    return Padding(
      padding: EdgeInsets.only(top: top, bottom: bottom),
      child: child,
    );
  }

  @override
  Widget createWindowsWidget(BuildContext context) {
    final data = windows?.call(context, platform(context));

    final controller = data?.controller ?? tabController?._windows(context);

    assert(controller != null, '''
FluentTabController cannot be null.
    Either have windows: (_, __) => FluentTabScaffoldData(controller: controller) or
    PlatformTabScaffold(tabController: controller) ''');

    return AnimatedBuilder(
      animation: controller!,
      builder: (context, _) => _buildWindows(
        context,
        windowsBuilder?.call(context, platform(context), controller.index) ??
            data,
        controller,
      ),
    );
  }

  Widget _buildWindows(
    BuildContext context,
    FluentTabScaffoldData? data,
    FluentTabController controller,
  ) {
    final platformNavBar = PlatformNavBar(
      items: items,
      backgroundColor: data?.tabsBackgroundColor ?? tabsBackgroundColor,
      currentIndex: controller.index,
      windows: windowsTabs,
      itemChanged: (index) {
        controller.index = index;
        itemChanged?.call(index);
      },
      height: data?.height ?? navBarHeight,
    );
    final tabBar = platformNavBar.createWindowsWidget(context);

    final child = data?.bodyBuilder?.call(context, controller.index) ??
        bodyBuilder?.call(context, controller.index);

    final appBar = data?.appBarBuilder?.call(context, controller.index);

    final remapSplitIndex = tabBar.tabs.length - (data?.remapToFooterItemsIndex ?? 0);

    return NavigationView(
      key: data?.widgetKey ?? widgetKey,
      appBar: appBar ??
          NavigationAppBar(
            key: appBar?.key,
            title: appBar?.title,
            leading: appBar?.leading,
            actions: appBar?.actions,
            automaticallyImplyLeading:
                appBar?.automaticallyImplyLeading ?? true,
            backgroundColor: data?.backgroundColor ??
                appBar?.backgroundColor ??
                pageBackgroundColor,
          ),
      pane: NavigationPane(
          items: [
            for (final (index, tab) in tabBar.tabs.take(remapSplitIndex).indexed)
              PaneItem(
                onTap: () => tabBar.onChanged!(index),
                icon: tab.icon ?? tab.text,
                body: ScaffoldPage.withPadding(content: child ?? tab.body),
                title: tab.text,
              ),
          ],
          footerItems: [
            PaneItemSeparator(),
            for (final (index, tab) in tabBar.tabs.skip(remapSplitIndex).indexed)
              PaneItem(
                onTap: () => tabBar.onChanged!(remapSplitIndex - index),
                icon: tab.icon ?? tab.text,
                body: ScaffoldPage.withPadding(content: child ?? tab.body),
                title: tab.text,
              ),
          ],
      ),
    );
  }

  //Todo(mehul): change themes here
  @override
  Widget createMacosWidget(BuildContext context) =>
      createCupertinoWidget(context);

  @override
  Widget createLinuxWidget(BuildContext context) =>
      createMaterialWidget(context);

  @override
  Widget createFuchsiaWidget(BuildContext context) =>
      createMaterialWidget(context);

  @override
  Widget createWebWidget(BuildContext context) => createMaterialWidget(context);
}

class MaterialTabControllerData {
  MaterialTabControllerData({
    this.initialIndex,
  });

  final int? initialIndex;
}

class MaterialTabController extends ChangeNotifier {
  MaterialTabController({int initialIndex = 0})
      : _index = initialIndex,
        assert(initialIndex >= 0);

  int get index => _index;
  int _index;

  set index(int value) {
    assert(value >= 0);
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }
}

class CupertinoTabControllerData {
  CupertinoTabControllerData({
    this.initialIndex,
  });

  final int? initialIndex;
}

class FluentTabControllerData {
  FluentTabControllerData({
    this.initialIndex,
  });

  final int? initialIndex;
}

class FluentTabController extends ChangeNotifier {
  FluentTabController({int initialIndex = 0})
      : _index = initialIndex,
        assert(initialIndex >= 0);

  int get index => _index;
  int _index;

  set index(int value) {
    assert(value >= 0);
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }
}

// In the same file so that the private android or ios controllers can be accessed
class PlatformTabController extends ChangeNotifier {
  PlatformTabController({
    int initialIndex = 0,
    this.android,
    this.ios,
    this.windows,
  })  : _initialIndex = initialIndex,
        assert(initialIndex >= 0);
  MaterialTabController? _materialController;
  CupertinoTabController? _cupertinoController;
  FluentTabController? _windowsController;

  final MaterialTabControllerData? android;
  final CupertinoTabControllerData? ios;
  final FluentTabControllerData? windows;

  final int _initialIndex;

  CupertinoTabController? _cupertino(BuildContext context) {
    _init(context);
    return _cupertinoController;
  }

  MaterialTabController? _material(BuildContext context) {
    _init(context);
    return _materialController;
  }

  FluentTabController? _windows(BuildContext context) {
    _init(context);
    return _windowsController;
  }

  int index(BuildContext context) {
    _init(context);

    return _materialController?.index ??
        _cupertinoController?.index ??
        _windowsController?.index ??
        0;
  }

  void setIndex(BuildContext context, int index) {
    assert(index >= 0);

    _init(context);

    _materialController?.index = index;
    _cupertinoController?.index = index;
    _windowsController?.index = index;
  }

  void _init(BuildContext context) {
    if (isMaterial(context)) {
      if (_materialController == null) {
        var useIndex = android?.initialIndex ?? _initialIndex;
        if (_cupertinoController != null) {
          useIndex = _cupertinoController?.index ?? 0;
          _cupertinoController?.removeListener(_listener);
          _cupertinoController?.dispose();
          _cupertinoController = null;
        }
        if (_windowsController != null) {
          useIndex = _windowsController?.index ?? 0;
          _windowsController?.removeListener(_listener);
          _windowsController?.dispose();
          _windowsController = null;
        }

        _materialController = MaterialTabController(
          initialIndex: useIndex,
        )..addListener(_listener);
      }
    } else if (isCupertino(context)) {
      if (_cupertinoController == null) {
        var useIndex = ios?.initialIndex ?? _initialIndex;
        if (_materialController != null) {
          useIndex = _materialController?.index ?? 0;
          _materialController?.removeListener(_listener);
          _materialController?.dispose();
          _materialController = null;
        }
        if (_windowsController != null) {
          useIndex = _windowsController?.index ?? 0;
          _windowsController?.removeListener(_listener);
          _windowsController?.dispose();
          _windowsController = null;
        }

        _cupertinoController = CupertinoTabController(
          initialIndex: useIndex,
        )..addListener(_listener);
      }
    } else if (isWindows(context)) {
      if (_windowsController == null) {
        var useIndex = windows?.initialIndex ?? _initialIndex;
        if (_materialController != null) {
          useIndex = _materialController?.index ?? 0;
          _materialController?.removeListener(_listener);
          _materialController?.dispose();
          _materialController = null;
        }
        if (_cupertinoController != null) {
          useIndex = _cupertinoController?.index ?? 0;
          _cupertinoController?.removeListener(_listener);
          _cupertinoController?.dispose();
          _cupertinoController = null;
        }

        _windowsController = FluentTabController(
          initialIndex: useIndex,
        )..addListener(_listener);
      }
    }
  }

  void _listener() {
    notifyListeners();
  }

  @override
  void dispose() {
    _materialController?.removeListener(_listener);
    _materialController?.dispose();
    _materialController = null;
    _cupertinoController?.removeListener(_listener);
    _cupertinoController?.dispose();
    _cupertinoController = null;
    _windowsController?.removeListener(_listener);
    _windowsController?.dispose();
    _windowsController = null;
    super.dispose();
  }
}
