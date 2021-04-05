#import "WireguardPlugin.h"
#if __has_include(<wireguard_plugin/wireguard_plugin-Swift.h>)
#import <wireguard_plugin/wireguard_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wireguard_plugin-Swift.h"
#endif

@implementation WireguardPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWireguardPlugin registerWithRegistrar:registrar];
}
@end
