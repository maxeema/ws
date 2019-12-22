import 'package:flutter/material.dart';
import 'package:ws/misc/ext.dart';
import 'package:ws/misc/insets.dart';
import 'package:ws/model/message.dart';
import 'package:ws/model/owner.dart';

class MessageItem extends StatelessWidget {

  MessageItem({
    Key key,
    @required this.msg
  }) : assert(msg != null), super(key: key);

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: msg.owner.system ? Alignment.center : (msg.isMine ? Alignment.centerRight : Alignment.centerLeft),
      widthFactor: .8,
      child: Container(
          child: RichText(
            textAlign: msg.isMine ? TextAlign.end : TextAlign.start,
            text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  if (!msg.isMine)
                    WidgetSpan(
                        child: Container(
                            alignment: Alignment.topLeft,
                            padding: 4.insets.vert,
                            child: Text(
                              (msg.owner.system ? context.l.systemUser : msg.user),
                              style: Theme.of(context).textTheme.overline.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            )
                        )
                    ),

                  TextSpan(
                    text: msg.text,
                    style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
                  ),

                  if (msg.hasDate)
                    WidgetSpan(
                      child: Container(
                          alignment: Alignment.bottomRight,
                          padding: 4.insets.vert,
                          child: Text(
                            msg.date.parseTimeOfDay().format(context),
                            style: Theme.of(context).textTheme.overline,
                          )
                      ),
                    )
                ]
            ),
          ),
          padding: 8.insets.all,
          margin: 4.insets.all,
          decoration: ShapeDecoration(
              color: msg.owner.system ? Colors.red : (msg.isMine ? Colors.green : Colors.blueGrey),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
          ),
      ),
    );
  }

}
