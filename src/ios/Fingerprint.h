#import <Cordova/CDV.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface Fingerprint :CDVPlugin

-(void)authenticate : (CDVInvokedUrlCommand*)command;

-(void)isAvailable : (CDVInvokedUrlCommand*)command;

@end
