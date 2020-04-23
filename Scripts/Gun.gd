extends Sprite

func _process(_delta):
	var target = get_global_mouse_position()
	var gun = self.global_position
	look_at(target)
	
	if gun.x > target.x:
		$".".flip_v = true
	else:
		$".".flip_v = false
