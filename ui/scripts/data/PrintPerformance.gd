extends Label


func _process(_delta):
	if not OS.is_debug_build():
		self.text = ""
		return

	var cpu_time = Performance.get_monitor(Performance.TIME_PROCESS)
	var gpu_time = Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS)
	var mem_used = Performance.get_monitor(Performance.MEMORY_STATIC)
	var fps = Performance.get_monitor(Performance.TIME_FPS)

	self.text = (
		"CPU: %sms     GPU: %sms     MEM: %sMB     FPS: %s"
		% [
			snapped(cpu_time * 1000, 0.01),
			snapped(gpu_time * 1000, 0.01),
			snapped(mem_used / 1048576, 0.01),
			fps
		]
	)
