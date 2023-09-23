import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';
import 'package:profile_part/src/widget/partial_widget/slider_widget.dart';

import '../../../View/Products/products_page.dart';
import '../../../constant/app_const.dart';
import '../../partial_widget/seemore_widget.dart';

class DashBoradWidget extends StatefulWidget {
  const DashBoradWidget({Key? key}) : super(key: key);

  @override
  State<DashBoradWidget> createState() => _DashBoradWidgetState();
}

class _DashBoradWidgetState extends State<DashBoradWidget> {
  final firebaseservice = Get.put(FirebaseService());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebaseservice.fetchAdsAndCategories(),
        builder: (context, snpshot) {
          if (snpshot.connectionState == ConnectionState.done) {
            if (snpshot.hasData) {
              final ads = snpshot.data!['ads'];
              final categories = snpshot.data!['categories'];

              List<Widget> convertSnapshotsToWidgets(
                  List<DocumentSnapshot<Object?>>? documentSnapshots) {
                List<Widget> widgetsList = [];

                if (documentSnapshots != null) {
                  for (DocumentSnapshot<Object?> snapshot
                      in documentSnapshots) {
                    // Extract data from the snapshot and create a widget.
                    var data = snapshot.data() as Map<String,
                        dynamic>?; // Adjust data type as per your document structure.

                    if (data != null) {
                      Widget documentWidget = AppContainer(
                          imgName: data['image'],
                          onTap: () => Get.to(categories));

                      widgetsList.add(documentWidget);
                    }
                  }
                }

                return widgetsList;
              }

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
                    elevation: 0,
                    pinned: true,
                    centerTitle: false,
                    expandedHeight: 300.h,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SliderWidget(
                        item: convertSnapshotsToWidgets(ads),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: 450.h,
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                            color: ColorConstants.mainScaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: AppConst.smallSize.h,
                            ),
                            SizedBox(
                              height: AppConst.smallSize.h,
                            ),
                            SizedBox(
                              height: 340.h,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: categories?.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    crossAxisSpacing: 2,
                                  ),
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      width: 150.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14.r))),
                                      child: Stack(
                                        children: [
                                          AppContainer(
                                            imgName: categories?[index]
                                                ['image'],
                                            onTap: () => Get.to(ProductsPage(
                                                title: categories?[index]
                                                    ['Title'])),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 140.h, left: 20.w),
                                            child: Text(
                                                categories?[index]['Title'],
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorConstants
                                                            .mainScaffoldBackgroundColor))),
                                          )
                                        ],
                                      ),
                                    );
                                  })),
                            ),
                            SeeMore(
                              onTap: () =>
                                  AuthenticationRepository.instance.logout(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else if (snpshot.hasError) {
              return Text('Erorr${snpshot.error}');
            } else {
              return const Text("somthing went wrong");
            }
          } else if (snpshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Text("somthing went wrong");
          }
        });
  }
}
