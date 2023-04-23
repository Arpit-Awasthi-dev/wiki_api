import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:test_wiki_assign/presentation/cubits/wiki_detail_page/wiki_detail_page_cubit.dart';
import '../presentation/cubits/wiki_list_page/wiki_list_page_cubit.dart';
import 'injection_container.dart' as di;

class BlocProviders {
  static List<SingleChildWidget> toGenerateProviders() {
    return [
      BlocProvider(
        create: (_) => di.sl<WikiListPageCubit>(),
      ),
      BlocProvider(
        create: (_) => di.sl<WikiDetailPageCubit>(),
      ),
    ];
  }
}
