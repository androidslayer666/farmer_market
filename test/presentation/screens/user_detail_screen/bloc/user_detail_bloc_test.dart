import 'package:bloc_test/bloc_test.dart';
import 'package:farmer_market/data/repository/address_repository/address_repository.dart';
import 'package:farmer_market/data/repository/auth_repository/auth_repository.dart';
import 'package:farmer_market/data/models/user/user.dart';
import 'package:farmer_market/data/repository/success_failure.dart';
import 'package:farmer_market/presentation/screens/user_detail_screen/bloc/user_detail_bloc.dart';
import 'package:farmer_market/presentation/screens/user_detail_screen/bloc/user_detail_event.dart';
import 'package:farmer_market/presentation/screens/user_detail_screen/bloc/user_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_detail_bloc_test.mocks.dart';

// ignore_for_file: prefer_const_constructors
@GenerateMocks([AddressRepository, AuthRepository])
void main() {
  late MockAddressRepository addressRepository;
  late MockAuthRepository authRepository;

  setUp(() {
    addressRepository = MockAddressRepository();
    authRepository = MockAuthRepository();
    when(authRepository.getCurrentUser())
        .thenAnswer((realInvocation) => Future(() => Success(data: User())));
  });

  group('WeatherCubit', () {
    blocTest<UserDetailBloc, UserDetailState>('',
        build: () => UserDetailBloc(
            addressRepository: addressRepository,
            authRepository: authRepository),
        act: (bloc) => bloc.add(UserDetailNameChanged('123')),
        expect: () => [UserDetailState(name: '123')]);

    blocTest<UserDetailBloc, UserDetailState>('',
        build: () => UserDetailBloc(
            addressRepository: addressRepository,
            authRepository: authRepository),
        act: (bloc) => bloc.add(UserDetailDescriptionChanged('123')),
        expect: () => [UserDetailState(description: '123')]);

    blocTest<UserDetailBloc, UserDetailState>('',
        build: () => UserDetailBloc(
            addressRepository: addressRepository,
            authRepository: authRepository),
        act: (bloc) => bloc.add(UserDetailInit(null)),
        expect: () => [
              UserDetailState(isLoading: true, isImageLoading: true),
              UserDetailState(
                  isLoading: false,
                  isImageLoading: true,
                  haveUserInfoOnServer: true,
              ),
              UserDetailState(
                  isLoading: false,
                  isImageLoading: false,
                  haveUserInfoOnServer: true)
            ]);
  });
}
