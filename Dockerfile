FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

SHELL ["/bin/bash", "-c"]

# ============================================================
# Base system
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl \
        wget \
        git \
        git-lfs \
        vim \
        nano \
        less \
        file \
        tree \
        unzip \
        zip \
        xz-utils \
        bzip2 \
        gzip \
        tar \
        rsync \
        sudo \
        locales \
        tzdata \
        bash-completion \
        software-properties-common \
        apt-transport-https \
        gnupg \
        lsb-release \
        pciutils \
        usbutils \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Build environment
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        gcc \
        g++ \
        make \
        cmake \
        ninja-build \
        pkg-config \
        autoconf \
        autoconf-archive \
        automake \
        libtool \
        m4 \
        gettext \
        patch \
        diffutils \
        ccache \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# LLVM / Clang
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        clang \
        clang-format \
        clang-tidy \
        clang-tools \
        llvm \
        llvm-dev \
        lld \
        llvm-runtime \
        libclang-dev \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# ARM32 / AArch32 cross compilation
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        gcc-arm-linux-gnueabihf \
        g++-arm-linux-gnueabihf \
        binutils-arm-linux-gnueabihf \
        libc6-dev-armhf-cross \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# ARM64 / AArch64 cross compilation
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        gcc-aarch64-linux-gnu \
        g++-aarch64-linux-gnu \
        binutils-aarch64-linux-gnu \
        libc6-dev-arm64-cross \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Multi-architecture binary tools
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        binutils \
        binutils-multiarch \
        elfutils \
        libelf-dev \
        binutils-dev \
        nasm \
        yasm \
        xxd \
        hexedit \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# QEMU ARM / AArch64
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        qemu-user \
        qemu-user-static \
        qemu-system-arm \
        qemu-system-aarch64 \
        qemu-utils \
        qemu-block-extra \
        qemu-efi-aarch64 \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Debuggers
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        gdb \
        gdbserver \
        gdb-multiarch \
        lldb \
        strace \
        ltrace \
        valgrind \
        linux-tools-common \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Kernel debugging / crash analysis
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        crash \
        makedumpfile \
        kexec-tools \
        dwarves \
        pahole \
        linux-headers-generic \
        bc \
        bison \
        flex \
        libssl-dev \
        libncurses-dev \
        libdw-dev \
        libunwind-dev \
        cpio \
        kmod \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Linux kernel development
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        libbpf-dev \
        libcap-dev \
        libcap-ng-dev \
        libzstd-dev \
        liblz4-dev \
        liblzma-dev \
        libpopt-dev \
        libaudit-dev \
        libtraceevent-dev \
        libtracefs-dev \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Static analysis
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        cppcheck \
        flawfinder \
        sparse \
        coccinelle \
        shellcheck \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Reverse engineering
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        radare2 \
        ghex \
        sqlite3 \
        jq \
        graphviz \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Network / remote debugging utilities
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        iproute2 \
        iputils-ping \
        net-tools \
        tcpdump \
        nmap \
        socat \
        netcat-openbsd \
        openssh-client \
        openssh-server \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Python
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-dev \
        python3-pip \
        python3-venv \
        python3-setuptools \
        python3-wheel \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Python reverse-engineering environment
# ============================================================

RUN python3 -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

RUN /opt/venv/bin/pip install --no-cache-dir --upgrade \
        pip \
        setuptools \
        wheel \
    && /opt/venv/bin/pip install --no-cache-dir \
        capstone \
        keystone-engine \
        unicorn \
        pyelftools \
        lief \
        pwntools \
        ropper \
        r2pipe \
        angr \
        z3-solver \
        cryptography \
        cffi \
        requests \
        scapy \
        pytest \
        hypothesis


# ============================================================
# uftrace
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        uftrace \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# ARM Trusted Firmware dependencies
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        device-tree-compiler \
        uuid-dev \
        libgnutls28-dev \
        libp11-kit-dev \
        libtasn1-6-dev \
        python3-cryptography \
        python3-pyelftools \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# OP-TEE / Trusted execution environment development
# ============================================================

RUN apt-get update && \
    apt-get install -y \
        android-sdk-libsparse-utils \
        libssl-dev \
        uuid-dev \
        python3-pyelftools \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# ARM assembly / disassembly helpers
# ============================================================

RUN cat > /usr/local/bin/arm64-gcc <<'EOF'
#!/bin/bash
exec aarch64-linux-gnu-gcc "$@"
EOF

RUN cat > /usr/local/bin/arm32-gcc <<'EOF'
#!/bin/bash
exec arm-linux-gnueabihf-gcc "$@"
EOF

RUN cat > /usr/local/bin/arm64-as <<'EOF'
#!/bin/bash
exec aarch64-linux-gnu-as "$@"
EOF

RUN cat > /usr/local/bin/arm32-as <<'EOF'
#!/bin/bash
exec arm-linux-gnueabihf-as "$@"
EOF

RUN cat > /usr/local/bin/arm64-objdump <<'EOF'
#!/bin/bash
exec aarch64-linux-gnu-objdump "$@"
EOF

RUN cat > /usr/local/bin/arm32-objdump <<'EOF'
#!/bin/bash
exec arm-linux-gnueabihf-objdump "$@"
EOF

RUN cat > /usr/local/bin/run-arm64 <<'EOF'
#!/bin/bash
exec qemu-aarch64 -L /usr/aarch64-linux-gnu "$@"
EOF

RUN cat > /usr/local/bin/run-arm32 <<'EOF'
#!/bin/bash
exec qemu-arm -L /usr/arm-linux-gnueabihf "$@"
EOF

RUN chmod +x \
        /usr/local/bin/arm64-gcc \
        /usr/local/bin/arm32-gcc \
        /usr/local/bin/arm64-as \
        /usr/local/bin/arm32-as \
        /usr/local/bin/arm64-objdump \
        /usr/local/bin/arm32-objdump \
        /usr/local/bin/run-arm64 \
        /usr/local/bin/run-arm32


# ============================================================
# Build helpers
# ============================================================

RUN cat > /usr/local/bin/build-arm64 <<'EOF'
#!/bin/bash
set -e

if [ "$#" -eq 0 ]; then
    echo "Usage: build-arm64 source.c [output]"
    exit 1
fi

SRC="$1"
OUT="${2:-a.out}"

aarch64-linux-gnu-gcc \
    -Wall \
    -Wextra \
    -g \
    -O0 \
    "$SRC" \
    -o "$OUT"

echo "[+] Built AArch64 binary: $OUT"
file "$OUT"
EOF

RUN cat > /usr/local/bin/build-arm32 <<'EOF'
#!/bin/bash
set -e

if [ "$#" -eq 0 ]; then
    echo "Usage: build-arm32 source.c [output]"
    exit 1
fi

SRC="$1"
OUT="${2:-a.out}"

arm-linux-gnueabihf-gcc \
    -Wall \
    -Wextra \
    -g \
    -O0 \
    "$SRC" \
    -o "$OUT"

echo "[+] Built AArch32 binary: $OUT"
file "$OUT"
EOF

RUN chmod +x \
        /usr/local/bin/build-arm64 \
        /usr/local/bin/build-arm32


# ============================================================
# ELF information helper
# ============================================================

RUN cat > /usr/local/bin/elf-info <<'EOF'
#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: elf-info <binary>"
    exit 1
fi

FILE="$1"

echo "========================================"
echo " ELF Information"
echo "========================================"

file "$FILE"

echo
echo "--- ELF Header ---"
readelf -h "$FILE"

echo
echo "--- Program Headers ---"
readelf -l "$FILE"

echo
echo "--- Sections ---"
readelf -S "$FILE"

echo
echo "--- Symbols ---"
readelf -s "$FILE" 2>/dev/null | head -100
EOF

RUN chmod +x /usr/local/bin/elf-info


# ============================================================
# Disassembly helper
# ============================================================

RUN cat > /usr/local/bin/disasm <<'EOF'
#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: disasm <binary>"
    exit 1
fi

FILE="$1"

echo "========================================"
echo " Disassembly"
echo "========================================"

file "$FILE"

echo
echo "--- Architecture ---"
readelf -h "$FILE" | grep -E \
    'Class:|Data:|Type:|Machine:|Entry point'

echo
echo "--- Instructions ---"
objdump -d -M no-aliases "$FILE"
EOF

RUN chmod +x /usr/local/bin/disasm


# ============================================================
# ARM environment information
# ============================================================

RUN cat > /usr/local/bin/arm-info <<'EOF'
#!/bin/bash

echo "========================================"
echo " Armv8-A Reverse Engineering Lab"
echo "========================================"

echo
echo "--- Host ---"
uname -a
uname -m

echo
echo "--- AArch64 Compiler ---"
aarch64-linux-gnu-gcc --version | head -1

echo
echo "--- AArch32 Compiler ---"
arm-linux-gnueabihf-gcc --version | head -1

echo
echo "--- QEMU ---"
qemu-system-aarch64 --version | head -1
qemu-aarch64 --version | head -1

echo
echo "--- Debuggers ---"
gdb --version | head -1
lldb --version | head -1

echo
echo "--- LLVM ---"
clang --version | head -1

echo
echo "--- Python ---"
python --version

echo
echo "--- Python RE ---"
python - <<'PY'
import capstone
import lief
import unicorn

print("Capstone:", capstone.__version__)
print("LIEF:", lief.__version__)
print("Unicorn:", unicorn.__version__)
PY
EOF

RUN chmod +x /usr/local/bin/arm-info


# ============================================================
# Security feature helper
# ============================================================

RUN cat > /usr/local/bin/arm-security-info <<'EOF'
#!/bin/bash

echo "========================================"
echo " Armv8-A Security Laboratory"
echo "========================================"

echo
echo "Compiler:"
aarch64-linux-gnu-gcc --version | head -1

echo
echo "Checking compiler PAC/BTI options:"
aarch64-linux-gnu-gcc -Q --help=target 2>/dev/null | \
    grep -Ei 'pac|bti|mbranch|branch-protection' || true

echo
echo "QEMU:"
qemu-system-aarch64 --version | head -1

echo
echo "Available ARM CPU models:"
qemu-system-aarch64 -cpu help 2>/dev/null | head -30

echo
echo "Note:"
echo "PAC/BTI/MTE/TrustZone behavior depends on the"
echo "selected QEMU CPU/machine model and kernel."
EOF

RUN chmod +x /usr/local/bin/arm-security-info


# ============================================================
# GDB configuration
# ============================================================

RUN mkdir -p /root/.config/gdb

RUN cat > /root/.gdbinit <<'EOF'
set disassembly-flavor att
set pagination off
set confirm off
set print pretty on
set disassemble-next-line on
set breakpoint pending on
set history save on
set history filename ~/.gdb_history
set history size 10000
EOF


# ============================================================
# Workspace
# ============================================================

RUN mkdir -p \
        /workspace/book \
        /workspace/my-code \
        /workspace/assembly \
        /workspace/aarch64 \
        /workspace/aarch32 \
        /workspace/elf \
        /workspace/reverse-engineering \
        /workspace/static-analysis \
        /workspace/dynamic-analysis \
        /workspace/kernel \
        /workspace/kernel/modules \
        /workspace/kernel/vmlinux \
        /workspace/kernel/vmcore \
        /workspace/qemu \
        /workspace/qemu/images \
        /workspace/qemu/kernels \
        /workspace/qemu/dtb \
        /workspace/trustzone \
        /workspace/trusted-firmware \
        /workspace/optee \
        /workspace/pac \
        /workspace/bti \
        /workspace/mte \
        /workspace/fuzzing \
        /workspace/crashes \
        /workspace/core-dumps \
        /workspace/scripts \
        /workspace/tests \
        /workspace/samples


# ============================================================
# Test ARM cross compilation during image build
# ============================================================

RUN printf '#include <stdio.h>\nint main(void){puts("AArch64 OK");return 0;}\n' \
        > /tmp/test-arm64.c && \
    aarch64-linux-gnu-gcc -static -g -O0 \
        /tmp/test-arm64.c -o /tmp/test-arm64 && \
    file /tmp/test-arm64 && \
    qemu-aarch64 /tmp/test-arm64 && \
    rm -f /tmp/test-arm64.c /tmp/test-arm64

RUN printf '#include <stdio.h>\nint main(void){puts("AArch32 OK");return 0;}\n' \
        > /tmp/test-arm32.c && \
    arm-linux-gnueabihf-gcc -static -g -O0 \
        /tmp/test-arm32.c -o /tmp/test-arm32 && \
    file /tmp/test-arm32 && \
    qemu-arm /tmp/test-arm32 && \
    rm -f /tmp/test-arm32.c /tmp/test-arm32


# ============================================================
# Shell environment
# ============================================================

RUN cat >> /root/.bashrc <<'EOF'

export PATH="/opt/venv/bin:$PATH"

export PS1='\[\033[01;32m\]\u@armv8-lab\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

alias arm64='aarch64-linux-gnu-gcc'
alias arm32='arm-linux-gnueabihf-gcc'

echo
echo "=============================================="
echo " Armv8-A Reverse Engineering Laboratory"
echo "=============================================="
echo
echo "Useful commands:"
echo "  arm-info             - show environment"
echo "  arm-security-info    - PAC/BTI/MTE/QEMU info"
echo "  build-arm64 foo.c    - compile AArch64"
echo "  build-arm32 foo.c    - compile AArch32"
echo "  run-arm64 ./foo      - run AArch64 binary"
echo "  run-arm32 ./foo      - run AArch32 binary"
echo "  elf-info ./foo       - inspect ELF"
echo "  disasm ./foo         - disassemble"
echo
echo "Workspace:"
echo "  /workspace/assembly"
echo "  /workspace/aarch64"
echo "  /workspace/aarch32"
echo "  /workspace/elf"
echo "  /workspace/reverse-engineering"
echo "  /workspace/kernel"
echo "  /workspace/qemu"
echo "  /workspace/trustzone"
echo "  /workspace/trusted-firmware"
echo "  /workspace/optee"
echo "  /workspace/pac"
echo "  /workspace/bti"
echo "  /workspace/mte"
echo
EOF

WORKDIR /workspace

CMD ["/bin/bash"]