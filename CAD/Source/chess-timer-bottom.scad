$fn=60;

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
bottomWithFeet();