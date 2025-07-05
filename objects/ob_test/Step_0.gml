var xDirection = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var jump = keyboard_check_pressed(vk_space);
var onTheGround = place_meeting(x, y + 1, obj_wall);
var onAWall = place_meeting(x-5, y, obj_wall) - place_meeting(x+5, y, obj_wall);
 
mvtLocked = max(mvtLocked - 1, 0);
 
if (onAWall != 0) ySpeed = min(ySpeed + 1, 5);
else ySpeed++;
 
if (mvtLocked <= 0) {
    if (xDirection != 0) image_xscale = xDirection;
    xSpeed = xDirection * spd;
 
    if (jump) {
        if (onTheGround) {
            ySpeed = -20;
        } 
    
        if (onAWall != 0) {
            ySpeed = -20;
            xSpeed = onAWall * spd;
            mvtLocked = 10;
        }
    }
}

if (place_meeting(x + xSpeed, y, obj_wall)) { 
    
    while (!place_meeting(x + sign(xSpeed), y, obj_wall)) {
        x += sign(xSpeed);
    }
    xSpeed = 0; 
}
 
x += xSpeed;
 
 
if (place_meeting(x, y + ySpeed, obj_wall)) { 
    
    while (!place_meeting(x, y + sign(ySpeed), obj_wall)) {
        y += sign(ySpeed);
    }
    
    ySpeed = 0; 
}
 
y += ySpeed;