const std = @import("std");
const RosIdlGenerator = @import("rosidl").RosIdlGenerator;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const linkage = b.option(std.builtin.LinkMode, "linkage", "Specify static or dynamic linkage") orelse .dynamic;
    const upstream = b.dependency("rcl_interfaces", .{});

    const rosidl_dep = b.dependency("rosidl", .{
        .target = target,
        .optimize = optimize,
        .linkage = linkage,
    });

    var builtin_interfaces = RosIdlGenerator.create(
        b,
        "builtin_interfaces",
        rosidl_dep,
        target,
        optimize,
        linkage,
    );

    builtin_interfaces.addMsgs(upstream.path("builtin_interfaces"), &.{
        "msg/Time.msg",
        "msg/Duration.msg",
    });

    builtin_interfaces.installArtifacts();

    var rosgraph_msgs = RosIdlGenerator.create(
        b,
        "rosgraph_msgs",
        rosidl_dep,
        target,
        optimize,
        linkage,
    );

    rosgraph_msgs.addMsgs(upstream.path("rosgraph_msgs"), &.{
        "msg/Clock.msg",
    });

    rosgraph_msgs.addDependency(.{ .name = "builtin_interfaces", .dependency = builtin_interfaces.asDependency() });
    rosgraph_msgs.installArtifacts();

    var service_msgs = RosIdlGenerator.create(
        b,
        "service_msgs",
        rosidl_dep,
        target,
        optimize,
        linkage,
    );

    service_msgs.addMsgs(
        upstream.path("service_msgs"),
        &.{"msg/ServiceEventInfo.msg"},
    );

    service_msgs.addDependency(.{ .name = "builtin_interfaces", .dependency = builtin_interfaces.asDependency() });

    service_msgs.installArtifacts();

    var type_description_interfaces = RosIdlGenerator.create(
        b,
        "type_description_interfaces",
        rosidl_dep,
        target,
        optimize,
        linkage,
    );

    type_description_interfaces.addMsgs(
        upstream.path("type_description_interfaces"),
        &.{
            "msg/Field.msg",
            "msg/FieldType.msg",
            "msg/IndividualTypeDescription.msg",
            "msg/KeyValue.msg",
            "msg/TypeDescription.msg",
            "msg/TypeSource.msg",
        },
    );

    type_description_interfaces.addSrvs(
        upstream.path("type_description_interfaces"),
        &.{"srv/GetTypeDescription.srv"},
    );

    // TODO any service depends on service msgs? make this standard?
    type_description_interfaces.addDependency(.{ .name = "service_msgs", .dependency = service_msgs.asDependency() });
    type_description_interfaces.addDependency(.{ .name = "builtin_interfaces", .dependency = builtin_interfaces.asDependency() });

    type_description_interfaces.installArtifacts();

    var statistics_msgs = RosIdlGenerator.create(
        b,
        "statistics_msgs",
        rosidl_dep,
        target,
        optimize,
        linkage,
    );

    statistics_msgs.addMsgs(
        upstream.path("statistics_msgs"),
        &.{
            "msg/MetricsMessage.msg",
            "msg/StatisticDataPoint.msg",
            "msg/StatisticDataType.msg",
        },
    );

    statistics_msgs.addDependency(.{ .name = "builtin_interfaces", .dependency = builtin_interfaces.asDependency() });

    statistics_msgs.installArtifacts();

    var rcl_interfaces = RosIdlGenerator.create(
        b,
        "rcl_interfaces",
        rosidl_dep,
        target,
        optimize,
        linkage,
    );

    rcl_interfaces.addMsgs(
        upstream.path("rcl_interfaces"),
        &.{
            "msg/FloatingPointRange.msg",
            "msg/IntegerRange.msg",
            "msg/ListParametersResult.msg",
            "msg/Log.msg",
            "msg/ParameterDescriptor.msg",
            "msg/ParameterEventDescriptors.msg",
            "msg/ParameterEvent.msg",
            "msg/Parameter.msg",
            "msg/ParameterType.msg",
            "msg/ParameterValue.msg",
            "msg/SetParametersResult.msg",
            "msg/LoggerLevel.msg",
            "msg/SetLoggerLevelsResult.msg",
        },
    );

    rcl_interfaces.addSrvs(
        upstream.path("rcl_interfaces"),
        &.{
            "srv/DescribeParameters.srv",
            "srv/GetParameters.srv",
            "srv/GetParameterTypes.srv",
            "srv/ListParameters.srv",
            "srv/SetParametersAtomically.srv",
            "srv/SetParameters.srv",
            "srv/GetLoggerLevels.srv",
            "srv/SetLoggerLevels.srv",
        },
    );

    // TODO any service depends on service msgs? make this standard?
    rcl_interfaces.addDependency(.{ .name = "service_msgs", .dependency = service_msgs.asDependency() });
    rcl_interfaces.addDependency(.{ .name = "builtin_interfaces", .dependency = builtin_interfaces.asDependency() });

    rcl_interfaces.installArtifacts();
}
