import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:test_wiki_assign/core/base_cubit/base_state.dart';
import 'package:test_wiki_assign/presentation/common_widget/no_internet_widget.dart';
import 'package:test_wiki_assign/presentation/cubits/wiki_list_page/wiki_list_page_cubit.dart';
import 'package:test_wiki_assign/presentation/pages/wiki_detail_page.dart';

import '../../../core/utils.dart';
import '../../../core/wiki_colors.dart';
import '../../../domain/entities/wiki_list_item.dart';
import '../../common_widget/circular_avatar_widget.dart';
import 'widgets/text_field_widget.dart';

class WikiListPage extends StatefulWidget {
  static const String routeName = '/wiki_list_page';

  const WikiListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<WikiListPage> createState() => _WikiListPageState();
}

class _WikiListPageState extends State<WikiListPage> {
  void _getWikiList(String query) {
    final cubit = context.read<WikiListPageCubit>();
    cubit.getWikiList(query);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WikiColors.scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(
          Translations.of(context).wikiList,
        ),
      ),
      body: _rootUI(),
    );
  }

  Widget _rootUI() {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Column(
        children: [
          const SizedBox(height: 16),
          _searchField(),
          _viewList(),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFieldWidget(
        onSearch: (String query) {
          _getWikiList(query);
        },
      ),
    );
  }

  Widget _viewList() {
    return Expanded(
      child: BlocBuilder<WikiListPageCubit, BaseState>(
        builder: (_, state) {
          if (state is GetWikiListSuccess) {
            return _view(state.wikiList);
          } else if (state is FailedState) {
            /// TODO error widget
            return const SizedBox();
          } else if (state is NoInternetState) {
            return const NoInternetWidget();
          }
          return _initialView();
        },
      ),
    );
  }

  Widget _view(List<WikiListItem> list) {
    return ListView.separated(
      itemCount: list.length,
      padding: const EdgeInsets.only(bottom: 24),
      itemBuilder: (_, index) {
        return _item(index, list[index]);
      },
      separatorBuilder: (_, __) => const Divider(),
    );
  }

  Widget _item(int index, WikiListItem item) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        removeFocus(context);
        Navigator.pushNamed(context, WikiDetailPage.routeName, arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularAvatarWidget(
              name: item.title,
              radius: 24,
              networkImage: item.thumbnail,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: WikiColors.textBodyColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(
                      color: WikiColors.textSubtitleColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _initialView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Icon(
          Icons.search,
          color: Colors.redAccent,
          size: 28,
        ),
        const SizedBox(height: 16),
        Text(
          Translations.of(context).searchWiki,
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
