import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:flutter_svg/flutter_svg.dart";

String getDateRange() {
  DateTime now = DateTime.now();

  // to get the end date of last month,
  // subtract one day from date of next month
  DateTime end = DateTime(now.year, now.month + 1, 0);

  String month = DateFormat('MMM').format(now);
  String endDay = end.day.toString();
  String year = now.year.toString();

  return "Net $month 1 - $month $endDay, $year";
}

String calculateNet(int income, int expense) {
  int net;
  if (income < expense) {
    net = expense - income;
  } else {
    net = income - expense;
  }
  return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(net.abs());
}

class NetCard extends StatefulWidget {
  const NetCard({Key? key}): super(key: key);

  @override
  State<NetCard> createState() => _NetCardState();
}

class _NetCardState extends State<NetCard> {
  int income = 1950;
  int expense = 450;
  static const timestamp = "Nice";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.71, -0.71),
          end: Alignment(-0.71, 0.71),
          colors: [Color(0xFFB2D3C2), Color(0xFFEBEBEB)],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              getDateRange(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (income > expense)
                  SvgPicture.asset(
                    'assets/svg/eva_arrow-up-fill.svg',
                    height: 30,
                    width: 30,
                  ),
                if (income == expense)
                  const Icon(
                    Icons.remove,
                    color: Colors.black12,
                    size: 34,
                  ),
                if (income < expense)
                  SvgPicture.asset(
                    'assets/svg/eva_arrow-down-fill.svg',
                    height: 30,
                    width: 30,
                  ),
                Text(
                  calculateNet(income, expense),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ]
            )
          )
        ],
      ),
    );
  }
}