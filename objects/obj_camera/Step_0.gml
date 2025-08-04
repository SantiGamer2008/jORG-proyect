if instance_exists(obj_testingCamera) exit

// Si no existe el jugador, no se ejecuta
if !instance_exists(obj_player) exit;

// Tamaño de la cámara
var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

// SOLO si no está en transición, calculamos la pantalla objetivo
if (!transitioning) {
    var screenX = floor(obj_player.x div _camWidth);
    var screenY = floor(obj_player.y div _camHeight);

    target_camX = clamp(screenX * _camWidth, 0, room_width - _camWidth);
    target_camY = clamp(screenY * _camHeight, 0, room_height - _camHeight);

    // Si el objetivo es distinto a la posición actual → iniciar transición
    if (target_camX != camera_get_view_x(view_camera[0]) ||
        target_camY != camera_get_view_y(view_camera[0])) {
        transitioning = true;
        obj_player.canMove = false; // Bloqueamos al jugador (NECESITAS esta variable en el player)
    }
}

// Si está en transición, movemos suavemente la cámara
if (transitioning) {
    var currentX = camera_get_view_x(view_camera[0]);
    var currentY = camera_get_view_y(view_camera[0]);

    var newX = lerp(currentX, target_camX, transition_speed);
    var newY = lerp(currentY, target_camY, transition_speed);

    camera_set_view_pos(view_camera[0], newX, newY);

    // Si ya llegó al objetivo, desbloqueamos al jugador
    if (point_distance(newX, newY, target_camX, target_camY) < 1) {
        camera_set_view_pos(view_camera[0], target_camX, target_camY);
        transitioning = false;
        obj_player.canMove = true;
    }
}
