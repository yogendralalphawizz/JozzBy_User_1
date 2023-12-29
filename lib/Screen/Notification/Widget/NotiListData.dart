import 'package:eshop_multivendor/Screen/Language/languageSettings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Helper/Color.dart';
import '../../../Helper/String.dart';
import '../../../Helper/routes.dart';
import '../../../Model/Notification_Model.dart';
import '../../../Provider/SingleProductProvider.dart';
import '../../../widgets/desing.dart';
import '../../../widgets/snackbar.dart';

class NotiListData extends StatelessWidget {
  int index;
  List<NotificationModel> notiList;

  NotiListData({Key? key, required this.index, required this.notiList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationModel model = notiList[index];
    return InkWell(
      onTap: () {
        if (model.type == 'products') {
          Future.delayed(Duration.zero).then((value) => context
              .read<SingleProProvider>()
              .getProduct(model.typeId!, 0, 0, true, context));
        } else if (model.type == 'categories') {
          Navigator.of(context).pop(true);
        } else if (model.type == 'wallet') {
          Routes.navigateToMyWalletScreen(context);
        } else if (model.type == 'order') {
          Routes.navigateToMyOrderScreen(context);
        } else if (model.type == 'ticket_message') {
          Routes.navigateToChatScreen(context, model.id, '');
        } else if (model.type == 'ticket_status') {
          Routes.navigateToCustomerSupportScreen(context);
        } else {
          setSnackbar(
              getTranslated(context, 'It is a normal Notification')!, context);
        }
      },
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [

                        Text(
                          "${index+1}",
                          style: const TextStyle(
                            color: colors.primary,
                            fontFamily: 'ubuntu',
                          ),
                        ),
                        SizedBox(width: 3,),
                        Text(
                          model.date!,
                          style: const TextStyle(
                            color: colors.primary,
                            fontFamily: 'ubuntu',
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        model.title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ubuntu',
                        ),
                      ),
                    ),
                    Text(
                      model.desc!,
                      style: const TextStyle(
                        fontFamily: 'ubuntu',
                      ),
                    )
                  ],
                ),
              ),
              model.img != null && model.img != ''
                  ? GestureDetector(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Hero(
                          tag: '$heroTagUniqueString ${model.id!}',
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              model.img!,
                            ),
                            radius: 25,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: true,
                            pageBuilder: (BuildContext context, _, __) {
                              return AlertDialog(
                                elevation: 0,
                                contentPadding: const EdgeInsets.all(0),
                                backgroundColor: Colors.transparent,
                                content: Hero(
                                  tag: '$heroTagUniqueString ${model.id!}',
                                  child:
                                      DesignConfiguration.getCacheNotworkImage(
                                    boxFit: null,
                                    context: context,
                                    heightvalue: null,
                                    widthvalue: null,
                                    imageurlString: model.img!,
                                    placeHolderSize: 150,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  : Container(
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
