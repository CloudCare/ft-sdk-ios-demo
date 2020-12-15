//
//  DemoViewController.m
//  FTSDKiOSDemo
//
//  Created by 胡蕾蕾 on 2019/11/28.
//  Copyright © 2019 hll. All rights reserved.
//

#import "DemoViewController.h"
#import "EventFlowLogTestVC.h"
#import <FTMobileAgent.h>
#import "AppDelegate.h"
#import "FTSDKiOSDemo-Swift.h"
#import "TestWKWebViewVC.h"
@interface DemoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mtableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.dataSource = @[@"Test_BindUser",@"Test_UserLogOut",@"Test_CustomLogging",@"Test_EventFlowLog",@"Test_CrashLog",@"Test_ConsoleLogTrack",@"Test_NetworkTrace",@"Test_WKWebViewTrace"];
    [self createUI];
}
- (void)onClickedOKbtn {
    NSLog(@"onClickedOKbtn");
}
-(void)createUI{
    _mtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200)];
    _mtableView.dataSource = self;
    _mtableView.delegate = self;
    [self.view addSubview:_mtableView];
    [_mtableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
- (void)testStartLocation{
    dispatch_async(dispatch_get_main_queue(), ^{
        [FTMobileAgent startLocation:^(NSInteger errorCode, NSString * _Nullable errorMessage) {
        
            [self showResult:[NSString stringWithFormat:@"errorCode = %ld,errorMessage=%@",(long)errorCode,errorMessage]];
        }];
    });
}
- (void)testBindUser{
    [[FTMobileAgent sharedInstance] bindUserWithUserID:@"testuser1"];
}
- (void)testUserLogout{
    [[FTMobileAgent sharedInstance] logout];
}
- (void)testCustomLogging{
    [[FTMobileAgent sharedInstance] logging:@"testLogging" status:FTStatusInfo];
}
- (void)testEventFlowLog{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[EventFlowLogTestVC new] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)showResult:(NSString *)title{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *commit = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:commit];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)testCrashLog{
    NSString *str = nil;
    NSDictionary *dict = @{@"name":str};
}
- (void)testLogTrack{
    NSLog(@"testLog");
    FrintHookTest *test = [[FrintHookTest alloc]init];
    [test show];
}
- (void)testNetworkTrace{
    NSArray *search = @[@"上海天气",@"鹅鹅鹅",@"温度",@"机器人"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    int x = arc4random() % 4;
    NSString *parameters = [NSString stringWithFormat:@"key=free&appid=0&msg=%@",search[x]];
    NSString *urlStr = @"http://api.qingyunke.com/api.php";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *res =(NSHTTPURLResponse *)response;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showResult:[NSString stringWithFormat:@"statusCode == %ld",(long)res.statusCode]];
        });
    }];
    [task resume];
}
- (void)testWKWebviewTrace{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[TestWKWebViewVC new] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark ========== UITableViewDataSource ==========
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    switch (row) {
        case 0:
            [self testBindUser];
            break;
        case 1:
            [self testUserLogout];
            break;
        case 2:
            [self testCustomLogging];
            break;
        case 3:
            [self testEventFlowLog];
            break;
        case 4:
            [self testCrashLog];
            break;
        case 5:
            [self testLogTrack];
            break;
        case 6:
            [self testNetworkTrace];
            break;
        case 7:
            [self testWKWebviewTrace];
            break;
        default:
            break;
    }
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
