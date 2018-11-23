//
//  YHPConst.h
//  02-百思不得其解
//
//  Created by yhp on 2016/10/8.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum {
    YHPTopicAllType     = 1,
    YHPTopicWordType    = 29,
    YHPTopicVoiceType   = 31,
    YHPTopicVideoType   = 41,
    YHPTopicPictureType = 10
}YHPTopicType;

/*精华顶部标题宽度和高度*/
UIKIT_EXTERN CGFloat const YHPTitilesViewH;
UIKIT_EXTERN CGFloat const YHPTitilesViewY;
/*精华--cell-间距*/
UIKIT_EXTERN CGFloat const YHPTopicCellMargin;
UIKIT_EXTERN CGFloat const YHPTopicCellTextY;
UIKIT_EXTERN CGFloat const YHPTopicCellButtomBarH;
UIKIT_EXTERN CGFloat const YHPTopicCellTopCmtTittleH;
/*图片帖子的最大值*/
UIKIT_EXTERN CGFloat const YHPTopicCellPictureMaxH;
UIKIT_EXTERN CGFloat const YHPTopicCellPictureBreakH;
/*YHPUser模型-性别属性值*/
UIKIT_EXTERN NSString* const YHPUserSexMale;
UIKIT_EXTERN NSString* const YHPUserSexFemale;
/*tabBar被点击的通知名字*/
UIKIT_EXTERN NSString* const YHPTabBarDidSelectedNotification;
UIKIT_EXTERN NSString* const YHPSelectedControllerIndexKey;
UIKIT_EXTERN NSString* const YHPSelectedControllerKey;
/** 标签间距*/
UIKIT_EXTERN CGFloat const YHPTagMargin;
/** 标签高度*/
UIKIT_EXTERN CGFloat const YHPTagH;

