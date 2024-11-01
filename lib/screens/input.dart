import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool isChiTieuSelected = true;
  DateTime selectedDate = DateTime.now(); // Initialize with the current date
  List<String> imagePaths = [
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
    "assets/icons/user.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isChiTieuSelected = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isChiTieuSelected
                                ? Colors.orange
                                : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 6.0),
                            minimumSize: Size.zero,
                            tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                          ).copyWith(
                            side: MaterialStateProperty.all(
                                BorderSide.none),
                          ),
                          child: Text(
                            'Chi tiêu',
                            style: TextStyle(
                              color: isChiTieuSelected
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isChiTieuSelected = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isChiTieuSelected
                                ? Colors.grey[300]
                                : Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 6.0),
                            minimumSize: Size.zero,
                            tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                          ).copyWith(
                            side: MaterialStateProperty.all(
                                BorderSide.none),
                          ),
                          child: Text(
                            'Thu nhập',
                            style: TextStyle(
                              color: isChiTieuSelected
                                  ? Colors.grey
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      // Action for edit icon
                    },
                  ),
                ],
              ),

              // Content that changes based on isChiTieuSelected
              isChiTieuSelected
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min, // Change here
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Ngày",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      const Spacer(), // Add some spacing
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          // Action for previous date
                          setState(() {
                            selectedDate = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day - 1);
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Show date picker when the container is tapped
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (newDate != null &&
                              newDate != selectedDate) {
                            setState(() {
                              selectedDate =
                                  newDate; // Update the selected date
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.yellow[100],
                            borderRadius:
                            BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year} (${getDayOfWeek(selectedDate)})",
                            // Format the date
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          // Action for next date
                          setState(() {
                            selectedDate = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day + 1);
                          });
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Text(
                        "Ghi chú",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Spacer(),
                      Container(
                        width:
                        MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Nhập ghi chú...",
                            hintStyle:
                            TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Text(
                        "Số tiền",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Spacer(),
                      Container(
                        width:
                        MediaQuery.of(context).size.width * 0.7,
                        padding:
                        EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        "đ",
                        style:
                        TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Danh mục",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 310,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.75,
                          ),
                          itemCount: imagePaths.length + 1, // Add one for the button
                          itemBuilder: (context, index) {
                            if (index == imagePaths.length) {
                              // Last item, render button
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {
                                      // Add your button functionality here
                                    },
                                    child: const Text(
                                      'Chỉnh sửa',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              // Render image
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      imagePaths[index],
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Action for button
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                            ),
                            child: const Text(
                              "Nhập tiền chi",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min, // Change here
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Ngày",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      const Spacer(), // Add some spacing
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          // Action for previous date
                          setState(() {
                            selectedDate = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day - 1);
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Show date picker when the container is tapped
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (newDate != null &&
                              newDate != selectedDate) {
                            setState(() {
                              selectedDate =
                                  newDate; // Update the selected date
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.yellow[100],
                            borderRadius:
                            BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year} (${getDayOfWeek(selectedDate)})",
                            // Format the date
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          // Action for next date
                          setState(() {
                            selectedDate = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day + 1);
                          });
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Text(
                        "Ghi chú",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Spacer(),
                      Container(
                        width:
                        MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Nhập ghi chú...",
                            hintStyle:
                            TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Text(
                        "Số tiền",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Spacer(),
                      Container(
                        width:
                        MediaQuery.of(context).size.width * 0.7,
                        padding:
                        EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        "đ",
                        style:
                        TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Danh mục",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 310,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.75,
                          ),
                          itemCount: imagePaths.length + 1, // Add one for the button
                          itemBuilder: (context, index) {
                            if (index == imagePaths.length) {
                              // Last item, render button
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {
                                      // Add your button functionality here
                                    },
                                    child: const Text(
                                      'Chỉnh sửa',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              // Render image
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      imagePaths[index],
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Action for button
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                            ),
                            child: const Text(
                              "Nhập tiền thu",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get the day of the week
  String getDayOfWeek(DateTime date) {
    List<String> days = [
      'Chủ nhật',
      'Thứ hai',
      'Thứ ba',
      'Thứ tư',
      'Thứ năm',
      'Thứ sáu',
      'Thứ bảy'
    ];
    return days[date.weekday % 7];
  }
}