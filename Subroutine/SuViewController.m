//
//  SuViewController.m
//  Subroutine
//
//  Created by shimin lu on 21/02/2013.
//  Copyright (c) 2013 shimin lu. All rights reserved.
//

#import "SuViewController.h"
#import "SuNumberSpeller.h"


@interface SuViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation SuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}
- (IBAction)ConvertAction:(UIButton *)sender {
    
    [self.view.window endEditing:YES];
    
}

#pragma mark - helpers

-(NSString*)convertToSpellString:(NSNumber*)num{

    // custom API
    SuNumberSpeller*speller =[[SuNumberSpeller alloc]init];
    NSString  *spelling = [speller spellFormatNumber:num];
    
    /* build-in Apple API
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    NSString  *spelling = [formatter stringFromNumber:num];    
    */
    
    assert(spelling);
    return spelling;
}

/*
-(NSString*)insertCharactersToString:(NSString*)string{
    
    NSMutableString *result = [NSMutableString stringWithString:string];
    NSRange range = [string rangeOfString:@"HUNDRED" options:NSBackwardsSearch];
    
    if (range.location!=NSNotFound) {
        [result insertString:@" AND " atIndex:range.location + @"HUNDRED".length];
    }
    else {
        range = [string rangeOfString:@"THOUSAND" options:NSBackwardsSearch];
        if (range.location!=NSNotFound) {
            [result insertString:@" AND " atIndex:range.location + @"THOUSAND".length];
        }else {        
            range = [string rangeOfString:@"MILLION" options:NSBackwardsSearch];
            if (range.location!=NSNotFound) {
                [result insertString:@" AND " atIndex:range.location + @"MILLION".length];
            }
        }
    }

    return result;
}*/

#pragma mark - Text Field delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location>15)    return NO;
    else                    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField.text.length>0) {
        SuNumberSpeller*speller =[[SuNumberSpeller alloc]init];
        return [speller convertToSpellString:textField.text];
       
    }else{
        self.resultLabel.text = nil;
    }
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{

    self.resultLabel.text = nil;
    return YES;
}








@end
