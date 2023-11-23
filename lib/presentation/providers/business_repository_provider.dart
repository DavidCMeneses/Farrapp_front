import 'package:farrap/infraestructure/datasources/business_datasource_impl.dart';
import 'package:farrap/infraestructure/repositories/business_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final businessRepositoryProvider = Provider((ref) {
  return BusinessRepositoryImpl( datasource: BusinessDatasourceImpl() );
});