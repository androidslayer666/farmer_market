import 'dart:typed_data';

import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:farmer_market/presentation/navigation/navigation_wrapper.dart';
import 'package:farmer_market/presentation/screens/main_screen_pages/user_products_page/bloc/user_products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/di/getit_setup.dart';
import '../../../data/models/product/category.dart';
import '../../../data/models/product/product.dart';
import '../../../data/repository/auth_repository/auth_repository.dart';
import '../../../data/repository/product_repository/product_repository.dart';
import '../../../generated/l10n.dart';
import '../../shared/icon_gradient_button.dart';
import '../../shared/show_confirmation_dialogue.dart';
import '../../shared/text_input_custom.dart';
import 'bloc/add_product_bloc.dart';
import 'bloc/add_product_event.dart';
import 'bloc/add_product_state.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AddProductArguments?;

    return BlocProvider(
      create: (context) => AddProductBloc(
          authRepository: locator<AuthRepository>(),
          productRepository: locator<ProductRepository>())
        ..add(AddProductInit(args)),
      child: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          final userProductBloc = context.read<UserProductsBloc>();
          if (state.deletingIsSuccessful == true) {
            navigateToMainScreen(context);
          }
          if (state.addingIsSuccessful == true) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Product added successfully"),
              duration: Duration(seconds: 1),
            ));
            Navigator.of(context).pop();
            userProductBloc.add(const UserProductsEventUpdateList());
          }
        },
        builder: (context, state) {
          return AddProductScreenBody(args: args, state: state);
        },
      ),
    );
  }
}

class AddProductScreenBody extends StatelessWidget {
  const AddProductScreenBody({Key? key, this.args, required this.state})
      : super(key: key);

  final AddProductArguments? args;
  final AddProductState state;

  @override
  Widget build(BuildContext context) {
    final _addProductBloc = context.read<AddProductBloc>();
    return Scaffold(
      appBar: AppBar(
        // leading: BackButton(
        //     color: Theme.of(context).indicatorColor
        // ),
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor, //change your color here
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(S.of(context).addProductScreen_addProduct, style: TextStyle(color: Theme.of(context).indicatorColor),),
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: Column(children: [
            AddProductTextInputs(
              addProductBloc: _addProductBloc,
              product: args?.product,
            ),
            AddProductUnitDropdown(
                unit: state.product?.unit, addProductBloc: _addProductBloc),
            AddProductCategoryDropdown(
                category: Category.milk, addProductBloc: _addProductBloc),
            const Divider(height: 30),
            AddProductImage(
                isImageLoading: state.isImageLoading,
                productImage: state.productImage,
                addProductBloc: _addProductBloc),
            const Divider(height: 30),
            AddProductBottomButtons(
                isLoading: state.isLoading,
                addProductBloc: _addProductBloc,
                productId: state.product?.id)
          ])),
    );
  }
}

class AddProductTextInputs extends StatelessWidget {
  const AddProductTextInputs(
      {Key? key, required this.product, required this.addProductBloc})
      : super(key: key);

  final Product? product;
  final AddProductBloc addProductBloc;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        TextInputCustom(
          initialValue: product?.name,
          icon: Icons.person,
          hint: S.of(context).addProductScreen_product,
          onChanged: (value) {
            addProductBloc.add(AddProductNameChanged(value));
          },
        ),
        TextInputCustom(
          initialValue: product?.description,
          icon: Icons.text_snippet,
          hint: S.of(context).addProductScreen_description,
          onChanged: (value) {
            addProductBloc.add(AddProductDescriptionChanged(value));
          },
        ),
        TextInputCustom(
          initialValue: product?.price.toString(),
          icon: Icons.monetization_on,
          textInputFormatter: FilteringTextInputFormatter.digitsOnly,
          textInputType: TextInputType.number,
          hint: S.of(context).addProductScreen_price,
          onChanged: (value) {
            addProductBloc.add(AddProductPriceChanged(value));
          },
        ),
      ],
    );
  }
}

class AddProductBottomButtons extends StatelessWidget {
  const AddProductBottomButtons(
      {Key? key,
      required this.isLoading,
      required this.addProductBloc,
      this.productId})
      : super(key: key);

  final bool? isLoading;
  final String? productId;
  final AddProductBloc addProductBloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (isLoading == true)
            const CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: () {
                addProductBloc.add(const AddProductSubmitted());
              },
              child: Text(S.of(context).addProductScreen_save),
            ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            onPressed: () {
              showConfirmationDialog(
                  text: 'Are you sure you want to delete the product?',
                  onConfirm: () {
                    addProductBloc
                        .add(AddProductDeleteSubmitted(productId ?? ''));
                  },
                  context: context);
            },
            icon: const Icon(Icons.delete),
            iconSize: 50,
          )
        ])
      ],
    );
  }
}

class AddProductUnitDropdown extends StatelessWidget {
  const AddProductUnitDropdown(
      {Key? key, required this.unit, required this.addProductBloc, this.portion})
      : super(key: key);

  final int? portion;
  final Unit? unit;
  final AddProductBloc addProductBloc;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddProductBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Measure', style: TextStyle(color: Theme.of(context).indicatorColor),),
        SizedBox(
            width: 200,
            child:
            TextInputCustom(
              textInputFormatter: FilteringTextInputFormatter.digitsOnly,
              initialValue: portion != null? portion.toString() : '0',
              textInputType: TextInputType.number,
              // hint: S.of(context).addProductScreen_price,
              onChanged: (value) {
                bloc.add(AddProductPortionChanged(int.parse(value)));
              },
            ),
        ),
        const SizedBox(width: 20),
        DropdownButton<Unit>(
          value: unit,
          underline: Container( height: 2, color: Theme.of(context).primaryColor),
          items: <Unit>[Unit.litres, Unit.kilos].map((Unit value) {
            return DropdownMenuItem<Unit>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
          onChanged: (value) {
            addProductBloc.add(AddProductUnitChanged(value!));
          },
        ),
      ],
    );
  }
}

class AddProductCategoryDropdown extends StatelessWidget {
  const AddProductCategoryDropdown(
      {Key? key, required this.category, required this.addProductBloc})
      : super(key: key);
  final Category? category;
  final AddProductBloc addProductBloc;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      value: category,
      underline: Container( height: 2, color: Theme.of(context).primaryColor),
      items: <Category>[Category.cheese, Category.meat, Category.milk]
          .map((Category value) {
        return DropdownMenuItem<Category>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      onChanged: (value) {
        addProductBloc.add(AddProductCategoryChanged(value!));
      },
    );
  }
}

class AddProductImage extends StatefulWidget {
  const AddProductImage(
      {Key? key,
      required this.isImageLoading,
      required this.productImage,
      required this.addProductBloc})
      : super(key: key);

  final bool? isImageLoading;
  final Uint8List? productImage;
  final AddProductBloc addProductBloc;

  @override
  State<AddProductImage> createState() => _AddProductImageState();
}

class _AddProductImageState extends State<AddProductImage> {
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isImageLoading == true) {
      return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50, minWidth: 50),
          child: const CircularProgressIndicator());
    } else {
      if (widget.productImage == null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            IconGradientButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  showOptions = !showOptions;
                });
              },
              size: 40,
              iconData: Icons.add_a_photo,
            ),
            if (showOptions) const SizedBox(width: 30),
            if (showOptions) IconGradientButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                widget.addProductBloc
                    .add(const AddProductImageAddClicked(ImageSource.gallery));
              },
              iconData: Icons.image_search,
              size: 30,
            ),
            if (showOptions) const SizedBox(width: 30),
            if (showOptions) IconGradientButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                widget.addProductBloc
                    .add(const AddProductImageAddClicked(ImageSource.camera));
              },
              iconData: Icons.camera_alt,
              size: 30,
            ),
          ],
        );
      } else {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 50, minWidth: 50),
          child: CircleAvatar(
            backgroundImage: MemoryImage(widget.productImage!),
            radius: 50,
          ),
        );
      }
    }
  }
}
