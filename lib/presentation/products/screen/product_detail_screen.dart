import 'package:ecommerce_admin/presentation/base/controller/menu_controller.dart';
import 'package:ecommerce_admin/presentation/base/widget/table_card_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _formData = FormData();
  late final MenuAppController menuAppController;

  @override
  void initState() {
    super.initState();
    menuAppController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    const pageTitle = 'Product Detail';
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            pageTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TableCardHeader(
                    title: pageTitle,
                  ),
                  _content(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
            child: FormBuilderTextField(
              name: 'item',
              decoration: const InputDecoration(
                labelText: 'Item',
                hintText: 'Item',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              initialValue: _formData.item,
              validator: FormBuilderValidators.required(),
              onSaved: (value) => (_formData.item = value ?? ''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
            child: FormBuilderTextField(
              name: 'price',
              decoration: const InputDecoration(
                labelText: 'Price',
                hintText: 'Price',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              initialValue: _formData.price,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: FormBuilderValidators.required(),
              onSaved: (value) => (_formData.price = value ?? ''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.arrow_circle_left_outlined,
                            size: 24,
                          ),
                        ),
                        Text("Back"),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: true,
                  child: SizedBox(
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.delete_rounded,
                              size: 24,
                            ),
                          ),
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16,),
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                          ),
                        ),
                        Text("Submit"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormData {
  String id = '';
  String item = '';
  String price = '';
}
