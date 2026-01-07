#!/bin/bash
set -e

# ==========================================
# 配置部分
# ==========================================
# 使用与编译时相同的 NDK 路径
export ANDROID_NDK_HOME=/opt/android-ndk/android-ndk-r27d
export TOOLCHAIN=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64
# 使用 llvm-ar 进行归档
export AR=$TOOLCHAIN/bin/llvm-ar

# 库文件所在目录
LIB_DIR=build_android/lib
# 合并后的输出文件名
OUTPUT_LIB=$LIB_DIR/libass_complete.a
# 临时脚本文件
MRI_FILE=merge.mri

# ==========================================
# 执行部分
# ==========================================

if [ ! -d "$LIB_DIR" ]; then
    echo "错误: 目录 $LIB_DIR 不存在，请先运行编译脚本。"
    exit 1
fi

echo "正在生成合并脚本..."

# 1. 创建 MRI 脚本 (用于控制 ar 的行为)
# create 命令指定输出文件
echo "create $OUTPUT_LIB" > $MRI_FILE

# 2. 定义需要合并的库列表
# 注意：这里列出了所有可能的依赖库
LIBS=(
    "libass.a"
    "libfreetype.a"
    "libfribidi.a"
    "libharfbuzz.a"
    "libunibreak.a"
    "libfontconfig.a"
    "libexpat.a"
)

# 3. 循环添加存在的库
for lib in "${LIBS[@]}"; do
    if [ -f "$LIB_DIR/$lib" ]; then
        echo "addlib $LIB_DIR/$lib" >> $MRI_FILE
        echo "  [+] 添加库: $lib"
    else
        echo "  [-] 跳过库: $lib (未找到)"
    fi
done

# 4. 保存并结束
echo "save" >> $MRI_FILE
echo "end" >> $MRI_FILE

# 5. 执行合并操作
echo "正在执行合并..."
"$AR" -M < $MRI_FILE

# 6. 清理临时文件
rm $MRI_FILE

echo "------------------------------------------------"
echo "成功！已生成合并后的静态库："
echo "$OUTPUT_LIB"
echo "------------------------------------------------"
