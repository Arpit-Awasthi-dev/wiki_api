import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_wiki_assign/core/base_cubit/base_state.dart';
import 'package:test_wiki_assign/domain/entities/wiki_list_item.dart';

import '../../core/wiki_colors.dart';
import '../common_widget/circular_avatar_widget.dart';
import '../common_widget/no_internet_widget.dart';
import '../cubits/wiki_detail_page/wiki_detail_page_cubit.dart';

class WikiDetailPage extends StatefulWidget {
  static const String routeName = '/wiki_detail_page';
  final WikiListItem wikiItem;

  const WikiDetailPage({
    required this.wikiItem,
    Key? key,
  }) : super(key: key);

  @override
  State<WikiDetailPage> createState() => _WikiDetailPageState();
}

class _WikiDetailPageState extends State<WikiDetailPage> {
  void _getWikiDetail() {
    final cubit = context.read<WikiDetailPageCubit>();
    cubit.getWikiList(
      widget.wikiItem.pageID,
      widget.wikiItem.title,
    );
  }

  @override
  void initState() {
    super.initState();
    _getWikiDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WikiColors.scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(
          widget.wikiItem.title,
        ),
      ),
      body: _rootUI(),
    );
  }

  Widget _rootUI() {
    return BlocBuilder<WikiDetailPageCubit, BaseState>(
      builder: (_, state) {
        if (state is GetWikiDetailSuccess) {
          return _wikiHTML(state.detail);
        } else if (state is FailedState) {
          /// TODO error widget
          return const SizedBox();
        } else if (state is NoInternetState) {
          return const NoInternetWidget();
        } else if(state is LoadingState){
          return const CircularProgressIndicator();
        }
        return const SizedBox();
      },
    );
  }

  Widget _wikiHTML(String detail) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _viewHeader(),
        const SizedBox(height: 16),
        _viewDetail(detail),
      ],
    );
  }

  Widget _viewHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularAvatarWidget(
          name: widget.wikiItem.title,
          radius: 24,
          networkImage: widget.wikiItem.thumbnail,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.wikiItem.title,
                style: const TextStyle(
                  color: WikiColors.textBodyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.wikiItem.description,
                style: const TextStyle(
                  color: WikiColors.textBodyColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _viewDetail(String detail) {
    return Text(
      detail,
      style: const TextStyle(
        color: WikiColors.textBodyColor,
        fontSize: 14,
      ),
    );
  }
}
