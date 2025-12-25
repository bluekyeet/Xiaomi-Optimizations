#!/system/bin/sh

# ---------- SurfaceFlinger / Display ----------
resetprop -p persist.sys.stability.miui_fbo_enable true
resetprop -p persist.sys.miui.sf_cores 4-7

# ---------- Animator / UI scheduling ----------
resetprop -p persist.sys.miui_animator_sched.bigcores 6-7
resetprop -p persist.sys.miui_animator_sched.sched_threads 2

# ---------- MIUI performance engines ----------
resetprop -p persist.miui.miperf.enable true

# ---------- Millet scheduler ----------
resetprop -p persist.sys.powmillet.enable true
resetprop ro.millet.netlink 29

# ---------- ART / Dex2OAT ----------
resetprop -p dalvik.vm.image-dex2oat-filter everything
resetprop -p dalvik.vm.dex2oat-filter everything
resetprop -p dalvik.vm.boot-dex2oat-threads 6

# ---------- Graphics pipline ----------
resetprop debug.hwui.renderer skiavk
resetprop ro.hwui.use_vulkan true
resetprop ro.hardware.vulkan adreno
resetprop debug.renderengine.vulkan true
resetprop debug.renderengine.backend skiavk

echo 0 > /sys/class/kgsl/kgsl-3d0/force_bus_on
echo 0 > /sys/class/kgsl/kgsl-3d0/force_clk_on
echo 0 > /sys/class/kgsl/kgsl-3d0/force_no_nap
echo 0 > /sys/class/kgsl/kgsl-3d0/force_rail_on
echo 1 > /sys/class/kgsl/kgsl-3d0/bus_split
echo 0 > /sys/class/kgsl/kgsl-3d0/popp
echo 0 > /sys/class/kgsl/kgsl-3d0/bcl
echo 1 > /proc/sys/walt/sched_conservative_pl
echo 2 > /proc/sys/walt/sched_window_stats_policy
echo 30 > /proc/sys/walt/sched_min_task_util_for_boost
echo 40 > /proc/sys/walt/sched_min_task_util_for_colocation
echo 20 > /proc/sys/walt/sched_idle_enough
echo 1 > /proc/sys/walt/sched_asymcap_boost

# Xiaomi BS
echo 0 > /proc/sys/migt/enable_pkg_monitor
echo 0 > /sys/module/migt/parameters/enable_pkg_monitor