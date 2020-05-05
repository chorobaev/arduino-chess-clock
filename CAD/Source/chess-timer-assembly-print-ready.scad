$fn = 60;

// Hull
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
module hull(){
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

// Bottom
module cut(){
    points = [ 
    [3,87,3],
    [102,87,3],
    [3,87,6],
    [102,87,6],
    [3,84.75,6],
    [102,84.75,6]];
    faces = [
    [0,1,2],
    [2,1,3],
    [0,4,1],
    [1,4,5],
    [2,3,4],
    [3,5,4],
    [0,2,4],
    [1,5,3]];
    polyhedron(points,faces);
}

module bottom() {
    union() {
        difference(){
            union(){
                translate([3,3,0])
                cube([105-6,90-6.25,3]);
                translate([26-3,15-3,0])
                cube([57,33,19+3]);
            }
            translate([26,15,0])
            cube([51,27,19]);
            translate([26+51-12,42+10,0])
            cube([12,5,3]);
            translate([26-3,15+2,3])
            cube([3,27-4,19-3-2]);
            translate([10,10,0])
            cylinder(3,d=2,true);
            translate([105-10,10,0])
            cylinder(3,d=2,true);
            translate([10,90-10,0])
            cylinder(3,d=2,true);
            translate([105-10,90-10,0])
            cylinder(3,d=2,true);
            translate([0, 0, -3])
            cut();
        }
    }
}

module foot(x,y){
    h = 3;
    outR = 5;
    inR = 2;
    translate([x,y,0])
    difference(){
        cylinder(h,r=outR,true);
        cylinder(h,r=inR,true);
    }
}

module bottomWithFeet() {
    union() {
        translate([0,0,3])
        bottom();
        foot(10,10);
        foot(105-10,10);
        foot(10,90-10);
        foot(105-10,90-10);
    }
}

hull();
translate([-10, 10, 0])
rotate([0, 0, 90])
switch();
translate([105, 185, 0])
rotate([0, 0, 180])
bottomWithFeet();