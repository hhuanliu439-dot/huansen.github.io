# Neon Rhythm Runner 2.5D

Godot 4.6 prototype for a 2.5D rhythm runner.

## Run

Open this folder in Godot:

```text
outputs/neon-rhythm-godot
```

Or run from the workspace root:

```bash
/Applications/Godot.app/Contents/MacOS/Godot --path outputs/neon-rhythm-godot
```

## Controls

- `A`: left lane
- `S`: middle lane
- `D`: right lane
- `Space`: hold note
- `Enter`: restart
- `F11`: toggle fullscreen / maximized preview
- `[`: chart offset -0.01s
- `]`: chart offset +0.01s
- `-`: BPM -0.1, also stretches the chart later
- `=`: BPM +0.1, also compresses the chart earlier
- `M`: toggle metronome click
- `0`: reset offset to 0
- `T`: tap along to the beat and estimate BPM
- `C`: apply the suggested BPM from beat taps
- `R`: start/stop chart recording
- `1`: simple beat chart, recommended first pass
- `2`: simple beat chart with a few off-beat taps
- `3`: denser chart with a few Hold notes
- `G`: generate a basic chart from the current BPM
- In recording mode, `A/S/D` records Tap notes
- In recording mode, `Shift + A/S/D` records Air notes
- In recording mode, `Ctrl + A/S/D` records Heavy notes
- In recording mode, `Space` records a 2-beat Hold note

## Current Prototype

- Real OGG music playback through `AudioStreamPlayer`
- Current test track: `Sugar_Rush_Combo.mp3`, user-provided Gemini generation
- Note timing follows corrected audio time: playback position + mix time - output latency
- Live calibration controls for chart offset, BPM grid, and metronome
- BPM calibration scales the moving notes from `source_bpm` to `bpm`
- Runtime chart recorder saves to `res://charts/recorded_chart.json`
- Basic chart generator saves to `res://charts/generated_chart.json`
- Loaded demo charts are automatically extended with basic notes if they end too early
- 3D neon lanes with fixed readable hit line
- Notes spawn from depth and travel toward the player
- JSON-driven demo chart at `res://charts/demo_chart.json`
- Tap judgement: Perfect / Great / Good / Miss
- Note types: Tap, Heavy, Air, Hold
- Score, combo, life, best score UI
- Hit feedback: judgement pop, short hit tones, burst particles, lane flash, light camera shake
- Temporary visual direction: darker stage/lanes with brighter notes and hit effects
- Temporary Luma character Billboard from `res://assets/characters/luma.png`
- Preview window starts at 1600x900 and maximizes on launch
- Simple combo-driven camera FOV feedback
- Generated placeholder 3D blocks, no external art required

## Note Types

- `tap`: round disc with white center, basic lane hit
- `heavy`: larger glowing accent with bright core, for strong beats
- `air`: elevated diamond with vertical marker, for upper-layer notes
- `hold`: long glowing rail with head/tail markers, press `Space` on time and keep holding

## Recording A Chart

1. Calibrate `bpm` and `offset` first.
2. Press `R` to restart the song in recording mode.
3. Tap `A/S/D` along with the music to record notes.
4. Hold `Shift` while tapping to record Air notes.
5. Hold `Ctrl` while tapping to record Heavy notes.
6. Press `Space` to record a 2-beat Hold note.
7. Press `R` again to save `res://charts/recorded_chart.json`.
8. Replace the `notes` array in `demo_chart.json` with the recorded notes once the take feels good.

## Generating A Basic Chart

1. Calibrate `bpm` and `offset` first.
2. Press `1`, `2`, or `3` to choose density.
3. Press `G` to generate a playable skeleton chart. Start with `1`.
4. The generated chart is saved to `res://charts/generated_chart.json`.
5. The game immediately restarts using the generated notes, so you can play-test it right away.

## Next Step

1. Use `T` to tap 8-16 steady beats from the music, then press `C` to apply the suggested BPM.
2. Use `M` and listen through the whole phrase to check whether the metronome drifts.
3. Use `[ / ]` to fix any remaining constant early/late offset.
4. Write the final `bpm` and `offset` back to `res://charts/demo_chart.json`.
5. Convert a good generated or recorded take into the main demo chart.
6. Add section-aware generation for intro, build, drop, and break.
7. Add Flick and Hold recording.
8. Crop/simplify the Luma sprite for gameplay readability.
9. Replace placeholder blocks with AI-generated rhythm-game assets.
10. Add character puppet run/attack animations and hit VFX.
