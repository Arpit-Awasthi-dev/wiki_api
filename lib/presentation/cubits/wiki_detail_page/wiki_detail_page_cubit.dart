import 'package:test_wiki_assign/core/base_cubit/base_cubit.dart';
import 'package:test_wiki_assign/core/base_cubit/base_state.dart';

import '../../../domain/usecases/get_wiki_detail_use_case.dart';

part 'wiki_detail_page_state.dart';

class WikiDetailPageCubit extends BaseCubit {
  final GetWikiDetailUseCase _getWikiDetailUseCase;

  WikiDetailPageCubit({
    required GetWikiDetailUseCase getWikiDetailUseCase,
  })  : _getWikiDetailUseCase = getWikiDetailUseCase,
        super(WikiDetailPageInitialState());

  Future<void> getWikiList(int pageID, String title) async {
    try {
      emit(const LoadingState(true));
      final response = await _getWikiDetailUseCase.call(GetWikiDetailParams(
        pageID: pageID,
        title: title,
      ));

      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (response) {
          emit(GetWikiDetailSuccess(detail: response));
        },
      );
    } catch (e) {
      emit(FailedState(e.toString()));
    }
  }
}
