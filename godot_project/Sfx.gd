extends Node

var audio_player: AudioStreamPlayer

func _ready() -> void:
    audio_player = AudioStreamPlayer.new()
    var gen = AudioStreamGenerator.new()
    gen.mix_rate = 44100
    gen.buffer_length = 0.1
    audio_player.stream = gen
    add_child(audio_player)

func play_beep(freq: float = 880.0, duration: float = 0.12) -> void:
    if not audio_player or not audio_player.stream:
        return
    var gen = audio_player.stream as AudioStreamGenerator
    audio_player.play()
    var pb = audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
    var sr = gen.mix_rate
    var frames = int(sr * duration)
    for i in range(frames):
        var t = i / sr
        var sample = sin(2.0 * PI * freq * t) * 0.2
        pb.push_frame(Vector2(sample, sample))
