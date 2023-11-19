import 'package:farrap/domain/entities/establishment_card.dart';

class EstablishmentResult {
  final int totalPages;
  final List<EstablishmentCard> establishments;

  EstablishmentResult({
    required this.totalPages, 
    required this.establishments
  });
  
}
