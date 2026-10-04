echo
echo "========== ARMv8-A LAB SMOKE TEST =========="

echo "[1] Compilers"
aarch64-linux-gnu-gcc --version | head -1
arm-linux-gnueabihf-gcc --version | head -1

echo "[2] QEMU"
qemu-aarch64 --version | head -1
qemu-arm --version | head -1
qemu-system-aarch64 --version | head -1
qemu-system-arm --version | head -1

echo "[3] Reverse engineering"
gdb-multiarch --version | head -1
objdump --version | head -1
readelf --version | head -1
radare2 -v | head -1

echo "[4] Analysis"
cppcheck --version
flawfinder --version | head -1
spatch --version | head -1
shellcheck --version | head -1
scan-build --help >/dev/null && echo "scan-build: OK"

echo "[5] Python RE stack"
python3 -c "import capstone, unicorn, lief, angr, z3, r2pipe; print('Python RE stack: OK')"

echo "[6] Kernel"
crash --version 2>&1 | head -1
pahole --version
eu-readelf --version | head -1

echo "[7] Tracing"
uftrace --version | head -1

echo
echo "============================================="
echo " ARMv8-A LAB SMOKE TEST COMPLETE"
echo "============================================="