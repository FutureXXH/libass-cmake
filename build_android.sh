#!/bin/bash
set -e

# 定义颜色输出
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting build process (V3)...${NC}"

# 检查 NDK 环境变量
if [ -z "$ANDROID_NDK_HOME" ]; then
    echo "Error: ANDROID_NDK_HOME is not set."
    echo "Please set it using: export ANDROID_NDK_HOME=/path/to/your/ndk"
    exit 1
fi

# ==========================================
# 关键修改：禁止 autogen.sh 自动运行 configure
# ==========================================
export NOCONFIGURE=1

echo -e "${GREEN}Using NDK: $ANDROID_NDK_HOME${NC}"

# 1. 预处理：运行 autogen.sh 生成 configure 脚本
echo -e "${GREEN}Generating configure scripts...${NC}"
for dir in src/ass src/freetype src/fribidi src/harfbuzz src/fontconfig src/unibreak src/expat; do
    if [ -d "$dir" ] && [ -f "$dir/autogen.sh" ]; then
        echo "Running autogen.sh in $dir..."
        (cd "$dir" && ./autogen.sh)
        
        # 双重保险：如果意外生成了 Makefile，尝试清理
        if [ -f "$dir/Makefile" ]; then
             echo "Warning: Makefile found in $dir, cleaning..."
             (cd "$dir" && make distclean || rm -f Makefile config.status)
        fi
    fi
done

# 2. 创建并进入构建目录
BUILD_DIR="build_android"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# 3. 运行 CMake
echo -e "${GREEN}Configuring CMake...${NC}"
cmake .. \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake" \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-21 \
    -DCMAKE_BUILD_TYPE=Release \
    -GNinja

# 4. 编译
echo -e "${GREEN}Building...${NC}"
ninja

echo -e "${GREEN}Build finished successfully!${NC}"
echo "Static libraries are located in: $(pwd)/lib"
