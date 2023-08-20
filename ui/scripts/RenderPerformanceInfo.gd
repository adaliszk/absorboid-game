extends Label


func _process(_delta):
	var cpu_time = Performance.get_monitor(Performance.TIME_PROCESS)
	var gpu_time = Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS)
	var mem_used = Performance.get_monitor(Performance.MEMORY_STATIC)
	var fps = Performance.get_monitor(Performance.TIME_FPS)

	var mem_snapped = snapped(mem_used / 1048576, 0.01)
	var mem_unit = "MB"
	if mem_snapped <= 1.0:
		mem_snapped = snapped(mem_used / 1024, 0.01)
		mem_unit = "kB"

	self.text = (
		"CPU: %sms   GPU: %sms   MEM: %s%s   FPS: %s"
		% [
			snapped(cpu_time * 1000, 0.01),
			snapped(gpu_time * 1000, 0.01),
			mem_snapped,
			mem_unit,
			fps
		]
	)
