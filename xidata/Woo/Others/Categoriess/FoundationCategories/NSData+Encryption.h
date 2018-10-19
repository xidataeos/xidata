//
//  Encryption.h
//  AesTest
//
//  Created by XinKai on 13-8-26.
//  Copyright (c) 2013年 Xin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@class NSString;
#define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */
typedef uint32_t CC_LONG;       /* 32 bit unsigned integer */

@interface NSData (Encryption)

- (NSData *)AES128EncryptWithMD5Key:(NSString *)key;   //加密
- (NSData *)AES128DecryptWithMD5Key:(NSString *)key;   //解密


- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密
- (NSString *)newStringInBase64FromData;            //追加64编码
+ (NSString*)base64encode:(NSString*)str;           //同上64编码

@end