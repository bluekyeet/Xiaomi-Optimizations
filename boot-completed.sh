#!/system/bin/sh

sleep 20


# ---------- CPU Optimizations ----------
# ---------- CPUSET Optimization ----------
echo 0-7 > /dev/cpuset/top-app/cpus
echo 0-5 > /dev/cpuset/foreground/cpus
echo 0-4 > /dev/cpuset/foreground_window/cpus
echo 0-4 > /dev/cpuset/system-background/cpus
echo 0-2 > /dev/cpuset/background/cpus

# ---------- Little cluster ----------
echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
echo 90      > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_load
echo 1000    > /sys/devices/system/cpu/cpufreq/policy0/walt/up_rate_limit_us
echo 10000   > /sys/devices/system/cpu/cpufreq/policy0/walt/down_rate_limit_us
echo 4       > /sys/devices/system/cpu/cpufreq/policy0/walt/target_load_shift

# ---------- Big cluster ----------
echo 1400000 > /sys/devices/system/cpu/cpufreq/policy4/walt/hispeed_freq
echo 85      > /sys/devices/system/cpu/cpufreq/policy4/walt/hispeed_load
echo 500     > /sys/devices/system/cpu/cpufreq/policy4/walt/up_rate_limit_us
echo 4000    > /sys/devices/system/cpu/cpufreq/policy4/walt/down_rate_limit_us
echo 1       > /sys/devices/system/cpu/cpufreq/policy4/walt/target_load_shift

# ---------- Prime cluster ----------
echo 2500000 > /sys/devices/system/cpu/cpufreq/policy7/walt/hispeed_freq
echo 80      > /sys/devices/system/cpu/cpufreq/policy7/walt/hispeed_load
echo 300     > /sys/devices/system/cpu/cpufreq/policy7/walt/up_rate_limit_us
echo 3500    > /sys/devices/system/cpu/cpufreq/policy7/walt/down_rate_limit_us
echo 1       > /sys/devices/system/cpu/cpufreq/policy7/walt/target_load_shift

# ---------- Usage adjustments ----------
echo 0 > /proc/sys/kernel/sched_util_clamp_min
echo 1024 > /proc/sys/kernel/sched_util_clamp_max
echo 12 > /dev/cpuctl/top-app/cpu.uclamp.min
echo 1024 > /dev/cpuctl/top-app/cpu.uclamp.max
echo 1 > /dev/cpuctl/foreground/cpu.uclamp.min
echo 1024 > /dev/cpuctl/foreground/cpu.uclamp.max
echo 0 > /dev/cpuctl/background/cpu.uclamp.min
echo 204 > /dev/cpuctl/background/cpu.uclamp.max
echo 0 > /dev/cpuctl/system-background/cpu.uclamp.min
echo 512 > /dev/cpuctl/system-background/cpu.uclamp.max


# ---------- Dalvik heap sizing ----------
TOTAL_RAM_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
TOTAL_RAM_GB=$((TOTAL_RAM_KB / 1024 / 1024))

if [ "$TOTAL_RAM_GB" -le 3 ]; then
    :
elif [ "$TOTAL_RAM_GB" -le 5 ]; then
    cmd settings put global dalvik.vm.heapsize 384m
elif [ "$TOTAL_RAM_GB" -le 7 ]; then
    cmd settings put global dalvik.vm.heapsize 512m
else
    cmd settings put global dalvik.vm.heapsize 768m
fi