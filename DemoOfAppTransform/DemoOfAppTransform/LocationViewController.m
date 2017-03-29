//
//  LocationViewController.m
//  DemoOfAppTransform
//
//  Created by 蔡成汉 on 2017/3/29.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "LocationViewController.h"
#import <Masonry/Masonry.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

@property (nonatomic , strong) UILabel *myLabel;
@property (nonatomic , strong) UIButton *myButtonOne;

@end

@implementation LocationViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([CLLocationManager locationServicesEnabled]) {
            _locationManager = [[CLLocationManager alloc]init];
            [_locationManager requestWhenInUseAuthorization];
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            _locationManager.distanceFilter = 0.1;
            _locationManager.pausesLocationUpdatesAutomatically = NO;
            _locationManager.activityType = CLActivityTypeFitness;
        }
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _locationManager.delegate = self;
    [self startLocation];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopLocation];
    _locationManager.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"定位授权";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myLabel = [[UILabel alloc]init];
    _myLabel.textAlignment = NSTextAlignmentCenter;
    _myLabel.font = [UIFont systemFontOfSize:14];
    _myLabel.text = @"等待定位";
    [self.view addSubview:_myLabel];
    
    _myButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [_myButtonOne setTitle:@"跳转权限设置" forState:UIControlStateNormal];
    [_myButtonOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _myButtonOne.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_myButtonOne addTarget:self action:@selector(myButtonOneIsTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myButtonOne];
    
    
    [_myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(50);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@30);
    }];
    
    [_myButtonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.top.equalTo(_myLabel.mas_bottom).offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

-(void)myButtonOneIsTouch{
NSURL *url = [NSURL URLWithString:@"App-Prefs:root=com.jiadai.DemoOfAppTransform"];
if ([[UIApplication sharedApplication]canOpenURL:url]) {
    [[UIApplication sharedApplication]openURL:url options:[NSDictionary dictionary] completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"成功");
        }
    }];
}
}


//开始定位
-(void)startLocation{
    [_locationManager startUpdatingHeading];
    [_locationManager startUpdatingLocation];
}

//停止定位
-(void)stopLocation{
    [_locationManager stopUpdatingHeading];
    [_locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"更新用户方向");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"更新位置");
    if (locations) {
        CLLocation *tpLocaton = [locations lastObject];
        _myLabel.text = [NSString stringWithFormat:@"%.3f-%.3f",tpLocaton.coordinate.latitude,tpLocaton.coordinate.longitude];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"尚未决定");
    }else if (status == kCLAuthorizationStatusRestricted){
        NSLog(@"其他原因无法授权");
    }else if (status == kCLAuthorizationStatusDenied){
        NSLog(@"用户拒绝");
    }else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"用户允许");
    }
}

-(void)dealloc{
    NSLog(@"销毁");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
