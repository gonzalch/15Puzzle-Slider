//
//  _5_PuzzleViewController.m
//  15 Puzzle
//
//  Created by student on 2/4/13.
//  Copyright (c) 2013 edu.sonoma. All rights reserved.
//

#import "_5_PuzzleViewController.h"

@interface _5_PuzzleViewController ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *buttonFinal;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *upSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *downSwipe;
@property (nonatomic, strong) BoardBrain *boardBrain;

@end

@implementation _5_PuzzleViewController
@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;
@synthesize button4 = _button4;
@synthesize button5 = _button5;
@synthesize button6 = _button6;
@synthesize button7 = _button7;
@synthesize button8 = _button8;
@synthesize button9 = _button9;
@synthesize button10 = _button10;
@synthesize button11 = _button11;
@synthesize button12 = _button12;
@synthesize button13 = _button13;
@synthesize button14 = _button14;
@synthesize button15 = _button15;
@synthesize button0 = _button0;
@synthesize shuffleSlider = _shuffleSlider;
@synthesize shuffleButton = _shuffleButton;
@synthesize resetButton = _resetButton;
@synthesize winLabel = _winLabel;

@synthesize boardBrain = _boardBrain;
@synthesize buttonArray = _buttonArray;
@synthesize buttonFinal = _buttonFinal;
@synthesize leftSwipe = _leftSwipe;
@synthesize rightSwipe = _rightSwipe;
@synthesize upSwipe = _upSwipe;
@synthesize downSwipe = _downSwipe;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.boardBrain = [[BoardBrain alloc] init];
      
    [self.view addGestureRecognizer:self.leftSwipe];
    [self.view addGestureRecognizer:self.rightSwipe];
    [self.view addGestureRecognizer:self.upSwipe];
    [self.view addGestureRecognizer:self.downSwipe];
    [self.shuffleButton addTarget:self action:@selector(didTapShuffle)
     forControlEvents:UIControlEventTouchUpInside];
    [self.resetButton addTarget:self action:@selector(didTapReset) forControlEvents:UIControlEventTouchUpInside];
    [self.winLabel setAlpha:0];
    
    //NSLog(@"Value of slider is %f", self.shuffleSlider.value);
    
    
}

- (NSMutableArray *) buttonArray
{
    if( ! _buttonArray)
        _buttonArray = [NSMutableArray arrayWithObjects:self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15, self.button0, nil];
    return _buttonArray;
}

- (NSMutableArray *) buttonFinal
{
    if( ! _buttonFinal)
        _buttonFinal = [NSMutableArray arrayWithObjects:self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15, self.button0, nil];
    return _buttonFinal;
}

-(UIGestureRecognizer *) leftSwipe
{
    if ( ! _leftSwipe ) {
        _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
        [_leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
        
    return _leftSwipe;
}

- (void) didSwipeLeft: (UIGestureRecognizer *) swipeObject
{
    NSLog(@"didSwipeLeft was called.");
    
    [self leftSwap];
    
}

- (void) leftSwap
{
    for (int i = 0; i < 16; i++){
        //NSLog(@"Value of i is %d and i mod 4 is %d", i, i%4);
        if ( [self.buttonArray objectAtIndex:i] == self.button0 &&  i % 4 != 3 ){
            
            //NSLog(@"Value of i is %d and i mod 4 is %d", i, i%4);
            UIButton *temp1 = [self.buttonArray objectAtIndex:i];
            UIButton *temp2 = [self.buttonArray objectAtIndex:i+1];
            
            CGPoint a = temp1.center;
            CGPoint b = temp2.center;
            
            [UIView animateWithDuration:0.5 animations:^{[temp1 setCenter:b];}];
            [UIView animateWithDuration:0.5 animations:^{[temp2 setCenter:a];}];
            
            [self.buttonArray replaceObjectAtIndex:i withObject:temp2];
            [self.buttonArray replaceObjectAtIndex:i+1 withObject:temp1];
            
            [self isComplete];
            
            break;
        }
        
    }
}

-(UIGestureRecognizer *) rightSwipe
{
    if ( ! _rightSwipe) {
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
        [_rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    
    return _rightSwipe;
}

- (void) didSwipeRight: (UIGestureRecognizer *) swipeObject
{
    NSLog(@"didSwipeRight was called.");
    
    [self rightSwap];
    
}

- (void) rightSwap
{
    for (int i = 0; i < 16; i++){
        if ( [self.buttonArray objectAtIndex:i] == self.button0 &&  i % 4 != 0 ){
            
            //NSLog(@"Value of i is %d", i);
            UIButton *temp1 = [self.buttonArray objectAtIndex:i];
            UIButton *temp2 = [self.buttonArray objectAtIndex:i-1];
            
            CGPoint a = temp1.center;
            CGPoint b = temp2.center;
            
            [UIView animateWithDuration:0.5 animations:^{[temp1 setCenter:b];}];
            [UIView animateWithDuration:0.5 animations:^{[temp2 setCenter:a];}];
            
            [self.buttonArray replaceObjectAtIndex:i withObject:temp2];
            [self.buttonArray replaceObjectAtIndex:i-1 withObject:temp1];
            
            [self isComplete];
        }
        
    }
}

-(UIGestureRecognizer *) upSwipe
{
    if ( ! _upSwipe ) {
        _upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeUp:)];
        [_upSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
    }
    
    return _upSwipe;
}

- (void) didSwipeUp: (UIGestureRecognizer *) swipeObject
{
    NSLog(@"didSwipeUp was called.");
    
    [self upSwap];
    
}

- (void) upSwap
{
    for (int i = 0; i < 16; i++){
        if ( [self.buttonArray objectAtIndex:i] == self.button0 &&  i < 12 ){
            
            //NSLog(@"Value of i is %d", i);
            UIButton *temp1 = [self.buttonArray objectAtIndex:i];
            UIButton *temp2 = [self.buttonArray objectAtIndex:i+4];
            
            CGPoint a = temp1.center;
            CGPoint b = temp2.center;
            
            [UIView animateWithDuration:0.5 animations:^{[temp1 setCenter:b];}];
            [UIView animateWithDuration:0.5 animations:^{[temp2 setCenter:a];}];
            
            [self.buttonArray replaceObjectAtIndex:i withObject:temp2];
            [self.buttonArray replaceObjectAtIndex:i+4 withObject:temp1];
            
            [self isComplete];
            
            break;
        }
        
    }
}

-(UIGestureRecognizer *) downSwipe
{
    if ( ! _downSwipe) {
        _downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown:)];
        [_downSwipe setDirection:UISwipeGestureRecognizerDirectionDown];
    }
    
    return _downSwipe;
}

- (void) didSwipeDown: (UIGestureRecognizer *) swipeObject
{
    NSLog(@"didSwipeDown was called.");
    
    [self downSwap];
    
}

- (void) downSwap
{
    for (int i = 0; i < 16; i++){
        if ( [self.buttonArray objectAtIndex:i] == self.button0 &&  i > 3 ){
            
            //NSLog(@"Value of i is %d", i);
            UIButton *temp1 = [self.buttonArray objectAtIndex:i];
            UIButton *temp2 = [self.buttonArray objectAtIndex:i-4];
            
            CGPoint a = temp1.center;
            CGPoint b = temp2.center;
            
            [UIView animateWithDuration:0.5 animations:^{[temp1 setCenter:b];}];
            [UIView animateWithDuration:0.5 animations:^{[temp2 setCenter:a];}];
            
            [self.buttonArray replaceObjectAtIndex:i withObject:temp2];
            [self.buttonArray replaceObjectAtIndex:i-4 withObject:temp1];
            
            [self isComplete];
            
        }
        
    }
}

- (void) didTapShuffle
{
    
    //NSLog(@"Shuffle tapped slider is at %d", (int) (self.shuffleSlider.value * 50));
    
    for (int i = 0; i < (int) (self.shuffleSlider.value * 50); i++){
        int temp = rand() % 4;
        
        
        
        if (temp == 0)
            [self leftSwap];
        
        if (temp == 1)
            [self rightSwap];
        
        if (temp == 2)
            [self upSwap];
        
        if (temp == 3)
            [self downSwap];
    }
}

- (void) didTapReset
{
    for (int i = 0; i < 16; i++)
    {
        UIButton *temp1 = [self.buttonArray objectAtIndex:i];
        UIButton *temp2 = [self.buttonFinal objectAtIndex:i];
        
        CGPoint a = temp1.center;
        CGPoint b = temp2.center;
        
        [UIView animateWithDuration:0.5 animations:^{[temp1 setCenter:b];}];
        [UIView animateWithDuration:0.5 animations:^{[temp2 setCenter:a];}];
        
        for (int j = 0; j < 16; j++)
        {
            if ( [self.buttonArray objectAtIndex:j] == temp2)
            {
                [self.buttonArray replaceObjectAtIndex:j withObject:temp1];
                
                break;
            }
        }
        
        [self.buttonArray replaceObjectAtIndex:i withObject:temp2];
    }
}

- (void) isComplete
{
    
    int countButtons = 0;
    
    for (int i = 0; i < 16; i++)
    {
        if ([self.buttonArray objectAtIndex:i] == [self.buttonFinal objectAtIndex:i])
            countButtons++;
    }
    
    //NSLog(@"counButtons is at %d", countButtons);
    
    if ( countButtons == 16)
        [self.winLabel setAlpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
