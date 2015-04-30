//
//  ViewController.m
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/16/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "ViewController.h"
#import "TetrisBoard.h"
#import "TetrisView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet TetrisView *puzzleView;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isPaused;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pause;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveDown{
    [self.puzzleView moveTetrominoDown];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.isPaused = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(moveDown) userInfo:nil repeats:YES];
}

- (IBAction)pause:(id)sender {
    if(self.isPaused){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(moveDown) userInfo:nil repeats:YES];
        self.isPaused = NO;
        [self.puzzleView setUserInteractionEnabled:YES];
        self.pause.title = @"Pause";
    }else{
        [self.timer invalidate];
        self.timer = nil;
        self.isPaused = YES;
        [self.puzzleView setUserInteractionEnabled:NO];
        self.pause.title = @"Resume";
    }
}

@end
