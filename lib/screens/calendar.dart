import 'package:financial_management/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../theme/color.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lịch", style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900)),
          backgroundColor: TColors.lightContainer,
          actions: [
            IconButton(
              icon: const Icon(Iconsax.search_normal_1, color: TColors.orange),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen())
                );
              },
            ),
          ],
        ),
        body: const Column(
          children: [
            MonthPicker(),
            CalendarTable(),
            TotalAmount(),
            TransactionDetail()
          ],
        )
    );
  }
}
class MonthPicker extends StatelessWidget {
  const MonthPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child:
        Row(
            children: [
              Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {},
                  )
              ),
              Expanded(
                  flex: 4,
                  child: TextButton(
                      onPressed: () {
                        showMonthPicker(
                          context: context,
                          initialDate: DateTime.now(),
                        ).then((date) {
                          if (date != null) {
                            print(date);
                          }
                        });
                      },
                      child: Container(
                          color: TColors.softYellow,
                          height: 30,
                          child:
                          Center(
                            child: Text("${DateTime.now().month}/${DateTime.now().year}", style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w800)),
                          )
                      )
                  )
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  )
              ),
            ]
        )
    );
  }

}
class CalendarTable extends StatelessWidget {

  const CalendarTable({super.key});
  @override
  Widget build(BuildContext context) {
    int startDayIndex = DateTime(DateTime.now().year, DateTime.now().month).weekday-1;
    int numberOfDays = DateTime(DateTime.now().year, DateTime.now().month+1, 0).day;
    double gridHeight = MediaQuery.of(context).size.width / 7;
    return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['Th 2', 'Th 3', 'Th 4', 'Th 5', 'Th 6', 'Th 7', 'CN']
                .map((label) => Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black
                    ),
                    color: TColors.lightGray,
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                )
            ))
                .toList(),
          ),
          SizedBox(
            height: gridHeight * 0.8 * ((numberOfDays + startDayIndex + 6) ~/ 7),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.25,
                ),
                itemCount: ((numberOfDays+startDayIndex+6)~/7)*7,
                itemBuilder: (context, index) {
                  if (index < startDayIndex || index >= numberOfDays+startDayIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: TColors.lightGray,
                      ),
                    );
                  } else {
                    return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: (index == DateTime.now().day+startDayIndex-1)
                              ? TColors.softYellow : Colors.white,
                        ),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: Text(
                                    "${index - startDayIndex + 1}",
                                    style: const TextStyle(fontSize: 9),
                                    textAlign: TextAlign.left,
                                  )
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: const Text(
                                    "200,000",
                                    style: TextStyle(fontSize: 9, color: TColors.lightBlue),
                                    textAlign: TextAlign.left,
                                  )
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: const Text(
                                    "200,000",
                                    style: TextStyle(fontSize: 9, color: Colors.red),
                                    textAlign: TextAlign.left,
                                  )
                              ),
                            ]
                        )
                    );
                  }
                }
            ),
          ),
        ]
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
                                "600,000đ",
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
                                "600,000đ",
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
class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
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
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                              10, (index) => Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 7, left: 25, right: 25),
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
                          )
                          )
                      )
                  )
              )
            ]
        )
    );
  }

}