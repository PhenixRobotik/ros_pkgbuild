#!/usr/bin/env bash

dependencies=(
  # 'python-empy'
  # 'python-vcstools'
  # 'python-wstool'
)
yay -S --noconfirm --asdeps "${dependencies[@]}"

packages_ordered=(
  'ros-melodic-rostest'
  'ros-melodic-rosbag-storage'
  'ros-melodic-topic-tools'
  'ros-melodic-rosbag'
  'ros-melodic-rosmsg'
  'ros-melodic-rosservice'
  'ros-melodic-dynamic-reconfigure'
  'ros-melodic-message-filters'
  'ros-melodic-nodelet-topic-tools'
  'ros-melodic-nodelet-core'
  'ros-melodic-roscpp-core'
  'ros-melodic-rosconsole-bridge'
  'ros-melodic-rosbag-migration-rule'
  'ros-melodic-rosmake'
  'ros-melodic-rosboost-cfg'
  'ros-melodic-rosbash'
  'ros-melodic-mk'
  'ros-melodic-roscreate'
  'ros-melodic-ros'
  'ros-melodic-roslisp'
  'ros-melodic-diagnostic-msgs'
  'ros-melodic-geometry-msgs'
  'ros-melodic-trajectory-msgs'
  'ros-melodic-sensor-msgs'
  'ros-melodic-stereo-msgs'
  'ros-melodic-actionlib-msgs'
  'ros-melodic-nav-msgs'
  'ros-melodic-shape-msgs'
  'ros-melodic-visualization-msgs'
  'ros-melodic-common-msgs'
  'ros-melodic-rostopic'
  'ros-melodic-rosnode'
  'ros-melodic-roswtf'
  'ros-melodic-ros-comm'
  'ros-melodic-ros-core'
  'ros-melodic-actionlib'
  'ros-melodic-ros-base'
)

for package in "${packages_ordered[@]}"; do
  if [[ ! -d "${package}" ]]; then
    git clone "https://aur.archlinux.org/${package}.git" "${package}"
  else
    git -C "${package}" pull
  fi

  pushd "${package}"
  makepkg -fis --noconfirm --skipinteg
  res=$?
  if [ ${res} -ne 0 ]; then
      git reset --hard "HEAD~1"
      makepkg -fis --noconfirm --skipinteg
      res=$?
  fi
  if [ ${res} -ne 0 ]; then
    exit 1
  fi
  popd
done
