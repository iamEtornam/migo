// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/billing_page_divider.dart';
import 'package:migo/widgets/buttons.dart';
import 'package:migo/widgets/product_link_opener.dart';

class AddProductsPage extends StatelessWidget {
  final TabController tabController;
  const AddProductsPage({Key? key, required this.tabController})
      : super(key: key);

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
                child: const _ProductsGrid(),
              ),
              if (!Responsive.isMobile(context))
                Expanded(
                  flex: 2,
                  child: ProductsToBeBilledList(tabController: tabController),
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
  const ProductsToBeBilledList({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Products to be billed",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (_, i) => const ProductToBeBilledListTile(),
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
                  children: const [
                    Text("Total"),
                    Text(
                      "₹9,999",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                PrimaryButton(
                  onPressed: () {
                    tabController.animateTo(1);
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

class ProductToBeBilledListTile extends StatelessWidget {
  const ProductToBeBilledListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Mi Watch Revolve Active",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "(₹9,999)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(
                        label: Text("Quanitity"),
                        fillColor: Color(0xff0C0D16),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Price"),
                      Text(
                        "₹9,999",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                "assets/mi_watch_img.png",
                scale: 2.5,
              ),
              PrimaryButton(
                onPressed: () {},
                // buttonTitle: "Remove product",
                bgColor: const Color(0xffFFBBC1),
                iconLeft: const Icon(Iconsax.trash),
                iconBgColor: const Color(0xffF29DA3),
                textColor: const Color(0xff1F212E),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductsGrid extends StatefulWidget {
  const _ProductsGrid({
    Key? key,
  }) : super(key: key);

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
          value: "Watches",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Watches",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Earphones",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Earphones",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DropdownMenuItem(
          value: "Mobiles",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Mobiles",
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
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: Responsive.isDesktop(context),
                      child: const Text(
                        "All Products in store (28)",
                        style: TextStyle(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
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
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
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
                price: index,
                name: " Mi ka phone",
                url: "https://hayat.design",
                quantitySelected: 0),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final int price;
  final String name;
  final String url;
  final int quantitySelected;
  const _ProductCard({
    Key? key,
    required this.price,
    required this.name,
    required this.url,
    required this.quantitySelected,
  }) : super(key: key);

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
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
                    Image.asset(
                      "assets/mi_watch_img.png",
                      scale: 1.5,
                    ),
                  ],
                ),
                Text(
                  widget.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),
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
                      "₹" + widget.price.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (widget.quantitySelected == 0)
                      Expanded(
                        child: PrimaryButton(
                          buttonTitle: "Add to bill",
                          onPressed: () {},
                          iconLeft: const Icon(Iconsax.add_circle),
                          bgColor: const Color(0xffDAEEB8),
                          textColor: const Color(0xff1F212E),
                          iconBgColor: const Color(0xffBEE29B),
                        ),
                      ),
                    if (widget.quantitySelected != 0)
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                buttonTitle: "Add one",
                                onPressed: () {},
                                iconLeft: const Icon(Iconsax.add_circle),
                                bgColor: const Color(0xffDAEEB8),
                                textColor: const Color(0xff1F212E),
                                iconBgColor: const Color(0xffBEE29B),
                              ),
                            ),
                            PrimaryButton(
                              onPressed: () {},
                              iconLeft: const Icon(Iconsax.trash),
                              bgColor: const Color(0xffFFBBC1),
                              textColor: const Color(0xff1F212E),
                              iconBgColor: const Color(0xffF29DA3),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ProductDescriptionLinkOpener(url: widget.url),
      ],
    );
  }
}
