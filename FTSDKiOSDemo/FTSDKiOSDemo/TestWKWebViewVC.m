//
//  TestWKWebViewVC.m
//  ft-sdk-iosTest
//
//  Created by 胡蕾蕾 on 2020/5/28.
//  Copyright © 2020 hll. All rights reserved.
//

#import "TestWKWebViewVC.h"
#import <WebKit/WebKit.h>

@interface TestWKWebViewVC ()<WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation TestWKWebViewVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"TestWKWebViewVC";
    [self startTest];
}
- (void)startTest{
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
    //! 使用添加了ScriptMessageHandler的userContentController配置configuration
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    [configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    
    //! 使用configuration对象初始化webView
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    [self.view addSubview:_webView];
    NSString *urlStr = @"https://github.com/CloudCare/dataflux-sdk-ios";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}

-(void)dealloc{
    NSLog(@"dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
