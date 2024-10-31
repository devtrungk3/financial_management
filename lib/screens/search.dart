import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/color.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tìm kiếm", style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900)),
          backgroundColor: TColors.lightContainer,
        ),
        body: const Column(
          children: [
            SearchBar(),
            TotalAmount(),
            SearchResult()
          ],
        )
    );
  }
}
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: TColors.softYellow
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Row(
                children: [
                  Icon(Iconsax.search_normal_1, size: 18, color: TColors.darkGrey),
                  Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Tìm kiếm",
                            hintStyle: TextStyle(color: TColors.darkGrey),
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10)
                        ),
                      )
                  )
                ]
            )
        )
    );
  }

}
class TotalAmount extends StatelessWidget {
  const TotalAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: TColors.lightGray,
        child:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          decoration: const BoxDecoration(
                            border: Border(right: BorderSide(
                              width: 2,
                              color: TColors.lightGray,
                            )),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Tiền thu",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "0đ",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800, color: TColors.lightBlue),
                              )
                            ],
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            children: [
                              const Text(
                                "Tiền chi",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "0đ",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800, color: Colors.red),
                              )
                            ],
                          )
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          decoration: const BoxDecoration(
                            border: Border(left: BorderSide(
                              width: 2,
                              color: TColors.lightGray,
                            )),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Tiền tổng",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "0đ",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800, color: Colors.red),
                              )
                            ],
                          )
                      )
                  ),
                ],
              )
          ),
        ));
  }

}
class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
                children: List.generate(4, (index) =>
                    Column(
                        children: [
                          Container(
                            color: TColors.gray,
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "10/10 (Th 5)",
                                      style: Theme.of(context).textTheme.titleSmall
                                  ),
                                  Text(
                                      "-81,000",
                                      style: Theme.of(context).textTheme.titleSmall
                                  )
                                ]
                            ),
                          ),
                          Column(
                              children: List.generate(2, (index) =>
                                  Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                children: [
                                                  const Icon(Iconsax.car, color: TColors.orange, size: 30),
                                                  Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: Text(
                                                          "Đi lại",
                                                          style: Theme.of(context).textTheme.titleLarge
                                                      )
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(left: 6),
                                                      child: Text(
                                                        "Đi lại",
                                                      )
                                                  )
                                                ]
                                            ),
                                            Text(
                                                "20,000đ",
                                                style: Theme.of(context).textTheme.titleSmall
                                            ),
                                          ]
                                      )
                                  ))
                          )
                        ]
                    )
                )
            )
        )
    );
  }

}