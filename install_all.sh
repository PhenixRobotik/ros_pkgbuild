#!/usr/bin/env bash

dependencies=(
  'python-empy'
  'python-vcstools'
  'python-wstool'
)
yay -S --noconfirm --asdeps "${dependencies[@]}"

packages_ordered=(
  'python-catkin-pkg'
  'python-rospkg'
  'python-rosdistro'
  'python-rosdep'
  'python-rosinstall'
  'python-rosinstall-generator'
  'ros-build-tools'

  # Melodic distro
  'ros-melodic-catkin'
)

for package in "${packages_ordered[@]}"; do
  pushd "${package}"
  makepkg -fis --noconfirm
  popd
done
