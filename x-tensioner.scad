// a belt tensioner for x-axis belts on the Makerfarm Prusa i3v. This is intended to go on the left end of the x-axis rail, just over
// the x-axis stepper motor.

// the screw hole width
mount_screw_diameter = 5.0;
mount_screw_radius = mount_screw_diameter / 2;

// the left side of the mount relative to the screw hole, looking from the left of the printer
mount_left_width = 6;
mount_right_width = 6;

full_rail_width = mount_left_width + mount_screw_diameter + mount_right_width;

mount_height = 15;

wall_thickness = 2;

// z parameters to use in difference calculations. You basically want a bit of slop on either end so
// it doesn't make a super thin "plug"
difference_z_depression = -1;
difference_z_height = wall_thickness + 2;

adjust_track_length = mount_height - (wall_thickness * 2) - (mount_screw_radius * 2);

track_cylinder_x = mount_left_width + mount_screw_radius;

bearing_shaft_diameter = 7.8;
bearing_shaft_radius = bearing_shaft_diameter / 2;
bearing_shaft_length = full_rail_width + 5;
bearing_width = 7;

module track_end_cylinder() {
    cylinder(h = difference_z_height, r = mount_screw_radius);
}

// the mount on the end of the rail
difference() {
  cube([full_rail_width, mount_height, wall_thickness]);

  translate([track_cylinder_x, wall_thickness + mount_screw_radius, difference_z_depression])
    track_end_cylinder();

  translate([mount_left_width, wall_thickness + mount_screw_radius, difference_z_depression])
     cube([mount_screw_diameter, adjust_track_length - mount_screw_radius, difference_z_height]);

  translate([track_cylinder_x, mount_height - wall_thickness - mount_screw_diameter, difference_z_depression])
    track_end_cylinder();
}

// a support for the bearing shaft
full_bearing_radius = 11;
translate([mount_left_width,0,wall_thickness]) {
  cube([(full_rail_width- mount_left_width - bearing_width), full_rail_width - mount_left_width - bearing_width, full_bearing_radius + bearing_shaft_radius]);
}

// the cylinder to hold the bearing
translate([mount_left_width, bearing_shaft_radius - .4, full_bearing_radius + bearing_shaft_radius]) {
  rotate([0,90,0]) {
    cylinder(h=bearing_shaft_length, r = bearing_shaft_radius);
  }
}


