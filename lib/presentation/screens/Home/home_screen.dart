
import 'package:farrap/presentation/providers/establishment_view_provider.dart';
import 'package:farrap/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:farrap/presentation/widgets/custom_bottom_navigationbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farrapp'),
      ),
      body: const _HomeView(),
      floatingActionButton: IconButton(onPressed: () {}, icon: const Icon(Icons.headset)),
      bottomNavigationBar: const CustomBottomNavigation(currentIndex: 0),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({super.key});

  @override
  ConsumerState<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    ref.read(homeProvider.notifier).loadNextPage();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        ref.read(homeProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final establishments = ref.watch(homeProvider).establishments;

    if (establishments.isEmpty) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return CustomScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                      children: [
                        CustomCard(establishmentCard: establishments[index]),
                        const Padding(padding: EdgeInsets.all(10))
                      ],
                    ),
                childCount: establishments.length))
      ],
    );
  }
}
