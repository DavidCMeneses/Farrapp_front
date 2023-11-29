import 'package:animate_do/animate_do.dart';
import 'package:farrap/config/constants/types.dart';
import 'package:farrap/domain/entities/establishment.dart';
import 'package:farrap/presentation/providers/establishment_provider.dart';
import 'package:farrap/presentation/widgets/custom_bottom_home.dart';
import 'package:farrap/presentation/widgets/custom_playlist.dart';
import 'package:farrap/presentation/widgets/user_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EstablishmentHomeScreen extends ConsumerStatefulWidget {
  static const name = 'establishment-home';

  final String establishmentId;

  const EstablishmentHomeScreen({super.key, required this.establishmentId});

  @override
  EstablishmentHomeScreenState createState() => EstablishmentHomeScreenState();
}

class EstablishmentHomeScreenState
    extends ConsumerState<EstablishmentHomeScreen> {
  @override
  void initState() {
    super.initState();

    ref
        .read(establishmentProvider.notifier)
        .loadEstablishment(widget.establishmentId);
  }

  @override
  Widget build(BuildContext context) {
    final Establishment? establishment =
        ref.watch(establishmentProvider)[widget.establishmentId];

    if (establishment == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return RefreshIndicator(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Preview del establecimiento'),
        ),
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            _CustomSliverAppBar(establishment: establishment),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => _EstablishmentDetails(
                          establishment: establishment,
                          establishmentId: widget.establishmentId,
                          onChangeRating: ref
                              .read(establishmentProvider.notifier)
                              .saveRating,
                        ),
                    childCount: 1)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(establishment.playlist.name),
              ),
            ),
            PlaylistWidget(
                playlistTitle: establishment.playlist.name,
                songs: establishment.playlist.songs),
          ],
        ),
        bottomNavigationBar: CustomBottomHome(currentIndex: 0),
      ),
      onRefresh: () => ref
          .read(establishmentProvider.notifier)
          .refreshEstablishment(widget.establishmentId),
    );
  }
}

class _EstablishmentDetails extends StatelessWidget {
  final Function(String, int) onChangeRating;
  final String establishmentId;
  final Establishment establishment;

  const _EstablishmentDetails(
      {required this.establishment,
      required this.establishmentId,
      required this.onChangeRating});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (size.width) * 0.3,
                child: Row(
                  children: [
                    Icon(
                      Icons.star_half_outlined,
                      color: Colors.yellow.shade800,
                      size: 25,
                    ),
                    const SizedBox(width: 3),
                    Text('${establishment.rating}',
                        style: textStyles.bodyMedium?.copyWith(
                            color: Colors.yellow.shade800, fontSize: 25)),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(establishment.city, style: textStyles.titleLarge),
                    Text(establishment.address),
                  ],
                ),
              )
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Horario", style: textStyles.titleLarge),
              Text(establishment.schedule
                  .map((e) => mapperDays[e.day])
                  .toList()
                  .join(",")),
              Text('Apertura: ${establishment.schedule.first.open}'),
              Text('Cierre: ${establishment.schedule.first.close}'),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: (size.width - 20),
            child: Text(establishment.description),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Tipo establecimiento', style: textStyles.titleLarge),
        ),

        // tipo establecimiento
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...establishment.preferences
                  .where((pref) => pref.type == "E")
                  .map((pref) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Chip(
                          label: Text(pref.name),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ))
            ],
          ),
        ),

        // Generos de Música
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Música más sonada', style: textStyles.titleLarge),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...establishment.preferences
                  .where((pref) => pref.type == "M")
                  .map((pref) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Chip(
                          label: Text(pref.name),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Califica tu experiencia', style: textStyles.titleLarge),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: UserRating(
            userRating: establishment.userRating,
            establishmentId: establishmentId,
            onChange: (a,i) {},
          ),
        ),

        const SizedBox(height: 50),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Establishment establishment;

  const _CustomSliverAppBar({required this.establishment});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          establishment.name,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                establishment.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1.0],
                          colors: [Colors.transparent, Colors.black87]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            ),
          ],
        ),
      ),
    );
  }
}
