import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/custom_light_theme_widget.dart';
import 'package:flutter_alcore/src/app/widgets/menu_info.dart';
import 'package:flutter_alcore/src/utils/widget_util.dart';

Widget getMenuPage(BuildContext context, MenuInfo parentMenu) {
  return GridMenuPage(
      title: parentMenu.title,
      items: parentMenu.children?.getActiveMenuInfoAfterCheckingAll());
}

class GridMenuPage extends StatefulWidget {
  final String? title;
  final List<MenuInfo>? items;
  const GridMenuPage({Key? key, this.title, this.items}) : super(key: key);

  @override
  State<GridMenuPage> createState() => _GridMenuPageState();
}

class _GridMenuPageState extends State<GridMenuPage> {
  @override
  Widget build(BuildContext context) {
    return CustomLightThemeWidget(
      child: Scaffold(
        appBar: widget.title == null
            ? null
            : AppBar(
                title: Text(widget.title!),
              ),
        //using gridview
        body: widget.items == null
            ? Container()
            : GridView.builder(
                itemCount: widget.items!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 9 / 10,
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 3
                        : 5),
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.items![index];
                  return item.asGridItemWidget();
                },
              ),

        //using wrap
        // body: SizedBox.expand(
        //   child: SingleChildScrollView(
        //     child: Wrap(
        //       spacing: 3,
        //       runSpacing: 3,
        //       alignment: WrapAlignment.spaceEvenly,
        //       runAlignment: WrapAlignment.start,
        //       children: widget.items
        //           .map((item) => item.asGridItemWidget())
        //           .toList(),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final void Function(BuildContext context)? onTap;
  final Widget Function(BuildContext context)? badgeBuilder;
  const GridItemWidget(
      {Key? key, this.imagePath, this.title, this.onTap, this.badgeBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call(context);
      },
      child: Card(
        child: Container(
          width: 100,
          height: 130,
          padding: const EdgeInsets.all(5.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imagePath != null)
                    Image.asset(
                      imagePath!,
                      width: 80,
                      height: 80,
                    ),
                  if (imagePath != null) spaceH(4),
                  if (title != null)
                    Text(
                      title!,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black, fontSize: 10),
                      textAlign: TextAlign.center,
                    )
                ],
              ),
              if (badgeBuilder != null)
                Positioned(left: 0, top: 0, child: badgeBuilder!.call(context)),
            ],
          ),
        ),
      ),
    );
  }
}
