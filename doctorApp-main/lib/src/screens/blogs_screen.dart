import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../../multi_language/language_constants.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_screen_sizes.dart';
import '../config/app_text_styles.dart';

import '../controllers/all_blogs_controller.dart';
import '../controllers/general_controller.dart';

import '../repositories/all_blogs_repo.dart';
import '../routes.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_skeleton_loader.dart';

// class BlogsScreen extends StatefulWidget {
//   const BlogsScreen({super.key});

//   @override
//   State<BlogsScreen> createState() => BlogsScreenState();
// }

// class BlogsScreenState extends State<BlogsScreen> {
//   final logic = Get.put(AllBlogsController());
//   // final List numbers = List.generate(30, (index) => "Item $index");

//   @override
//   void initState() {
//     super.initState();
//     postMethod(
//         context, '$getAllBlogsPosts?page=1', null, false, getAllBlogsPostsRepo);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<GeneralController>(builder: (generalController) {
//       return GetBuilder<AllBlogsController>(builder: (allBlogsPostsController) {
//         return Scaffold(
//           backgroundColor: AppColors.white,
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(56),
//             child: AppBarWidget(
//               leadingIcon: 'assets/icons/Expand_left.png',
//               leadingOnTap: () {
//                 Get.back();
//               },
//               titleText: LanguageConstant.blogs.tr,
//             ),
//           ),
//           body: !allBlogsPostsController.allBlogsPostsLoader
//               ? const CustomGridViewSkeletonLoader(
//                   highlightColor: AppColors.grey,
//                   seconds: 2,
//                   totalCount: 5,
//                   aspectRatio: 0.9,
//                 )
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       GridView.count(
//                         padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 0),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 18.0,
//                         mainAxisSpacing: 12.0,
//                         childAspectRatio: 0.62,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         children: List.generate(
//                           allBlogsPostsController
//                               .blogsPostsListForPagination.length,
//                           (index) {
//                             return InkWell(
//                               onTap: () {
//                                 allBlogsPostsController
//                                     .updateSelectedBlogsPostsForView(
//                                         allBlogsPostsController
//                                                 .blogsPostsListForPagination[
//                                             index]);

//                                 Get.toNamed(PageRoutes.blogDetailScreen);
//                               },
//                               child: Container(
//                                 // padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
//                                 margin: EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 8.h),
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.15),
//                                       spreadRadius: 7,
//                                       blurRadius: 10,
//                                     )
//                                   ],
//                                   color: AppColors.white,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Center(
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(20),
//                                         // ignore: unrelated_type_equality_checks
//                                         child: allBlogsPostsController
//                                                 .blogsPostsListForPagination[
//                                                     index]
//                                                 .image!
//                                                 .isNotEmpty
//                                             ? Image(
//                                                 image: NetworkImage(
//                                                     "$mediaUrl${allBlogsPostsController.blogsPostsListForPagination[index].image}"),
//                                                 fit: BoxFit.cover,
//                                                 height: AppScreenSizes
//                                                         .screenHeight *
//                                                     0.17,
//                                                 width:
//                                                     AppScreenSizes.screenWidth *
//                                                         0.6,
//                                               )
//                                             : Image(
//                                                 image: const AssetImage(
//                                                     'assets/images/events-image-2.png'),
//                                                 height: AppScreenSizes
//                                                         .screenHeight *
//                                                     0.17,
//                                                 width:
//                                                     AppScreenSizes.screenWidth *
//                                                         0.6,
//                                               ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.fromLTRB(
//                                           10.w, 10.h, 10.w, 0.h),
//                                       child: Text(
//                                         "${allBlogsPostsController.blogsPostsListForPagination[index].name}",
//                                         textAlign: TextAlign.start,
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: AppTextStyles.bodyTextStyle16,
//                                       ),
//                                     ),
//                                     Html(
//                                       data:
//                                           "${allBlogsPostsController.blogsPostsListForPagination[index].description}",
//                                       shrinkWrap: true,
//                                       style: {
//                                         "body": Style(
//                                             fontFamily:
//                                                 AppFont.primaryFontFamily,
//                                             fontSize: FontSize(10.sp),
//                                             fontWeight: FontWeight.w400,
//                                             color: AppColors.textColorOne,
//                                             textAlign: TextAlign.start,
//                                             padding: HtmlPaddings.only(
//                                                 left: 10.w, right: 10.w),
//                                             maxLines: 2,
//                                             textOverflow: TextOverflow.ellipsis,
//                                             margin: Margins.zero),
//                                       },
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.fromLTRB(
//                                           10.w, 0.h, 10.w, 10.h),
//                                       child: Text(
//                                         // "25th March, 2023",
//                                         "${allBlogsPostsController.blogsPostsListForPagination[index].createdAt?.split(",").first}",
//                                         textAlign: TextAlign.start,
//                                         style: AppTextStyles.bodyTextStyle17,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 18.h),
//                       allBlogsPostsController
//                                       .blogsPostsListForPagination.length ==
//                                   allBlogsPostsController.getAllBlogPostsModel
//                                       .data!.data!.length &&
//                               allBlogsPostsController.getAllBlogPostsModel.data!
//                                       .meta!.currentPage !=
//                                   allBlogsPostsController
//                                       .getAllBlogPostsModel.data!.meta!.lastPage
//                           ? Container(
//                               margin: EdgeInsets.fromLTRB(0, 0.h, 0, 18.h),
//                               width: MediaQuery.of(context).size.width * .35,
//                               child: generalController
//                                       .getPaginationProgressCheck
//                                   ? Container(
//                                       height: generalController
//                                               .getPaginationProgressCheck
//                                           ? 50.0
//                                           : 0,
//                                       color: Colors.transparent,
//                                       child: Center(
//                                         child: CircularProgressIndicator(
//                                           color: AppColors.primaryColor,
//                                         ),
//                                       ),
//                                     )
//                                   : ButtonWidgetOne(
//                                       buttonText: LanguageConstant.loadMore.tr,
//                                       onTap: () {
//                                         allBlogsPostsController
//                                             .paginationDataLoad(context);
//                                       },
//                                       buttonTextStyle:
//                                           AppTextStyles.buttonTextStyle1,
//                                       borderRadius: 10,
//                                     ))
//                           : const SizedBox(),
//                     ],
//                   ),
//                 ),
//         );
//       });
//     });
//   }
// }

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => BlogsScreenState();
}

class BlogsScreenState extends State<BlogsScreen> {
  final logic = Get.put(AllBlogsController());

  @override
  void initState() {
    super.initState();
    postMethod(
        context, '$getAllBlogsPosts?page=1', null, false, getAllBlogsPostsRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<AllBlogsController>(builder: (allBlogsPostsController) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppBarWidget(
              leadingIcon: 'assets/icons/Expand_left.png',
              leadingOnTap: () {
                Get.back();
              },
              titleText: LanguageConstant.blogs.tr,
            ),
          ),
          body: !allBlogsPostsController.allBlogsPostsLoader
              ? const CustomGridViewSkeletonLoader(
                  highlightColor: AppColors.grey,
                  seconds: 2,
                  totalCount: 5,
                  aspectRatio: 0.9,
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.count(
                        padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 0),
                        crossAxisCount: 2,
                        crossAxisSpacing: 18.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 0.62,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          allBlogsPostsController
                              .blogsPostsListForPagination.length,
                          (index) {
                            final blog = allBlogsPostsController
                                .blogsPostsListForPagination[index];
                            return InkWell(
                              onTap: () {
                                allBlogsPostsController
                                    .updateSelectedBlogsPostsForView(blog);
                                Get.toNamed(PageRoutes.blogDetailScreen);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.15),
                                      spreadRadius: 7,
                                      blurRadius: 10,
                                    )
                                  ],
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                      child: blog.image!.isNotEmpty
                                          ? Image.network(
                                              "$mediaUrl${blog.image}",
                                              fit: BoxFit.cover,
                                              height:
                                                  AppScreenSizes.screenHeight *
                                                      0.17,
                                              width: double.infinity,
                                            )
                                          : Image.asset(
                                              'assets/images/events-image-2.png',
                                              height:
                                                  AppScreenSizes.screenHeight *
                                                      0.17,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 8.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              blog.name ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  AppTextStyles.bodyTextStyle16,
                                            ),
                                            SizedBox(height: 6.h),
                                            Expanded(
                                              child: Html(
                                                data: blog.description ?? '',
                                                shrinkWrap: true,
                                                style: {
                                                  "body": Style(
                                                    fontSize: FontSize(10.sp),
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.textColorOne,
                                                    maxLines: 2,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    padding: HtmlPaddings.zero,
                                                    margin: Margins.zero,
                                                  ),
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              blog.createdAt
                                                      ?.split(",")
                                                      .first ??
                                                  '',
                                              style:
                                                  AppTextStyles.bodyTextStyle17,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 18.h),
                      allBlogsPostsController
                                      .blogsPostsListForPagination.length ==
                                  allBlogsPostsController.getAllBlogPostsModel
                                      .data!.data!.length &&
                              allBlogsPostsController.getAllBlogPostsModel.data!
                                      .meta!.currentPage !=
                                  allBlogsPostsController
                                      .getAllBlogPostsModel.data!.meta!.lastPage
                          ? Container(
                              margin: EdgeInsets.only(bottom: 18.h),
                              width: MediaQuery.of(context).size.width * .35,
                              child: generalController
                                      .getPaginationProgressCheck
                                  ? SizedBox(
                                      height: 50.0,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    )
                                  : ButtonWidgetOne(
                                      buttonText: LanguageConstant.loadMore.tr,
                                      onTap: () {
                                        allBlogsPostsController
                                            .paginationDataLoad(context);
                                      },
                                      buttonTextStyle:
                                          AppTextStyles.buttonTextStyle1,
                                      borderRadius: 10,
                                    ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
        );
      });
    });
  }
}
