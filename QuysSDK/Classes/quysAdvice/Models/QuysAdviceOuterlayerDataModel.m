//
//  QuysAdviceOuterlayerDataModel.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdviceOuterlayerDataModel.h"

@implementation QuysAdviceOuterlayerDataModel

//映射：
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[QuysAdviceModel class]};
}
////替换字符：
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return
//  @{
//        @"name" : @"n",
//        @"page" : @"p",
//        @"desc" : @"ext.desc",
//        @"bookID" : @[@"id",@"ID",@"book_id"]
//    };
//}
@end
