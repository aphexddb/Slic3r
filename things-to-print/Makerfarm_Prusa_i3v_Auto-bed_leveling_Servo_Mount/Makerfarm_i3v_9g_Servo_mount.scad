// Mount for a servo for autoleveling on the Makerfarm Prusa i3v:
// Original by Zennmaster
// Updated for i3v by VoltaicLoki

// added nut cutouts for the back side
// added a chord tie for the servo cord
// added a nut trap for fitting with the i3v
// moved the back tab to make it alight with i3v
// change the size of various parts to make them fit more snugly with the i3v

// add cutouts for the m2.5 nuts
nut_cutouts = true;
// add the cable holder
cord_tie = true;

servo_width=23;  // Width of cutout for servo.
servo_height=12.5; // Height of cutout for servo. 
servo_bolt_size=3; // Diameter of bolt shaft


difference() {
rotate([90,0,0]) // Lay it down for printing:
union(){
difference(){

	mainblock();
	translate([6,0,1]) servo_hole();
	translate([-22,0,3.7])	nut_trap();
}
}
	// nut cut outs
	if (nut_cutouts == true){
		translate([-11.5,-4.5,4.18]) screw_hole(); //z=4.175
		translate([16.5,-4.5,4.18]) screw_hole(); //z=4.175
	}
}
	

module mainblock() { //Set up the "blank" part:
  difference() {
    block();
    rotate([90,0,0])
    translate([-5,17.25,0])
      cylinder (h=10,r=2, $fn=30, center = true);
    translate([28,0,-12])
    rotate([0,-17,0])
      cube([50,15,10],true);
  }
}
module block(){
	// Top tab:
	translate([-5,0,17.25]) cube ([19.75,6.35,6.5], true);
	// Cord Tie
	if (cord_tie == true) {
		difference() {
			translate([24.25,0,15.25]) cube([6.5,6.35,5.5], true);
			translate([24.25,0,15.25]) cube([4,6.35,3], true);
			translate([27.25,0,14.75]) cube([2,6.35,1.75], true);	
		}
	}
	// Main body:
	cube([55,6.35,28.5], true);
	// Back tab:
	translate([-30.25,0,-4.2]) cube([6,6.35,5.75], true);
}

module servo_hole(){ // Make the opening for the servo.  Adjust the variables above to fit your part.
cube([servo_width,10,servo_height], true);
translate([servo_width/2 + servo_bolt_size/2 +1,0,0])
rotate([90,0,0])
cylinder (h=10,r=servo_bolt_size/2, $fn=30, center = true);
translate([-servo_width/2 - servo_bolt_size/2-1,0,0])
rotate([90,0,0])
cylinder (h=10,r=servo_bolt_size/2, $fn=30, center = true);
}

module nut_trap(){
		rotate([90,0,0]) cube([11.5,3.25,6.5], true);
		rotate([90,0,0]) translate([3.25,0,0]) cube([3,5.75,6.5], true);
}

module screw_hole() {
// File: 3d_print_screw_hole_test.scad
// Author: Mark Heywood alias Airtripper
// Airtripper Extruder Filament Force Sensor Bracket
// by Airtripper May 2013
// Copyright � 2013 Airtripper
// http://www.airtripper.com
// Licensed Attribution-NonCommercial-ShareAlike 3.0 Unported. 
// Last edit: 26/09/2013

/* [Global] */
//  - Select part to view/print from list
view_part = 0;	// [0:design, 1:head_up, 2:head_down, 3:horizontal]

//  - Screw head diameter - flat side to flat side on hex nut or bolt head
head = 5;		
//  - Screw head type - [6] for hex head and [50] or more for round head
type = 6;			
//  - Screw size diameter
size = 2.5;		
//  - Screw size diameter smoothness
smoothness = 50;	
//  - Screw size length - not including screw head
length = 0;			
//  - Screw head length
cap = 2;			
//  - Block border thickness between screw head and block edge
border = 1;			
//  - Print layer thickness - only required for head down print
layer = 0.25;	

    	translate([border+(head/2),border+(head/2),-1-layer]) cylinder(length+1, r=size/2, $fn=smoothness, center=true);	// screw size
		translate([border+(head/2),border+(head/2),length]) cylinder(cap+1, r=head/2, $fn=type, center=true);	// screw head/cap
		translate([border+(head/2),border+(head/2),length+cap-4]) color("red") cylinder(2, r1=(head/2)/cos(180/type), r2=((head/2)+.5)/cos(180/type), $fn=type, center=true); // screw head/cap taper

}
