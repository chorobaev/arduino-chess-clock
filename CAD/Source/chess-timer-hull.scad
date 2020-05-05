$fn = 60;

module backTopSides(){
    union() {
        difference(){
            difference() {
                cube([105, 90, 40]);
                translate([-5,0,0])
                rotate(a=53.13010235, v=[1,0,0])
                cube([115, 90, 40]);
            }
            
            translate([3,0,-3])
            difference(){
                cube([99, 87, 40]);
                translate([-5,0,0])
                rotate(a=53.13010235, v=[1,0,0])
                cube([109, 87, 40]);
            }
            
            translate([9, 39, 35])
            cube([87, 42, 10]);
            
            translate([5, 4, 0])
            rotate(a=53.13010235, v=[1,0,0])
            cube([95, 45, 5]);
        }
        translate([47.5,81,35])
        cube([10, 6, 5]);

        translate([52.5,81,35])
        rotate(a=-90, v=[1,0,0])
        cylinder(6, 5, 5, $fn=99);

        translate([47.5,30,35])
        cube([10, 9, 5]);

        translate([52.5,30,35])
        rotate(a=-90, v=[1,0,0])
        cylinder(9, 5, 5, $fn=99);
    }
}
module hole(){
    difference(){
        cylinder(5, 2, 2, $fn=99);
        translate([0,0,-1.5])
        cylinder(5, 1, 1, $fn=99);
    }
}
module front(){
    union() {
        difference(){
            cube([105, 48, 3]);
            translate([31, 9, -1])
            cylinder(5, 2.25, 2.25, $fn=99);
                    
            translate([52.5, 9, -1])
            cylinder(5, 2.25, 2.25, $fn=99);
                    
            translate([74, 9, -1])
            cylinder(5, 2.25, 2.25, $fn=99);
                    
            translate([16.5, 17, -1])
            cube([72, 26 ,5]);
        }
        translate([15, 45.5, -3.5])
        hole();
        translate([15, 14.5, -3.5])
        hole();
        translate([90, 45.5, -3.5])
        hole();
        translate([90, 14.5, -3.5])
        hole();
        translate([15, 9, -3.5])
        hole();
        translate([90, 9, -3.5])
        hole();
    }
}
module hall(){
    union() {
        difference(){
            backTopSides();
            
            translate([50.5,80,35.5])
            cube([4, 7, 5.5]);
            
            translate([52.5,80,35.5])
            rotate(a=-90, v=[1,0,0])
            cylinder(7, 2, 2, $fn=99);
            
            translate([50.5,33,35.5])
            cube([4, 7, 5.5]);
            
            translate([52.5,33,36])
            rotate(a=-90, v=[1,0,0])
            cylinder(7, 2, 2, $fn=99);   
        }
        translate([6, 60, 33])
        hole();
        translate([99, 60, 33])
        hole();
        rotate(a=53.13010235, v=[1,0,0])
        translate([0,2,-3])
        front();
    }
}

hall();