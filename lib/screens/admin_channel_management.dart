import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

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
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoActionSheet(
                    title: Text(items[index].name),
                    message: Text(items[index].place),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        childconst : const Text('채널 정보 수정'),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        ),
                        isDestructiveAction: tru
                        child: const Text('채널 삭제'),e,
                      ,,,),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      childconst : const Text('취소'),
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
