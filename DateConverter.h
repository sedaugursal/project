
#import <Foundation/Foundation.h>

@interface DateConverter : NSObject

+ (NSDate *)convertDateFromDotNetJSONString:(NSString *)string;

@end
