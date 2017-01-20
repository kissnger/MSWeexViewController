//
//  MSWeexLoadImg.m
//  MSWeexViewController
//
//  Created by Massimo on 2017/1/16.
//  Copyright © 2017年 Massimo. All rights reserved.
//

#import "MSWeexLoadImg.h"
#import "WeexSDK.h"
#import "UIImageView+WebCache.h"
@implementation MSWeexLoadImg


- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url imageFrame:(CGRect)imageFrame userInfo:(NSDictionary *)options completed:(void (^)(UIImage *, NSError *, BOOL))completedBlock{
  
  
  if ([url hasPrefix:@"//"]) {
    url = [@"http:" stringByAppendingString:url];
  }
  
  return (id <WXImageOperationProtocol>)[[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    
  } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
    if (completedBlock) {
      completedBlock(image,error,finished);
    }
  }];
}
@end
