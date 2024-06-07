$fn=100;
a=17;

if($preview){
    translate([-380,0,0])rotate([0,0,-10])mirror([1,0,0])assy();
    translate([380,0,0])rotate([0,0,10])mirror([0,0,0])assy();
}else{
    $fn=300;
    mirror([0,0,0])stand(a);
}

// generate a single stand, mirror to generate the other half
// a = monitor-angle; r = monitor edge radius
module stand(a=0, r=11){
    d=r*2;
    intersection(){
        difference(){
            union(){
                // front-facing arm
                rotate([a,0,0])hull(){
                    rotate([0,90,0])translate([0,0,-20])cylinder(d=d+2,h=24);
                    rotate([0,90,0])translate([0,180,-20])cylinder(d=d,h=24);
                }
                // up-facing arm
                rotate([a,0,0])hull(){
                    rotate([0,90,0])translate([0,0,-20])cylinder(d=d+2,h=24);
                    rotate([0,90,0])translate([-30,0,-20+24/2])cube([21,d+2,24],center=true);
                }
                // foot
                hull(){
                    rotate([a,0,0])rotate([0,90,0])translate([0,180,-20])cylinder(d=d,h=24);
                    rotate([a,0,0])rotate([0,90,0])translate([0,160,-20])cylinder(d=d,h=24);
                    rotate([0,90,0])translate([-2+24/2-0.7,140,-24/2+4])cube([4,14,24],center=true);
                }
            }union(){
                // rest
                rotate([a,0,0])hull(){
                    rotate([0,90,0])translate([0,0,-20])cylinder(d=d-1,h=20);
                    rotate([0,90,0])translate([0,180,-20])cylinder(d=d-1,h=20);
                    rotate([0,90,0])translate([-40,0,-20])cylinder(d=d-1,h=20);
                }
                // foot
                translate([-10,0,-24/2])cube([40,6,1.4],center=true);
            }
        }
        union(){
            // funky stylistic cutoff for the stand, add a # infront to see what it does :3 
            rotate([a,0,0])rotate([0,90,0])translate([-0,-0,-25])scale([6,3.5,1])cylinder(d=100,h=40);
        }
    }
}

/*--------------*/

// my assembly, nubert monitors
module assy(){
    rotate([0,90,0])rotate([0,0,a])translate([-196/2+10,196/2-10,0])monitor();
    translate([326/2,0,0])mirror([0,0,0])stand(a);
    translate([-326/2,0,0])mirror([1,0,0])stand(a);
    // these translations won't scale with the angle
    rotate([180,0,0])translate([326/2,-117,-220])mirror([0,0,0])stand(a);
    rotate([180,0,0])translate([-326/2,-117,-220])mirror([1,0,0])stand(a);
    translate([0,40,232])plate();
}

// top-plate, wood in my case
module plate(){
    color("Sienna")translate([0,0,10/2])cube([334,170,10],center=true);
}

// nubert-monitor
module monitor(){
    translate([0,0,-326/2])difference(){
        union(){
            color("grey")translate([0,0,326/2])minkowski(){
                cube([196-20,196-20,326-0.001],center=true);
                cylinder(d=20,h=0.001);
            }
            color("DimGray")for(i=[-3:2:3]){
                translate([12*i,196/2,30])rotate([-90,0,0])cylinder(d=14,h=20);
            }
                color("black")translate([0,196/2,140])rotate([-90,0,0])cylinder(d=150,h=2);
                color("black")translate([0,196/2,270])rotate([-90,0,0])cylinder(d=100,h=2);
        }union(){
        }
    }
}