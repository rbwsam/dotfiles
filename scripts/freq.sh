#!/bin/bash

cat /sys/devices/system/cpu/cpu*/power/energy_perf_bias /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
