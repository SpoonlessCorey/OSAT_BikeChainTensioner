mntLength = 70;
mntDepth = 14;
mntWidth = 26;
chainClr = 5;
rollerDia = 20;
boltDia = 4.75;
chamfer = 2;
pipeDia = 20;


rotate([0,270,0])
difference(){

  //main geometry
  linear_extrude(height = mntWidth){
    polygon([

      [0,0],
      [0,mntLength],
      [mntDepth,mntLength],
      [mntDepth+chainClr+rollerDia*1.6,mntLength*.65],
      [mntDepth+chainClr+rollerDia*1.6,mntLength*.35],
      [mntDepth,0],
      [0,0]

    ]);
  }

  //Chain path cut-away

  translate([mntDepth+chamfer,0,mntWidth*.2+chamfer])
    rotate([270,0,0])
      cylinder(h = mntLength, r=chamfer, $fn=30);

  translate([mntDepth+chamfer,0,mntWidth*.8-chamfer])
    rotate([270,0,0])
      cylinder(h = mntLength, r=chamfer, $fn=30);

  translate([mntDepth+chamfer,0,mntWidth*.2])
    cube([chainClr+rollerDia*2-chamfer,
          mntLength,
          mntWidth*.6]);

  translate([mntDepth,0,mntWidth*.2+chamfer])
    cube([chainClr+rollerDia*1.51,
          mntLength,
          mntWidth*.6-chamfer*2]);

  //bolt hole
  translate([mntDepth+chainClr+rollerDia,mntLength/2,-.01])
    cylinder(h = mntWidth+.02, r=boltDia/2, $fn=30);
  
  //pipe cutaway
  translate([0,-.01,mntWidth/2])
    rotate([270,0,0])
      cylinder(h = mntLength+.02, r=pipeDia/2, $fn=30);

  //ziptie holes
  ziptiehole(mntDepth-4,mntLength*.15,mntWidth-4);
  ziptiehole(mntDepth-4,mntLength*.85-7,mntWidth-4);
  mirror([0,0,1])ziptiehole(mntDepth-4,mntLength*.15,-4);
  mirror([0,0,1])ziptiehole(mntDepth-4,mntLength*.85-7,-4);

}



//Roller
//rotate([0,270,0])translate([mntDepth+chainClr+rollerDia,mntLength/2,mntWidth*.2+1])//test in place
translate([rollerDia,mntLength/2,0])//print location

difference(){
  cylinder(h = mntWidth*.6-2, r=rollerDia*.75, $fn=30);

  translate([0, 0, (mntWidth*.6-2)/2])
    rotate_extrude(convexity = 30)
      translate([rollerDia*.9, 0, 0])
        circle(r = rollerDia*.3, $fn = 30);

  //bolt hole
    cylinder(h = mntWidth+.02, r=boltDia/2, $fn=30);

}


module ziptiehole(posX,posY,posZ){
  translate([posX,posY,posZ])
    rotate([270,0,0])
      union(){

        translate([4,-0.1,0])
          cube([4,10,7]);
        
        difference(){
          cylinder(h = 7, r=8, $fn=30);

          translate([0,0,-0.01])
            cylinder(h = 7.02, r=4, $fn=30);      
          translate([-10,0,-0.01])
            cube([20,10,10.2]);
          translate([-10,-10,-0.01])
            cube([10,20,10.2]);
        }
      }

}
