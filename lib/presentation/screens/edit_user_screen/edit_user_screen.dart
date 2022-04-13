import 'dart:typed_data';

import 'package:farmer_market/data/repository/success_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/di/getit_setup.dart';
import '../../../data/models/api/address.dart';
import '../../../data/models/api/suggestion.dart';
import '../../../data/repository/auth_repository/auth_repository.dart';
import '../../../data/repository/interfaces/i_address_repository.dart';
import '../../../data/models/user/user.dart';
import '../../../generated/l10n.dart';
import '../../navigation/arguments.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/image_add_image_row.dart';
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
                if (state.changesSaved == true) {
                  navigateToMainScreen(context, clearStack: true);
                }
                if (state.saveClickedWhenInputIsNotValid == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please fill all the fields correctly"),
                    duration: Duration(seconds: 2),
                  ));
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
              user: args?.user,
              state: state,
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
            const SizedBox(height: 30),
            EditUserChooseAvatarWidget(
                isImageLoading: state.isImageLoading,
                avatarFile: state.avatarFile,
                signInBloc: editUserBloc),
            const SizedBox(height: 30),
            EditUserButtonRow(
              isLoading: state.isLoading,
              editUserBloc: editUserBloc,
            )
          ])),
    );
  }
}

class EditUserTextInputs extends StatefulWidget {
  const EditUserTextInputs({
    Key? key,
    required this.user,
    required this.context,
    required this.addresses,
    required this.signInBloc,
    required this.state,
  }) : super(key: key);

  final EditUserState state;
  final User? user;
  final BuildContext context;
  final List<Address>? addresses;
  final EditUserBloc signInBloc;

  @override
  State<EditUserTextInputs> createState() => _EditUserTextInputsState();
}

class _EditUserTextInputsState extends State<EditUserTextInputs> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController()..text = widget.user?.name ?? '';
    nameController.addListener(() {
      widget.signInBloc.add(UserDetailNameChanged(nameController.text));
    });
    descriptionController = TextEditingController()
      ..text = widget.user?.description ?? '';
    descriptionController.addListener(() {
      widget.signInBloc
          .add(UserDetailDescriptionChanged(descriptionController.text));
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextInputCustom(
        controller: nameController,
        icon: Icons.person,
        hint: S.of(context).userDetailScreen_name,
        errorText: widget.state.nameIsValid == false
            ? 'Please fill in the field'
            : null,
      ),
      TextInputCustom(
        controller: descriptionController,
        icon: Icons.text_snippet,
        hint: S.of(context).userDetailScreen_description,
        errorText: widget.state.descriptionIsValid == false
            ? 'Description is too long'
            : null,
      ),
    ]);
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
          lines: null,
          initialValue: initial,
          node: node,
          icon: Icons.location_city,
          hint: S.of(context).userDetailScreen_address,
          onChanged: (value) {
            editUserBloc.add(UserDetailAddressChanged(value));
            addressProvidedController.text = value;
          },
          errorText: state.addressIsValid == false
              ? 'please choose the address'
              : null,
        );
      },
      onSelected: (Address address) {
        editUserBloc.add(UserDetailAddressOptionSubmitted(address));
      },
    );
  }
}

class EditUserChooseAvatarWidget extends StatefulWidget {
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
  State<EditUserChooseAvatarWidget> createState() =>
      _EditUserChooseAvatarWidgetState();
}

class _EditUserChooseAvatarWidgetState
    extends State<EditUserChooseAvatarWidget> {
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    return ImageAddImageRow(
      isImageLoading: widget.isImageLoading,
      image: widget.avatarFile,
      addImageFromGallery: () => widget.signInBloc
          .add(const UserDetailImageAddClicked(ImageSource.gallery)),
      addImageFromCamera: () => widget.signInBloc
          .add(const UserDetailImageAddClicked(ImageSource.camera)),
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
                iconSize: 35,
              )
            ])
          ],
        ),
      ],
    );
  }
}
