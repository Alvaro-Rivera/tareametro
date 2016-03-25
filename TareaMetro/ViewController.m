//
//  ViewController.m
//  TareaMetro
//
//  Created by Álvaro Rivera on 24-03-16.
//  Copyright © 2016 Álvaro Rivera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"content HTML" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSAttributedString *attrStr = [self attributedStringWithHTML:htmlString];
    [_contenido setAttributedText:attrStr];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSAttributedString *)attributedStringWithHTML:(NSString *)HTML {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType };
    return [[NSAttributedString alloc] initWithData:[HTML dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:NULL error:NULL];
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    NSURL *requestURL = URL;
    NSURL *newRequestURL;
    if ([requestURL.scheme isEqualToString:@"applewebdata"]) {
        NSString *requestURLString = requestURL.absoluteString;
        NSString *trimmedRequestURLString = [requestURLString stringByReplacingOccurrencesOfString:@"^(?:applewebdata://[0-9A-Z-]*/?)" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, requestURLString.length)];
        NSString *trimmedURL = [trimmedRequestURLString stringByReplacingOccurrencesOfString:@"%22" withString:@""];
        if (trimmedRequestURLString.length > 0) {
            newRequestURL = [[NSURL alloc] initWithString:trimmedURL];
        }
        else{
            newRequestURL = [[NSURL alloc] initWithString:trimmedRequestURLString];
        }
        NSLog(@"url trimmed: %@",newRequestURL.absoluteString);
        if([self validateUrl:newRequestURL.absoluteString]){
            NSURL * URLtoLoad = [[NSURL alloc ]initWithString:newRequestURL.absoluteString];
            SFSafariViewController *websiteToOpen = [[SFSafariViewController alloc]initWithURL:URLtoLoad entersReaderIfAvailable:YES];
            websiteToOpen.delegate = self;
            [self presentViewController:websiteToOpen animated:YES completion:nil];
        }else{
            NSURL *google = [[NSURL alloc]initWithString:@"https://www.google.cl"];
            SFSafariViewController *websiteToOpen = [[SFSafariViewController alloc]initWithURL:google entersReaderIfAvailable:YES];
            websiteToOpen.delegate = self;
            [self presentViewController:websiteToOpen animated:YES completion:nil];
        }
    }
    
    return YES;
}
-(BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

@end
