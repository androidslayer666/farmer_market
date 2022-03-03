import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../data/api/address_suggestions_rest_client.dart';
import '../../data/repository/address_repository/address_repository.dart';
import '../../data/repository/auth_repository/auth_repository.dart';
import '../../data/repository/interfaces/i_address_repository.dart';
import '../../data/repository/products/product_repository.dart';
import '../../data/repository/storage/storage_repository.dart';
import '../../data/repository/token_provider/token_provider.dart';

GetIt locator = GetIt.instance;

void setupGetIt() {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _dio = Dio();
  final _dadataClient = DadataClient(_dio);
  final TokenProvider tokenProvider = TokenProvider(firestore: _firestore);

  locator.registerLazySingleton(
      () => StorageRepository(storage: _storage, auth: _auth));
  locator.registerLazySingleton<IAddressRepository>(
      () => AddressRepository(firestore: _firestore, auth: _auth, dadataClient: _dadataClient, tokenProvider: tokenProvider));

  final StorageRepository _storageRepository = locator<StorageRepository>();

  locator.registerLazySingleton(() => AuthRepository(
      firestore: _firestore,
      auth: _auth,
      storageRepository: _storageRepository));

  final IAddressRepository _addressRepository = locator<IAddressRepository>();

  locator.registerLazySingleton(() => ProductRepository(
      firestore: _firestore,
      auth: _auth,
      storageRepository: _storageRepository,
      addressRepository: _addressRepository));
}
