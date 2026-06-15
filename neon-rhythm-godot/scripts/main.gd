extends Node3D

const LANES := [-2.8, 0.0, 2.8]
const LANE_KEYS := ["lane_left", "lane_middle", "lane_right"]
const LANE_NAMES := ["A", "S", "D"]
const COLORS := [
	Color(0.08, 0.84, 0.28),
	Color(1.00, 0.86, 0.02),
	Color(0.10, 0.54, 0.96)
]

const BPM := 132.0
const BEAT := 60.0 / BPM
const HOLD_KEY := "hold_space"
const SPAWN_Z := -42.0
const HIT_Z := 5.0
const DESPAWN_Z := 8.0
const TRAVEL_TIME := 2.0
const PERFECT_WINDOW := 0.055
const GREAT_WINDOW := 0.105
const GOOD_WINDOW := 0.170
const CHART_PATH := "res://charts/demo_chart.json"
const RECORDED_CHART_PATH := "res://charts/recorded_chart.json"
const GENERATED_CHART_PATH := "res://charts/generated_chart.json"
const MUSIC_PATH := "res://assets/music/Sugar_Rush_Combo.mp3"
const CHARACTER_PATH := "res://assets/characters/luma_music_ship_graffiti_v2.png"
const PIXEL_CHARACTER_PATH := "res://assets/characters/luma_pixel_ship_low_v1.png"
const PLAYER_SHADOW_PATH := "res://assets/characters/luma_music_ship_graffiti_print_shadow_v1.png"
const PIXEL_PLAYER_SHADOW_PATH := "res://assets/characters/luma_pixel_ship_print_shadow_v1.png"
const NOTE_TAP_PATH := "res://assets/notes/note_tap_v1.png"
const NOTE_HEAVY_PATH := "res://assets/notes/note_heavy_v1.png"
const NOTE_AIR_PATH := "res://assets/notes/note_air_v2.png"
const NOTE_HOLD_HEAD_PATH := "res://assets/notes/note_hold_head_v1.png"
const NOTE_HOLD_RAIL_PATH := "res://assets/notes/note_hold_rail_v1.png"
const NOTE_JUDGELINE_PATH := "res://assets/notes/note_judgeline_v1.png"
const NOTE_TAP_SHADOW_PATH := "res://assets/notes/note_tap_shadow_v1.png"
const NOTE_HEAVY_SHADOW_PATH := "res://assets/notes/note_heavy_shadow_v1.png"
const NOTE_AIR_SHADOW_PATH := "res://assets/notes/note_air_shadow_v2.png"
const NOTE_HOLD_HEAD_SHADOW_PATH := "res://assets/notes/note_hold_head_shadow_v1.png"
const NOTE_HOLD_RAIL_SHADOW_PATH := "res://assets/notes/note_hold_rail_shadow_v1.png"
const NOTE_JUDGELINE_SHADOW_PATH := "res://assets/notes/note_judgeline_shadow_v1.png"
const BACKDROP_TEXTURE_PATH := "res://assets/backgrounds/pop_collage_bg_v1.png"
const TORN_GATEWAY_PATH := "res://assets/backgrounds/torn_track_gateway_frame_v2.png"
const TORN_GATEWAY_TUNNEL_PATH := "res://assets/backgrounds/torn_gateway_tunnel_v1.png"
const PERFORMANCE_STAGE_PATH := "res://assets/backgrounds/performance_stage_collage_v1.png"
const LANE_DECAL_BASE_PATHS := [
	{
		"near": "res://assets/backgrounds/lane_decals_segmented/lane_green_base_near_v3.png",
		"mid": "res://assets/backgrounds/lane_decals_segmented/lane_green_base_mid_v3.png",
		"far": "res://assets/backgrounds/lane_decals_segmented/lane_green_base_far_v3.png"
	},
	{
		"near": "res://assets/backgrounds/lane_decals_segmented/lane_yellow_base_near_v3.png",
		"mid": "res://assets/backgrounds/lane_decals_segmented/lane_yellow_base_mid_v3.png",
		"far": "res://assets/backgrounds/lane_decals_segmented/lane_yellow_base_far_v3.png"
	},
	{
		"near": "res://assets/backgrounds/lane_decals_segmented/lane_blue_base_near_v3.png",
		"mid": "res://assets/backgrounds/lane_decals_segmented/lane_blue_base_mid_v3.png",
		"far": "res://assets/backgrounds/lane_decals_segmented/lane_blue_base_far_v3.png"
	}
]
const LANE_DECAL_DROP_PATHS := [
	{
		"near": "res://assets/backgrounds/lane_decals_segmented/lane_green_drop_near_v3.png",
		"mid": "res://assets/backgrounds/lane_decals_segmented/lane_green_drop_mid_v3.png",
		"far": "res://assets/backgrounds/lane_decals_segmented/lane_green_drop_far_v3.png"
	},
	{
		"near": "res://assets/backgrounds/lane_decals_segmented/lane_yellow_drop_near_v3.png",
		"mid": "res://assets/backgrounds/lane_decals_segmented/lane_yellow_drop_mid_v3.png",
		"far": "res://assets/backgrounds/lane_decals_segmented/lane_yellow_drop_far_v3.png"
	},
	{
		"near": "res://assets/backgrounds/lane_decals_segmented/lane_blue_drop_near_v3.png",
		"mid": "res://assets/backgrounds/lane_decals_segmented/lane_blue_drop_mid_v3.png",
		"far": "res://assets/backgrounds/lane_decals_segmented/lane_blue_drop_far_v3.png"
	}
]
const LANE_DECAL_SEGMENTS := {
	"near": Vector2(-8.0, 5.3),
	"mid": Vector2(-25.0, -7.6),
	"far": Vector2(-43.2, -24.6)
}
const LANE_DECAL_SEGMENT_ORDER := ["near", "mid", "far"]
const JUDGEMENT_BADGE_PATHS := {
	"perfect": "res://assets/ui/judgement/badge_perfect_v1.png",
	"great": "res://assets/ui/judgement/badge_great_v1.png",
	"good": "res://assets/ui/judgement/badge_good_v1.png",
	"miss": "res://assets/ui/judgement/badge_miss_v1.png",
	"hold": "res://assets/ui/judgement/badge_hold_v1.png",
	"stage": "res://assets/ui/judgement/badge_stage_v1.png"
}
const DROP_TIME := 44.5
const EVOLUTION_TIME := DROP_TIME
const BACKGROUND_COLOR := Color(0.96, 0.92, 0.82)
const LANE_BASE_EMISSION := 0.10

@export_group("Torn Gateway")
@export var torn_gateway_position := Vector3(0.05, 1.82, -43.6)
@export_range(0.001, 0.040, 0.0001) var torn_gateway_pixel_size := 0.0210
@export var torn_tunnel_offset := Vector3(0.0, -0.04, -0.08)
@export_range(0.001, 0.030, 0.0001) var torn_tunnel_pixel_size := 0.0120
@export_range(0.0, 0.20, 0.005) var torn_tunnel_breathe := 0.035
@export_range(0.0, 8.0, 0.1) var torn_tunnel_rotation_degrees := 1.6

@export_group("Lane Decals")
@export_range(0.05, 1.0, 0.01) var lane_decal_alpha := 0.82
@export_range(0.05, 1.0, 0.01) var lane_drop_decal_alpha := 0.94
@export_range(1.40, 1.70, 0.01) var lane_decal_width := 1.62
@export_range(0.05, 0.50, 0.005) var lane_decal_height := 0.205
@export var enable_drop_lane_decals := true

@export_group("Stage Judgement")
@export var stage_judgement_position := Vector2(800.0, 148.0)
@export_range(0.5, 1.8, 0.05) var stage_judgement_scale := 1.0
@export_range(0.0, 0.8, 0.05) var stage_judgement_animation_strength := 0.35

@export_group("Action Judgement")
@export_range(0.0, 160.0, 1.0) var action_judgement_right_margin := 32.0
@export_range(0.0, 700.0, 1.0) var action_judgement_top := 178.0
@export_range(0.35, 1.2, 0.01) var action_judgement_scale := 0.62
@export_range(0.0, 0.8, 0.05) var action_judgement_animation_strength := 0.28

var song_time := 0.0
var running := false
var chart: Array[Dictionary] = []
var active_notes: Array[Dictionary] = []
var next_note_index := 0
var score := 0
var combo := 0
var life := 100.0
var best := 0
var song_length := 38.0
var chart_title := "Candy Galaxy Demo"
var chart_bpm := BPM
var chart_source_bpm := BPM
var chart_offset := 0.0
var music_loop_length := 0.0
var music_loop_base_time := 0.0
var metronome_enabled := false
var next_metronome_beat := 0
var beat_taps: Array[float] = []
var suggested_bpm := 0.0
var recording_mode := false
var chart_playback_enabled := true
var recorded_notes: Array[Dictionary] = []
var generator_density := 1
var drop_mode := false
var pending_lane_inputs: Array[int] = []
var pending_hold_input := false

var score_label: Label
var combo_label: Label
var status_label: Label
var judge_label: Label
var debug_label: Label
var life_bar: ColorRect
var camera: Camera3D
var camera_base_position := Vector3.ZERO
var camera_shake_time := 0.0
var camera_shake_strength := 0.0
var scoreboard_panel: Node3D
var score_3d_label: Label3D
var combo_3d_label: Label3D
var status_3d_label: Label3D
var debug_3d_label: Label3D
var life_3d_bar: MeshInstance3D
var player: Node3D
var player_sprite: Sprite3D
var pixel_player_sprite: Sprite3D
var player_shadow_sprite: Sprite3D
var pixel_player_shadow_sprite: Sprite3D
var player_evolved := false
var performance_panel: Node3D
var background_pattern_groups: Array[Node3D] = []
var drop_lane_fx: Array[Node3D] = []
var lane_base_decals: Array[MeshInstance3D] = []
var lane_drop_decals: Array[MeshInstance3D] = []
var impact_texture_cache: Dictionary = {}
var torn_gateway_frame: Sprite3D
var torn_gateway_tunnel: Sprite3D
var judgement_badge: Control
var judgement_badge_texture: TextureRect
var judgement_badge_text: Label
var judgement_badge_tween: Tween
var hit_line: MeshInstance3D
var judge_marker: Node3D
var judge_marker_lane := 1
var judge_marker_pop_time := 0.0
var music_player: AudioStreamPlayer
var metronome_player: AudioStreamPlayer
var hit_player: AudioStreamPlayer

func _ready() -> void:
	_setup_preview_window()
	_prime_impact_textures()
	best = int(ProjectSettings.get_setting("application/config/best_score", 0))
	_build_world()
	_build_ui()
	_build_audio()
	_load_chart()
	_start_song()


func _exit_tree() -> void:
	if music_player:
		music_player.stop()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		_start_song()

	if not running:
		pending_lane_inputs.clear()
		pending_hold_input = false
		return

	_update_song_time(delta)
	_update_drop_mode()
	_update_evolution()
	_update_metronome()
	_handle_input()
	_update_judge_marker(delta)
	_spawn_due_notes()
	_update_notes()
	_update_torn_gateway(delta)
	_update_camera(delta)
	_update_performance_panel(delta)
	_update_pattern_background(delta)
	_update_scoreboard_3d(delta)
	_update_ui()

	if song_time > song_length and recording_mode:
		_stop_recording()
	elif life <= 0.0 or song_time > song_length:
		_finish_song()


func _update_song_time(delta: float) -> void:
	if music_player and music_player.playing:
		var precise_time := music_player.get_playback_position()
		precise_time += AudioServer.get_time_since_last_mix()
		precise_time -= AudioServer.get_output_latency()
		song_time = max(0.0, music_loop_base_time + precise_time)
	else:
		song_time += delta


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return
	var key_event := event as InputEventKey
	if not key_event.pressed or key_event.echo:
		return

	var physical := key_event.physical_keycode
	if physical == KEY_A or key_event.keycode == KEY_A:
		pending_lane_inputs.append(0)
		get_viewport().set_input_as_handled()
		return
	if physical == KEY_S or key_event.keycode == KEY_S:
		pending_lane_inputs.append(1)
		get_viewport().set_input_as_handled()
		return
	if physical == KEY_D or key_event.keycode == KEY_D:
		pending_lane_inputs.append(2)
		get_viewport().set_input_as_handled()
		return
	if physical == KEY_SPACE or key_event.keycode == KEY_SPACE:
		pending_hold_input = true
		get_viewport().set_input_as_handled()
		return

	match key_event.keycode:
		KEY_BRACKETLEFT:
			_adjust_offset(-0.01)
		KEY_BRACKETRIGHT:
			_adjust_offset(0.01)
		KEY_MINUS:
			_adjust_bpm(-0.1)
		KEY_EQUAL:
			_adjust_bpm(0.1)
		KEY_M:
			metronome_enabled = not metronome_enabled
			_reset_metronome()
		KEY_0:
			chart_offset = 0.0
			_reset_metronome()
			judge_label.text = "OFFSET RESET"
		KEY_T:
			_tap_beat()
		KEY_C:
			_apply_suggested_bpm()
		KEY_E:
			if not player_evolved:
				_trigger_evolution()
		KEY_R:
			if recording_mode:
				_stop_recording()
			else:
				_start_recording()
		KEY_G:
			_generate_basic_chart()
		KEY_1:
			generator_density = 1
			judge_label.text = "GEN DENSITY 1"
		KEY_2:
			generator_density = 2
			judge_label.text = "GEN DENSITY 2"
		KEY_3:
			generator_density = 3
			judge_label.text = "GEN DENSITY 3"
		KEY_F11:
			_toggle_fullscreen()


func _setup_preview_window() -> void:
	DisplayServer.window_set_min_size(Vector2i(1280, 720))
	DisplayServer.window_set_size(Vector2i(1600, 900))
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _toggle_fullscreen() -> void:
	var mode := DisplayServer.window_get_mode()
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _adjust_offset(amount: float) -> void:
	chart_offset += amount
	_reset_metronome()
	judge_label.text = "OFFSET %+0.03fs" % chart_offset


func _adjust_bpm(amount: float) -> void:
	chart_bpm = max(40.0, chart_bpm + amount)
	_clear_beat_taps()
	_reset_metronome()
	judge_label.text = "BPM %0.1f" % chart_bpm


func _tap_beat() -> void:
	beat_taps.append(song_time)
	if beat_taps.size() > 16:
		beat_taps.pop_front()

	if beat_taps.size() < 4:
		judge_label.text = "TAP BEAT %d/4" % beat_taps.size()
		return

	var intervals: Array[float] = []
	for i in range(1, beat_taps.size()):
		var interval := beat_taps[i] - beat_taps[i - 1]
		if interval > 0.2 and interval < 2.0:
			intervals.append(interval)

	if intervals.is_empty():
		return

	intervals.sort()
	var median_interval := intervals[intervals.size() / 2]
	suggested_bpm = 60.0 / median_interval
	judge_label.text = "SUGGEST %0.1f BPM" % suggested_bpm


func _apply_suggested_bpm() -> void:
	if suggested_bpm <= 0.0:
		judge_label.text = "NO BPM TAP"
		return
	chart_bpm = suggested_bpm
	_clear_beat_taps()
	_reset_metronome()
	judge_label.text = "APPLIED %0.1f BPM" % chart_bpm


func _clear_beat_taps() -> void:
	beat_taps.clear()
	suggested_bpm = 0.0


func _start_recording() -> void:
	recording_mode = true
	chart_playback_enabled = false
	recorded_notes.clear()
	_start_song()
	metronome_enabled = true
	judge_label.text = "RECORDING"


func _stop_recording() -> void:
	recording_mode = false
	chart_playback_enabled = true
	_save_recorded_chart()
	_finish_song()
	judge_label.text = "SAVED %d NOTES" % recorded_notes.size()


func _record_lane(lane: int, kind: String) -> void:
	var raw_time := _raw_chart_time(song_time)
	var note := {
		"time": snapped(raw_time, 0.001),
		"lane": lane,
		"kind": kind
	}
	if kind == "hold":
		note["duration"] = 0.5
	recorded_notes.append(note)
	_flash_lane(lane, _note_color(lane, kind))
	judge_label.text = "REC %s %s %0.3f" % [LANE_NAMES[lane], kind.to_upper(), raw_time]


func _record_hold() -> void:
	var raw_time := _raw_chart_time(song_time)
	var note := {
		"time": snapped(raw_time, 0.001),
		"lane": 1,
		"kind": "hold",
		"duration": snapped(60.0 / chart_bpm * 2.0, 0.001)
	}
	recorded_notes.append(note)
	_flash_lane(1, _note_color(1, "hold"))
	judge_label.text = "REC SPACE HOLD %0.3f" % raw_time


func _save_recorded_chart() -> void:
	recorded_notes.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return float(a.time) < float(b.time))
	var output := {
		"title": chart_title + " Recorded",
		"source_bpm": chart_source_bpm,
		"bpm": chart_bpm,
		"offset": chart_offset,
		"music_loop_length": music_loop_length,
		"length": song_length,
		"notes": recorded_notes
	}
	var json := JSON.stringify(output, "\t")
	var file := FileAccess.open(RECORDED_CHART_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json + "\n")
		file.close()
	else:
		push_error("Could not write recorded chart to %s" % RECORDED_CHART_PATH)


func _generate_basic_chart() -> void:
	var notes: Array[Dictionary] = []
	var beat_duration: float = 60.0 / chart_bpm
	var start_time: float = max(0.0, 1.0 - chart_offset)
	var end_time: float = max(0.0, song_length - 2.0 - chart_offset)
	var start_bar := int(floor(start_time / (beat_duration * 4.0)))
	var end_bar := int(floor(end_time / (beat_duration * 4.0)))

	for bar in range(start_bar, end_bar + 1):
		_append_doodle_bar(notes, bar, beat_duration, end_time, generator_density)

	_save_generated_chart(notes)
	_load_chart_from_notes(notes, chart_title + " Generated")
	_start_song()
	judge_label.text = "GENERATED %d NOTES" % notes.size()


func _chart_note(time: float, lane: int, kind: String) -> Dictionary:
	return {
		"time": snapped(time, 0.001),
		"lane": lane,
		"kind": kind
	}


func _chart_note_with_duration(time: float, lane: int, kind: String, duration: float) -> Dictionary:
	var note := _chart_note(time, lane, kind)
	note["duration"] = snapped(duration, 0.001)
	return note


func _append_doodle_bar(notes: Array[Dictionary], bar: int, beat_duration: float, end_time: float, density: int) -> void:
	var bar_time: float = float(bar) * beat_duration * 4.0
	var motif := bar % 8
	var steps: Array[Array] = []
	match motif:
		0:
			steps = [[0.0, 1, "heavy"], [1.0, 0, "tap"], [2.0, 2, "air"], [3.0, 1, "tap"]]
		1:
			steps = [[0.0, 0, "tap"], [0.5, 1, "tap"], [1.5, 2, "tap"], [2.0, 1, "heavy"], [3.0, 0, "air"]]
		2:
			steps = [[0.0, 2, "air"], [1.0, 1, "tap"], [2.0, 0, "tap"], [2.5, 1, "tap"], [3.5, 2, "tap"]]
		3:
			steps = [[0.0, 1, "hold"], [2.0, 0, "tap"], [3.0, 2, "heavy"]]
		4:
			steps = [[0.0, 0, "heavy"], [0.75, 2, "tap"], [1.5, 1, "tap"], [2.0, 2, "air"], [3.0, 0, "tap"]]
		5:
			steps = [[0.0, 2, "tap"], [0.5, 1, "tap"], [1.0, 0, "air"], [2.0, 1, "heavy"], [3.0, 2, "tap"]]
		6:
			steps = [[0.0, 1, "air"], [1.0, 0, "tap"], [1.5, 2, "tap"], [2.0, 1, "air"], [3.0, 0, "tap"]]
		_:
			steps = [[0.0, 2, "heavy"], [0.75, 1, "tap"], [1.5, 0, "air"], [2.0, 0, "hold"], [3.5, 1, "heavy"]]

	for step in steps:
		var time: float = bar_time + float(step[0]) * beat_duration
		if time < 0.0 or time > end_time:
			continue
		var lane := int(step[1])
		var kind := String(step[2])
		if kind == "hold":
			notes.append(_chart_note_with_duration(time, lane, "hold", beat_duration * (1.5 if density < 3 else 2.0)))
		else:
			notes.append(_chart_note(time, lane, kind))

	if density >= 2:
		var fill_time: float = bar_time + beat_duration * 3.5
		if fill_time <= end_time and motif % 2 == 1:
			notes.append(_chart_note(fill_time, (motif + bar) % LANES.size(), "tap"))
		if motif == 7:
			var pop_time: float = bar_time + beat_duration * 2.75
			if pop_time <= end_time:
				notes.append(_chart_note(pop_time, 2, "air"))
	if density >= 3:
		var burst_time: float = bar_time + beat_duration * 1.75
		if burst_time <= end_time and motif % 3 == 0:
			notes.append(_chart_note(burst_time, (bar + 2) % LANES.size(), "tap"))
		if motif == 7:
			for offset in [3.0, 3.25, 3.5]:
				var roll_time: float = bar_time + beat_duration * float(offset)
				if roll_time <= end_time:
					notes.append(_chart_note(roll_time, int(offset * 4.0) % LANES.size(), "tap"))


func _save_generated_chart(notes: Array[Dictionary]) -> void:
	var output := {
		"title": chart_title + " Generated",
		"source_bpm": chart_bpm,
		"bpm": chart_bpm,
		"offset": chart_offset,
		"music_loop_length": music_loop_length,
		"length": song_length,
		"notes": notes
	}
	var file := FileAccess.open(GENERATED_CHART_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(output, "\t") + "\n")
		file.close()
	else:
		push_error("Could not write generated chart to %s" % GENERATED_CHART_PATH)


func _load_chart_from_notes(notes: Array[Dictionary], title: String) -> void:
	for note in active_notes:
		if is_instance_valid(note.node):
			note.node.queue_free()
	active_notes.clear()
	chart = notes.duplicate(true)
	chart.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return float(a.time) < float(b.time))
	chart_title = title
	chart_source_bpm = chart_bpm


func _build_world() -> void:
	var environment := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = BACKGROUND_COLOR
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.22, 0.11, 0.50)
	env.ambient_light_energy = 0.68
	env.glow_enabled = true
	env.glow_intensity = 0.24
	environment.environment = env
	add_child(environment)

	camera = Camera3D.new()
	camera.position = Vector3(0.0, 6.5, 13.0)
	camera_base_position = camera.position
	camera.rotation_degrees = Vector3(-27.0, 0.0, 0.0)
	camera.fov = 55.0
	add_child(camera)
	_build_scoreboard_3d()

	var light := DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-55.0, 35.0, 0.0)
	light.light_color = Color(1.0, 0.88, 0.24)
	light.light_energy = 1.55
	add_child(light)

	_build_pattern_background()
	_create_torn_track_gateway()
	_create_stage_lights()
	_build_performance_panel()

	for i in LANES.size():
		_create_lane(i)

	hit_line = _box(Vector3(9.4, 0.035, 0.08), Color(0.28, 0.24, 0.36), 0.08)
	hit_line.position = Vector3(LANES[1], 0.08, HIT_Z)
	add_child(hit_line)
	judge_marker = _make_layered_sprite(NOTE_JUDGELINE_PATH, NOTE_JUDGELINE_SHADOW_PATH, 0.0124, true, Vector3(0.0, -0.05, -0.05))
	judge_marker.position = Vector3(LANES[judge_marker_lane], 0.42, HIT_Z + 0.02)
	judge_marker.rotation_degrees.x = -58.0
	add_child(judge_marker)

	player = _make_player()
	player.position = Vector3(-5.34, 1.50, HIT_Z + 1.36)
	add_child(player)


func _build_stage_decor() -> void:
	_create_doodle_backdrop()
	_create_doodle_burst(Vector3(-8.4, 3.4, -18.0), 2.3, Color(1.0, 0.86, 0.02), -16.0)
	_create_doodle_burst(Vector3(7.8, 4.7, -28.0), 3.0, Color(1.0, 0.48, 0.03), 18.0)
	_create_doodle_burst(Vector3(2.4, 5.8, -38.0), 3.8, Color(1.0, 0.88, 0.02), -6.0)
	_create_doodle_splat(Vector3(-9.0, 5.1, -30.0), 1.55, Color(0.42, 1.0, 0.24), 10.0)
	_create_doodle_splat(Vector3(8.7, 3.1, -16.0), 1.35, Color(0.50, 1.0, 0.24), -18.0)
	_create_doodle_blob(Vector3(-6.8, 2.2, -12.0), Color(0.06, 0.56, 0.96), -20.0)
	_create_doodle_blob(Vector3(6.1, 6.3, -35.0), Color(0.06, 0.72, 0.92), 18.0)
	_create_scribble_line(Vector3(-7.0, 4.0, -15.0), Vector3(7.0, 6.6, -32.0), Color(0.96, 0.96, 0.92), 0.055)
	_create_scribble_line(Vector3(8.5, 2.7, -12.0), Vector3(-6.0, 5.6, -36.0), Color(1.0, 0.84, 0.03), 0.07)
	_create_stage_lights()


func _build_pattern_background() -> void:
	background_pattern_groups.clear()

	for i in 3:
		var backdrop := _make_camera_backdrop(i)
		background_pattern_groups.append(backdrop)
		camera.add_child(backdrop)


func _build_scoreboard_3d() -> void:
	scoreboard_panel = Node3D.new()
	scoreboard_panel.name = "Scoreboard3D"
	scoreboard_panel.position = Vector3(-4.72, 2.78, -8.0)
	scoreboard_panel.scale = Vector3(0.88, 0.88, 1.0)
	scoreboard_panel.rotation_degrees = Vector3(0.0, 0.0, -2.5)
	camera.add_child(scoreboard_panel)

	var paint_shadow := _hud_box(Vector3(5.05, 0.34, 0.030), Color(0.025, 0.018, 0.055, 0.96))
	paint_shadow.position = Vector3(-0.05, -0.94, -0.085)
	paint_shadow.rotation_degrees.z = 1.8
	scoreboard_panel.add_child(paint_shadow)

	var hot_sticker := _hud_box(Vector3(1.35, 0.32, 0.030), Color(1.0, 0.18, 0.48, 0.92))
	hot_sticker.position = Vector3(-2.16, 0.83, -0.075)
	hot_sticker.rotation_degrees.z = 11.0
	scoreboard_panel.add_child(hot_sticker)

	var cyan_sticker := _hud_box(Vector3(1.10, 0.24, 0.030), Color(0.00, 0.76, 0.82, 0.92))
	cyan_sticker.position = Vector3(1.78, 0.82, -0.070)
	cyan_sticker.rotation_degrees.z = -8.0
	scoreboard_panel.add_child(cyan_sticker)

	var paper_shadow := _hud_box(Vector3(4.72, 1.42, 0.035), Color(0.08, 0.05, 0.16, 0.46))
	paper_shadow.position = Vector3(0.16, -0.12, -0.04)
	paper_shadow.rotation_degrees.z = -1.5
	scoreboard_panel.add_child(paper_shadow)

	var paper := _hud_box(Vector3(4.72, 1.42, 0.035), Color(0.98, 0.94, 0.82, 1.0))
	paper.rotation_degrees.z = -1.5
	scoreboard_panel.add_child(paper)

	var torn_left := _hud_box(Vector3(0.30, 1.26, 0.04), Color(0.98, 0.94, 0.82, 1.0))
	torn_left.position = Vector3(-2.34, -0.02, 0.02)
	torn_left.rotation_degrees.z = 7.0
	scoreboard_panel.add_child(torn_left)

	var black_strip := _hud_box(Vector3(4.48, 0.42, 0.045), Color(0.035, 0.025, 0.06, 1.0))
	black_strip.position = Vector3(0.02, -0.34, 0.05)
	black_strip.rotation_degrees.z = -1.0
	scoreboard_panel.add_child(black_strip)

	var debug_strip := _hud_box(Vector3(4.36, 0.30, 0.045), Color(0.035, 0.025, 0.06, 0.92))
	debug_strip.position = Vector3(0.0, -0.72, 0.06)
	debug_strip.rotation_degrees.z = 1.0
	scoreboard_panel.add_child(debug_strip)

	var tape := _hud_box(Vector3(0.78, 0.16, 0.05), Color(0.12, 0.78, 0.84, 1.0))
	tape.position = Vector3(1.62, 0.68, 0.08)
	tape.rotation_degrees.z = -9.0
	scoreboard_panel.add_child(tape)

	var pink_tape := _hud_box(Vector3(0.54, 0.14, 0.05), Color(1.0, 0.22, 0.50, 1.0))
	pink_tape.position = Vector3(-1.85, 0.66, 0.08)
	pink_tape.rotation_degrees.z = 8.0
	scoreboard_panel.add_child(pink_tape)

	var black_slash := _hud_box(Vector3(1.24, 0.12, 0.055), Color(0.025, 0.018, 0.055, 1.0))
	black_slash.position = Vector3(-1.54, 0.76, 0.11)
	black_slash.rotation_degrees.z = -13.0
	scoreboard_panel.add_child(black_slash)

	var star := _star_prism(0.26, 0.045, Color(0.0, 0.78, 0.78, 1.0), 0.0)
	star.position = Vector3(2.05, 0.34, 0.10)
	star.rotation_degrees = Vector3(90.0, 0.0, 12.0)
	scoreboard_panel.add_child(star)

	var yellow_badge := _star_prism(0.32, 0.045, Color(1.0, 0.82, 0.02, 1.0), 0.04)
	yellow_badge.position = Vector3(-2.12, 0.56, 0.12)
	yellow_badge.rotation_degrees = Vector3(90.0, 0.0, -16.0)
	scoreboard_panel.add_child(yellow_badge)

	score_3d_label = _score_label_3d("SCORE 0", Vector3(-2.12, 0.34, 0.10), 48, Color(0.05, 0.035, 0.10))
	scoreboard_panel.add_child(score_3d_label)
	combo_3d_label = _score_label_3d("COMBO 0", Vector3(-2.12, -0.04, 0.10), 42, Color(0.05, 0.035, 0.10))
	scoreboard_panel.add_child(combo_3d_label)
	status_3d_label = _score_label_3d("A / S / D lanes    LIFE 100    BEST 0", Vector3(-2.08, -0.40, 0.12), 22, Color(0.42, 1.0, 0.74))
	scoreboard_panel.add_child(status_3d_label)
	debug_3d_label = _score_label_3d("time 00.00s", Vector3(-2.08, -0.78, 0.12), 17, Color(0.96, 0.94, 0.90))
	scoreboard_panel.add_child(debug_3d_label)

	var life_back := _hud_box(Vector3(1.20, 0.075, 0.05), Color(0.06, 0.04, 0.10, 1.0))
	life_back.position = Vector3(1.58, -0.05, 0.11)
	scoreboard_panel.add_child(life_back)
	life_3d_bar = _hud_box(Vector3(1.08, 0.05, 0.055), Color(0.42, 1.0, 0.36, 1.0))
	life_3d_bar.position = Vector3(1.52, -0.05, 0.14)
	scoreboard_panel.add_child(life_3d_bar)


func _hud_box(size: Vector3, color: Color) -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA if color.a < 0.99 else BaseMaterial3D.TRANSPARENCY_DISABLED
	material.no_depth_test = true
	var node := MeshInstance3D.new()
	node.mesh = mesh
	node.material_override = material
	node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	return node


func _score_label_3d(text: String, pos: Vector3, font_size: int, color: Color) -> Label3D:
	var label := Label3D.new()
	label.text = text
	label.font_size = font_size
	label.modulate = color
	label.outline_size = 6
	label.outline_modulate = Color(1.0, 0.95, 0.78, 0.85)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.position = pos
	label.no_depth_test = true
	label.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	label.render_priority = 90
	return label


func _make_camera_backdrop(kind: int) -> MeshInstance3D:
	var mesh := QuadMesh.new()
	mesh.size = Vector2(164.0, 92.0)

	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_texture = load(BACKDROP_TEXTURE_PATH) if ResourceLoader.exists(BACKDROP_TEXTURE_PATH) else _make_backdrop_texture(kind)
	material.cull_mode = BaseMaterial3D.CULL_DISABLED

	var node := MeshInstance3D.new()
	node.name = ["CirclePosterBackdrop", "StarPosterBackdrop", "QuadPosterBackdrop"][kind]
	node.mesh = mesh
	node.material_override = material
	node.position = Vector3(0.0, 0.0, -82.0)
	node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	return node


func _create_torn_track_gateway() -> void:
	var root := Node3D.new()
	root.name = "TornTrackGateway"
	root.position = torn_gateway_position
	add_child(root)

	if ResourceLoader.exists(TORN_GATEWAY_PATH):
		if ResourceLoader.exists(TORN_GATEWAY_TUNNEL_PATH):
			torn_gateway_tunnel = _make_billboard_sprite(TORN_GATEWAY_TUNNEL_PATH, torn_tunnel_pixel_size, true)
			torn_gateway_tunnel.name = "TornGatewayTunnelSprite"
			torn_gateway_tunnel.position = torn_tunnel_offset
			torn_gateway_tunnel.no_depth_test = false
			torn_gateway_tunnel.render_priority = -12
			root.add_child(torn_gateway_tunnel)
		torn_gateway_frame = _make_billboard_sprite(TORN_GATEWAY_PATH, torn_gateway_pixel_size, true)
		torn_gateway_frame.name = "TornGatewayFrameSprite"
		torn_gateway_frame.position.z = 0.04
		torn_gateway_frame.no_depth_test = false
		torn_gateway_frame.render_priority = -8
		root.add_child(torn_gateway_frame)
		return

	var black_core := _paper_cutout(Vector2(5.8, 1.45), Color(0.025, 0.018, 0.055, 0.92), 0.0)
	black_core.position = Vector3(0.0, 0.05, -0.14)
	black_core.rotation_degrees.z = -2.0
	root.add_child(black_core)

	for i in 10:
		var side := -1.0 if i % 2 == 0 else 1.0
		var strip := _paper_cutout(Vector2(1.35 + float(i % 3) * 0.32, 0.18), Color(0.98, 0.94, 0.82, 0.96), 0.0)
		strip.position = Vector3(side * (1.05 + float(i) * 0.18), 0.05 + sin(float(i) * 1.2) * 0.42, 0.02 + float(i % 2) * 0.025)
		strip.rotation_degrees.z = side * (18.0 + float(i % 4) * 11.0)
		root.add_child(strip)

	for i in 8:
		var tooth := _paper_cutout(Vector2(0.72, 0.24), Color(0.04, 0.03, 0.08, 0.94), 0.0)
		tooth.position = Vector3(-2.55 + float(i) * 0.74, -0.34 + float((i * 7) % 5) * 0.15, 0.05)
		tooth.rotation_degrees.z = float((i * 29) % 80) - 40.0
		root.add_child(tooth)

	var colors := [
		Color(1.0, 0.18, 0.48, 0.92),
		Color(0.0, 0.72, 0.82, 0.86),
		Color(1.0, 0.82, 0.02, 0.88),
		Color(0.50, 0.84, 0.20, 0.82)
	]
	for i in 8:
		var shard := _paper_cutout(Vector2(0.86 + float(i % 2) * 0.28, 0.16), colors[i % colors.size()], 0.02)
		shard.position = Vector3(-3.30 + float(i) * 0.95, 0.70 + sin(float(i) * 1.7) * 0.55, 0.08)
		shard.rotation_degrees.z = float((i * 37) % 92) - 46.0
		root.add_child(shard)

	for i in 7:
		var slash := _paper_cutout(Vector2(0.95, 0.055), Color(0.03, 0.025, 0.05, 0.88), 0.0)
		slash.position = Vector3(-2.9 + float(i) * 0.96, 0.90 + cos(float(i) * 0.9) * 0.36, 0.12)
		slash.rotation_degrees.z = float((i * 17) % 70) - 35.0
		root.add_child(slash)


func _create_gateway_depth_rings(parent: Node3D) -> void:
	var palette := [
		Color(0.12, 0.06, 0.30, 0.58),
		Color(0.00, 0.62, 0.78, 0.46),
		Color(1.0, 0.72, 0.06, 0.38),
		Color(1.0, 0.18, 0.48, 0.34),
		Color(0.04, 0.03, 0.08, 0.62)
	]
	for ring in 5:
		var t := float(ring) / 4.0
		var width: float = lerp(8.20, 2.10, t)
		var height: float = lerp(2.45, 0.62, t)
		var thick: float = lerp(0.135, 0.055, t)
		var z := 0.030 + float(ring) * 0.018
		var color: Color = palette[ring % palette.size()]
		var y_shift := -0.04 - float(ring) * 0.035
		var top := _paper_cutout(Vector2(width, thick), color, 0.02)
		top.position = Vector3(0.0, y_shift + height * 0.50, z)
		top.rotation_degrees.z = -2.0 + float(ring) * 1.4
		parent.add_child(top)
		var bottom := _paper_cutout(Vector2(width * 0.92, thick), color.darkened(0.16), 0.01)
		bottom.position = Vector3(0.0, y_shift - height * 0.50, z)
		bottom.rotation_degrees.z = 2.5 - float(ring) * 1.1
		parent.add_child(bottom)
		for side in [-1, 1]:
			var vertical := _paper_cutout(Vector2(thick, height), color.darkened(0.10), 0.01)
			vertical.position = Vector3(float(side) * width * 0.50, y_shift, z)
			vertical.rotation_degrees.z = float(side) * (5.0 + t * 7.0)
			parent.add_child(vertical)

	for i in 12:
		var side := -1.0 if i % 2 == 0 else 1.0
		var ray := _paper_cutout(Vector2(1.05 - float(i % 3) * 0.16, 0.045), Color(0.98, 0.93, 0.78, 0.28), 0.0)
		ray.position = Vector3(side * (0.82 + float(i % 4) * 0.36), -0.16 + sin(float(i) * 0.9) * 0.62, 0.14 + float(i % 3) * 0.012)
		ray.rotation_degrees.z = side * (18.0 + float((i * 11) % 38))
		parent.add_child(ray)


func _make_backdrop_texture(kind: int) -> Texture2D:
	var image := Image.create(1600, 900, false, Image.FORMAT_RGBA8)
	image.fill(Color(0.96, 0.91, 0.76, 1.0))

	_draw_rotated_rect(image, Vector2(280, 190), Vector2(760, 220), deg_to_rad(-9.0), Color(0.58, 0.35, 0.92, 0.20))
	_draw_rotated_rect(image, Vector2(1320, 230), Vector2(720, 260), deg_to_rad(12.0), Color(0.30, 0.86, 0.72, 0.18))
	_draw_rotated_rect(image, Vector2(760, 730), Vector2(1180, 320), deg_to_rad(-6.0), Color(1.0, 0.72, 0.14, 0.22))
	_draw_rotated_rect(image, Vector2(1140, 650), Vector2(540, 180), deg_to_rad(18.0), Color(0.30, 0.62, 0.98, 0.12))

	for i in 30:
		var p := _poster_point(i, kind)
		var size := 48.0 + float((i * 17 + kind * 11) % 46)
		var angle := deg_to_rad(float((i * 31 + kind * 17) % 70) - 35.0)
		var color := _poster_color(i, kind)
		var shadow := Color(0.10, 0.06, 0.25, 0.34)
		var shadow_pos := p + Vector2(14.0, 14.0)
		match kind:
			0:
				_draw_circle(image, shadow_pos, size * 0.54, shadow)
				_draw_circle(image, p, size * 0.48, color)
			1:
				_draw_poster_star(image, shadow_pos, size * 0.72, angle, shadow)
				_draw_poster_star(image, p, size * 0.62, angle, color)
			_:
				_draw_rotated_rect(image, shadow_pos, Vector2(size, size), angle, shadow)
				_draw_rotated_rect(image, p, Vector2(size * 0.86, size * 0.86), angle, color)

	for i in 160:
		var x := int(abs(sin(float(i) * 12.9898)) * 1599.0)
		var y := int(abs(cos(float(i) * 78.233)) * 899.0)
		_blend_pixel(image, x, y, Color(0.12, 0.08, 0.26, 0.20))

	return ImageTexture.create_from_image(image)


func _poster_point(index: int, kind: int) -> Vector2:
	var seed := float(index * 37 + kind * 101)
	var x := 80.0 + fmod(abs(sin(seed * 0.73)) * 1420.0 + float(index % 5) * 53.0, 1440.0)
	var y := 70.0 + fmod(abs(cos(seed * 0.41)) * 760.0 + float(index % 7) * 37.0, 760.0)
	return Vector2(x, y)


func _poster_color(index: int, kind: int) -> Color:
	var palette := [
		Color(0.17, 0.08, 0.52, 0.88),
		Color(0.02, 0.46, 0.96, 0.82),
		Color(0.30, 0.84, 0.06, 0.82),
		Color(1.0, 0.38, 0.02, 0.82),
		Color(0.98, 0.78, 0.02, 0.86)
	]
	return palette[(index * 2 + kind) % palette.size()]


func _draw_circle(image: Image, center: Vector2, radius: float, color: Color) -> void:
	var min_x: int = max(0, int(floor(center.x - radius)))
	var max_x: int = min(image.get_width() - 1, int(ceil(center.x + radius)))
	var min_y: int = max(0, int(floor(center.y - radius)))
	var max_y: int = min(image.get_height() - 1, int(ceil(center.y + radius)))
	var radius_sq: float = radius * radius
	for y in range(min_y, max_y + 1):
		for x in range(min_x, max_x + 1):
			var offset: Vector2 = Vector2(float(x), float(y)) - center
			if offset.length_squared() <= radius_sq:
				_blend_pixel(image, x, y, color)


func _draw_poster_star(image: Image, center: Vector2, radius: float, angle: float, color: Color) -> void:
	for i in 5:
		var arm_angle: float = angle + float(i) * TAU / 5.0
		_draw_rotated_rect(image, center, Vector2(radius * 0.42, radius * 1.22), arm_angle, color)
	_draw_circle(image, center, radius * 0.28, color.lerp(Color.WHITE, 0.10))


func _draw_rotated_rect(image: Image, center: Vector2, size: Vector2, angle: float, color: Color) -> void:
	var half: Vector2 = size * 0.5
	var radius: float = size.length() * 0.55
	var min_x: int = max(0, int(floor(center.x - radius)))
	var max_x: int = min(image.get_width() - 1, int(ceil(center.x + radius)))
	var min_y: int = max(0, int(floor(center.y - radius)))
	var max_y: int = min(image.get_height() - 1, int(ceil(center.y + radius)))
	var c: float = cos(-angle)
	var s: float = sin(-angle)
	for y in range(min_y, max_y + 1):
		for x in range(min_x, max_x + 1):
			var rel: Vector2 = Vector2(float(x), float(y)) - center
			var local: Vector2 = Vector2(rel.x * c - rel.y * s, rel.x * s + rel.y * c)
			if abs(local.x) <= half.x and abs(local.y) <= half.y:
				_blend_pixel(image, x, y, color)


func _blend_pixel(image: Image, x: int, y: int, color: Color) -> void:
	var base: Color = image.get_pixel(x, y)
	var alpha: float = clamp(color.a, 0.0, 1.0)
	image.set_pixel(x, y, Color(
		lerpf(base.r, color.r, alpha),
		lerpf(base.g, color.g, alpha),
		lerpf(base.b, color.b, alpha),
		1.0
	))


func _make_background_group(group_name: String) -> Node3D:
	var group := Node3D.new()
	group.name = group_name
	group.position = Vector3(0.0, 0.02, 0.0)
	add_child(group)
	return group


func _pattern_position(row: int, col: int) -> Vector3:
	var seed := float(row * 11 + col * 7)
	var x := -15.4 + float(col) * 3.55 + sin(seed * 1.37) * 0.92 + (1.2 if row % 2 == 1 else 0.0)
	var z := 7.6 - float(row) * 8.1 - cos(seed * 0.91) * 1.15 - float((col * 7 + row * 3) % 5) * 0.22
	return Vector3(x, 0.04, z)


func _pattern_color(row: int, col: int, phase: int) -> Color:
	var palette := [
		Color(0.18, 0.08, 0.50, 0.54),
		Color(0.02, 0.45, 0.95, 0.50),
		Color(0.28, 0.82, 0.05, 0.52),
		Color(1.0, 0.39, 0.02, 0.48),
		Color(0.96, 0.72, 0.02, 0.54)
	]
	return palette[(row * 2 + col + phase) % palette.size()]


func _build_performance_panel() -> void:
	performance_panel = Node3D.new()
	performance_panel.name = "CharacterPerformancePanel"
	performance_panel.position = Vector3(-5.38, 1.46, HIT_Z + 0.28)
	performance_panel.scale = Vector3(1.03, 1.03, 1.0)
	add_child(performance_panel)

	var stage_sprite := _make_billboard_sprite(PERFORMANCE_STAGE_PATH, 0.00278, true)
	stage_sprite.name = "PerformanceStageSprite"
	stage_sprite.position = Vector3(0.02, 0.02, -0.10)
	stage_sprite.no_depth_test = true
	stage_sprite.render_priority = 6
	stage_sprite.modulate = Color(1.0, 1.0, 1.0, 0.94)
	performance_panel.add_child(stage_sprite)


func _create_candy_planet(pos: Vector3, radius: float, base_color: Color, ring_color: Color) -> void:
	var planet := _sphere(radius, base_color, 0.32)
	planet.position = pos
	add_child(planet)

	var ring := _ring_disc(radius * 1.55, 0.035, ring_color, 0.75)
	ring.position = pos
	ring.rotation_degrees = Vector3(68.0, 0.0, 24.0)
	ring.scale.z = 0.15
	add_child(ring)

	var shine := _sphere(radius * 0.22, Color(1.0, 1.0, 1.0, 0.72), 0.9)
	shine.position = pos + Vector3(-radius * 0.28, radius * 0.34, radius * 0.45)
	add_child(shine)


func _create_doodle_backdrop() -> void:
	var slices := [
		[Vector3(-13.2, 4.8, -52.0), Vector3(10.0, 0.08, 14.0), Color(0.64, 0.50, 0.92, 0.10), -34.0],
		[Vector3(13.8, 3.2, -46.0), Vector3(9.0, 0.08, 12.0), Color(0.30, 0.78, 0.92, 0.09), 32.0],
		[Vector3(-15.0, 2.7, -30.0), Vector3(7.8, 0.08, 10.0), Color(1.0, 0.64, 0.28, 0.08), 22.0],
		[Vector3(16.2, 5.2, -55.0), Vector3(7.2, 0.08, 10.8), Color(0.56, 1.0, 0.32, 0.08), -26.0]
	]
	for item in slices:
		var slice := _box(item[1], item[2], 0.04)
		slice.position = item[0]
		slice.rotation_degrees = Vector3(0.0, item[3], 18.0)
		add_child(slice)


func _create_doodle_burst(pos: Vector3, radius: float, color: Color, yaw: float) -> void:
	var burst := _star_prism(radius, 0.08, color, 0.34)
	burst.position = pos
	burst.rotation_degrees = Vector3(72.0, yaw, 8.0)
	add_child(burst)
	var outline := _star_prism(radius * 1.14, 0.035, Color(0.03, 0.025, 0.05), 0.0)
	outline.position = pos + Vector3(0.12, -0.10, -0.06)
	outline.rotation_degrees = burst.rotation_degrees
	add_child(outline)


func _create_doodle_splat(pos: Vector3, radius: float, color: Color, yaw: float) -> void:
	var root := Node3D.new()
	root.position = pos
	root.rotation_degrees = Vector3(70.0, yaw, 0.0)
	add_child(root)
	for i in 9:
		var angle := float(i) / 9.0 * TAU
		var petal := _sphere(radius * randf_range(0.22, 0.36), color.lerp(Color.WHITE, 0.12), 0.22)
		petal.position = Vector3(cos(angle) * radius * 0.45, sin(angle) * radius * 0.20, sin(angle) * radius * 0.30)
		petal.scale = Vector3(1.6, 0.34, 0.7)
		root.add_child(petal)
	var core := _sphere(radius * 0.58, color, 0.25)
	core.scale = Vector3(1.5, 0.30, 0.9)
	root.add_child(core)
	var eye_a := _box(Vector3(radius * 0.12, 0.035, radius * 0.46), Color(0.98, 0.96, 0.90), 0.0)
	eye_a.position = Vector3(-radius * 0.22, 0.05, 0.0)
	root.add_child(eye_a)
	var eye_b := _box(Vector3(radius * 0.12, 0.035, radius * 0.46), Color(0.98, 0.96, 0.90), 0.0)
	eye_b.position = Vector3(radius * 0.22, 0.05, 0.0)
	root.add_child(eye_b)


func _create_doodle_blob(pos: Vector3, color: Color, yaw: float) -> void:
	var blob := _sphere(0.55, color, 0.20)
	blob.position = pos
	blob.scale = Vector3(1.8, 0.34, 0.72)
	blob.rotation_degrees = Vector3(70.0, yaw, 0.0)
	add_child(blob)
	for i in 4:
		var drop := _sphere(0.16, color.lerp(Color.WHITE, 0.12), 0.12)
		drop.position = pos + Vector3(randf_range(-0.75, 0.75), randf_range(-0.28, 0.35), randf_range(-0.25, 0.25))
		add_child(drop)


func _create_scribble_line(from: Vector3, to: Vector3, color: Color, thickness: float) -> void:
	var previous := from
	for i in 1 + 8:
		var t := float(i) / 8.0
		var point := from.lerp(to, t) + Vector3(sin(t * TAU * 2.0) * 0.18, cos(t * TAU * 1.5) * 0.12, 0.0)
		var mid := (previous + point) * 0.5
		var length := previous.distance_to(point)
		var segment := _box(Vector3(thickness, thickness, length), color, 0.18)
		segment.position = mid
		add_child(segment)
		segment.look_at(point, Vector3.FORWARD)
		previous = point


func _create_piano_bridge() -> void:
	for i in 18:
		var is_black := i % 5 == 1 or i % 5 == 3
		var key_color := Color(0.08, 0.09, 0.15) if is_black else Color(0.78, 0.86, 1.0)
		var emission := 0.08 if is_black else 0.22
		var key := _box(Vector3(0.46, 0.055, 1.6 if not is_black else 1.05), key_color, emission)
		key.position = Vector3(-4.2 + float(i) * 0.5, -0.22, -12.0 - float(i) * 0.36)
		key.rotation_degrees.y = -10.0
		add_child(key)


func _create_stage_lights() -> void:
	for side in [-1, 1]:
		var x := float(side) * 6.1
		var stand := _box(Vector3(0.18, 3.0, 0.18), Color(0.04, 0.04, 0.11), 0.03)
		stand.position = Vector3(x, 1.25, -5.4)
		add_child(stand)

		var head := _cylinder(0.36, 0.48, 18, Color(0.07, 0.06, 0.16), 0.06)
		head.position = Vector3(x, 2.95, -5.4)
		head.rotation_degrees.x = 80.0
		add_child(head)

		var beam_color := Color(0.42, 1.0, 0.24, 0.22) if side < 0 else Color(1.0, 0.84, 0.03, 0.20)
		var beam := _box(Vector3(0.18, 0.18, 8.2), beam_color, 0.28)
		beam.position = Vector3(x - float(side) * 1.2, 2.55, -10.0)
		beam.rotation_degrees = Vector3(0.0, float(side) * 18.0, 0.0)
		add_child(beam)


func _create_rainbow_arc(center: Vector3, radius: float, color: Color, yaw: float) -> void:
	var yaw_basis := Basis(Vector3.UP, deg_to_rad(yaw))
	var previous := Vector3.ZERO
	var has_previous := false
	for i in 28:
		var t: float = float(i) / 27.0
		var angle: float = lerp(-0.95, 0.95, t)
		var local_point := Vector3(sin(angle) * radius, cos(angle) * radius * 0.42, t * -5.5)
		var point: Vector3 = center + yaw_basis * local_point
		if has_previous:
			var mid: Vector3 = (previous + point) * 0.5
			var length: float = previous.distance_to(point)
			var segment := _box(Vector3(0.07, 0.07, length), color, 0.7)
			segment.position = mid
			add_child(segment)
			segment.look_at(point, Vector3.UP)
		previous = point
		has_previous = true


func _build_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)

	var root := Control.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	layer.add_child(root)

	score_label = _label("SCORE 0", Vector2(24, 20), 24)
	score_label.visible = false
	root.add_child(score_label)

	combo_label = _label("COMBO 0", Vector2(24, 54), 24)
	combo_label.visible = false
	root.add_child(combo_label)

	status_label = _label("A / S / D  hit lanes    SPACE restart", Vector2(24, 94), 18)
	status_label.modulate = Color(0.20, 0.12, 0.42)
	status_label.visible = false
	root.add_child(status_label)

	debug_label = _label("", Vector2(24, 122), 16)
	debug_label.modulate = Color(0.18, 0.16, 0.34)
	debug_label.visible = false
	root.add_child(debug_label)

	judge_label = _label("READY", Vector2(0, 0), 38)
	judge_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	judge_label.anchor_left = 0.0
	judge_label.anchor_right = 1.0
	judge_label.anchor_top = 0.0
	judge_label.anchor_bottom = 0.0
	judge_label.offset_left = 0.0
	judge_label.offset_right = 0.0
	judge_label.offset_top = 112.0
	judge_label.offset_bottom = 160.0
	judge_label.visible = false
	root.add_child(judge_label)
	_build_judgement_badge(root)

	var life_back := ColorRect.new()
	life_back.color = Color(1, 1, 1, 0.13)
	life_back.position = Vector2(24, 680)
	life_back.size = Vector2(300, 12)
	life_back.visible = false
	root.add_child(life_back)

	life_bar = ColorRect.new()
	life_bar.color = Color(0.45, 1.0, 0.56)
	life_bar.position = Vector2(24, 680)
	life_bar.size = Vector2(300, 12)
	life_bar.visible = false
	root.add_child(life_bar)


func _build_judgement_badge(parent: Control) -> void:
	judgement_badge = Control.new()
	judgement_badge.name = "JudgementBadge"
	judgement_badge.size = Vector2(620.0, 280.0)
	judgement_badge.pivot_offset = judgement_badge.size * 0.5
	judgement_badge.position = stage_judgement_position - judgement_badge.pivot_offset
	judgement_badge.scale = Vector2.ONE * stage_judgement_scale
	judgement_badge.mouse_filter = Control.MOUSE_FILTER_IGNORE
	judgement_badge.visible = false
	parent.add_child(judgement_badge)

	judgement_badge_texture = TextureRect.new()
	judgement_badge_texture.name = "BadgeBacking"
	judgement_badge_texture.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	judgement_badge_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	judgement_badge_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	judgement_badge_texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	judgement_badge.add_child(judgement_badge_texture)

	judgement_badge_text = Label.new()
	judgement_badge_text.name = "BadgeText"
	judgement_badge_text.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	judgement_badge_text.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	judgement_badge_text.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	judgement_badge_text.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var marker_font := SystemFont.new()
	marker_font.font_names = PackedStringArray(["Marker Felt", "Chalkboard SE", "Arial Black"])
	marker_font.font_weight = 800
	judgement_badge_text.add_theme_font_override("font", marker_font)
	judgement_badge_text.add_theme_font_size_override("font_size", 58)
	judgement_badge_text.add_theme_constant_override("outline_size", 12)
	judgement_badge_text.add_theme_color_override("font_outline_color", Color(0.025, 0.018, 0.055, 1.0))
	judgement_badge_text.add_theme_color_override("font_color", Color(1.0, 0.96, 0.82, 1.0))
	judgement_badge.add_child(judgement_badge_text)


func _build_audio() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Master"
	if ResourceLoader.exists(MUSIC_PATH):
		music_player.stream = load(MUSIC_PATH)
	music_player.finished.connect(_on_music_finished)
	add_child(music_player)

	metronome_player = AudioStreamPlayer.new()
	metronome_player.bus = "Master"
	metronome_player.volume_db = -5.0
	metronome_player.stream = _make_click_stream()
	add_child(metronome_player)

	hit_player = AudioStreamPlayer.new()
	hit_player.bus = "Master"
	hit_player.volume_db = -6.0
	add_child(hit_player)


func _load_chart() -> void:
	if not FileAccess.file_exists(CHART_PATH):
		_build_chart()
		return

	var file := FileAccess.open(CHART_PATH, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		_build_chart()
		return

	var data: Dictionary = parsed
	chart_title = String(data.get("title", chart_title))
	song_length = float(data.get("length", song_length))
	chart_source_bpm = float(data.get("source_bpm", BPM))
	chart_bpm = float(data.get("bpm", chart_bpm))
	chart_offset = float(data.get("offset", chart_offset))
	music_loop_length = float(data.get("music_loop_length", 0.0))
	chart.clear()

	var notes: Array = data.get("notes", [])
	for raw_note in notes:
		if typeof(raw_note) != TYPE_DICTIONARY:
			continue
		var note: Dictionary = raw_note
		chart.append({
			"time": float(note.get("time", 0.0)),
			"lane": int(note.get("lane", 0)),
			"kind": String(note.get("kind", "tap")),
			"duration": float(note.get("duration", 0.0))
		})
	chart.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return float(a.time) < float(b.time))
	_extend_chart_to_song_length()


func _build_chart() -> void:
	chart.clear()
	var beat_duration: float = 60.0 / chart_bpm
	var end_time: float = max(8.0, song_length - 2.0 - chart_offset)
	var end_bar := int(floor(end_time / (beat_duration * 4.0)))
	for bar in range(0, end_bar + 1):
		_append_doodle_bar(chart, bar, beat_duration, end_time, 1)
	chart.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return float(a.time) < float(b.time))
	_extend_chart_to_song_length()


func _extend_chart_to_song_length() -> void:
	var end_target: float = max(0.0, _raw_chart_time(song_length - 2.0))
	if end_target <= 0.0:
		return
	var last_time: float = 0.0
	for note in chart:
		last_time = max(last_time, float(note.time) + float(note.get("duration", 0.0)))
	if last_time >= end_target - 4.0:
		return

	var beat_duration: float = 60.0 / chart_bpm
	var start_bar := int(ceil(last_time / (beat_duration * 4.0)))
	var end_bar := int(floor(end_target / (beat_duration * 4.0)))
	for bar in range(start_bar, end_bar + 1):
		_append_doodle_bar(chart, bar, beat_duration, end_target, 1)
	chart.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return float(a.time) < float(b.time))


func _start_song() -> void:
	for note in active_notes:
		if is_instance_valid(note.node):
			note.node.queue_free()
	active_notes.clear()
	next_note_index = 0
	song_time = 0.0
	pending_lane_inputs.clear()
	pending_hold_input = false
	music_loop_base_time = 0.0
	score = 0
	combo = 0
	life = 100.0
	running = true
	drop_mode = false
	_set_drop_lane_fx_visible(false)
	judge_marker_lane = 1
	_snap_judge_marker()
	_set_player_evolved(false, false)
	_reset_metronome()
	if music_player and music_player.stream:
		music_player.stop()
		music_player.play()
	judge_label.text = chart_title
	_show_judgement("READY", Color(0.98, 0.86, 0.24))
	status_label.text = "A / S / D lanes    SPACE hold notes    ENTER restart"
	_update_ui()


func _finish_song() -> void:
	running = false
	if music_player:
		music_player.stop()
	if score > best:
		best = score
		ProjectSettings.set_setting("application/config/best_score", best)
	_show_judgement("STAGE CLEAR" if life > 0.0 else "FAILED", Color(0.98, 0.86, 0.24))
	status_label.text = "Final Score %d    Best %d    ENTER restart" % [score, best]


func _on_music_finished() -> void:
	if not running or not music_player or not music_player.stream:
		return
	if music_loop_length <= 0.0 or music_loop_base_time + music_loop_length >= song_length:
		return
	music_loop_base_time += music_loop_length
	music_player.play()


func _handle_input() -> void:
	var hold_pressed := pending_hold_input
	pending_hold_input = false
	if not hold_pressed:
		hold_pressed = Input.is_action_just_pressed(HOLD_KEY)
	if hold_pressed:
		if recording_mode:
			_record_hold()
		else:
			_judge_hold()

	var lanes_to_handle := pending_lane_inputs.duplicate()
	pending_lane_inputs.clear()
	if lanes_to_handle.is_empty():
		for lane in LANE_KEYS.size():
			if Input.is_action_just_pressed(LANE_KEYS[lane]):
				lanes_to_handle.append(lane)

	for lane in lanes_to_handle:
		_handle_lane_press(lane)


func _handle_lane_press(lane: int) -> void:
	judge_marker_lane = lane
	_snap_judge_marker()
	if recording_mode:
		var kind := "tap"
		if Input.is_key_pressed(KEY_SHIFT):
			kind = "air"
		elif Input.is_key_pressed(KEY_CTRL):
			kind = "heavy"
		_record_lane(lane, kind)
		return
	_judge_lane(lane)


func _spawn_due_notes() -> void:
	if not chart_playback_enabled:
		return
	while next_note_index < chart.size():
		var note_data := chart[next_note_index]
		if _scheduled_time(note_data) - song_time > TRAVEL_TIME:
			return
		active_notes.append(_create_note(note_data))
		next_note_index += 1


func _update_notes() -> void:
	for i in range(active_notes.size() - 1, -1, -1):
		var note := active_notes[i]
		var node: Node3D = note.node
		var kind := String(note.kind)
		var duration := float(note.duration)
		var hit_time := _scheduled_time(note)
		var end_time := hit_time + duration
		var time_to_hit := hit_time - song_time
		var note_y := _note_height(kind) + sin(song_time * 8.0 + float(note.lane)) * 0.08

		if kind == "hold":
			var head_z := _note_z_for_time(hit_time)
			var tail_z := _note_z_for_time(end_time)
			node.position.z = (head_z + tail_z) * 0.5
			node.position.y = note_y
			_update_note_bounce(node, kind, hit_time)
			_resize_hold_note(node, max(0.8, abs(head_z - tail_z)))
			if bool(note.get("holding", false)):
				if not Input.is_action_pressed(HOLD_KEY) and song_time < end_time - GOOD_WINDOW:
					_miss_note(i)
					continue
				if song_time >= end_time:
					_complete_hold(i)
					continue
			elif song_time - hit_time > GOOD_WINDOW:
				_miss_note(i)
				continue
		else:
			node.position.z = _note_z_for_time(hit_time)
			node.position.y = note_y
			_update_note_bounce(node, kind, hit_time)
			if song_time - hit_time > GOOD_WINDOW:
				_miss_note(i)
				continue
		node.rotate_y(0.055)
		if node.position.z > DESPAWN_Z and kind != "hold":
			active_notes.remove_at(i)
			node.queue_free()


func _judge_lane(lane: int) -> void:
	var best_index := -1
	var best_delta := 999.0
	for i in active_notes.size():
		var note := active_notes[i]
		if int(note.lane) != lane:
			continue
		if String(note.kind) == "hold":
			continue
		if bool(note.get("holding", false)):
			continue
		var delta = abs(_scheduled_time(note) - song_time)
		if delta < best_delta:
			best_delta = delta
			best_index = i

	if best_index == -1 or best_delta > GOOD_WINDOW:
		_bad_hit(lane)
		return

	var note := active_notes[best_index]
	var points := 100
	var text := "GOOD"
	if best_delta <= PERFECT_WINDOW:
		points = 320
		text = "PERFECT"
	elif best_delta <= GREAT_WINDOW:
		points = 220
		text = "GREAT"

	score += points + min(combo * 8, 500)
	combo += 1
	life = min(100.0, life + 1.2)
	_flash_lane(lane, COLORS[lane])

	if String(note.kind) == "air":
		text = "AIR " + text
	_show_judgement(text, _judge_color(text))
	_hit_feedback(lane, _note_color(lane, String(note.kind)), text, String(note.kind))
	_pop_note(best_index)


func _judge_hold() -> void:
	var best_index := -1
	var best_delta := 999.0
	for i in active_notes.size():
		var note := active_notes[i]
		if String(note.kind) != "hold":
			continue
		if bool(note.get("holding", false)):
			continue
		var delta = abs(_scheduled_time(note) - song_time)
		if delta < best_delta:
			best_delta = delta
			best_index = i

	if best_index == -1 or best_delta > GOOD_WINDOW:
		combo = 0
		life -= 4.0
		_show_judgement("HOLD MISS", Color(1.0, 0.25, 0.28))
		_miss_feedback(1)
		_flash_lane(1, Color(1.0, 0.18, 0.22))
		return

	var note := active_notes[best_index]
	active_notes[best_index]["holding"] = true
	score += 120
	combo += 1
	life = min(100.0, life + 1.2)
	_show_judgement("HOLD", _note_color(int(note.lane), "hold"))
	_hit_feedback(int(note.lane), _note_color(int(note.lane), "hold"), "HOLD", "hold")
	_flash_lane(int(note.lane), _note_color(int(note.lane), "hold"))


func _bad_hit(lane: int) -> void:
	combo = 0
	life -= 4.0
	_show_judgement("MISS", Color(1.0, 0.25, 0.28))
	_miss_feedback(lane)
	_flash_lane(lane, Color(1.0, 0.18, 0.22))


func _miss_note(index: int) -> void:
	combo = 0
	life -= 7.0
	_show_judgement("MISS", Color(1.0, 0.25, 0.28))
	_miss_feedback(int(active_notes[index].lane))
	_pop_note(index)


func _complete_hold(index: int) -> void:
	var note := active_notes[index]
	var lane := int(note.lane)
	score += 420 + min(combo * 10, 700)
	combo += 1
	life = min(100.0, life + 2.5)
	_show_judgement("HOLD CLEAR", Color(0.64, 1.0, 0.68))
	_hit_feedback(lane, Color(0.64, 1.0, 0.68), "HOLD CLEAR", "hold")
	_flash_lane(lane, Color(0.45, 1.0, 0.56))
	_pop_note(index)


func _pop_note(index: int) -> void:
	var note := active_notes[index]
	if is_instance_valid(note.node):
		note.node.queue_free()
	active_notes.remove_at(index)


func _create_lane(index: int) -> void:
	var lane_color: Color = COLORS[index].lerp(Color(0.04, 0.03, 0.13), 0.45)
	var sticker_shadow := _box(Vector3(2.18, 0.045, 54.0), Color(0.03, 0.022, 0.055, 0.72), 0.0)
	sticker_shadow.position = Vector3(LANES[index] + 0.13, -0.002, -17.78)
	sticker_shadow.rotation_degrees.y = 0.8
	add_child(sticker_shadow)

	var sticker_base := _box(Vector3(2.08, 0.045, 54.0), Color(0.96, 0.93, 0.82, 1.0), 0.0)
	sticker_base.position = Vector3(LANES[index] - 0.02, 0.012, -18.0)
	sticker_base.rotation_degrees.y = -0.4
	add_child(sticker_base)

	var lane := _box(Vector3(1.72, 0.06, 54.0), lane_color.lerp(Color(0.03, 0.025, 0.08), 0.28), 0.06)
	lane.position = Vector3(LANES[index], 0.045, -18.0)
	add_child(lane)

	for side in [-1, 1]:
		var paper_edge := _box(Vector3(0.15, 0.082, 54.0), Color(0.98, 0.95, 0.82, 1.0), 0.0)
		paper_edge.position = Vector3(LANES[index] + float(side) * 0.96, 0.090, -18.0)
		add_child(paper_edge)
		var edge := _box(Vector3(0.08, 0.095, 54.0), Color(0.018, 0.014, 0.04), 0.0)
		edge.position = Vector3(LANES[index] + float(side) * 1.05, 0.11, -17.92)
		add_child(edge)
		var scribble := _box(Vector3(0.045, 0.105, 54.0), Color(1.0, 0.86, 0.02, 0.68), 0.08)
		scribble.position = Vector3(LANES[index] + float(side) * 0.78, 0.135, -18.0 + float(side) * 0.12)
		add_child(scribble)

	var center_line := _box(Vector3(0.05, 0.07, 54.0), COLORS[index].lerp(Color(1.0, 0.86, 0.02), 0.24), 0.18)
	center_line.position = Vector3(LANES[index], 0.13, -18.0)
	add_child(center_line)
	_create_lane_decals(index)

	var drop_fx := Node3D.new()
	drop_fx.name = "DropLaneFX_%d" % index
	drop_fx.visible = false
	add_child(drop_fx)
	drop_lane_fx.append(drop_fx)

	var glow := _box(Vector3(1.86, 0.035, 54.0), COLORS[index].lerp(Color(1.0, 0.14, 0.52), 0.32), 0.32)
	glow.position = Vector3(LANES[index], 0.185, -18.0)
	drop_fx.add_child(glow)

	for step in 11:
		var z := HIT_Z - 4.0 - float(step) * 4.2
		var key := _box(Vector3(1.42, 0.03, 0.08), Color(0.95, 0.82, 0.10, 0.40), 0.06)
		key.position = Vector3(LANES[index], 0.165, z)
		add_child(key)

	var label := Label3D.new()
	label.text = LANE_NAMES[index]
	label.font_size = 96
	label.modulate = COLORS[index]
	label.position = Vector3(LANES[index], 0.15, HIT_Z + 1.2)
	label.rotation_degrees = Vector3(-70.0, 0.0, 0.0)
	add_child(label)


func _create_lane_decals(index: int) -> void:
	for segment_name in LANE_DECAL_SEGMENT_ORDER:
		var z_range: Vector2 = LANE_DECAL_SEGMENTS[segment_name]
		var segment_length := z_range.y - z_range.x
		var segment_center := (z_range.x + z_range.y) * 0.5
		var root := Node3D.new()
		root.name = "LaneDecalRoot_%d_%s" % [index, segment_name]
		root.position = Vector3(LANES[index], lane_decal_height, segment_center)
		root.rotation_degrees.x = -90.0
		add_child(root)

		var base_path: String = LANE_DECAL_BASE_PATHS[index][segment_name]
		if ResourceLoader.exists(base_path):
			var base := _make_lane_decal_mesh(base_path, lane_decal_width, segment_length, lane_decal_alpha, 1)
			base.name = "LaneBaseDecal_%d_%s" % [index, segment_name]
			root.add_child(base)
			lane_base_decals.append(base)

		var drop_path: String = LANE_DECAL_DROP_PATHS[index][segment_name]
		if ResourceLoader.exists(drop_path):
			var drop := _make_lane_decal_mesh(drop_path, lane_decal_width, segment_length, lane_drop_decal_alpha, 2)
			drop.name = "LaneDropDecal_%d_%s" % [index, segment_name]
			drop.position.z = 0.003
			drop.visible = false
			root.add_child(drop)
			lane_drop_decals.append(drop)


func _make_lane_decal_mesh(path: String, width: float, length: float, alpha: float, priority: int) -> MeshInstance3D:
	var quad := QuadMesh.new()
	quad.size = Vector2(width, length)

	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.cull_mode = BaseMaterial3D.CULL_DISABLED
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	material.albedo_texture = load(path)
	material.albedo_color = Color(1.0, 1.0, 1.0, alpha)
	material.render_priority = priority
	quad.material = material

	var decal := MeshInstance3D.new()
	decal.mesh = quad
	decal.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	return decal


func _make_player() -> Node3D:
	var root := Node3D.new()
	root.name = "LumaPlayer"

	pixel_player_shadow_sprite = _make_billboard_sprite(PIXEL_PLAYER_SHADOW_PATH, 0.00558, true)
	pixel_player_shadow_sprite.name = "LumaPixelPrintShadow"
	pixel_player_shadow_sprite.position = Vector3(0.12, -0.20, -0.08)
	pixel_player_shadow_sprite.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	pixel_player_shadow_sprite.no_depth_test = true
	pixel_player_shadow_sprite.modulate = Color(1.0, 1.0, 1.0, 0.86)
	pixel_player_shadow_sprite.render_priority = 14
	root.add_child(pixel_player_shadow_sprite)

	player_shadow_sprite = _make_billboard_sprite(PLAYER_SHADOW_PATH, 0.00366, true)
	player_shadow_sprite.name = "LumaPrintShadow"
	player_shadow_sprite.position = Vector3(0.16, -0.18, -0.08)
	player_shadow_sprite.no_depth_test = true
	player_shadow_sprite.modulate = Color(1.0, 1.0, 1.0, 0.82)
	player_shadow_sprite.render_priority = 14
	player_shadow_sprite.visible = false
	root.add_child(player_shadow_sprite)

	var halo := _ring_disc(1.05, 0.035, Color(0.38, 0.96, 1.0, 0.45), 0.82)
	halo.scale.x = 1.55
	halo.scale.z = 0.18
	halo.position = Vector3(0.02, -0.12, -0.08)
	halo.rotation_degrees = Vector3(78.0, 0.0, 0.0)
	halo.visible = false
	root.add_child(halo)

	pixel_player_sprite = Sprite3D.new()
	pixel_player_sprite.name = "LumaPixelSprite"
	if ResourceLoader.exists(PIXEL_CHARACTER_PATH):
		pixel_player_sprite.texture = load(PIXEL_CHARACTER_PATH)
	pixel_player_sprite.pixel_size = 0.00558
	pixel_player_sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	pixel_player_sprite.no_depth_test = true
	pixel_player_sprite.shaded = false
	pixel_player_sprite.alpha_cut = SpriteBase3D.ALPHA_CUT_DISABLED
	pixel_player_sprite.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	pixel_player_sprite.position = Vector3(0.0, -0.08, 0.01)
	pixel_player_sprite.render_priority = 16
	root.add_child(pixel_player_sprite)

	player_sprite = Sprite3D.new()
	player_sprite.name = "LumaSprite"
	if ResourceLoader.exists(CHARACTER_PATH):
		player_sprite.texture = load(CHARACTER_PATH)
	player_sprite.pixel_size = 0.00366
	player_sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	player_sprite.no_depth_test = true
	player_sprite.shaded = false
	player_sprite.alpha_cut = SpriteBase3D.ALPHA_CUT_DISABLED
	player_sprite.position = Vector3(0.0, 0.0, 0.0)
	player_sprite.rotation_degrees.y = 8.0
	player_sprite.render_priority = 16
	player_sprite.visible = false
	root.add_child(player_sprite)

	var anchor := _box(Vector3(0.12, 0.12, 0.12), Color(1.0, 0.91, 0.36), 1.1)
	anchor.position = Vector3(0.0, -0.98, 0.0)
	root.add_child(anchor)
	return root


func _create_note(note_data: Dictionary) -> Dictionary:
	var lane := int(note_data.lane)
	var kind := String(note_data.get("kind", "tap"))
	var duration := float(note_data.get("duration", 0.0))
	var node := _make_note_visual(lane, kind, duration)
	node.position = Vector3(LANES[lane], _note_height(kind), SPAWN_Z)
	add_child(node)
	return {
		"node": node,
		"time": float(note_data.time),
		"lane": lane,
		"kind": kind,
		"duration": duration,
		"holding": false
		}


func _make_note_visual(lane: int, kind: String, duration: float) -> Node3D:
	var root := Node3D.new()
	root.name = "Note_%s" % kind

	if kind == "heavy":
		var sprite := _make_layered_sprite(NOTE_HEAVY_PATH, NOTE_HEAVY_SHADOW_PATH, 0.00355, true, Vector3(0.0, -0.10, -0.15))
		sprite.position.y = 0.08
		root.add_child(sprite)
	elif kind == "air":
		var sprite := _make_layered_sprite(NOTE_AIR_PATH, NOTE_AIR_SHADOW_PATH, 0.00325, true, Vector3(0.0, -0.10, -0.15))
		sprite.position.y = 0.08
		root.add_child(sprite)
		var stem := _box(Vector3(0.04, 0.68, 0.04), Color(0.45, 0.56, 0.62, 0.30), 0.06)
		stem.position.y = -0.62
		root.add_child(stem)
	elif kind == "hold":
		var length: float = max(0.8, duration * (HIT_Z - SPAWN_Z) / TRAVEL_TIME)
		var body := _box(Vector3(0.06, 0.04, length), Color(0.05, 0.04, 0.08, 0.18), 0.0)
		body.name = "HoldBody"
		body.visible = false
		root.add_child(body)
		var rail := _make_layered_sprite(NOTE_HOLD_RAIL_PATH, NOTE_HOLD_RAIL_SHADOW_PATH, 0.00405, false, Vector3(0.0, -0.07, -0.13))
		rail.name = "HoldRailSprite"
		rail.rotation_degrees.x = -90.0
		rail.scale.z = max(1.0, length / 1.6)
		rail.position.y = 0.11
		root.add_child(rail)
		var head := _box(Vector3(0.05, 0.04, 0.05), Color(0.05, 0.04, 0.08, 0.18), 0.0)
		head.name = "HoldHead"
		head.visible = false
		head.position.z = length * 0.5
		root.add_child(head)
		var head_sprite := _make_layered_sprite(NOTE_HOLD_HEAD_PATH, NOTE_HOLD_HEAD_SHADOW_PATH, 0.00385, true, Vector3(0.0, -0.09, -0.15))
		head_sprite.name = "HoldHeadSprite"
		head_sprite.position = Vector3(0.0, 0.18, length * 0.5 + 0.04)
		root.add_child(head_sprite)
		var tail := _box(Vector3(0.05, 0.04, 0.05), Color(0.05, 0.04, 0.08, 0.18), 0.0)
		tail.name = "HoldTail"
		tail.visible = false
		tail.position.z = -length * 0.5
		root.add_child(tail)
	else:
		var sprite := _make_layered_sprite(NOTE_TAP_PATH, NOTE_TAP_SHADOW_PATH, 0.00325, true, Vector3(0.0, -0.09, -0.15))
		sprite.position.y = 0.08
		root.add_child(sprite)

	return root


func _flash_lane(lane: int, color: Color) -> void:
	var flash := _make_impact_burst(color, false)
	flash.position = Vector3(LANES[lane], 0.56, HIT_Z + 0.10)
	flash.rotation_degrees.x = -58.0
	var tween := create_tween()
	var pop_scale := 1.55 if drop_mode else 1.35
	var out_scale := 1.98 if drop_mode else 1.72
	tween.tween_property(flash, "scale", Vector3(pop_scale, pop_scale, pop_scale), 0.055).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(flash, "rotation_degrees:z", randf_range(-9.0, 9.0), 0.055)
	tween.tween_property(flash, "scale", Vector3(out_scale, out_scale, out_scale), 0.12)
	tween.parallel().tween_property(flash, "modulate:a", 0.0, 0.12)
	tween.tween_callback(flash.queue_free)


func _hit_feedback(lane: int, color: Color, judgement: String, kind: String) -> void:
	var x: float = LANES[lane]
	var y: float = _note_height(kind)
	_spawn_hit_burst(Vector3(x, y, HIT_Z), color, 8 if kind != "heavy" else 14)
	_play_hit_sound(judgement, kind)
	if kind == "heavy" or judgement.contains("PERFECT"):
		_add_camera_shake(0.09, 0.07)
	_player_pulse(kind)


func _miss_feedback(lane: int) -> void:
	_spawn_hit_burst(Vector3(LANES[lane], 0.45, HIT_Z), Color(1.0, 0.18, 0.22), 6)
	var miss_burst := _make_impact_burst(Color(1.0, 0.12, 0.16), true)
	miss_burst.position = Vector3(LANES[lane], 0.72, HIT_Z + 0.18)
	miss_burst.rotation_degrees.x = -58.0
	var tween := create_tween()
	tween.tween_property(miss_burst, "scale", Vector3(1.52, 1.52, 1.52), 0.06).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(miss_burst, "rotation_degrees:z", randf_range(-15.0, 15.0), 0.06)
	tween.tween_property(miss_burst, "scale", Vector3(1.95, 1.95, 1.95), 0.13)
	tween.parallel().tween_property(miss_burst, "modulate:a", 0.0, 0.13)
	tween.tween_callback(miss_burst.queue_free)
	_play_hit_sound("MISS", "miss")
	_add_camera_shake(0.18, 0.16)
	_player_miss()


func _make_impact_burst(color: Color, is_miss: bool) -> Node3D:
	var sprite := Sprite3D.new()
	sprite.name = "MissImpactBurst" if is_miss else "HitImpactBurst"
	sprite.texture = _get_impact_texture(color, is_miss)
	sprite.pixel_size = 0.0064 if not is_miss else 0.0074
	sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite.no_depth_test = true
	sprite.shaded = false
	sprite.alpha_cut = SpriteBase3D.ALPHA_CUT_DISABLED
	sprite.render_priority = 35
	sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
	sprite.scale = Vector3(0.30, 0.30, 0.30)
	add_child(sprite)
	return sprite


func _prime_impact_textures() -> void:
	for lane_color in COLORS:
		_get_impact_texture(lane_color, false)
	_get_impact_texture(Color(0.45, 1.0, 0.56), false)
	_get_impact_texture(Color(1.0, 0.12, 0.16), true)


func _get_impact_texture(color: Color, is_miss: bool) -> Texture2D:
	var key := "%s_%0.3f_%0.3f_%0.3f" % ["miss" if is_miss else "hit", color.r, color.g, color.b]
	if impact_texture_cache.has(key):
		return impact_texture_cache[key]
	var texture := _make_impact_texture(color, is_miss)
	impact_texture_cache[key] = texture
	return texture


func _make_impact_texture(color: Color, is_miss: bool) -> Texture2D:
	var image := Image.create(512, 512, false, Image.FORMAT_RGBA8)
	image.fill(Color(0.0, 0.0, 0.0, 0.0))
	var center := Vector2(256, 256)
	var shadow := Color(0.04, 0.02, 0.07, 0.90)
	var paper := Color(0.98, 0.94, 0.80, 1.0)
	var accent := Color(0.06, 0.70, 0.95, 1.0) if not is_miss else Color(0.04, 0.02, 0.07, 1.0)
	var outer_radius := 176.0 if not is_miss else 204.0
	_draw_poster_star(image, center + Vector2(18, 18), outer_radius, deg_to_rad(-10.0), shadow)
	_draw_poster_star(image, center, outer_radius * 0.94, deg_to_rad(-10.0), paper)
	for i in 8:
		var angle := float(i) / 8.0 * TAU + 0.15
		var p := center + Vector2(cos(angle), sin(angle)) * 28.0
		_draw_rotated_rect(image, p, Vector2(40, 170), angle, color if i % 2 == 0 else accent)
	_draw_poster_star(image, center + Vector2(8, 8), outer_radius * 0.48, deg_to_rad(18.0), shadow)
	_draw_poster_star(image, center, outer_radius * 0.42, deg_to_rad(18.0), color)
	if is_miss:
		_draw_rotated_rect(image, center, Vector2(250, 24), deg_to_rad(-24.0), Color(0.04, 0.02, 0.07, 1.0))
		_draw_rotated_rect(image, center, Vector2(230, 22), deg_to_rad(24.0), Color(0.04, 0.02, 0.07, 1.0))
	return ImageTexture.create_from_image(image)


func _impact_card(size: Vector3, color: Color, emission: float = 0.0) -> MeshInstance3D:
	var node := _box(size, color, emission)
	node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	return node


func _player_pulse(kind: String) -> void:
	if not player:
		return
	var target_scale := Vector3(1.08, 1.08, 1.08) if kind != "heavy" else Vector3(1.16, 1.16, 1.16)
	var target_rot := -5.0 if kind == "heavy" else -2.5
	var tween := create_tween()
	tween.tween_property(player, "scale", target_scale, 0.055).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(player, "rotation_degrees:z", target_rot, 0.055)
	tween.tween_property(player, "scale", Vector3.ONE, 0.13).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _player_miss() -> void:
	if not player:
		return
	var tween := create_tween()
	tween.tween_property(player, "rotation_degrees:z", 7.0, 0.055)
	tween.parallel().tween_property(player, "scale", Vector3(0.94, 0.94, 0.94), 0.055)
	tween.tween_property(player, "rotation_degrees:z", -4.0, 0.07)
	tween.parallel().tween_property(player, "scale", Vector3(1.04, 1.04, 1.04), 0.07)
	tween.tween_property(player, "rotation_degrees:z", 0.0, 0.10)
	tween.parallel().tween_property(player, "scale", Vector3.ONE, 0.10).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _update_drop_mode() -> void:
	if drop_mode:
		return
	var drop_time: float = DROP_TIME
	if song_time >= drop_time:
		drop_mode = true
		_enter_drop_mode()


func _enter_drop_mode() -> void:
	_set_drop_lane_fx_visible(true)
	_add_camera_shake(0.32, 0.18)
	if player and not player_evolved:
		_trigger_evolution()
	_show_judgement("DROP!", Color(1.0, 0.22, 0.55))
	if performance_panel:
		var panel_tween := create_tween()
		panel_tween.tween_property(performance_panel, "scale", Vector3(1.28, 1.28, 1.0), 0.14).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		panel_tween.tween_property(performance_panel, "scale", Vector3(1.08, 1.08, 1.0), 0.18).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	if scoreboard_panel:
		var board_tween := create_tween()
		board_tween.tween_property(scoreboard_panel, "scale", Vector3(1.02, 1.02, 1.0), 0.08).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		board_tween.parallel().tween_property(scoreboard_panel, "rotation_degrees:z", -9.5, 0.07)
		board_tween.tween_property(scoreboard_panel, "scale", Vector3(0.91, 0.91, 1.0), 0.13).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		board_tween.parallel().tween_property(scoreboard_panel, "rotation_degrees:z", -1.5, 0.10)


func _set_drop_lane_fx_visible(visible: bool) -> void:
	for fx in drop_lane_fx:
		if is_instance_valid(fx):
			fx.visible = visible
	for decal in lane_base_decals:
		if is_instance_valid(decal):
			decal.visible = not visible or not enable_drop_lane_decals
	for decal in lane_drop_decals:
		if is_instance_valid(decal):
			decal.visible = visible and enable_drop_lane_decals


func _update_evolution() -> void:
	if player_evolved:
		return
	var evolve_time: float = EVOLUTION_TIME
	if song_time >= evolve_time:
		_trigger_evolution()


func _set_player_evolved(evolved: bool, animate: bool) -> void:
	player_evolved = evolved
	if not player or not player_sprite or not pixel_player_sprite:
		return
	player.scale = Vector3.ONE
	if not animate:
		player_sprite.visible = evolved
		pixel_player_sprite.visible = not evolved
		if player_shadow_sprite:
			player_shadow_sprite.visible = evolved
		if pixel_player_shadow_sprite:
			pixel_player_shadow_sprite.visible = not evolved
		player_sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
		pixel_player_sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
		return

	player_sprite.visible = true
	if player_shadow_sprite:
		player_shadow_sprite.visible = true
	if pixel_player_shadow_sprite:
		pixel_player_shadow_sprite.visible = true
	player_sprite.modulate = Color(1.0, 1.0, 1.0, 0.0)
	pixel_player_sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
	if player_shadow_sprite:
		player_shadow_sprite.modulate = Color(1.0, 1.0, 1.0, 0.0)
	if pixel_player_shadow_sprite:
		pixel_player_shadow_sprite.modulate = Color(1.0, 1.0, 1.0, 0.86)
	var tween := create_tween()
	tween.tween_property(pixel_player_sprite, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.18)
	tween.parallel().tween_property(player_sprite, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.22)
	if player_shadow_sprite:
		tween.parallel().tween_property(player_shadow_sprite, "modulate", Color(1.0, 1.0, 1.0, 0.82), 0.22)
	if pixel_player_shadow_sprite:
		tween.parallel().tween_property(pixel_player_shadow_sprite, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.18)
	tween.parallel().tween_property(player, "scale", Vector3(1.22, 1.22, 1.22), 0.12).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(player, "scale", Vector3.ONE, 0.18).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func() -> void:
		pixel_player_sprite.visible = false
		pixel_player_sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
		if pixel_player_shadow_sprite:
			pixel_player_shadow_sprite.visible = false
			pixel_player_shadow_sprite.modulate = Color(1.0, 1.0, 1.0, 0.86)
	)


func _trigger_evolution() -> void:
	_set_player_evolved(true, true)
	_show_judgement("EVOLVE!", Color(1.0, 0.88, 0.32))
	_add_camera_shake(0.22, 0.12)
	_spawn_hit_burst(player.global_position + Vector3(0.0, 0.4, 0.0), Color(1.0, 0.88, 0.32), 36)
	_spawn_hit_burst(player.global_position + Vector3(0.0, 0.1, 0.0), Color(0.25, 0.95, 1.0), 28)


func _spawn_hit_burst(origin: Vector3, color: Color, count: int) -> void:
	for i in count:
		var particle := _box(Vector3(0.08, 0.08, 0.08), color, 2.8)
		particle.position = origin
		add_child(particle)
		var angle := randf() * TAU
		var distance := randf_range(0.45, 1.65)
		var target := origin + Vector3(cos(angle) * distance, randf_range(0.2, 1.35), sin(angle) * distance)
		var tween := create_tween()
		tween.tween_property(particle, "position", target, 0.22).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(particle, "scale", Vector3(0.12, 0.12, 0.12), 0.08)
		tween.tween_property(particle, "transparency", 1.0, 0.18)
		tween.tween_callback(particle.queue_free)


func _show_judgement(text: String, color: Color) -> void:
	judge_label.text = text
	if not judgement_badge or not judgement_badge_texture or not judgement_badge_text:
		return

	var style := _judgement_style(text)
	var is_stage := _is_stage_judgement(text)
	var texture_path: String = JUDGEMENT_BADGE_PATHS.get(style, JUDGEMENT_BADGE_PATHS["stage"])
	if ResourceLoader.exists(texture_path):
		judgement_badge_texture.texture = load(texture_path)

	judgement_badge_text.text = text
	judgement_badge_text.add_theme_color_override("font_color", _judgement_text_color(style, color))
	var font_size := 58
	if text.length() >= 10:
		font_size = 46
	elif text.length() >= 7:
		font_size = 52
	judgement_badge_text.add_theme_font_size_override("font_size", font_size)

	if judgement_badge_tween and judgement_badge_tween.is_valid():
		judgement_badge_tween.kill()

	var badge_scale := stage_judgement_scale if is_stage else action_judgement_scale
	var animation_strength := stage_judgement_animation_strength if is_stage else action_judgement_animation_strength
	var badge_center := stage_judgement_position if is_stage else _action_judgement_center(badge_scale)
	var base_scale := Vector2.ONE * badge_scale
	var pop_scale := base_scale * (1.0 + animation_strength)
	var tilt := -4.0 if style in ["perfect", "hold", "stage"] else 4.0
	if style == "miss":
		tilt = -7.0
	judgement_badge.position = badge_center - judgement_badge.pivot_offset
	judgement_badge.scale = pop_scale
	judgement_badge.rotation_degrees = tilt * animation_strength
	judgement_badge.modulate = Color.WHITE
	judgement_badge.visible = true

	judgement_badge_tween = create_tween()
	judgement_badge_tween.set_parallel(true)
	judgement_badge_tween.tween_property(judgement_badge, "scale", base_scale, 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	judgement_badge_tween.tween_property(judgement_badge, "rotation_degrees", 0.0, 0.18).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	judgement_badge_tween.set_parallel(false)
	judgement_badge_tween.tween_interval(0.48 if is_stage else 0.30)
	judgement_badge_tween.tween_property(judgement_badge, "modulate:a", 0.0, 0.20)
	judgement_badge_tween.tween_callback(func() -> void: judgement_badge.visible = false)


func _is_stage_judgement(text: String) -> bool:
	return text.to_upper() in ["READY", "DROP!", "EVOLVE!", "STAGE CLEAR", "FAILED"]


func _action_judgement_center(scale_value: float) -> Vector2:
	var viewport_width: float = get_viewport().get_visible_rect().size.x
	var scaled_size := judgement_badge.size * scale_value
	return Vector2(
		viewport_width - action_judgement_right_margin - scaled_size.x * 0.5,
		action_judgement_top + scaled_size.y * 0.5
	)


func _judgement_style(text: String) -> String:
	var normalized := text.to_upper()
	if normalized.contains("PERFECT"):
		return "perfect"
	if normalized.contains("GREAT"):
		return "great"
	if normalized.contains("GOOD"):
		return "good"
	if normalized.contains("MISS") or normalized == "FAILED":
		return "miss"
	if normalized.contains("HOLD"):
		return "hold"
	return "stage"


func _judgement_text_color(style: String, fallback: Color) -> Color:
	match style:
		"perfect":
			return Color(1.0, 0.88, 0.18)
		"great":
			return Color(0.04, 0.86, 0.92)
		"good":
			return Color(0.52, 0.88, 0.18)
		"miss":
			return Color(1.0, 0.22, 0.48)
		"hold":
			return Color(0.58, 0.38, 0.92)
		_:
			return fallback


func _judge_color(text: String) -> Color:
	if text.contains("PERFECT"):
		return Color(1.0, 0.94, 0.35)
	if text.contains("GREAT"):
		return Color(0.35, 0.95, 1.0)
	if text.contains("GOOD"):
		return Color(0.65, 1.0, 0.65)
	return Color(0.96, 0.98, 1.0)


func _play_hit_sound(judgement: String, kind: String) -> void:
	if not hit_player:
		return
	var freq := 760.0
	if judgement.contains("PERFECT"):
		freq = 1120.0
	elif judgement.contains("GREAT"):
		freq = 920.0
	elif kind == "heavy":
		freq = 520.0
	elif kind == "hold":
		freq = 680.0
	elif judgement.contains("MISS"):
		freq = 180.0
	hit_player.pitch_scale = 1.0
	hit_player.stream = _make_tone_stream(freq, 0.055 if not judgement.contains("MISS") else 0.09)
	hit_player.play()


func _add_camera_shake(duration: float, strength: float) -> void:
	camera_shake_time = max(camera_shake_time, duration)
	camera_shake_strength = max(camera_shake_strength, strength)


func _update_camera(delta: float) -> void:
	var target_fov: float = 55.0 + (2.4 if drop_mode else 0.0) + float(min(combo, 40)) * 0.08
	camera.fov = lerpf(camera.fov, target_fov, delta * 4.0)
	if camera_shake_time > 0.0:
		camera_shake_time = max(0.0, camera_shake_time - delta)
		var shake: float = camera_shake_strength * (camera_shake_time / max(0.001, camera_shake_time + delta))
		camera.position = camera_base_position + Vector3(randf_range(-shake, shake), randf_range(-shake, shake), 0.0)
	else:
		camera.position = camera.position.lerp(camera_base_position, delta * 10.0)
	var beat_phase: float = song_time * TAU * max(chart_bpm, 1.0) / 60.0
	if player_evolved:
		var evolved_bounce := 0.125 if drop_mode else 0.085
		player.position.y = 1.35 + sin(beat_phase) * evolved_bounce + sin(beat_phase * 2.0) * 0.030
		player.rotation_degrees.z = sin(beat_phase + 0.35) * (3.6 if drop_mode else 2.35)
		player.rotation_degrees.x = sin(beat_phase * 0.5) * (1.6 if drop_mode else 1.1)
	else:
		var step: float = 1.0 if sin(beat_phase) >= 0.0 else -1.0
		player.position.y = 1.30 + step * 0.045
		player.rotation_degrees.z = step * 1.4
		player.rotation_degrees.x = 0.0


func _update_performance_panel(delta: float) -> void:
	if not performance_panel:
		return
	var beat_duration: float = 60.0 / max(chart_bpm, 1.0)
	var phase: float = (song_time - chart_offset) / beat_duration * TAU
	var beat_pop: float = max(0.0, sin(phase))
	var combo_pop: float = clamp(float(combo) / 40.0, 0.0, 1.0)
	var base_scale := 1.03
	var target_scale := base_scale + beat_pop * (0.028 if drop_mode else 0.010) + combo_pop * 0.018
	performance_panel.scale = performance_panel.scale.lerp(Vector3(target_scale, target_scale, 1.0), delta * 8.0)
	performance_panel.rotation_degrees.z = lerpf(performance_panel.rotation_degrees.z, sin(phase * 0.5) * (1.15 if drop_mode else 0.45), delta * 5.0)


func _update_pattern_background(delta: float) -> void:
	if background_pattern_groups.is_empty():
		return
	var progress: float = clamp(song_time / max(song_length, 0.001), 0.0, 1.0)
	var active_index := 0
	if drop_mode:
		active_index = 2
	elif progress > 0.66:
		active_index = 2
	elif progress > 0.33:
		active_index = 1

	var beat_duration: float = 60.0 / max(chart_bpm, 1.0)
	var phase: float = (song_time - chart_offset) / beat_duration * TAU
	var beat_pop: float = max(0.0, sin(phase))
	for i in background_pattern_groups.size():
		var group := background_pattern_groups[i]
		group.visible = i == active_index
		if not group.visible:
			continue
		var pulse := 1.0 + beat_pop * ((0.046 if drop_mode else 0.018) + float(i) * 0.006)
		group.scale = group.scale.lerp(Vector3(pulse, pulse, 1.0), delta * 7.0)
		group.position.x = lerpf(group.position.x, sin(phase * 0.25 + float(i)) * (0.28 if drop_mode else 0.12), delta * 2.0)
		group.position.y = lerpf(group.position.y, cos(phase * 0.20 + float(i)) * (0.18 if drop_mode else 0.08), delta * 2.0)


func _update_scoreboard_3d(delta: float) -> void:
	if not scoreboard_panel:
		return
	var beat_duration: float = 60.0 / max(chart_bpm, 1.0)
	var phase: float = (song_time - chart_offset) / beat_duration * TAU
	var beat_pop: float = max(0.0, sin(phase))
	var base_scale := 0.88
	var target_scale := base_scale + beat_pop * (0.050 if drop_mode else 0.014)
	scoreboard_panel.scale = scoreboard_panel.scale.lerp(Vector3(target_scale, target_scale, 1.0), delta * 8.0)
	var wobble := sin(phase * 0.5) * (2.20 if drop_mode else 0.55) + sin(phase * 1.5) * (0.55 if drop_mode else 0.12)
	scoreboard_panel.rotation_degrees.z = lerpf(scoreboard_panel.rotation_degrees.z, -2.5 + wobble, delta * 5.0)


func _update_ui() -> void:
	score_label.text = "SCORE %d" % score
	combo_label.text = "COMBO %d" % combo
	var audio_state := "music synced" if music_player and music_player.stream else "no music file"
	if recording_mode:
		status_label.text = "RECORDING %d notes    A/S/D tap    Shift air    Ctrl heavy    R save" % recorded_notes.size()
	else:
		status_label.text = "A / S / D lanes    LIFE %d    BEST %d    %s" % [int(max(life, 0.0)), best, audio_state]
	debug_label.text = "time %05.2fs    offset %+0.03fs ([ / ])    bpm %05.1f (- / =)    metro %s (M)    0 reset" % [
		song_time,
		chart_offset,
		chart_bpm,
		"on" if metronome_enabled else "off"
	]
	if suggested_bpm > 0.0:
		debug_label.text += "    suggested %05.1f (C apply)" % suggested_bpm
	else:
		debug_label.text += "    T tap bpm    R record    G gen d%d" % generator_density
	life_bar.size.x = 300.0 * clamp(life / 100.0, 0.0, 1.0)
	if score_3d_label:
		score_3d_label.text = "SCORE %d" % score
	if combo_3d_label:
		combo_3d_label.text = "COMBO %d" % combo
	if status_3d_label:
		status_3d_label.text = status_label.text
	if debug_3d_label:
		debug_3d_label.text = debug_label.text
	if life_3d_bar:
		var life_ratio: float = clamp(life / 100.0, 0.0, 1.0)
		life_3d_bar.scale.x = life_ratio
		life_3d_bar.position.x = 0.98 + life_ratio * 0.54


func _scheduled_time(note: Dictionary) -> float:
	var scale: float = chart_source_bpm / max(chart_bpm, 1.0)
	return float(note.time) * scale + chart_offset


func _raw_chart_time(real_time: float) -> float:
	var scale: float = chart_source_bpm / max(chart_bpm, 1.0)
	return max(0.0, (real_time - chart_offset) / scale)


func _reset_metronome() -> void:
	var beat_duration := 60.0 / chart_bpm
	next_metronome_beat = max(0, int(floor((song_time - chart_offset) / beat_duration)))


func _update_metronome() -> void:
	if not metronome_enabled or chart_bpm <= 0.0:
		return
	var beat_duration := 60.0 / chart_bpm
	while song_time >= chart_offset + float(next_metronome_beat) * beat_duration:
		if song_time >= 0.0 and metronome_player:
			metronome_player.pitch_scale = 1.45 if next_metronome_beat % 4 == 0 else 1.0
			metronome_player.play()
			hit_line.scale = Vector3(1.0, 1.0, 1.0)
			var tween := create_tween()
			tween.tween_property(hit_line, "scale", Vector3(1.08, 1.0, 1.0), 0.04)
			tween.tween_property(hit_line, "scale", Vector3.ONE, 0.10)
		next_metronome_beat += 1


func _make_click_stream() -> AudioStreamWAV:
	var stream := AudioStreamWAV.new()
	var sample_rate := 44100
	var sample_count := int(sample_rate * 0.045)
	var bytes := PackedByteArray()
	bytes.resize(sample_count * 2)
	for i in sample_count:
		var t := float(i) / float(sample_rate)
		var fade := 1.0 - float(i) / float(sample_count)
		var sample := sin(TAU * 1760.0 * t) * fade * 0.55
		var value := int(clamp(sample, -1.0, 1.0) * 32767.0)
		bytes[i * 2] = value & 0xff
		bytes[i * 2 + 1] = (value >> 8) & 0xff
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	stream.data = bytes
	return stream


func _make_tone_stream(frequency: float, length: float) -> AudioStreamWAV:
	var stream := AudioStreamWAV.new()
	var sample_rate := 44100
	var sample_count := int(sample_rate * length)
	var bytes := PackedByteArray()
	bytes.resize(sample_count * 2)
	for i in sample_count:
		var t := float(i) / float(sample_rate)
		var fade := pow(1.0 - float(i) / float(sample_count), 2.0)
		var sample := sin(TAU * frequency * t) * fade * 0.35
		var value := int(clamp(sample, -1.0, 1.0) * 32767.0)
		bytes[i * 2] = value & 0xff
		bytes[i * 2 + 1] = (value >> 8) & 0xff
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	stream.data = bytes
	return stream


func _note_color(lane: int, kind: String) -> Color:
	if kind == "heavy":
		return Color(1.0, 0.43, 0.04)
	if kind == "air":
		return Color(0.40, 1.0, 0.20)
	if kind == "hold":
		return Color(0.26, 0.50, 0.96)
	return COLORS[lane]


func _note_height(kind: String) -> float:
	if kind == "air":
		return 1.75
	if kind == "hold":
		return 0.62
	return 0.45


func _resize_hold_note(node: Node3D, length: float) -> void:
	var body := node.get_node_or_null("HoldBody")
	if body is MeshInstance3D and (body as MeshInstance3D).mesh is BoxMesh:
		((body as MeshInstance3D).mesh as BoxMesh).size = Vector3(0.06, 0.04, length)
	var rail := node.get_node_or_null("HoldRailSprite")
	if rail is Node3D:
		(rail as Node3D).scale.z = max(1.0, length / 1.6)
	var head := node.get_node_or_null("HoldHead")
	if head is Node3D:
		(head as Node3D).position.z = length * 0.5
	var head_sprite := node.get_node_or_null("HoldHeadSprite")
	if head_sprite is Node3D:
		(head_sprite as Node3D).position.z = length * 0.5 + 0.04
	var tail := node.get_node_or_null("HoldTail")
	if tail is Node3D:
		(tail as Node3D).position.z = -length * 0.5


func _update_note_bounce(node: Node3D, kind: String, hit_time: float) -> void:
	var beat_duration: float = 60.0 / max(chart_bpm, 1.0)
	var phase: float = (song_time - chart_offset) / beat_duration * TAU
	var approach: float = clamp(1.0 - abs(hit_time - song_time) / TRAVEL_TIME, 0.0, 1.0)
	var bounce: float = max(0.0, sin(phase))
	var amount: float = 0.070
	if kind == "heavy":
		amount = 0.120
	elif kind == "air":
		amount = 0.095
	elif kind == "hold":
		amount = 0.048
	var pulse: float = 1.0 + bounce * amount * lerp(0.65, 1.0, approach)
	if kind == "hold":
		node.scale = Vector3(pulse, pulse, 1.0)
	else:
		node.scale = Vector3(pulse, pulse, pulse)


func _update_judge_marker(delta: float) -> void:
	if not judge_marker:
		return
	var target_x: float = LANES[judge_marker_lane]
	judge_marker.position.x = target_x
	judge_marker_pop_time = max(0.0, judge_marker_pop_time - delta)
	var beat_duration: float = 60.0 / max(chart_bpm, 1.0)
	var phase: float = (song_time - chart_offset) / beat_duration * TAU
	var pop: float = judge_marker_pop_time / 0.10
	var pulse: float = 1.0 + max(0.0, sin(phase)) * 0.025 + max(0.0, pop) * 0.24
	judge_marker.scale = Vector3(pulse, pulse, pulse)


func _snap_judge_marker() -> void:
	if not judge_marker:
		return
	judge_marker.position.x = LANES[judge_marker_lane]
	judge_marker_pop_time = 0.10


func _update_torn_gateway(delta: float) -> void:
	if not torn_gateway_tunnel:
		return
	var beat_duration: float = 60.0 / max(chart_bpm, 1.0)
	var phase: float = (song_time - chart_offset) / beat_duration * TAU
	var beat_pop: float = max(0.0, sin(phase))
	var strength: float = torn_tunnel_breathe * (1.85 if drop_mode else 1.0)
	var pulse: float = 1.0 + beat_pop * strength
	torn_gateway_tunnel.scale = torn_gateway_tunnel.scale.lerp(Vector3(pulse, pulse, 1.0), delta * 8.0)
	var rotation_amount: float = torn_tunnel_rotation_degrees * (1.8 if drop_mode else 1.0)
	torn_gateway_tunnel.rotation_degrees.z = lerpf(
		torn_gateway_tunnel.rotation_degrees.z,
		sin(phase * 0.5) * rotation_amount,
		delta * 4.0
	)


func _note_z_for_time(hit_time: float) -> float:
	var time_to_hit: float = hit_time - song_time
	var progress: float = clamp(1.0 - time_to_hit / TRAVEL_TIME, 0.0, 1.0)
	var eased_progress: float = progress * progress * (3.0 - 2.0 * progress)
	var beat_duration: float = 60.0 / max(chart_bpm, 1.0)
	var beat_phase: float = (song_time - chart_offset) / beat_duration * TAU
	var beat_push: float = sin(beat_phase) * 0.035 * sin(progress * PI)
	var final_progress: float = clamp(eased_progress + beat_push, 0.0, 1.0)
	return lerp(SPAWN_Z, HIT_Z, final_progress)


func _box(size: Vector3, color: Color, emission: float = 0.0) -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	mesh.material = _material(color, emission)
	var node := MeshInstance3D.new()
	node.mesh = mesh
	return node


func _cylinder(radius: float, height: float, sides: int, color: Color, emission: float = 0.0) -> MeshInstance3D:
	var mesh := CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius
	mesh.height = height
	mesh.radial_segments = sides
	mesh.rings = 1
	mesh.material = _material(color, emission)
	var node := MeshInstance3D.new()
	node.mesh = mesh
	return node


func _paper_cutout(size: Vector2, color: Color, emission: float = 0.0) -> MeshInstance3D:
	var mesh := QuadMesh.new()
	mesh.size = size
	mesh.material = _material(color, emission)
	var material := mesh.material as StandardMaterial3D
	if material:
		material.cull_mode = BaseMaterial3D.CULL_DISABLED
	var node := MeshInstance3D.new()
	node.mesh = mesh
	node.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	return node


func _ring_disc(radius: float, height: float, color: Color, emission: float = 0.0) -> MeshInstance3D:
	return _cylinder(radius, height, 40, color, emission)


func _make_billboard_sprite(path: String, pixel_size: float, billboard: bool = true) -> Sprite3D:
	var sprite := Sprite3D.new()
	if ResourceLoader.exists(path):
		sprite.texture = load(path)
	sprite.pixel_size = pixel_size
	sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED if billboard else BaseMaterial3D.BILLBOARD_DISABLED
	sprite.no_depth_test = false
	sprite.shaded = false
	sprite.alpha_cut = SpriteBase3D.ALPHA_CUT_DISABLED
	sprite.render_priority = 0
	return sprite


func _make_layered_sprite(path: String, shadow_path: String, pixel_size: float, billboard: bool = true, shadow_offset: Vector3 = Vector3(0.0, -0.06, -0.08)) -> Node3D:
	var root := Node3D.new()
	var shadow := _make_billboard_sprite(shadow_path, pixel_size, billboard)
	shadow.name = "DepthShadow"
	shadow.position = shadow_offset
	shadow.scale = Vector3(1.035, 1.035, 1.035)
	shadow.modulate = Color(1.0, 1.0, 1.0, 0.88)
	shadow.no_depth_test = true
	shadow.render_priority = -10
	root.add_child(shadow)

	var front := _make_billboard_sprite(path, pixel_size, billboard)
	front.name = "FrontSprite"
	front.position.z = 0.02
	front.no_depth_test = true
	front.render_priority = 10
	root.add_child(front)
	return root


func _star_prism(radius: float, height: float, color: Color, emission: float = 0.0) -> Node3D:
	var root := Node3D.new()
	for i in 5:
		var arm := _box(Vector3(radius * 0.36, height, radius * 1.05), color, emission)
		arm.rotation_degrees.y = float(i) * 72.0
		root.add_child(arm)
	var center := _cylinder(radius * 0.28, height * 1.05, 16, color.lerp(Color.WHITE, 0.16), emission)
	root.add_child(center)
	return root


func _sphere(radius: float, color: Color, emission: float = 0.0) -> MeshInstance3D:
	var mesh := SphereMesh.new()
	mesh.radius = radius
	mesh.height = radius * 2.0
	mesh.radial_segments = 32
	mesh.rings = 16
	mesh.material = _material(color, emission)
	var node := MeshInstance3D.new()
	node.mesh = mesh
	return node


func _material(color: Color, emission: float = 0.0) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	if color.a < 0.99:
		material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		material.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_DISABLED
	material.emission_enabled = true
	material.emission = color
	material.emission_energy_multiplier = emission
	return material


func _label(text: String, pos: Vector2, font_size: int) -> Label:
	var label := Label.new()
	label.text = text
	label.position = pos
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", Color(0.16, 0.10, 0.34))
	return label


func _random_star_color(seed: int) -> Color:
	match seed % 4:
		0:
			return Color(1.0, 0.86, 0.03)
		1:
			return Color(0.42, 1.0, 0.24)
		2:
			return Color(0.08, 0.54, 0.96)
		_:
			return Color(0.96, 0.98, 1.0)
