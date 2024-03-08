import 'package:flutter/material.dart';

class FavoriteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoriteAppBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Favorites'),
      centerTitle: true,
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(vertical: 10),
        controller: tabController,
        indicator: const _Decoration(color: Colors.blue),
        tabs: const [
          Tab(
            text: 'Movies',
          ),
          Tab(
           text: 'Series',
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _Decoration extends Decoration {
  final Color color;

  const _Decoration({required this.color});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _Painter(color);
}

class _Painter extends BoxPainter {
  final Color color;

  _Painter(this.color);
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final paint = Paint()..color = color;
    final size = configuration.size ?? Size.zero;

    // canvas.clipRRect(
    //   RRect.fromRectAndRadius(
    //     Rect.fromLTWH(
    //       size.width * 0.5 + offset.dx,
    //       size.height * 0.85,
    //       10,
    //       4,
    //     ),
    //     const Radius.circular(4),
    //   ),
    //   paint,

    // );

    canvas.drawCircle(
      Offset(size.width * 0.5 + offset.dx, size.height * 0.85),
      4,
      paint,
    );
  }
}
