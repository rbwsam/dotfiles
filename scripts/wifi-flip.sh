#!/bin/bash
set -ex

iwctl adapter phy0 set-property Powered off \
&& sleep 60 \
&& iwctl adapter phy0 set-property Powered on \
&& sleep 10 \
&& ping -c 10 1.1.1.1

