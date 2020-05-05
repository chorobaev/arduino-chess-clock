$fn = 60;

module switch(){
    union() {
        cube([42.5, 41, 6]);
        translate([43, 0, 0])
        rotate(a=-8, v=[0,1,0])
        cube([42.5, 41, 6]);
        translate([42.5, 46, 1.5])
        rotate(a=90, v=[1,0,0])
        cylinder(51, 1.5, 1.5, $fn=99);
    }
}

switch();