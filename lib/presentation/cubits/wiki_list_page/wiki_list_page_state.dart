part of 'wiki_list_page_cubit.dart';

class WikiListPageState extends BaseState {
  @override
  List<Object?> get props => [];
}

class WikiListPageInitialState extends WikiListPageState {
  WikiListPageInitialState();
}

class GetWikiListSuccess extends WikiListPageState {
  final List<WikiListItem> wikiList;
  final bool hasNextPage;

  GetWikiListSuccess({
    required this.wikiList,
    required this.hasNextPage,
  });

  @override
  List<Object?> get props => [wikiList];
}
