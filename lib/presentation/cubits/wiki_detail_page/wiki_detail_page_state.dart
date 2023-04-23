part of 'wiki_detail_page_cubit.dart';

class WikiDetailPageState extends BaseState{
  @override
  List<Object?> get props => [];
}

class WikiDetailPageInitialState extends WikiDetailPageState{}

class GetWikiDetailSuccess extends WikiDetailPageState{
  final String detail;
  GetWikiDetailSuccess({required this.detail});
}