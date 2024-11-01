import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _subTabController;
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 2, vsync: this);
    _subTabController = TabController(length: 2, vsync: this);
    _updateDateDisplay();
    _mainTabController.addListener(() {
      setState(() {
        _updateDateDisplay();
      });
    });
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _subTabController.dispose();
    super.dispose();
  }

  void _updateDateDisplay() {
    if (_mainTabController.index == 0) {
      _dateController.text = DateFormat('MM/yyyy').format(_selectedDate);
    } else {
      _dateController.text = DateFormat('yyyy').format(_selectedDate);
    }
  }

  void _changeMonth(int months) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + months);
      _updateDateDisplay();
    });
  }

  void _changeYear(int years) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year + years, _selectedDate.month);
      _updateDateDisplay();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    if (_mainTabController.index == 0) {
      // Monthly
      await _selectMonth(context);
    } else {
      // Yearly
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialDatePickerMode: DatePickerMode.year,
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
          _updateDateDisplay();
        });
      }
    }
  }

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(picked.year, picked.month);
        _updateDateDisplay();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _mainTabController,
        children: [
          _buildReportView(
            expense: "-50,000đ",
            income: "+30,000đ",
            netResult: "-20,000đ",
          ),
          _buildReportView(
            expense: "-600,000đ",
            income: "+400,000đ",
            netResult: "-200,000đ",
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: _buildMainTabBar(),
      actions: [
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.search, color: Colors.orange),
        )
      ],
    );
  }

  TabBar _buildMainTabBar() {
    return TabBar(
      controller: _mainTabController,
      labelColor: Colors.orange,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.orange,
      tabs: const [
        Tab(text: 'Monthly'),
        Tab(text: 'Yearly'),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_left, color: Colors.orange),
            onPressed: () {
              if (_mainTabController.index == 0) {
                _changeMonth(-1);
              } else {
                _changeYear(-1);
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: _dateController,
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onTap: () => _selectDate(context),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_right, color: Colors.orange),
            onPressed: () {
              if (_mainTabController.index == 0) {
                _changeMonth(1);
              } else {
                _changeYear(1);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportView({
    required String expense,
    required String income,
    required String netResult,
  }) {
    return Column(
      children: [
        _buildDateSelector(),
        _buildSummarySection(expense: expense, income: income, netResult: netResult),
        _buildSubTabBar(),
        Expanded(
          child: TabBarView(
            controller: _subTabController,
            children: [
              Column(
                children: [
                  _buildPieChart(expenseSections: true),
                  _buildDetailedSection(expenseSections: true),
                ],
              ),
              Column(
                children: [
                  _buildPieChart(expenseSections: false),
                  _buildDetailedSection(expenseSections: false),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  TabBar _buildSubTabBar() {
    return TabBar(
      controller: _subTabController,
      labelColor: Colors.orange,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.orange,
      tabs: const [
        Tab(text: 'Expense'),
        Tab(text: 'Income'),
      ],
    );
  }

  Widget _buildSummarySection({
    required String expense,
    required String income,
    required String netResult,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryColumn('Expense', expense, Colors.red),
              _buildSummaryColumn('Income', income, Colors.blue),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: _buildSummaryColumn('Net Result', netResult, Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryColumn(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: color, fontSize: 16)),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 24)),
      ],
    );
  }

  Widget _buildPieChart({required bool expenseSections}) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sections: expenseSections
              ? [
            PieChartSectionData(color: Colors.red, value: 60, title: 'Ăn uống', radius: 50, titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            PieChartSectionData(color: Colors.blue, value: 30, title: 'Di chuyển', radius: 50, titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            PieChartSectionData(color: Colors.orange, value: 10, title: 'Khác', radius: 50, titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          ]
              : [
            PieChartSectionData(color: Colors.green, value: 70, title: 'Lương', radius: 50, titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            PieChartSectionData(color: Colors.purple, value: 20, title: 'Đầu tư', radius: 50, titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            PieChartSectionData(color: Colors.blue, value: 10, title: 'Khác', radius: 50, titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedSection({required bool expenseSections}) {
    final details = expenseSections
        ? [
      {'icon': Icons.fastfood, 'title': 'Ăn uống', 'amount': '-20,000đ', 'percentage': '20%'},
      {'icon': Icons.directions_car, 'title': 'Di chuyển', 'amount': '-500,000đ', 'percentage': '70%'},
    ]
        : [
      {'icon': Icons.monetization_on, 'title': 'Lương', 'amount': '+30,000đ', 'percentage': '60%'},
      {'icon': Icons.trending_up, 'title': 'Đầu tư', 'amount': '+20,000đ', 'percentage': '40%'},
    ];

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: details.length,
        itemBuilder: (context, index) {
          final detail = details[index];
          return ListTile(
            leading: Icon(detail['icon'] as IconData, color: Colors.orange),
            title: Text(detail['title'] as String),
            subtitle: Text(detail['amount'] as String),
            trailing: Text(detail['percentage'] as String),
          );
        },
      ),
    );
  }
}