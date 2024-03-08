import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/media/media.dart';
import '../global/controllers/favorites/favourites_controller.dart';
import '../global/dialogs/show_loader.dart';

Future<void> markAsFAvorite({
  required BuildContext context,
  required Media media,
  required bool Function() mounted,
}) async {
  final FavoritesController favoritesController = context.read();

  final result = await showLoader(
    context,
    favoritesController.markAsFAvorite(media),
  );

  if (!mounted()) {
    return;
  }

  result.whenOrNull(
    left: (failure) {
      final errorMessage = failure.when(
        notFound: () => 'Resource not found',
        network: () => 'Network error',
        unauthorized: () => 'Unauthorized',
        unknown: () => 'Unknown',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    },
  );
}
