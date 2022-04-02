import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_app/ui/size_config.dart';
import 'package:my_todo_app/ui/theme.dart';

import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Container(
        // padding: EdgeInsets.symmetric(
        //     horizontal: getProportionateScreenWidth(
        //         SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
        // width: SizeConfig.orientation == Orientation.landscape
        //     ?MediaQuery.of(context).size.width / 2
        //     : MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _getBGClr(task.color),
          ),
          child: Row(children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title!,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                        const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${task.startTime}-${task.endTime}',
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 13, color: Colors.white)),
                      ),
                    
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    task.note!,
                    style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                ],
              ),
            )),
            Container(
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? 'TODO' : 'Completed',
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            )
          ]),
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return primaryClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
    }
  }
}
