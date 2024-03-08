import '../../../../domain/either/either.dart';
import '../../../../domain/failures/http_request/http.request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../state_notifier.dart';
import 'state/favorites_state.dart';

class FavoritesController extends StateNotifier {
  FavoritesController(
    super.state, {
    required this.accountRepository,
  });
  final AccountRepository accountRepository;

  Future<void> init() async {
    state = FavoritesState.loading();
    final movieResult = await accountRepository.getFavorites(
      MediaType.movie,
    );
    state = await movieResult.when(
      left: (_) async => state = FavoritesState.failed(),
      right: (movies) async {
        final seriesResult = await accountRepository.getFavorites(
          MediaType.tv,
        );
        return seriesResult.when(
          left: (_) => FavoritesState.failed(),
          right: (series) => FavoritesState.loaded(
            movies: movies,
            series: series,
          ),
        );
      },
    );
  }

  Future<Either<HttpRequestFailure, void>> markAsFAvorite(Media media) async {
    assert(state is FavoritesStateLoaded);
    final loadedState = state as FavoritesStateLoaded;

    final isMovie = media.type == MediaType.movie;
    final Map<int, Media> map =
        isMovie ? {...loadedState.movies} : {...loadedState.series};
    final favorite = !map.keys.contains(media.id);
    final result = await accountRepository.markAsFAvorite(
      mediaId: media.id,
      type: media.type,
      favorite: favorite,
    );
    result.whenOrNull(
      right: (_) {
        if (favorite) {
          map[media.id] = media;
        } else {
          map.remove(media.id);
        }
        state = isMovie
            ? loadedState.copyWith(movies: map)
            : loadedState.copyWith(series: map);
      },
    );
    return result;
  }
}
