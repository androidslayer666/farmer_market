import 'dart:typed_data';

import 'package:farmer_market/data/repository/success_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/getit_setup.dart';
import '../../../data/models/api/address.dart';
import '../../../data/models/api/suggestion.dart';
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
            child: BlocConsumer<EditUserBloc, EditUserState>(
              listener: (context, state) {
                if (state.userDetailStatus == UserDetailStatus.success) {
                  navigateToMainScreen(context, clearStack: true);
                }
                if (state.logOutIsClicked == true) {
                  navigateToEnterPhoneScreen(context, clearStack: true);
                }
              },
              builder: (context, state) {
                return EditUserScreenBody(args: args, state: state);
              },
            )));
  }
}

class EditUserScreenBody extends StatelessWidget {
  const EditUserScreenBody({Key? key, this.args, required this.state})
      : super(key: key);

  final UserDetailArguments? args;
  final EditUserState state;

  @override
  Widget build(BuildContext context) {
    final editUserBloc = context.read<EditUserBloc>();
    return SafeArea(
      child: SingleChildScrollView(
          reverse: true,
          child: Column(children: [
            Image.asset('assets/images/logo1.png'),
            EditUserTextInputs(
              existedUser: args?.user,
              context: context,
              addresses: state.addresses,
              signInBloc: editUserBloc,
            ),
            EditUserAddressAutocomplete(
              state: state,
              editUserBloc: editUserBloc,
              initial: args?.user?.address.toString(),
            ),
            EditUserIsSellerCheckBox(
              editUserBloc: editUserBloc,
              isChecked: state.user?.isSeller == true,
            ),
            const Divider(height: 30),
            EditUserChooseAvatarWidget(
                isImageLoading: state.isImageLoading,
                avatarFile: state.avatarFile,
                signInBloc: editUserBloc),
            const Divider(height: 30),
            if (state.userDetailStatus == UserDetailStatus.failure)
              Center(
                child: Row(
                  children: [
                    const Icon(Icons.error),
                    Text(S.of(context).userDetailScreen_serverResponseGaveBad)
                  ],
                ),
              ),
            EditUserButtonRow(
              isLoading: state.isLoading,
              editUserBloc: editUserBloc,
            )
          ])),
    );
  }
}

class EditUserIsSellerCheckBox extends StatelessWidget {
  const EditUserIsSellerCheckBox(
      {Key? key, required this.isChecked, required this.editUserBloc})
      : super(key: key);

  final bool isChecked;
  final EditUserBloc editUserBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: Theme.of(context).primaryColor,
          checkColor: Theme.of(context).backgroundColor,
          value: isChecked,
          onChanged: (bool? value) {
            editUserBloc.add(UserDetailIsSellerChanged(!isChecked));
          },
        ),
        const Text('Are you a seller?')
      ],
    );
  }
}

class EditUserAddressAutocomplete extends StatelessWidget {
  const EditUserAddressAutocomplete(
      {Key? key, required this.state, required this.editUserBloc, this.initial})
      : super(key: key);

  final EditUserState state;
  final EditUserBloc editUserBloc;
  final String? initial;

  @override
  Widget build(BuildContext context) {
    final addressRepository = locator.get<IAddressRepository>();
    return Autocomplete<Address>(
      optionsBuilder: (TextEditingValue value) async {
        // didn't find a way to get an actual result through state here. That's why direct request is used.
        final result = await addressRepository.getSuggestions(value.text);
        if (result is Success<List<Suggestion>, String>) {
          return result.data?.map((e) => e.data) ?? [];
        } else {
          return <Address>[];
        }
        // return state.addresses ?? <Address>[];
      },
      fieldViewBuilder:
          (context, addressProvidedController, node, onFieldSubmitted) {
        return TextInputCustom(
          initialValue: initial,
          node: node,
          icon: Icons.location_city,
          hint: S.of(context).userDetailScreen_address,
          onChanged: (value) {
            editUserBloc.add(UserDetailAddressChanged(value));
            addressProvidedController.text = value;
          },
        );
      },
      onSelected: (Address address) {
        editUserBloc.add(UserDetailAddressOptionSubmitted(address));
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
    // required this.nameController,
    // required this.descriptionController,
    required this.existedUser,
    required this.context,
    required this.addresses,
    required this.signInBloc,
  }) : super(key: key);

  // final TextEditingController nameController;
  // final TextEditingController descriptionController;
  final User? existedUser;
  final BuildContext context;
  final List<Address>? addresses;
  final EditUserBloc signInBloc;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextInputCustom(
        initialValue: existedUser?.name,
        icon: Icons.person,
        //controller: nameController,
        hint: S.of(context).userDetailScreen_name,
        onChanged: (value) {
          signInBloc.add(UserDetailNameChanged(value));
        },
      ),
      TextInputCustom(
        initialValue: existedUser?.description,
        icon: Icons.text_snippet,
        //controller: descriptionController,
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
