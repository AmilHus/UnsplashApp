import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/stores/image_store.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '/styles/styles.dart';

class HomeScreen extends StatefulObserverWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImageStore store = ImageStore();

  @override
  void initState() {
    super.initState();
    store.storeInitialize();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(child: _buildImageGrid()),
            if (store.isLoading) _buildLoadingIndicator(),
            if (store.isDownloading) _buildDownloadProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      margin: const EdgeInsets.only(top: 40.0, bottom: 20, left: 8, right: 8),
      decoration: BoxDecoration(
        color: AppColors.searchBarBackground,
        border: Border.all(color: AppColors.searchBarBorder),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: store.textEditingController,
        onChanged: (value) => store.onSearchChanged(),
        style: TextStyles.searchBarTextStyle,
        decoration: const InputDecoration(
          hintStyle: TextStyles.searchBarHintStyle,
          prefixIcon: Icon(Icons.search, color: AppColors.searchBarIcon),
          hintText: "Search",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return Scrollbar(
      controller: store.scrollController,
      child: GridView.custom(
        controller: store.scrollController,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          pattern: const [
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => _buildImageTile(index),
          childCount: store.images.length,
        ),
      ),
    );
  }

  Widget _buildImageTile(int index) {
    final image = store.images[index];
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        onDoubleTap: () => store.downloadImage(image.url),
        child: CachedNetworkImage(
          imageUrl: image.url,
          fit: BoxFit.fill,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.imageTileBorder,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          placeholder: (context, url) => Transform.scale(
            scale: 2,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.imagePlaceholder,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const LinearProgressIndicator(
      color: AppColors.progressBarLoading,
      backgroundColor: AppColors.progressBarBackground,
    );
  }

  Widget _buildDownloadProgressIndicator() {
    return StreamBuilder<int>(
      stream: store.downloadService.progressController.stream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        final progress = snapshot.data ?? 0;
        return LinearProgressIndicator(
          value: progress / 100,
          color: AppColors.progressBarDownloading,
          backgroundColor: AppColors.progressBarBackground,
        );
      },
    );
  }
}
