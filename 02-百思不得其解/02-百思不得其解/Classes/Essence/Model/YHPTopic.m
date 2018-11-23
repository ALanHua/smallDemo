//
//  YHPTopic.m
//  02-百思不得其解
//
//  Created by yhp on 2016/10/7.
//  Copyright © 2016年 YouHuaPei. All rights reserved.
//

#import "YHPTopic.h"
#import "YHPComment.h"
#import "YHPUser.h"
#import <MJExtension.h>

@implementation YHPTopic
{
    CGFloat _cellHeight;
//    CGRect _pictureViewFrame;
//    CGRect _voiceViewFeame;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID": @"id",
             @"top_cmt": @"top_cmt[0]"
             };
}

//+(NSDictionary *)mj_objectClassInArray
//{
////    return @{@"top_cnt": [YHPComment class]};
//    return @{@"top_cmt": @"YHPComment"};
//}

-(NSString*)create_time
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate* create = [fmt dateFromString:_create_time];
    if ([create isThisYear]) {
        if ([create isToday]) {// 今天
            NSDateComponents* cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1 ) {
               return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){// 时间差距小于1小时
               return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else {// 小于1分钟
                return  @"刚刚";
            }
        }else if([create isYesterday]){// 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return  [fmt stringFromDate:create];
        }else{ // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return  [fmt stringFromDate:create];
        }
    }else{
        return  _create_time;
    }
    
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - YHPTopicCellMargin * 4, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight= YHPTopicCellTextY + textH + YHPTopicCellMargin;
        if (self.type == YHPTopicPictureType) {
            if (self.width != 0 || self.height != 0) { // 过滤异常文件
                CGFloat imageW = maxSize.width;
                CGFloat imageH = imageW * self.height / self.width;
                if (imageH >= YHPTopicCellPictureMaxH) {
                    imageH = YHPTopicCellPictureBreakH ;
                    self.bigPicture = YES;
                }
                // 计算图片控件的frame
                CGFloat pictureViewX = YHPTopicCellMargin;
                CGFloat pictureViewY = YHPTopicCellTextY + textH + YHPTopicCellMargin;
                _pictureViewFrame = CGRectMake(pictureViewX, pictureViewY, imageW, imageH);
                _cellHeight += imageH + YHPTopicCellMargin;
            }
        }else if (self.type == YHPTopicVoiceType){
            CGFloat voiceX = YHPTopicCellMargin;
            CGFloat voiceY = YHPTopicCellTextY + textH + YHPTopicCellMargin;;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;;
            _voiceViewFrame = CGRectMake(voiceX,voiceY, voiceH, voiceW);
            _cellHeight += voiceH + YHPTopicCellMargin;
        }else if (self.type == YHPTopicVideoType){
            CGFloat videoX = YHPTopicCellMargin;
            CGFloat videoY = YHPTopicCellTextY + textH + YHPTopicCellMargin;;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;;
            _videoViewFrame = CGRectMake(videoX,videoY, videoW, videoH);
            _cellHeight += videoH + YHPTopicCellMargin;
        }
        // 计算最热评论高度
        YHPComment* cmt = self.top_cmt;
        if (cmt) {
            NSString* content = [NSString stringWithFormat:@"%@,%@",cmt.user.username,cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += YHPTopicCellTopCmtTittleH + contentH + YHPTopicCellMargin;
            
        }
        
        _cellHeight += (YHPTopicCellButtomBarH +YHPTopicCellMargin);
    }
    
    return _cellHeight;
}

@end
