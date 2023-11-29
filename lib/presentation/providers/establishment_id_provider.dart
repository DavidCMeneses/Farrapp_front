import 'package:farrap/infraestructure/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final establishmentIdProvider = Provider((ref) => KeyValueStorageServiceImpl());
