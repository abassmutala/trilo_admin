import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:trilo_admin/constants/app_colors.dart';
import 'package:trilo_admin/widgets/detail_tile.dart';

class PhoneNumbers extends StatelessWidget {
  const PhoneNumbers({super.key, this.phoneNumbers});
  final List? phoneNumbers;

  @override
  Widget build(BuildContext context) {
    // final Launcher launcher = Launcher();

    return phoneNumbers!.isNotEmpty
        ? Column(
            children: phoneNumbers!
                .map(
                  (e) => Column(
                    children: [
                      DetailTile(
                        icon: LucideIcons.phone,
                        title: e,
                        trailing: LucideIcons.arrowUpRight,
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Make call"),
                                  content: const Text(
                                      "Are you sure you want to place a call?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: AppColours.dangerLight),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          // launcher.makePhoneCall(e);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Yes"))
                                  ],
                                )),
                      ),
                      const Divider(),
                    ],
                  ),
                )
                .toList(),
          )
        : Container();
  }
}
