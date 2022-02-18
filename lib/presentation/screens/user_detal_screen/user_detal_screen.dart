import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/getit_setup.dart';
import '../../../repository/auth_repository/auth_repository.dart';
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
            authRepository: locator<AuthRepository>(), context: context)
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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
        if(state.existedName != null) {
          nameController.text = state.existedName!;
        }
        if(state.existedDescription != null) {
          descriptionController.text = state.existedDescription!;
        }
      },
      builder: (context, state) => SafeArea(
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
      ),
    );
  }
}
