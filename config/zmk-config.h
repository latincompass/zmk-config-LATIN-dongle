/* 核心配置：禁用分体键盘，启用单端蓝牙键盘 */
#define ZMK_SPLIT 0          // 强制关闭分体模式
#define ZMK_BLE 1            // 启用蓝牙 HID（接收器+键盘一体）
#undef ZMK_SPLIT_BLE        // 禁用分体蓝牙配对逻辑