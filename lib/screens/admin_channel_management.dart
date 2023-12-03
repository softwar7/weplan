import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/screens/forms/channel_form.dart';
import 'package:weplan/services/channel_service.dart';
import 'package:weplan/viewmodels/channel.dart';

class ChannelManagement extends StatelessWidget {
  const ChannelManagement({super.key});

  @override
  Widget build(BuildContext context) {
    var items = context.watch<ChannelService>().list;
    // var formKey = GlobalKey<FormState>();
    return RefreshIndicator(
      onRefresh: context.read<ChannelService>().updateChannels,
      child: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text(items[index].place),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            onTap: () {
              ChannelViewModel channel = items[index];
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 300,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            channel.name,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(channel.place),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                child: const Column(
                                  children: [
                                    Icon(Icons.edit),
                                    Text('수정'),
                                  ],
                                ),
                                onPressed: () {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                    ) {
                                      return ChannelFormAlertDialog(
                                        // formKey: formKey,
                                        channel: channel,
                                      );
                                    },
                                  );
                                },
                              ),

                              // 삭제버튼
                              TextButton(
                                child: const Column(
                                  children: [
                                    Icon(Icons.delete),
                                    Text('삭제'),
                                  ],
                                ),
                                onPressed: () {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                    ) {
                                      return AlertDialog(
                                        title: const Text('채널 삭제'),
                                        content: const Text('정말 삭제하시겠습니까?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('취소'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          TextButton(
                                            child: const Text('삭제'),
                                            onPressed: () async {
                                              await channel
                                                  .deleteChannel(verbose: true)
                                                  .then(
                                                    (_) => context
                                                        .read<ChannelService>()
                                                        .updateChannels(),
                                                  );
                                              if (!context.mounted) return;
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(height: 1, thickness: 0.1),
      ),
    );
  }
}
