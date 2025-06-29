import 'package:fire_social_media/features/search/domain/search_repo.dart';
import 'package:fire_social_media/features/search/screen/cubits/search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;

  SearchCubit({required this.searchRepo}) : super(SearchInitial());

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    try {
      emit(SearchLoading());
      final users = await searchRepo.searchUsers(query);
      emit(SearchLoaded(users));
    } catch (e) {
      emit(SearchError("Error fetching search results"));
    }
  }
}
