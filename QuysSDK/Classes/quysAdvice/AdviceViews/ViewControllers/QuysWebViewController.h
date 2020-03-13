//
//  QuysWebViewController.h
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
///webview
@interface QuysWebViewController : QuysBaseViewController

- (instancetype)initWithUrl:(NSString *)requestUrl;

- (instancetype)initWithHtml:(NSString *)html;
@end

NS_ASSUME_NONNULL_END
