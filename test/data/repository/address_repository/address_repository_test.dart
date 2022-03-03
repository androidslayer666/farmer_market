import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_market/data/api/address_suggestions_rest_client.dart';
import 'package:farmer_market/data/repository/address_repository/address_repository.dart';
import 'package:farmer_market/data/repository/models/api/address.dart';
import 'package:farmer_market/data/repository/models/api/suggestion.dart';
import 'package:farmer_market/data/repository/models/api/suggestions.dart';
import 'package:farmer_market/data/repository/success_failure.dart';
import 'package:farmer_market/data/repository/token_provider/token_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_repository_test.mocks.dart';

@GenerateMocks([FirebaseFirestore, FirebaseAuth, DadataClient, TokenProvider])
void main() async {
  final _firestore = MockFirebaseFirestore();
  final _auth = MockFirebaseAuth();
  final _dadataClient = MockDadataClient();
  final _tokenProvider = MockTokenProvider();

  final repo = AddressRepository(
      auth: _auth,
      dadataClient: _dadataClient,
      firestore: _firestore,
      tokenProvider: _tokenProvider);

  group('get_suggestions_group', () {
    test('get failure if token is not received', () async {
      when(_tokenProvider.getDadataToken()).thenAnswer((_) async => null);
      final result = await repo.getSuggestions('query');
      assert(result is Failure);
      // expect(result, equals(Failure()));
    });
    test('get success if everything is ok', () async {
      when(_tokenProvider.getDadataToken()).thenAnswer((_) async => 'token');
      when(_dadataClient.getSuggestions('query', 'Token token'))
          .thenAnswer((_) async => Future(() => Suggestions()));
      final result = await repo.getSuggestions('query');
      assert(result is Success);
    });

    test('get right suggestions', () async {
      when(_tokenProvider.getDadataToken()).thenAnswer((_) async => 'token');
      when(_dadataClient.getSuggestions('query', 'Token token')).thenAnswer(
          (_) async => Future(() => Suggestions(suggestions: [
                Suggestion(value: 'value', data: Address(userId: '123'))
              ])));
      final result = await repo.getSuggestions('query');
      final suggestions = (result as Success<List<Suggestion>, String>).data;
      assert(suggestions![0].data.userId == '123');
    });
  });
}
