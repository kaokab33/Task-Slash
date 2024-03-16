import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:slash/components/cards.dart';

import 'package:slash/models/all_products.dart';
import 'package:slash/services/get_all_products.dart';

class Proudcts extends StatefulWidget {
  const Proudcts({super.key});

  @override
  State<Proudcts> createState() => _ProudctsState();
}

class _ProudctsState extends State<Proudcts> {
  final PagingController<int, AllProudcts> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  final _pageSize = 1;
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await GetProuducts().getProducts(pageKey + 1);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0c0c0c),
          title: const Center(
              child: Text('Slash.',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ))),
        ),
        body: PagedGridView<int, AllProudcts>(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            animateTransitions: true,
            noItemsFoundIndicatorBuilder: (context) {
              return const Center(
                child: Text(
                  "No Products Found.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            },
            firstPageProgressIndicatorBuilder: (context) {
              return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  color: const Color(0xFF1A1A3F),
                  size: 50,
                ),
              );
            },
            newPageProgressIndicatorBuilder: (context) => Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: const Color(0xFF1A1A3F),
                size: 50,
              ),
            ),
            itemBuilder: (context, item, index) {
              return CardProduct(product: item);
            },
          ),
        ));
  }
}
