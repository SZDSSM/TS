//
//  UIImage+saveimage.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "UIImage+saveimage.h"

@implementation UIImage (saveimage)

- (NSData * )imageIntoData:(UIImage *)image
{
    NSData *data;
    
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(image);
        
    }
    return data;
}

@end
