import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/locator.dart';
import 'package:trilo_admin/models/store.dart';
import 'package:trilo_admin/services/db.dart';
import 'package:trilo_admin/services/nav.dart';
import 'package:trilo_admin/widgets/shimmer_effect.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview(this.uid, {super.key});
  final String uid;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  final PageController controller = PageController();
  final DatabaseService db = locator<DatabaseService>();
  final NavigationService nav = locator<NavigationService>();

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      children: [
        FutureBuilder<Store>(
            future: db.getStore(widget.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Store store = snapshot.data!;
                final photos = store.photos;
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(photos[index]),
                        initialScale: PhotoViewComputedScale.contained * 0.8,
                        heroAttributes:
                            PhotoViewHeroAttributes(tag: photos[index]),
                      );
                    },
                    itemCount: photos!.length,
                    loadingBuilder: (context, event) => Center(
                      child: CircularProgressIndicator.adaptive(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                int.parse(event.expectedTotalBytes.toString()),
                      ),
                    ),
                    // backgroundDecoration: widget.backgroundDecoration,
                    pageController: pageController,
                    // onPageChanged: onPageChanged,
                  ),
                );
              }
              return Center(
                child: SizedBox(
                  width: ScreenSize.width,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ShimmerEffect(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              );
            }),
        SafeArea(
          child: IconButton.filledTonal(
            onPressed: () => nav.pop(),
            icon: const Icon(LucideIcons.chevronLeft),
          ),
        ),
      ],
    );
  }
}
