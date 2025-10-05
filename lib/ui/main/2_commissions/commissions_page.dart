import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quali_prevention_app/common/helper.dart';
import 'package:quali_prevention_app/common/model/client_model.dart';
import 'package:quali_prevention_app/common/model/user_network.dart';
import 'package:quali_prevention_app/common/style.dart';
import 'package:quali_prevention_app/global_widgets/custom_app_bar.dart';
import 'package:quali_prevention_app/services/user_service.dart';

class CommissionsPage extends StatefulWidget {
  const CommissionsPage({super.key});

  @override
  State<CommissionsPage> createState() => _CommissionsPageState();
}

class _CommissionsPageState extends State<CommissionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String? selectedValue;
  late List<String>? items;

  final UserService userService = UserService();
  String? currentMonthCa;
  String? currentMonthCommission;
  List<Map<String, int>>? allCommissions = [];
  List<Client>? allClients = [];
  Map<String, int>? clientAmountByYear;
  List<UserNetwork>? userNetwork = [];

  Map<String, int>? currentMonthClients;
  bool isLoading = true;

  Future<void> _loadUserNetwork() async {
    userNetwork = await userService.getUserNetwork();
    setState(() {});
  }

  Future<void> _loadUserProfile() async {
    currentMonthCa = await userService.getUserCA(
      params: '?month=current',
    );
    currentMonthCommission = await userService.getCurrentMonthUserCommissions();
    currentMonthClients = await userService.getUserClientsByStatus(
      params: '?month=current',
    );
    allCommissions = await userService.getAllUserCommissions();
    allClients = await userService.getAllUserClients();
    clientAmountByYear = await userService.getClientAmountByYear(year: 2024);
    await _loadUserNetwork();
    setState(() {});
  }

  Future<void> updateClientAmountByYear(String year) async {
    clientAmountByYear =
        await userService.getClientAmountByYear(year: int.parse(year));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    selectedValue = '2024';
    items = [
      '2024',
      '2023',
      '2022',
      '2021',
      '2020',
      '2019',
      '2018',
      '2017',
      '2016',
      '2015',
      '2014',
      '2013',
      '2012',
      '2011',
      '2010',
    ];
    _loadUserProfile();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Commissions'),
      backgroundColor: white,
      body: Column(
        children: [
          Container(
            color: white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: primary,
              labelColor: primary,
              unselectedLabelColor: textBlack,
              labelStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              tabs: const [
                Tab(text: 'Statistiques'),
                Tab(text: 'Historique'),
                Tab(text: 'Suivi'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Statistiques Tab Content
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Example content for Statistiques
                      Container(
                        padding: const EdgeInsets.all(20),
                        color: white,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFF99B0C),
                                Color(0xFFFCB514),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(18),
                          height: 100,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/turnover.svg',
                                width: 50,
                              ),
                              const SizedBox(width: 20),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'CA du mois',
                                      style: GoogleFonts.poppins(
                                        color: white,
                                        height: 1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      currentMonthCa ?? '0€',
                                      style: GoogleFonts.poppins(
                                        color: white,
                                        height: 1,
                                        fontSize: 34,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 25,
                          bottom: 25,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: textPrimary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(18),
                              height: 100,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/percent.svg',
                                    width: 50,
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Commissions du mois',
                                          style: GoogleFonts.poppins(
                                            color: white,
                                            height: 1,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          currentMonthCommission ?? '0€',
                                          style: GoogleFonts.poppins(
                                            color: white,
                                            height: 1,
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              'Filleuls sur le mois en cours',
                              style: GoogleFonts.poppins(
                                color: textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: 300,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: BarChart(randomData()),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      /*Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 10,
                              children: [
                                Text(
                                  'Année',
                                  style: GoogleFonts.poppins(
                                    color: textPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      selectedValue ?? 'Choisir',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: items!
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      item == selectedValue
                                                          ? FontWeight.w800
                                                          : FontWeight.w400,
                                                  color: primary,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                      updateClientAmountByYear(value!);
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 100,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: primaryBackground,
                                      ),
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: primary,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: primaryBackground,
                                      ),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: WidgetStateProperty.all(6),
                                        thumbVisibility:
                                            WidgetStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              width: 600,
                              height: 430,
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 50,
                                right: 25,
                              ),
                              child: LineChart(
                                LineChartData(
                                  lineTouchData: const LineTouchData(
                                    touchTooltipData: LineTouchTooltipData(),
                                    handleBuiltInTouches: false,
                                  ),
                                  minX: 0,
                                  maxX: 11,
                                  minY: 0,
                                  maxY: maxYValue,
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 100,
                                        reservedSize: 40,
                                        getTitlesWidget: (value, meta) {
                                          return Text(
                                            value.toInt().toString(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        },
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                        getTitlesWidget: (value, meta) {
                                          const style = TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            height: 2,
                                          );
                                          Widget text;
                                          switch (value.toInt()) {
                                            case 0:
                                              text = const Text('Jan',
                                                  style: style);
                                              break;
                                            case 1:
                                              text = const Text('Fév',
                                                  style: style);
                                              break;
                                            case 2:
                                              text = const Text('Mar',
                                                  style: style);
                                              break;
                                            case 3:
                                              text = const Text('Avr',
                                                  style: style);
                                              break;
                                            case 4:
                                              text = const Text('Mai',
                                                  style: style);
                                              break;
                                            case 5:
                                              text = const Text('Juin',
                                                  style: style);
                                              break;
                                            case 6:
                                              text = const Text('Juil',
                                                  style: style);
                                              break;
                                            case 7:
                                              text = const Text('Aout',
                                                  style: style);
                                              break;
                                            case 8:
                                              text = const Text('Sept',
                                                  style: style);
                                              break;
                                            case 9:
                                              text = const Text('Oct',
                                                  style: style);
                                              break;
                                            case 10:
                                              text = const Text('Nov',
                                                  style: style);
                                              break;
                                            case 11:
                                              text = const Text('Déc',
                                                  style: style);
                                              break;
                                            default:
                                              text =
                                                  const Text('', style: style);
                                              break;
                                          }
                                          return SideTitleWidget(
                                            meta: meta,
                                            space: 10,
                                            child: text,
                                          );
                                        },
                                      ),
                                    ),
                                    topTitles: const AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    rightTitles: const AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                  ),
                                  gridData: FlGridData(
                                    show: true,
                                    horizontalInterval: 100,
                                    drawVerticalLine: false,
                                    getDrawingHorizontalLine: (value) {
                                      return FlLine(
                                        color: Colors.grey.withOpacity(0.3),
                                        strokeWidth: 1,
                                      );
                                    },
                                    getDrawingVerticalLine: (value) {
                                      return FlLine(
                                        color: Colors.grey.withOpacity(0.3),
                                        strokeWidth: 1,
                                      );
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border(
                                      top: BorderSide(
                                        color: const Color(0xff979797)
                                            .withOpacity(0.2),
                                        width: 1,
                                      ),
                                      bottom: BorderSide(
                                        color: const Color(0xff979797)
                                            .withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      preventCurveOverShooting: true,
                                      spots: spotsData,
                                      isCurved: true,
                                      barWidth: 3,
                                      isStrokeCapRound: true,
                                      color: const Color(0xffFBAF12),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color(0xFFFBAF12)
                                                .withOpacity(0.3),
                                            white.withOpacity(0.3),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      dotData: const FlDotData(
                                        show: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),*/
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
                // Historique Tab Content
                Container(
                  color: primaryBackground,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 150,
                    ),
                    itemCount: allCommissions!.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final commission = allCommissions![index];
                      final date = commission.keys.first;
                      final amount = commission.values.first;

                      return Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff004357).withOpacity(0.10),
                              spreadRadius: 0,
                              blurRadius: 30,
                              offset: const Offset(
                                0,
                                5,
                              ),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDate(date),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: textBlack,
                              ),
                            ),
                            Text(
                              formatCurrency(amount.toDouble()),
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Suivi Tab Content
                Container(
                  color: primaryBackground,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 150,
                    ),
                    itemCount: allClients!.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      Client client = allClients![index];
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff004357).withOpacity(0.10),
                              spreadRadius: 0,
                              blurRadius: 30,
                              offset: const Offset(
                                0,
                                5,
                              ),
                            ),
                          ],
                        ),
                        child: FilledButton(
                          onPressed: () async => await Navigator.pushNamed(
                            context,
                            '/commission_detail',
                            arguments: {'clientId': client.id},
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                            minimumSize: const Size(100, 30),
                            maximumSize: const Size(100, 100),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center,
                            backgroundColor: white,
                            overlayColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                spacing: 20,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://crm.quali-prevention.fr${client.picture}'),
                                    backgroundColor: grey,
                                    radius: 25,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 200),
                                        child: Text(
                                          '${client.firstName} ${client.lastName}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: textPrimary,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        client.statutName,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: textBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios, color: textPrimary),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                /* Réseau Tab Content
                Container(
                  color: primaryBackground,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Text
                      Text(
                        'Commissions du mois pour chaque membre de votre réseau',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                          height: 20), // Spacer between title and list
                      // Network List
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(bottom: 150),
                          itemCount: userNetwork!.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            final user = userNetwork![index];
                            final DateTime now = DateTime.now();
                            final String currentMonthYear =
                                '${now.month.toString().padLeft(2, '0')}/${now.year.toString().substring(2)}';

                            // Get the current month's commission or default to 0
                            final double currentMonthCommission = user
                                    .monthlyCommission[currentMonthYear]
                                    ?.toDouble() ??
                                0.0;

                            // Format the commission for display
                            final String formattedCommission =
                                formatCurrency(currentMonthCommission);

                            return Container(
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff004357)
                                        .withOpacity(0.10),
                                    spreadRadius: 0,
                                    blurRadius: 30,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: FractionallySizedBox(
                                      widthFactor:
                                          0.7, // Max width of 70% of container
                                      child: Text(
                                        user.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: textBlack,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    formattedCommission,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: LinearGradient(
            colors: [const Color(0xffF99B0C), secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          borderDashArray: x >= 4 ? [4, 4] : null,
          width: 50,
        ),
      ],
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff727576),
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    List<String> days = [
      'Prospect',
      'Abandon',
      'Signé',
      'En formation',
      'Sortie'
    ];

    Widget text = Text(
      days[value.toInt()],
      style: style,
    );

    return SideTitleWidget(
      meta: meta,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    // Calculate the maximum value from the data
    double maxValue = 0;
    if (currentMonthClients != null) {
      maxValue = currentMonthClients!.values
          .map((value) => value.toDouble())
          .reduce((a, b) => a > b ? a : b); // Find the max value
    }

    // Round up to the nearest multiple of 5
    double maxYValue = (maxValue + 4) ~/ 5 * 5;

    return BarChartData(
      maxY: maxYValue + 5,
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 30,
            showTitles: true,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        // only the top border
        border: Border(
          top: BorderSide(
            color: const Color(0xff979797).withOpacity(0.2),
            width: 1,
          ),
          bottom: BorderSide(
            color: const Color(0xff979797).withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      barGroups: currentMonthClients == null ? [] : clientsData(),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: 2,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) => FlLine(
          color: const Color(0xff979797).withOpacity(0.2),
          strokeWidth: 1,
        ),
      ),
    );
  }

  List<BarChartGroupData> clientsData() {
    return [
      if (currentMonthClients!['Prospect'] != null)
        makeGroupData(0, currentMonthClients!['Prospect']!.toDouble()),
      if (currentMonthClients!['Abandon'] != null)
        makeGroupData(1, currentMonthClients!['Abandon']!.toDouble()),
      if (currentMonthClients!['Signé'] != null)
        makeGroupData(2, currentMonthClients!['Signé']!.toDouble()),
      if (currentMonthClients!['En formation'] != null)
        makeGroupData(3, currentMonthClients!['En formation']!.toDouble()),
      if (currentMonthClients!['Sortie'] != null)
        makeGroupData(4, currentMonthClients!['Sortie']!.toDouble()),
    ];
  }

  List<FlSpot> get spotsData {
    List<FlSpot> spots = [];
    if (clientAmountByYear == null) return [];
    clientAmountByYear!.forEach((key, value) {
      spots.add(FlSpot(double.parse(key) - 1, value.toDouble()));
    });

    return spots;
  }

  double get maxYValue {
    if (clientAmountByYear == null) return 0;

    double maxValue = clientAmountByYear!.values
        .map((value) => value.toDouble())
        .reduce((a, b) => a > b ? a : b);
    maxValue = (maxValue + 4) ~/ 5 * 5;

    return maxValue;
  }
}
