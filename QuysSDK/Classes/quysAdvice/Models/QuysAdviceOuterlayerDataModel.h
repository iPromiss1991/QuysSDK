//
//  QuysAdviceOuterlayerDataModel.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysAdviceModel.h"
NS_ASSUME_NONNULL_BEGIN
///数据外层模型
@interface QuysAdviceOuterlayerDataModel : NSObject
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , strong) NSArray <QuysAdviceModel *>              * data;
@property (nonatomic , assign) NSInteger              code;

@end

NS_ASSUME_NONNULL_END
