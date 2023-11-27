import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/services/channel_service.dart';

class ChannelManagement extends StatelessWidget {
  const ChannelManagement({super.key});

  @override
  Widget build(BuildContext context) {
    var items = context.watch<ChannelService>().list;
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
                            items[index].name,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(items[index].place),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                    ) {
                                      return AlertDialog(
                                        title: const Text('채널 수정'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              initialValue: items[index].name,
                                              decoration: const InputDecoration(
                                                labelText: '채널 이름',
                                              ),
                                              onChanged: (value) {
                                                // TODO: Implement
                                                // items[index].name = value;
                                              },
                                            ),
                                            TextFormField(
                                              initialValue: items[index].place,
                                              decoration: const InputDecoration(
                                                labelText: '장소',
                                              ),
                                              onChanged: (value) {
                                                // TODO: Implement
                                                // items[index].place = value;
                                              },
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('취소'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // TODO: Implement
                                              // await context
                                              //     .read<ChannelService>()
                                              //     .updateChannel(
                                              //       items[index].id,
                                              //       items[index],
                                              //     );
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              showErrorSnackBar(
                                                context,
                                                'Not implemented',
                                              );
                                            },
                                            child: const Text('수정'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.edit),
                                    Text('수정'),
                                  ],
                                ),
                              ),
                              ElevatedButton(
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
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('취소'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // TODO: Implement
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              showErrorSnackBar(
                                                context,
                                                'Not implemented',
                                              );
                                            },
                                            child: const Text('삭제'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.delete),
                                    Text('삭제'),
                                  ],
                                ),
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
