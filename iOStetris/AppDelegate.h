//
//  AppDelegate.h
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/16/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TetrisBoard.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TetrisBoard *board;

@end

