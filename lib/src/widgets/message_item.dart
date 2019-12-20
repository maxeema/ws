import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageItem extends StatefulWidget {

  final Message msg;

  MessageItem({@required this.msg});

  @override
  _MessageItemState createState() => _MessageItemState();

}
class _MessageItemState extends State<MessageItem> {

  bool animate = false;

  @override
  Widget build(BuildContext context) {
    final content = createContent(widget.msg);

    Future(() {
      setState(() {animate = true;});
    });

    return AnimatedCrossFade(
      firstChild: Opacity(opacity: 0, child: content,),
      secondChild: content,
      crossFadeState: animate ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: Duration(milliseconds: 300),
    );
  }

  Widget createContent(Message msg) => Flex(
    direction: Axis.horizontal,
    children: <Widget>[

      if (msg.isMine)
        Flexible(
          child: Container(),
        ),

      Flexible(
        flex: 6,
        fit: FlexFit.loose,
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
                        padding: EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                          (msg.isSystem ? 'system' : msg.name),
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
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          TimeOfDay.fromDateTime(DateTime.parse(msg.date)).format(context),
                          style: Theme.of(context).textTheme.overline,
                        )
                      ),
                    )
                ]
            ),
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(4),
          decoration: ShapeDecoration(
              color: msg.isSystem ? Colors.red : (msg.isMine ? Colors.green : Colors.blueGrey),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
          ),
        ),
      ),

      if (!msg.isMine)
        Flexible(
          child: Container(),
        )

    ],
  );

}
