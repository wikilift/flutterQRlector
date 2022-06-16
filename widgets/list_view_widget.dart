import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../helpers/helpers.dart';
import '../services/scan_list_service.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({Key? key, required this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListService>(context);

    return Center(
      child: ListView.separated(
          itemBuilder: (context, index) {
            final scan = scanListProvider.scans[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Icon(Icons.delete_forever, size: 30, color: Colors.white),
                  ),
                ]),
              ),
              child: ListTile(
                leading: Icon(icon, size: 35, color: Colors.red),
                title: Text(
                  scan.value.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: const Icon(Icons.keyboard_arrow_right, size: 35, color: Colors.red),
                onTap: () async {
                  scan.value.contains('http')
                      ? await Helpers.launchUrl(scan.value)
                      : Navigator.pushNamed(context, 'map', arguments: scan);
                },
              ),
              onDismissed: (direction) {
                scanListProvider.deleteOne(scan.id!);
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: scanListProvider.scans.length),
    );
  }
}
