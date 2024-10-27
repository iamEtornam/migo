// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/invoice_controller.dart';
import 'package:migo/controller/product_controller.dart';
import 'package:migo/models/product/product.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/billing_page_divider.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:migo/widgets/product_link_opener.dart';
import 'package:migo/widgets/products_tobe_billed_list_tile.dart';

class AddProductsPage extends StatefulWidget {
  final TabController tabController;
  final InvoiceController invoiceController;
  const AddProductsPage({
    super.key,
    required this.tabController,
    required this.invoiceController,
  });

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    productController.fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BillingPageDivider(),
        SizedBox(
          width: !Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width - 110
              : null,
          height: !Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height - 150
              : MediaQuery.of(context).size.height - 220,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: Responsive.isTablet(context) ? 3 : 5,
                child: Obx(() {
                  if (productController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return _ProductsGrid(
                        productController: productController,
                        invoiceController: widget.invoiceController);
                  }
                }),
              ),
              if (!Responsive.isMobile(context))
                Expanded(
                  flex: 2,
                  child: ProductsToBeBilledList(
                    tabController: widget.tabController,
                    invoiceController: widget.invoiceController,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}

class ProductsToBeBilledList extends StatelessWidget {
  final TabController tabController;
  final InvoiceController invoiceController;
  const ProductsToBeBilledList({
    super.key,
    required this.tabController,
    required this.invoiceController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Products to be billed",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                TextButton(
                    onPressed: () {
                      invoiceController.clearInvoice();
                    },
                    child: const Text("clear all"))
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: invoiceController.productList.length,
                  itemBuilder: (_, i) => ProductToBeBilledListTile(
                    product: invoiceController.productList[i],
                    index: i,
                    invoiceController: invoiceController,
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total"),
                    Obx(
                      () => Text(
                        "₹" + invoiceController.totalAmt.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                PrimaryButton(
                  onPressed: () {
                    tabController
                        .animateTo(Responsive.isMobile(context) ? 2 : 1);
                  },
                  buttonTitle: "Continue",
                  horzPad: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatefulWidget {
  final ProductController productController;
  final InvoiceController invoiceController;
  const _ProductsGrid(
      {required this.productController,
      required this.invoiceController});

  @override
  State<_ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<_ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    String? chosenDropdownOption;
    var filterDropdown = DropdownButton(
      hint: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text("Select Filter"),
      ),
      elevation: 8,
      value: chosenDropdownOption,
      icon: const Icon(Iconsax.arrow_circle_down),
      borderRadius: BorderRadius.circular(8),
      items: const [
        DropdownMenuItem(
          value: "All",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "All products",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Audio",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Audio",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Laptops",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Laptops",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Fitness bands",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Fitness bands",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "TV",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "TV",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Phones",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Phones",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
      onChanged: (value) {
        setState(
          () {
            chosenDropdownOption = value;
            // print(value);
          },
        );
      },
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchAndFilterRow(
            filterDropdown: filterDropdown,
            productController: widget.productController,
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: widget.productController.productList.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context)
                  ? 3
                  : Responsive.isMobile(context)
                      ? 1
                      : 2,
              childAspectRatio: 4 / 5,
            ),
            itemBuilder: (_, index) => _ProductCard(
                widget.productController.productList[index],
                widget.invoiceController),
          ),
        ],
      ),
    );
  }
}

class SearchAndFilterRow extends StatelessWidget {
  final ProductController productController;
  const SearchAndFilterRow({
    super.key,
    required this.productController,
    required this.filterDropdown,
  });

  final DropdownButton<String> filterDropdown;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: Responsive.isDesktop(context),
                child: Text(
                  "All Products in store (${productController.productList.length})",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    prefixIcon: Icon(Iconsax.search_normal),
                    hintText: 'Search...',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              )
            ],
          ),
          DropdownButtonHideUnderline(
            child: filterDropdown,
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final InvoiceController invoiceController;
  const _ProductCard(this.product, this.invoiceController);

  @override
  Widget build(BuildContext context) {
    // width: Responsive.isDesktop(context)
    //     ? (MediaQuery.of(context).size.width - 500) / 3
    //     : Responsive.isTablet(context)
    //         ? (MediaQuery.of(context).size.width - 500)
    //         : MediaQuery.of(context).size.width - 8,
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FadeInImage(
                      image: NetworkImage(product.image.toString()),
                      placeholder:
                          const AssetImage("assets/placeholder_product.png"),
                      fit: BoxFit.fitWidth,
                      placeholderFit: BoxFit.fitWidth,
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
                Text(
                  product.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18),
                ),
                Row(
                  children: [
                    const Text(
                      "Price: ",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      "₹" +
                          product.sellingPrice.toString().substring(
                              0, product.sellingPrice.toString().length - 3),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (true)
                      Expanded(
                        child: PrimaryButton(
                          buttonTitle: "Add to bill",
                          onPressed: () {
                            invoiceController.productList.add(
                              Product(
                                id: product.id,
                                name: product.name,
                                description: product.description,
                                category: product.category,
                                price: product.price,
                                sellingPrice: product.sellingPrice,
                                stockAmount: product.stockAmount,
                              ),
                            );
                            var sellpr = product.sellingPrice.toString();
                            invoiceController.addToTotal(
                              int.parse(sellpr.substring(0, sellpr.length - 3)),
                            );
                          },
                          iconLeft: const Icon(Iconsax.add_circle),
                          bgColor: const Color(0xffDAEEB8),
                          textColor: const Color(0xff1F212E),
                          iconBgColor: const Color(0xffBEE29B),
                        ),
                      ),
                    // if (false)
                    //   Expanded(
                    //     child: Row(
                    //       children: [
                    //         Expanded(
                    //           child: PrimaryButton(
                    //             buttonTitle: "Add one",
                    //             onPressed: () {},
                    //             iconLeft: const Icon(Iconsax.add_circle),
                    //             bgColor: const Color(0xffDAEEB8),
                    //             textColor: const Color(0xff1F212E),
                    //             iconBgColor: const Color(0xffBEE29B),
                    //           ),
                    //         ),
                    //         PrimaryButton(
                    //           onPressed: () {},
                    //           iconLeft: const Icon(Iconsax.trash),
                    //           bgColor: const Color(0xffFFBBC1),
                    //           textColor: const Color(0xff1F212E),
                    //           iconBgColor: const Color(0xffF29DA3),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ProductDescriptionLinkOpener(url: product.url.toString()),
      ],
    );
  }
}
