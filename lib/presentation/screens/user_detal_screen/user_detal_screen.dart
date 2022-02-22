import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/getit_setup.dart';
import '../../../repository/address_repository/address_repository.dart';
import '../../../repository/auth_repository/auth_repository.dart';
import '../../../repository/models/api/address.dart';
import '../../../repository/models/api/suggestion.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/text_input_custom.dart';
import 'bloc/user_detail_bloc.dart';
import 'bloc/user_detail_event.dart';
import 'bloc/user_detail_state.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return UserDetailBloc(
            authRepository: locator<AuthRepository>(),
            addressRepository: locator<AddressRepository>())
          ..add(const UserDetailInit());
      },
      child: const UserDetailScreenBody(),
    ));
  }
}

class UserDetailScreenBody extends StatefulWidget {
  const UserDetailScreenBody({Key? key}) : super(key: key);

  @override
  State<UserDetailScreenBody> createState() => _UserDetailScreenBodyState();
}

class _UserDetailScreenBodyState extends State<UserDetailScreenBody> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController addressController;
  final node = FocusNode();

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    //addressController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void onFieldSubmitted() {}

  @override
  Widget build(BuildContext context) {
    final signInBloc = context.read<UserDetailBloc>();
    return BlocConsumer<UserDetailBloc, UserDetailState>(
      listener: (context, state) {
        if (state.userDetailStatus == UserDetailStatus.success) {
          navigateToMainScreen(context, clearStack: true);
        }
        if (state.logOutIsClicked == true) {
          navigateToEnterPhoneScreen(context, clearStack: true);
        }
        if (state.existedUser?.name != null) {
          nameController.text = state.existedUser!.name;
        }
        if (state.existedUser?.description != null) {
          descriptionController.text = state.existedUser!.description!;
        }
        if (state.existedUser?.address?.city != null) {
          print(state);
          addressController.text = state.existedUser!.address!.city!;
        }
      },
      builder: (context, state) {
        //print(state.addresses);
        return SafeArea(
          child: SingleChildScrollView(
              reverse: true,
              child: Column(children: [
                Image.asset('assets/images/logo1.png'),
                TextInputCustom(
                  icon: const Icon(Icons.person),
                  controller: nameController,
                  hint: 'Name',
                  onChanged: (value) {
                    signInBloc.add(UserDetailNameChanged(value));
                  },
                ),
                TextInputCustom(
                  icon: const Icon(Icons.text_snippet),
                  controller: descriptionController,
                  hint: 'Description',
                  onChanged: (value) {
                    signInBloc.add(UserDetailDescriptionChanged(value));
                  },
                ),
                Autocomplete<Address>(
                  optionsBuilder: (TextEditingValue value) {
                    print(state.addresses);
                    return state.addresses ?? <Address>[];
                  },
                  fieldViewBuilder: (context, addressProvidedController, node,
                      onFieldSubmitted) {
                    addressController = addressProvidedController;
                    print(addressController);
                    return TextInputCustom(
                      node: node,
                      icon: const Icon(Icons.location_city),
                      controller: addressController,
                      hint: 'Address',
                      onChanged: (value) {
                        signInBloc.add(UserDetailAddressChanged(value));
                      },
                    );
                  },
                  onSelected: (Address address) {
                    signInBloc.add(UserDetailAddressOptionSubmitted(address));
                    debugPrint('You just selected $address');
                  },
                ),
                const Divider(height: 30),
                if (state.isImageLoading == true)
                  ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 50, minWidth: 50),
                      child: const CircularProgressIndicator())
                else if (state.avatarFile == null)
                  IconButton(
                    onPressed: () {
                      signInBloc.add(const UserDetailImageAddClicked());
                    },
                    icon: Image.asset('assets/images/avatar_blank.png'),
                    iconSize: 50,
                  )
                else
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 50, minWidth: 50),
                    child: CircleAvatar(
                      backgroundImage: MemoryImage(state.avatarFile!),
                      radius: 50,
                    ),
                  ),
                const Divider(height: 30),
                if (state.userDetailStatus == UserDetailStatus.failure)
                  Center(
                    child: Row(
                      children: const [
                        Icon(Icons.error),
                        Text(
                            'Something went wrong with server response, please try later')
                      ],
                    ),
                  ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      if (state.isLoading == true)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: () {
                            signInBloc.add(const UserDetailSubmitted());
                          },
                          child: const Text('Save'),
                        ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                        onPressed: () {
                          signInBloc.add(const UserDetailLogOutClicked());
                        },
                        icon: Icon(Icons.logout),
                        iconSize: 50,
                      )
                    ])
                  ],
                ),
              ])),
        );
      },
    );
  }
}
