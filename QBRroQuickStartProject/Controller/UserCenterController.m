//
//  UserCenterController.m
//  QBRroQuickStartProject
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018 Lei Ni. All rights reserved.
//

#import "UserCenterController.h"
#import "UIViewController+Kit.h"
#import "AppContainerTransition.h"
#import "RunnerPathController.h"
#import "UserCenterView.h"
#import "Masonry.h"

@interface UserCenterController ()

@property(nonatomic,strong) UserCenterView *userView;

@end

@implementation UserCenterController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"user";
        [self addReturnButton:@selector(dismiss)];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _userView = [UserCenterView new];
    _userView.frame = self.view.bounds;
    [self.view addSubview:_userView];
    [self addStartSampleBtn];
}

- (void)addStartSampleBtn {
    UIButton *sampleBtn  = [UIButton new];
    UIColor *color    = [UIColor colorWithRed:251/255.0f green:101/255.0f blue:60/255.0f alpha:0.8];
    [sampleBtn setTitle:@"sample data" forState:UIControlStateNormal];
    sampleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:21];
    [sampleBtn setBackgroundColor:color];
    
    [self.view addSubview:sampleBtn];
    [sampleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(200.0);
    }];
    [sampleBtn addTarget:self action:@selector(didSampleButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didSampleButtonSelected:(id)sender {
    RunnerPathController *runnerPath = [RunnerPathController new];
    RunnerCourse *course    = [EntityManager readSampleRunnerCourse];
    runnerPath.runnerCourse = course;
    [self.navigationController pushViewController:runnerPath animated:YES];
}
#pragma mark - 配置事件
- (void)dismiss {
    [AppContainerTransition moveToMainController];
}


@end
