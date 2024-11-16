# Zig package for rcl_interfaces

**This repo is deprecated, please see the [zigros mono repo](https://github.com/zig-robotics/zigros) for updates.**
Maintaining individual repos paired with the zig package manager is too error prone.

This provides a zig package for the rcl_interfaces project.
This currently targets zig 0.13 and ROS Jazzy.

Currently this only builds the interfaces mandatory for building rcl:
 - builtin_interfaces
 - service_msgs 
 - type_description_interfaces 
 - rcl_interfaces
 - rosgraph_msgs
 - statistics_msgs

Still missing:
 - action_msgs
 - composition_interfaces
 - lifecycle_msgs
 - test_msgs

https://github.com/ros2/rcl_interfaces/tree/jazzy
