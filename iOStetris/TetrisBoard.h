//
//  TetrisBoard.h
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/21/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TetrisBoard : NSObject

@property (strong, nonatomic) NSMutableArray *tetrisBoard;
@property (strong, nonatomic) NSMutableArray *nextPieces;
@property (assign, nonatomic) NSInteger currentPiece;
@property (assign, nonatomic) NSInteger currentPieceXPos;
@property (assign, nonatomic) NSInteger currentPieceYPos;

@property (strong, nonatomic) NSMutableArray *scoreBoard;
@property (assign, nonatomic) NSInteger *score;
@property (assign, nonatomic) NSInteger *level;

@end
