import 'package:farrap/domain/entities/establishment_card.dart';

class EstablishmentResult {
  final int totalPages;
  final List<EstablishmentCard> establishments;

  EstablishmentResult({required this.totalPages, required this.establishments});

  EstablishmentResult copyWith({
    int? totalpages,
    List<EstablishmentCard>? establishments,
  }) =>
      EstablishmentResult(
          totalPages: totalPages, 
          establishments: establishments ?? this.establishments);
}
