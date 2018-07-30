

/// 处理单利模式的宏文件
/*
 eg:在.h文件中  BYSingletonH(BYAlertHelper)
    在.m文件中  BYSingletonM(BYAlertHelper)
 */
// .h文件
#define BYSingletonH(name) + (instancetype)shared##name;

// .m文件
#define BYSingletonM(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (instancetype)shared##name \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}
