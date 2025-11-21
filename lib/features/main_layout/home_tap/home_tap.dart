import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/widgets/custom_tab_bar.dart';
import 'package:evently/core/widgets/event_item.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  late CategoryModel selectedCategory = CategoryModel.allCategories(context)[0];

  @override
  Widget build(BuildContext context) {
    var configProvider=Provider.of<ConfigProvider>(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
            color: Theme.of(context).primaryColor,
          ),
          padding: REdgeInsets.only(top: 40.h,left: 16.w,right: 16.w ,bottom: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.welcome_back,style: Theme.of(context).textTheme.headlineMedium,),
                      Text(UserModel.currentUser!.userName,style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    configProvider.toggleTheme();
                  },icon:Icon(configProvider.isDark?Icons.dark_mode:Icons.light_mode),color: ColorsManager.white,),
                  InkWell(
                    onTap:() {
                      configProvider.toggleLanguage();
                    } ,
                    child: Card(
                      color: ColorsManager.white,
                      margin: REdgeInsets.only(left: 10),
                      child: Padding(
                        padding:  REdgeInsets.all(8.0),
                        child: Text(configProvider.currentLanguage,style: Theme.of(context).textTheme.headlineSmall,),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              // Row(
              //   children: [
              //     Icon(Icons.location_on,color: ColorsManager.white,),
              //     Text("Cairo , Egypt",style: Theme.of(context).textTheme.headlineMedium,),
              //   ],
              // ),
              SizedBox(
                height: 16.h,
              ),
              CustomTabBar(
                unselectedFgColor: ColorsManager.white,
                unselectedBgColor:Colors.transparent ,
                selectedFgColor: ColorsManager.blue,
                selectedBgColor: ColorsManager.white,
                categories: CategoryModel.allCategories(context),
                itemOnClicked: (category) {
                  selectedCategory=category;
                  setState(() {

                  });
                },
              ),

            ],
          ),
        ),
        StreamBuilder(stream: FirebaseService.getEventFromFirebase(context,selectedCategory), builder:(context, snapshot) {
          if(snapshot.connectionState== ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Center(child: Text(snapshot.hasError.toString()),);
          }
          List<EventModel> events =snapshot.data ?? [];
          if (events.isEmpty) {
            return Expanded(
              child: Center(
                child: Text(
                  "No events yet",
                ),
              ),
            );
          }
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => EventItem(event: events[index],),
              itemCount: events.length,),
          );
        }, ),

      ],
    );
  }
}
