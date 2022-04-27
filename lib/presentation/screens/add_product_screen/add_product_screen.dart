import 'dart:typed_data';

import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:farmer_market/presentation/navigation/navigation_wrapper.dart';
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
import '../../shared/image_add_image_row.dart';
import '../../shared/show_confirmation_dialogue.dart';
import '../../shared/text_input_custom.dart';
import '../main_screen/main_screen_pages/user_products_page/bloc/user_products_bloc.dart';
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
          if (state.saveClickedWhenInputIsNotValid == true) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please fill all the fields correctly"),
              duration: Duration(seconds: 2),
            ));
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
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor, //change your color here
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          S.of(context).addProductScreen_addProduct,
          style: TextStyle(color: Theme.of(context).indicatorColor),
        ),
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: Column(children: [
            AddProductTextInputs(
              addProductBloc: _addProductBloc,
              product: args?.product,
              nameIsValid: state.nameIsValid,
              descriptionIsValid: state.descriptionIsValid,
              priceIsValid: state.priceIsValid,
            ),
            AddProductMeasureInput(
              addProductBloc: _addProductBloc,
              measureIsValid: state.measureIsValid,
              product: args?.product,
              unit: state.product?.unit,
            ),
            AddProductCategoryDropdown(
                category: state.product?.category,
                addProductBloc: _addProductBloc),
            const SizedBox(height: 30),
            AddProductImage(
              isImageLoading: state.isImageLoading,
              productImage: state.productImage,
              addProductBloc: _addProductBloc,
            ),
            const SizedBox(height: 30),
            AddProductBottomButtons(
              isLoading: state.isLoading,
              addProductBloc: _addProductBloc,
              productId: state.product?.id,
            )
          ])),
    );
  }
}

class AddProductTextInputs extends StatefulWidget {
  const AddProductTextInputs(
      {Key? key,
      required this.product,
      required this.addProductBloc,
      required this.nameIsValid,
      required this.descriptionIsValid,
      required this.priceIsValid})
      : super(key: key);

  final Product? product;
  final AddProductBloc addProductBloc;
  final bool? nameIsValid;
  final bool? descriptionIsValid;
  final bool? priceIsValid;

  @override
  State<AddProductTextInputs> createState() => _AddProductTextInputsState();
}

class _AddProductTextInputsState extends State<AddProductTextInputs> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController()..text = widget.product?.name ?? '';
    nameController.addListener(() {
      widget.addProductBloc.add(AddProductNameChanged(nameController.text));
    });
    descriptionController = TextEditingController()
      ..text = widget.product?.description ?? '';
    descriptionController.addListener(() {
      widget.addProductBloc
          .add(AddProductDescriptionChanged(descriptionController.text));
    });
    priceController = TextEditingController()
      ..text =
          widget.product?.price != null ? widget.product!.price.toString() : '';
    priceController.addListener(() {
      widget.addProductBloc.add(AddProductPriceChanged(priceController.text));
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameErrorText = widget.nameIsValid == false
        ? 'Please enter valid name, current is either too long of empty'
        : null;
    final descriptionErrorText = widget.descriptionIsValid == false
        ? 'Please enter valid description, current may be too long'
        : null;
    final priceErrorText =
        widget.priceIsValid == false ? 'Please enter valid price' : null;

    return Column(
      children: [
        TextInputCustom(
          controller: nameController,
          icon: Icons.person,
          hint: S.of(context).addProductScreen_product,
          errorText: nameErrorText,
        ),
        TextInputCustom(
          controller: descriptionController,
          lines: null,
          icon: Icons.text_snippet,
          hint: S.of(context).addProductScreen_description,
          errorText: descriptionErrorText,
        ),
        TextInputCustom(
          controller: priceController,
          icon: Icons.monetization_on,
          textInputFormatter: FilteringTextInputFormatter.digitsOnly,
          textInputType: TextInputType.number,
          hint: S.of(context).addProductScreen_price,
          errorText: priceErrorText,
        ),
      ],
    );
  }
}

class AddProductMeasureInput extends StatefulWidget {
  const AddProductMeasureInput(
      {Key? key,
      required this.measureIsValid,
      this.product,
      this.unit,
      required this.addProductBloc})
      : super(key: key);
  final Product? product;
  final bool? measureIsValid;
  final Unit? unit;
  final AddProductBloc addProductBloc;

  @override
  State<AddProductMeasureInput> createState() => _AddProductMeasureInputState();
}

class _AddProductMeasureInputState extends State<AddProductMeasureInput> {
  late final TextEditingController portionController;

  @override
  void initState() {
    super.initState();
    portionController = TextEditingController()
      ..text = widget.product?.portion != null
          ? widget.product!.portion.toString()
          : '';
    portionController.addListener(() {
      widget.addProductBloc
          .add(AddProductPortionChanged(portionController.text));
    });
  }

  @override
  void dispose() {
    portionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddProductBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Measure',
          style: TextStyle(color: Theme.of(context).indicatorColor),
        ),
        SizedBox(
          width: 200,
          child: TextInputCustom(
            controller: portionController,
            textInputFormatter: FilteringTextInputFormatter.digitsOnly,
            textInputType: TextInputType.number,
            errorText: widget.measureIsValid == false ? 'Incorrect' : null,
          ),
        ),
        const SizedBox(width: 20),
        DropdownButton<Unit>(
          value: widget.product?.unit ?? widget.unit,
          underline:
              Container(height: 2, color: Theme.of(context).primaryColor),
          items: <Unit>[Unit.litres, Unit.kilos].map((Unit value) {
            return DropdownMenuItem<Unit>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
          onChanged: (value) {
            bloc.add(AddProductUnitChanged(value!));
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
      underline: Container(height: 2, color: Theme.of(context).primaryColor),
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
    return ImageAddImageRow(
      isImageLoading: widget.isImageLoading,
      image: widget.productImage,
      addImageFromGallery: () => widget.addProductBloc
          .add(const AddProductImageAddClicked(ImageSource.gallery)),
      addImageFromCamera: () => widget.addProductBloc
          .add(const AddProductImageAddClicked(ImageSource.camera)),
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
            iconSize: 35,
          )
        ])
      ],
    );
  }
}
