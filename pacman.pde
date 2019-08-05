int radius = 20;
int x = 120;
int y =120;
boolean []ghost={true, true, true, true};
int []ghost_x={20, 20, 340, 580};                                  //int(random(2,11)*10)
int []ghost_y={20, 580, 380, 580};                                  //int(random(2,11)*10);
int direction = 0;
int mouth =0;
int []candy_x=new int [87];   //x position
int []candy_y=new int [87];   //y position
boolean big=true;
boolean []candy=new boolean[87]; //not be eaten
int count=0;
//PImage img;
boolean win=false;
boolean lose=false;
PShape EE;

import ddf.minim.*;
Minim minim;         
AudioPlayer player,player2; 



void setup() {
  minim = new Minim(this);
 
  player = minim.loadFile("pacman.mp3");
  player2 = minim.loadFile("Chomp.mp3");
  size(600, 600);
  ellipseMode(RADIUS);
  fill(#FFF412);
  textSize(64);
  //img=loadImage ("Google_Pac-Man_banner.png");
  fill(#0625CE);
  EE=createShape();
  EE.beginShape();
  EE.vertex(40, 40);
  EE.vertex(240, 40);
  EE.vertex(240, 80);
  EE.vertex(80, 80);
  EE.vertex(80, 280);
  EE.vertex(240, 280);
  EE.vertex(240, 320);
  EE.vertex(80, 320);
  EE.vertex(80, 520);
  EE.vertex(240, 520);
  EE.vertex(240, 560);
  EE.vertex(40, 560);
  EE.endShape();
  //---------------set candy
  for (int i=0; i<15; i++)
  {
    candy_x[i]=i*40+20;
    candy_y[i]=20;
    candy[i]=true;
  }
  for (int i=0; i<15; i++)
  {
    candy_x[i+15]=i*40+20;
    candy_y[i+15]=580;
    candy[i+15]=true;
  }
  for (int i=0; i<15; i++)
  {
    candy_x[i+30]=20;
    candy_y[i+30]=i*40+20;
    candy[i+30]=true;
  }
  for (int i=0; i<15; i++)
  {
    candy_x[i+45]=580;
    candy_y[i+45]=i*40+20;
    candy[i+45]=true;
  }
  for (int i=0; i<15; i++)
  {

    candy_x[i+60]=260+(i%3)*40;
    candy_y[i+60]=i*40+20;
    candy[i+60]=true;
  }
  for (int i=0; i<3; i++)
  {

    candy_x[i+75]=100+((i+2)%3)*40;
    candy_y[i+75]=(i+2)*40+20;
    candy[i+75]=true;
  }
  for (int i=0; i<3; i++)
  {

    candy_x[i+78]=460+((i+2)%3)*40;
    candy_y[i+78]=(i+2)*40+20;
    candy[i+78]=true;
  }
  for (int i=0; i<3; i++)
  {

    candy_x[i+84]=100+((i+2)%3)*40;
    candy_y[i+84]=(i+2)*40+260;
    candy[i+84]=true;
  }
  for (int i=0; i<3; i++)
  {

    candy_x[i+81]=460+((i+2)%3)*40;
    candy_y[i+81]=(i+2)*40+260;
    candy[i+81]=true;
  }
}

void draw() {
   player.play();
  
  
  stroke(#0625CE); 


  if (win==false) {
    background(0);
    shape(EE, 0, 0);
    shape(EE, 320, 0);
    fill(#FFF412);
    mouth= abs( (frameCount*3)%90 -30 ) ;

    //image(img,0,0);


    //pacman eat candy
    for (int i=0; i<87; i++) {
      if ((x==candy_x[i])&&(y==candy_y[i])&&candy[i]==true)
      {
        candy[i]=false;
        count++;
      }
      if (candy[i])
      {
        ellipse(candy_x[i], candy_y[i], 5, 5);
      }
    }
    //big 
    if ((x==480)&&(y==480))
    {
      big=false;
    }
    if (big)
    {

      ellipse(480, 480, 10, 10);
    }
    //border handling
    if ((x > width-radius) || (x < radius)) {
      if (direction==0)
      {

        x=width-radius;
      } else if (direction==1)
      {

        x=radius;
      }
    }

    if ((y>height-radius)||(y<radius)) {

      if (direction==2)
      {
        direction=3;// Flip direction
        y=radius;
      } else if (direction==3)
      {
        direction=2;
        y=height-radius;
      }
    }





    // -------------------------------show Pacman-------------------------------
    if (direction == 0) {
      arc(x, y, radius, radius, radians(45-mouth), radians(315+mouth)); // Face right
    } else if (direction==1) {
      arc(x, y, radius, radius, radians(225-mouth), radians(495+mouth)); // Face left
    } else if (direction==2)
    {
      arc(x, y, radius, radius, radians(315-mouth), radians(585+mouth)); // Face top
    } else if (direction==3)
    {
      arc(x, y, radius, radius, radians(135-mouth), radians(405+mouth)); // Face down
    }
    //------------ghost------------------------------------------------------------------------------

    //ghost move 
    for (int number=0; number<4; number++) {
      if (ghost_x[number]<x) {

        if (ghost_y[number]==20||ghost_y[number]==580||(ghost_x[number]>=260&&ghost_x[number]<340)||(ghost_y[number]>=100&&ghost_y[number]<=260&&ghost_x[number]>=100&&ghost_x[number]<260)||(ghost_y[number]>=100&&ghost_y[number]<=260&&ghost_x[number]>=420&&ghost_x[number]<580)||(ghost_y[number]>=340&&ghost_y[number]<=500&&ghost_x[number]>=100&&ghost_x[number]<260)||(ghost_y[number]>=340&&ghost_y[number]<=500&&ghost_x[number]>=420&&ghost_x[number]<580))
          ghost_x[number]+=1;
      }
      if (ghost_x[number]>x) {

        if (ghost_y[number]==20||ghost_y[number]==580||(ghost_x[number]>260&&ghost_x[number]<=340)||(ghost_y[number]>=100&&ghost_y[number]<=260&&ghost_x[number]>100&&ghost_x[number]<=260)||(ghost_y[number]>=100&&ghost_y[number]<=260&&ghost_x[number]>420&&ghost_x[number]<=580)||(ghost_y[number]>=340&&ghost_y[number]<=500&&ghost_x[number]>100&&ghost_x[number]<=260)||(ghost_y[number]>=340&&ghost_y[number]<=500&&ghost_x[number]>420&&ghost_x[number]<=580))
          ghost_x[number]-=1;
      }
      if (ghost_y[number]<y) {
        if (ghost_x[number]==20||ghost_x[number]==580||(ghost_x[number]>=260&&ghost_x[number]<=340)||(ghost_y[number]>=100&&ghost_y[number]<260&&ghost_x[number]>=100&&ghost_x[number]<=260)||(ghost_y[number]>=100&&ghost_y[number]<260&&ghost_x[number]>=420&&ghost_x[number]<=580)||(ghost_y[number]>=340&&ghost_y[number]<500&&ghost_x[number]>=100&&ghost_x[number]<=260)||(ghost_y[number]>=340&&ghost_y[number]<500&&ghost_x[number]>=420&&ghost_x[number]<=580))
          ghost_y[number]+=1;
      }
      if (ghost_y[number]>y) {
        if (ghost_x[number]==20||ghost_x[number]==580||(ghost_x[number]>=260&&ghost_x[number]<=340)||(ghost_y[number]>100&&ghost_y[number]<=260&&ghost_x[number]>=100&&ghost_x[number]<=260)||(ghost_y[number]>100&&ghost_y[number]<=260&&ghost_x[number]>=420&&ghost_x[number]<=580)||(ghost_y[number]>340&&ghost_y[number]<=500&&ghost_x[number]>=100&&ghost_x[number]<=260)||(ghost_y[number]>340&&ghost_y[number]<=500&&ghost_x[number]>=420&&ghost_x[number]<=580))
          ghost_y[number]-=1;
      }
    }
    //show ghost
    if (ghost[0]==true) {
      fill(#AAAAA3);
      arc(ghost_x[0], ghost_y[0], radius, radius, radians(100), radians(440));
    }
    if (ghost[1]==true) {
      fill(#1AEAE9);
      arc(ghost_x[1], ghost_y[1], radius, radius, radians(100), radians(440));
    }
    if (ghost[2]==true) {
      fill(#056C6B);
      arc(ghost_x[2], ghost_y[2], radius, radius, radians(100), radians(440));
    }
    if (ghost[3]==true) {
      fill(#F03A16);
      arc(ghost_x[3], ghost_y[3], radius, radius, radians(100), radians(440));
    }
    fill(255);
    if (ghost[0]==true) {
      ellipse(ghost_x[0]-8, ghost_y[0]-8, 5, 5);
      ellipse(ghost_x[0]+8, ghost_y[0]-8, 5, 5);
    }
    if (ghost[1]==true) {
      ellipse(ghost_x[1]-8, ghost_y[1]-8, 5, 5);
      ellipse(ghost_x[1]+8, ghost_y[1]-8, 5, 5);
    }
    if (ghost[2]==true) {
      ellipse(ghost_x[2]-8, ghost_y[2]-8, 5, 5);
      ellipse(ghost_x[2]+8, ghost_y[2]-8, 5, 5);
    }
    if (ghost[3]==true) {
      ellipse(ghost_x[3]-8, ghost_y[3]-8, 5, 5);
      ellipse(ghost_x[3]+8, ghost_y[3]-8, 5, 5);
    }
    fill(0);
    //ghost eye
    if (ghost[0]==true) {
      ellipse(ghost_x[0]-8, ghost_y[0]-8, 2, 2);
      ellipse(ghost_x[0]+8, ghost_y[0]-8, 2, 2);
    }
    fill(#1B3BE3);
    if (ghost[1]==true) {
      ellipse(ghost_x[1]-8, ghost_y[1]-8, 2, 2);
      ellipse(ghost_x[1]+8, ghost_y[1]-8, 2, 2);
    }
    fill(#BF13A0);
    if (ghost[2]==true) {
      ellipse(ghost_x[2]-8, ghost_y[2]-8, 2, 2);
      ellipse(ghost_x[2]+8, ghost_y[2]-8, 2, 2);
    }
    fill(#4AEA1A);
    if (ghost[3]==true) {
      ellipse(ghost_x[3]-8, ghost_y[3]-8, 2, 2);
      ellipse(ghost_x[3]+8, ghost_y[3]-8, 2, 2);
    }
    //normal
    if (dist(x, y, ghost_x[0], ghost_y[0])<=radius*2&&big==true) {
      fill(255);
      lose=true;
    }
    if (dist(x, y, ghost_x[1], ghost_y[1])<=radius*2&&big==true) {
      fill(255);
      lose=true;
    }
    if (dist(x, y, ghost_x[2], ghost_y[2])<=radius*2&&big==true) {
      fill(255);
      lose=true;
    }
    if (dist(x, y, ghost_x[3], ghost_y[3])<=radius*2&&big==true) {
      fill(255);
      lose=true;
    }

    //big

    if (dist(x, y, ghost_x[0], ghost_y[0])<=radius*2&&big==false) {

      ghost[0]=false;
    }
    if (dist(x, y, ghost_x[1], ghost_y[1])<=radius*2&&big==false) {
      ghost[1]=false;
    }
    if (dist(x, y, ghost_x[2], ghost_y[2])<=radius*2&&big==false) {
      ghost[2]=false;
    }
    if (dist(x, y, ghost_x[3], ghost_y[3])<=radius*2&&big==false) {
      ghost[3]=false;
    }





    //win or lose-------------------------------------
    if (count==87)
    {
      win=true;
    }
  } else {
    noLoop();
    fill(255);
    text("YOU WIN", width/2, height/2);
  }


  if (lose) {
    player2.pause();
     player = minim.loadFile("Death.mp3");
     player.play();
     delay(500);
    noLoop();
    text("GAME OVER", width/4, height/2);
  }
}



void keyPressed() {
  if (keyCode==RIGHT) {
    direction=0;
    if (y==20||y==580||(x>=260&&x<340)||(y>=100&&y<=260&&x>=100&&x<260)||(y>=100&&y<=260&&x>=420&&x<580)||(y>=340&&y<=500&&x>=100&&x<260)||(y>=340&&y<=500&&x>=420&&x<580))
      x+=10;
  }
  if (keyCode==LEFT) {
    direction=1;
    if (y==20||y==580||(x>260&&x<=340)||(y>=100&&y<=260&&x>100&&x<=260)||(y>=100&&y<=260&&x>420&&x<=580)||(y>=340&&y<=500&&x>100&&x<=260)||(y>=340&&y<=500&&x>420&&x<=580))
      x-=10;
  }
  if (keyCode==UP) {
    direction=2;
    if (x==20||x==580||(x>=260&&x<=340)||(y>100&&y<=260&&x>=100&&x<=260)||(y>100&&y<=260&&x>=420&&x<=580)||(y>340&&y<=500&&x>=100&&x<=260)||(y>340&&y<=500&&x>=420&&x<=580))
      y-=10;
  }
  if (keyCode==DOWN) {
    direction=3;
    if (x==20||x==580||(x>=260&&x<=340)||(y>=100&&y<260&&x>=100&&x<=260)||(y>=100&&y<260&&x>=420&&x<=580)||(y>=340&&y<500&&x>=100&&x<=260)||(y>=340&&y<500&&x>=420&&x<=580))
      y+=10;
  }
  
  
  
  if(player2.isPlaying()==false)
  player2.rewind();
    
  player2.play();
 
  
}
