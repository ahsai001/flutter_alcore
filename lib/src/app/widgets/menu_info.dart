import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/grid_menu_page.dart';
import 'package:flutter_alcore/src/utils/widget_util.dart';

class Lvlmenu {
  String? namaMenu;
  String? cookedNamaMenu;
  int? stts;
  String? levelName;

  Lvlmenu({
    this.namaMenu,
    this.cookedNamaMenu,
    this.stts,
    this.levelName,
  }) {
    cookedNamaMenu ??= namaMenu?.cook();
  }

  factory Lvlmenu.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Lvlmenu();
    return Lvlmenu(
      namaMenu: json["nama_menu"],
      cookedNamaMenu: (json["nama_menu"] as String?)?.cook(),
      stts: json["stts"],
      levelName: json["level_name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "nama_menu": namaMenu,
        "stts": stts,
        "level_name": levelName,
      };
}

class MenuInfo {
  String? title;
  String? name; //permission name
  String? cookedName; //cooked permission name
  String? imagePath;
  bool? active;
  void Function(BuildContext context)? onTap;
  List<MenuInfo>? children;
  Widget Function(BuildContext context)? badgeBuilder;
  void Function()? didPopBack;
  MenuInfo(this.title,
      {this.name,
      this.cookedName,
      this.imagePath,
      this.active,
      this.onTap,
      this.children,
      this.badgeBuilder,
      this.didPopBack}) {
    name ??= title;
    cookedName ??= name?.cook();
    active ??= false;
  }

  bool isChildMenuInfoActive(String name) {
    return children?.isMenuActive(name) ?? false;
  }

  GridItemWidget asGridItemWidget() {
    return GridItemWidget(
      title: title,
      imagePath: imagePath,
      onTap: (onTap == null && children != null && children!.isNotEmpty)
          ? (context) {
              pushNewPageWithTransition(
                      context, (context) => getMenuPage(context, this),
                      rootNavigator: true)
                  .then((value) => didPopBack?.call());
            }
          : onTap,
      badgeBuilder: badgeBuilder,
    );
  }
}

bool isNeedShowMenu(
    List<Lvlmenu>? permissions, List<String> cookedDependentModules) {
  var existMenus = permissions?.where((permission) =>
      cookedDependentModules.contains(permission.cookedNamaMenu));
  return existMenus?.isNotEmpty ?? false;
}

extension GetLevelMenuFromMenuInfo on List<MenuInfo> {
  //for single layer
  List<Lvlmenu> getActiveLevelMenuWithPermissions(List<Lvlmenu>? permissions) {
    List<Lvlmenu> activeMenus = [];
    if (permissions != null) {
      for (var menuInfo in this) {
        var cookedDependentModuleNames = getDependentModules(menuInfo.name!)
            .map((e) => e.cookedName!)
            .toList();
        if (isNeedShowMenu(permissions, cookedDependentModuleNames)) {
          activeMenus.add(Lvlmenu(
              namaMenu: menuInfo.name,
              cookedNamaMenu: menuInfo.cookedName,
              stts: 1,
              levelName: "local"));
          menuInfo.active = true;
        } else {
          menuInfo.active = false;
        }
      }
    }
    return activeMenus;
  }

  //for single layer
  List<MenuInfo> getActiveMenuInfoWithPermissions(List<Lvlmenu>? permissions) {
    List<MenuInfo> activeMenus = [];
    if (permissions != null) {
      for (var menuInfo in this) {
        var cookedDependentModuleNames = getDependentModules(menuInfo.name!)
            .map((e) => e.cookedName!)
            .toList();
        if (isNeedShowMenu(permissions, cookedDependentModuleNames)) {
          activeMenus.add(menuInfo);
          menuInfo.active = true;
        } else {
          menuInfo.active = false;
        }
      }
    }
    return activeMenus;
  }

  List<MenuInfo> getDependentModules(String menuName) {
    MenuInfo? menuInfo = getMenuInfoWithName(menuName);
    List<MenuInfo> result = [];
    if (menuInfo != null && menuInfo.children != null) {
      menuInfo.children?.forEach((menuInfo) {
        if (menuInfo.children == null) {
          result.add(menuInfo);
        } else {
          result.addAll(_getDependentModules(menuInfo.children!));
        }
      });
    }
    return result;
  }

  List<MenuInfo> _getDependentModules(List<MenuInfo> menuInfos) {
    List<MenuInfo> result = [];
    for (var menuInfo in menuInfos) {
      if (menuInfo.children == null) {
        result.add(menuInfo);
      } else {
        result.addAll(_getDependentModules(menuInfo.children!));
      }
    }
    return result;
  }

  MenuInfo? getMenuInfoWithName(String name) {
    var result =
        firstWhereOrNull((menuInfo) => menuInfo.cookedName == name.cook());
    if (result == null) {
      for (var menuInfo in this) {
        result = menuInfo.children?.getMenuInfoWithName(name);
        if (result != null) {
          break;
        }
      }
    }
    return result;
  }

  //for multiple layer, all children
  bool checkingAllActiveMenuInfoWithPermissions(List<Lvlmenu>? permissions) {
    forEach((menuInfo) {
      if (menuInfo.children == null) {
        var permission = permissions?.firstWhereOrNull(
            (permission) => permission.cookedNamaMenu == menuInfo.cookedName);
        if (permission != null) {
          menuInfo.active = true;
        } else {
          menuInfo.active = false;
        }
      } else {
        menuInfo.active = menuInfo.children!
            .checkingAllActiveMenuInfoWithPermissions(permissions);
      }
    });
    return fold<bool>(
        false, (previousValue, element) => previousValue || element.active!);
  }

  List<MenuInfo> getActiveMenuInfoAfterCheckingAll() {
    return where((menuInfo) => menuInfo.active!).toList();
  }

  List<Lvlmenu> getActiveLevelMenuAfterCheckingAll() {
    List<MenuInfo> activeMenuInfo = getActiveMenuInfoAfterCheckingAll();
    return activeMenuInfo
        .map((menuInfo) => Lvlmenu(
            namaMenu: menuInfo.name,
            cookedNamaMenu: menuInfo.cookedName,
            stts: 1,
            levelName: "local"))
        .toList();
  }

  //for single layer
  bool isMenuActive(String name) {
    var result = firstWhereOrNull(
        (menuInfo) => menuInfo.cookedName == name.cook() && menuInfo.active!);
    return result != null;
  }

  //convert to List<GridItemWidget>
  List<GridItemWidget> asGridItemWidgets() {
    return map((menuInfo) {
      return menuInfo.asGridItemWidget();
    }).toList();
  }
}

extension StringCookEx on String {
  String cook() {
    return trim().toLowerCase().replaceAll(RegExp(r"\s+"), "_");
  }
}
