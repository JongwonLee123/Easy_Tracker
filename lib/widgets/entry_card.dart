import "package:easy_tracker/utils/themes.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:flutter_svg/flutter_svg.dart";

String timestampToDate(int timestamp) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('MMM dd, yyyy, h:mma').format(dt);
}

String formatUSD(double n) {
  return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(n.abs());
}

class EntryCard extends StatefulWidget {
  final int id;
  final String? name;
  final double amount;
  final int timestamp;
  final String? description;

  const EntryCard({
    Key? key,
    required this.id,
    required this.name,
    required this.amount,
    required this.timestamp,
    required this.description
  }): super(key: key);

  @override
  State<EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: fgWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [generalShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 230,
                child: Text(
                  widget.name!,
                  style: bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              Text(
                timestampToDate(widget.timestamp),
                style: bodySmall,
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                child: Text(
                  widget.description!,
                  style: bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.amount > 0)
                      SvgPicture.asset(
                        'assets/svg/eva_arrow-up-fill.svg',
                        height: 24,
                        width: 24,
                      ),
                    if (widget.amount < 0)
                      SvgPicture.asset(
                        'assets/svg/eva_arrow-down-fill.svg',
                        height: 24,
                        width: 24,
                      ),
                    Text(
                      formatUSD(widget.amount),
                      style: bodyMedium,
                    )
                  ]
                )
              )
            ]
          )
        ],
      ),
    );
  }
}