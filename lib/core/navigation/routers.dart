import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_wiki_assign/domain/entities/wiki_list_item.dart';
import 'package:test_wiki_assign/presentation/pages/wiki_detail_page.dart';

import '../../presentation/pages/wiki_list_page/wiki_list_page.dart';

class Routers {
  static RouteSettings? _settings;

  static Route<dynamic> toGenerateRoute(RouteSettings settings) {
    _settings = settings;

    switch (settings.name) {
      case WikiListPage.routeName:
        return _pageRoute(builder: (context) {
          return const WikiListPage();
        });

      case WikiDetailPage.routeName:
        return _pageRoute(builder: (context) {
          return WikiDetailPage(wikiItem: settings.arguments as WikiListItem);
        });

      default:
        throw Exception('Route Not Found');
    }
  }

  static _pageRoute({required WidgetBuilder builder, bool showModal = false}) {
    if (Platform.isAndroid) {
      return MaterialPageRoute(
        builder: builder,
        settings: _settings,
      );
    } else if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: builder,
        settings: _settings,
        fullscreenDialog: showModal,
      );
    }
  }
}
