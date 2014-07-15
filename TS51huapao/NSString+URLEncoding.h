//
//  NSString+URLEncoding.h
//  TS51huapao
//
//  Created by 80_xiaoye on 13-12-12.
//
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)


-(NSString *)URLEncodedString;
-(NSString *)URLDecodedString;

/*邮箱验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateEmail:(NSString *)email;

/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL) isValidateMobile:(NSString *)mobile;

/*车牌号验证 MODIFIED BY HELENSONG*/
-(BOOL) validateCarNo:(NSString *) carNo;

@end
