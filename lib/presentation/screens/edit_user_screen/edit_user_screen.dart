import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/getit_setup.dart';
import '../../../data/models/api/address.dart';
import '../../../data/repository/auth_repository/auth_repository.dart';
import '../../../data/repository/interfaces/i_address_repository.dart';
import '../../../data/models/user/user.dart';
import '../../../generated/l10n.dart';
import '../../navigation/arguments.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/text_input_custom.dart';
import 'bloc/edit_user_bloc.dart';
import 'bloc/edit_user_event.dart';
import 'bloc/edit_user_state.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UserDetailArguments?;
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return EditUserBloc(
            authRepository: locator<AuthRepository>(),
            addressRepository: locator<IAddressRepository>())
          ..add(UserDetailInit(args?.user));
      },
      child: EditUserScreenBody(args: args),
    ));
  }
}

class EditUserScreenBody extends StatefulWidget {
  const EditUserScreenBody({Key? key, this.args}) : super(key: key);

  final UserDetailArguments? args;

  @override
  State<EditUserScreenBody> createState() => _EditUserScreenBodyState();
}

class _EditUserScreenBodyState extends State<EditUserScreenBody> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController addressController;
  final node = FocusNode();

  @override
  void initState() {
    super.initState();
    final User? user = widget.args?.user;
    nameController = TextEditingController(text: user?.name ?? '');
    descriptionController =
        TextEditingController(text: user?.description ?? '');
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInBloc = context.read<EditUserBloc>();
    return BlocConsumer<EditUserBloc, EditUserState>(
      listener: (context, state) {
        if (state.userDetailStatus == UserDetailStatus.success) {
          navigateToMainScreen(context, clearStack: true);
        }
        if (state.logOutIsClicked == true) {
          navigateToEnterPhoneScreen(context, clearStack: true);
        }
        //this is because of the hardcoded editing controller in Autocomplete.
        // It's not possible to set initial text directly, so I pass the value
        // after the link to the controller is passed to addressController
        if (state.addressQuery == null) {
          addressController.text = widget.args?.user?.address.toString() ?? '';
        }
      },
      builder: (context, state) {
        //print(state.addresses);
        return SafeArea(
          child: SingleChildScrollView(
              reverse: true,
              child: Column(children: [
                Image.asset('assets/images/logo1.png'),
                EditUserTextInputs(
                  nameController: nameController,
                  descriptionController: descriptionController,
                  context: context,
                  addresses: state.addresses,
                  signInBloc: signInBloc,
                ),
                Autocomplete<Address>(
                  optionsBuilder: (TextEditingValue value) {
                    //print(state.addresses);
                    return state.addresses ?? <Address>[];
                  },
                  fieldViewBuilder: (context, addressProvidedController, node,
                      onFieldSubmitted) {
                    addressController = addressProvidedController;
                    //print(addressController);
                    return TextInputCustom(
                      node: node,
                      icon: const Icon(Icons.location_city),
                      controller: addressController,
                      hint: S.of(context).userDetailScreen_address,
                      onChanged: (value) {
                        signInBloc.add(UserDetailAddressChanged(value));
                      },
                    );
                  },
                  onSelected: (Address address) {
                    signInBloc.add(UserDetailAddressOptionSubmitted(address));
                  },
                ),
                const Divider(height: 30),
                EditUserChooseAvatarWidget(
                    isImageLoading: state.isImageLoading,
                    avatarFile: state.avatarFile,
                    signInBloc: signInBloc),
                const Divider(height: 30),
                if (state.userDetailStatus == UserDetailStatus.failure)
                  Center(
                    child: Row(
                      children: [
                        const Icon(Icons.error),
                        Text(S
                            .of(context)
                            .userDetailScreen_serverResponseGaveBad)
                      ],
                    ),
                  ),
                EditUserButtonRow(
                  isLoading: state.isLoading,
                  editUserBloc: signInBloc,
                )
              ])),
        );
      },
    );
  }
}

class EditUserChooseAvatarWidget extends StatelessWidget {
  const EditUserChooseAvatarWidget({
    Key? key,
    required this.isImageLoading,
    required this.avatarFile,
    required this.signInBloc,
  }) : super(key: key);

  final bool? isImageLoading;
  final Uint8List? avatarFile;
  final EditUserBloc signInBloc;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (isImageLoading == true)
        ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 50, minWidth: 50),
            child: const CircularProgressIndicator())
      else if (avatarFile == null)
        IconButton(
          onPressed: () {
            signInBloc.add(const UserDetailImageAddClicked());
          },
          icon: Image.asset('assets/images/avatar_blank.png'),
          iconSize: 50,
        )
      else
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 50, minWidth: 50),
          child: CircleAvatar(
            backgroundImage: MemoryImage(avatarFile!),
            radius: 50,
          ),
        ),
    ]);
  }
}

class EditUserTextInputs extends StatelessWidget {
  const EditUserTextInputs({
    Key? key,
    required this.nameController,
    required this.descriptionController,
    required this.context,
    required this.addresses,
    required this.signInBloc,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final BuildContext context;
  final List<Address>? addresses;
  final EditUserBloc signInBloc;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextInputCustom(
        icon: const Icon(Icons.person),
        controller: nameController,
        hint: S.of(context).userDetailScreen_name,
        onChanged: (value) {
          signInBloc.add(UserDetailNameChanged(value));
        },
      ),
      TextInputCustom(
        icon: const Icon(Icons.text_snippet),
        controller: descriptionController,
        hint: S.of(context).userDetailScreen_description,
        onChanged: (value) {
          signInBloc.add(UserDetailDescriptionChanged(value));
        },
      ),
    ]);
  }
}

class EditUserButtonRow extends StatelessWidget {
  const EditUserButtonRow(
      {Key? key, required this.isLoading, required this.editUserBloc})
      : super(key: key);

  final bool? isLoading;
  final EditUserBloc editUserBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (isLoading == true)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () {
                    editUserBloc.add(const UserDetailSubmitted());
                  },
                  child: Text(S.of(context).userDetailScreen_save),
                ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                onPressed: () {
                  editUserBloc.add(const UserDetailLogOutClicked());
                },
                icon: const Icon(Icons.logout),
                iconSize: 50,
              )
            ])
          ],
        ),
      ],
    );
  }
}
