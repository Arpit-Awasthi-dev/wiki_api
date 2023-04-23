import '../../../core/base_cubit/base_cubit.dart';
import '../../../core/base_cubit/base_state.dart';
import '../../../domain/entities/wiki_list_item.dart';
import '../../../domain/usecases/get_wiki_list_use_case.dart';

part 'wiki_list_page_state.dart';

class WikiListPageCubit extends BaseCubit {
  final GetWikiListUseCase _getWikiListUseCase;

  WikiListPageCubit({
    required GetWikiListUseCase getWikiListUseCase,
  })  : _getWikiListUseCase = getWikiListUseCase,
        super(WikiListPageInitialState());

  Future<void> getWikiList(String query) async {
    try {
      final response =
          await _getWikiListUseCase.call(GetWikiListParams(query: query));

      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (response) {
          emit(GetWikiListSuccess(wikiList: response, hasNextPage: false));
        },
      );
    } catch (e) {
      emit(FailedState(e.toString()));
    }
  }
}
