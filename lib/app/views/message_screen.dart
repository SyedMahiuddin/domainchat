import 'package:domainchat/app/controlers/message_controller.dart';
import 'package:domainchat/app/widgets/logout_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../helpers/color_helper.dart';
import '../helpers/space_helper.dart';
import '../widgets/commons.dart';
import '../models/message_model.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final MessageController messageController = Get.put(MessageController());
  final TextEditingController _searchController = TextEditingController();
  final RxList<Message> _filteredMessages = <Message>[].obs;
  final RxBool _isSearching = false.obs;

  @override
  void initState() {
    super.initState();
    _filteredMessages.value = messageController.messageList;
  }

  Future<void> _refreshMessages() async {
    await messageController.fetchMessages();
    _filterMessages(_searchController.text);
  }

  void _filterMessages(String query) {
    if (query.isEmpty) {
      _filteredMessages.value = messageController.messageList;
    } else {
      _filteredMessages.value = messageController.messageList.where((message) {
        final fromMatch = message.from.name.toLowerCase().contains(query.toLowerCase()) ||
            message.from.address.toLowerCase().contains(query.toLowerCase());
        final subjectMatch = message.subject.toLowerCase().contains(query.toLowerCase());
        return fromMatch || subjectMatch;
      }).toList();
    }
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorHelper.secondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: ColorHelper.greyColor,
            size: 20.sp,
          ),
          SpaceHelper.horizontalSpace10,
          Expanded(
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                color: ColorHelper.whiteColor,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search messages...',
                hintStyle: TextStyle(
                  color: ColorHelper.greyColor,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                _isSearching.value = value.isNotEmpty;
                _filterMessages(value);
              },
            ),
          ),
          if (_isSearching.value)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _isSearching.value = false;
                _filterMessages('');
              },
              child: Icon(
                Icons.close,
                color: ColorHelper.greyColor,
                size: 20.sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Message message) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorHelper.secondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: message.seen
              ? ColorHelper.secondary
              : ColorHelper.primary.withOpacity(0.5),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonComponents.customText(
                      text: message.from.name.isEmpty
                          ? message.from.address
                          : message.from.name,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    SpaceHelper.verticalSpace5,
                    CommonComponents.customText(
                      text: message.subject,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              CommonComponents.customText(
                text: messageController.formatDate(message.createdAt),
                fontSize: 12,
                color: ColorHelper.greyColor,
              ),
            ],
          ),
          SpaceHelper.verticalSpace10,
          CommonComponents.customText(
            text: message.intro,
            fontSize: 14,
            color: ColorHelper.greyColor,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (message.hasAttachments)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_file,
                    color: ColorHelper.greyColor,
                    size: 16.sp,
                  ),
                  SpaceHelper.horizontalSpace5,
                  CommonComponents.customText(
                    text: 'Attachment',
                    fontSize: 12,
                    color: ColorHelper.greyColor,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpaceHelper.verticalSpace10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonComponents.headingText(
                    text: 'Messages',
                    fontSize: 24,
                  ),
                  IconButton(onPressed: (){
                    LogoutDialog.show(context);
                  }, icon: const Icon(Icons.logout))
                ],
              ),
              SpaceHelper.verticalSpace20,
              _buildSearchBar(),
              SpaceHelper.verticalSpace20,
              Expanded(
                child: Obx(() {
                  if (messageController.messageList.isEmpty) {
                    return _buildShimmerList();
                  } else if (_filteredMessages.isEmpty && _isSearching.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48.sp,
                            color: ColorHelper.greyColor,
                          ),
                          SpaceHelper.verticalSpace10,
                          CommonComponents.customText(
                            text: 'No messages found',
                            color: ColorHelper.greyColor,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: _refreshMessages,
                      child: ListView.builder(
                        itemCount: _filteredMessages.length,
                        itemBuilder: (context, index) {
                          return _buildMessageItem(_filteredMessages[index]);
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorHelper.secondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: ColorHelper.whiteColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SpaceHelper.verticalSpace10,
                    Container(
                      width: 200.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        color: ColorHelper.whiteColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 50.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: ColorHelper.whiteColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
          SpaceHelper.verticalSpace15,
          Container(
            width: double.infinity,
            height: 14.h,
            decoration: BoxDecoration(
              color: ColorHelper.whiteColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SpaceHelper.verticalSpace10,
          Container(
            width: 200.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: ColorHelper.whiteColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: ColorHelper.secondary,
      highlightColor: ColorHelper.primary.withOpacity(0.2),
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => _buildShimmerItem(),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}