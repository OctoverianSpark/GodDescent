extends Node

const DASH_PARTICLES = preload("res://scenes/particles/dash_particles.tscn")


func create_particle(vfx_name,pos):
	var particle
	match vfx_name:
		"dash":
			particle = DASH_PARTICLES
			
	var new_particle = particle.instantiate()
	new_particle.one_shot = true
	new_particle.position = pos
	get_tree().current_scene.add_child(new_particle)
	await get_tree().create_timer(1).timeout
	destroy_particle(new_particle)
	

func destroy_particle(particle):
	particle.queue_free()
	
