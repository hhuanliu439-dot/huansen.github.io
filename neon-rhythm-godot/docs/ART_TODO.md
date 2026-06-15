# Neon Rhythm Runner 2.5D Art TODO

Last updated: 2026-06-12

## Art Direction

Current direction: graffiti collage rhythm stage, 2.5D perspective lanes, bright sticker-like notes, and a cute music-ship character named Luma.

Visual keywords:
- Torn paper collage
- Street poster / music zine
- Neon lane paint
- Sticker badges
- Cute cyber-pop mascot
- Readable rhythm-game silhouettes

Primary gameplay colors:
- Left lane: green
- Middle lane: yellow
- Right lane: blue
- Miss / danger: hot pink and red
- Paper base: warm cream
- Ink / shadow: near-black purple

## Current Runtime Screenshots

These are the current reference captures for art QA:

- `docs/screenshots/runtime_03s.png`
- `docs/screenshots/runtime_06s.png`

Observed issues from screenshots:
- First rendered frame can be a flat gray screen before assets appear.
- HUD still reads like a debug prototype.
- Background style is strong and attractive, but it competes with notes in places.
- Judgement badge art exists, but placement and animation need polish.
- Luma is charming, but the left-stage character display needs a more intentional base, shadow, and rhythm pose.

## Resource Inventory

Approximate current PNG counts:

- Backgrounds: 58
- Characters: 24
- Notes: 16
- UI: 7
- Total under `assets`: 105

## Already Wired Into Gameplay

These files are referenced by `scripts/main.gd` and visible or usable in the current game.

### Music And Charts

- `assets/music/Sugar_Rush_Combo.mp3`
- `charts/demo_chart.json`
- `charts/recorded_chart.json`
- `charts/generated_chart.json`

### Stage And Background

- `assets/backgrounds/pop_collage_bg_v1.png`
- `assets/backgrounds/torn_track_gateway_frame_v2.png`
- `assets/backgrounds/torn_gateway_tunnel_v1.png`
- `assets/backgrounds/lane_decals_segmented/lane_green_base_near_v3.png`
- `assets/backgrounds/lane_decals_segmented/lane_green_base_mid_v3.png`
- `assets/backgrounds/lane_decals_segmented/lane_green_base_far_v3.png`
- `assets/backgrounds/lane_decals_segmented/lane_yellow_base_near_v3.png`
- `assets/backgrounds/lane_decals_segmented/lane_yellow_base_mid_v3.png`
- `assets/backgrounds/lane_decals_segmented/lane_yellow_base_far_v3.png`
- `assets/backgrounds/lane_decals_segmented/lane_blue_base_near_v3.png`
- `assets/backgrounds/lane_decals_segmented/lane_blue_base_mid_v3.png`
- `assets/backgrounds/lane_decals_segmented/lane_blue_base_far_v3.png`
- Drop variants for all three lanes in `assets/backgrounds/lane_decals_segmented/`

### Character

- `assets/characters/luma_music_ship_graffiti_v2.png`
- `assets/characters/luma_pixel_ship_low_v1.png`
- `assets/characters/luma_music_ship_graffiti_print_shadow_v1.png`
- `assets/characters/luma_pixel_ship_print_shadow_v1.png`

### Notes

- `assets/notes/note_tap_v1.png`
- `assets/notes/note_heavy_v1.png`
- `assets/notes/note_air_v2.png`
- `assets/notes/note_hold_head_v1.png`
- `assets/notes/note_hold_rail_v1.png`
- `assets/notes/note_judgeline_v1.png`
- Shadow variants for each note type in `assets/notes/`

### Judgement UI

- `assets/ui/judgement/badge_perfect_v1.png`
- `assets/ui/judgement/badge_great_v1.png`
- `assets/ui/judgement/badge_good_v1.png`
- `assets/ui/judgement/badge_miss_v1.png`
- `assets/ui/judgement/badge_hold_v1.png`
- `assets/ui/judgement/badge_stage_v1.png`

## Candidate Or Source Resources

These can be reused, cleaned, or promoted into final assets.

### Background Candidates

- `assets/backgrounds/performance_stage_collage_v1.png`
- `assets/backgrounds/torn_track_gateway_v1.png`
- `assets/backgrounds/lane_decals/*.png`
- `assets/backgrounds/lane_scraps/*.png`
- `assets/backgrounds/source/*.png`

### Character Candidates

- `assets/characters/luma_music_ship_v1.png`
- `assets/characters/luma_music_ship_graffiti_v1.png`
- `assets/characters/luma_pixel_ship_graffiti_v1.png`
- `assets/characters/luma_pixel_ship_low_clean_v1.png`
- `assets/characters/luma_pixel_v1.png`
- `assets/characters/luma_pixel_v2.png`
- `assets/characters/concepts/*.png`
- `assets/characters/concepts/views/*.png`

### Note Source Sheets

- `assets/notes/source/core_notes_sheet_v1.png`
- `assets/notes/source/core_notes_sheet_v1_chroma.png`

### UI Source Sheets

- `assets/ui/source/judgement_badges_sheet_source_v1.png`

## Missing Final Art Sets

Use this as the main checklist. Each item should end with an in-game screenshot pass.

### 1. Title And Entry Flow

- [ ] Title screen background
- [ ] Neon Rhythm Runner 2.5D logo treatment
- [ ] Start button
- [ ] Song card for `Sugar_Rush_Combo.mp3`
- [ ] Difficulty / mode sticker
- [ ] Input hint strip for A / S / D / Space
- [ ] Transition from title to gameplay

Acceptance:
- Title screen feels like the same graffiti music world as gameplay.
- No gray-screen start is visible in normal play.
- Player can start the chart without seeing debug UI first.

### 2. Countdown And Start Feedback

- [ ] READY sticker
- [ ] 3 / 2 / 1 / GO sticker sequence
- [ ] Beat-synced pop animation
- [ ] Start-line flash or lane pulse

Acceptance:
- The song start has a readable visual lead-in.
- The first playable note is not visually surprising or unfair.

### 3. Gameplay HUD

- [ ] Final score panel
- [ ] Final combo display
- [ ] Life meter
- [ ] Best score display
- [ ] Song progress display
- [ ] Formal debug toggle, with debug text hidden by default

Acceptance:
- HUD reads clearly at 1600x900.
- HUD does not cover the hit line, notes, or Luma.
- Debug/calibration text is not part of the normal art presentation.

### 4. Judgement And Hit VFX

- [ ] Perfect badge placement and animation
- [ ] Great badge placement and animation
- [ ] Good badge placement and animation
- [ ] Miss badge placement and animation
- [ ] Lane hit burst for green lane
- [ ] Lane hit burst for yellow lane
- [ ] Lane hit burst for blue lane
- [ ] Miss burst
- [ ] Combo milestone sticker, e.g. 25 / 50 / 100 combo

Acceptance:
- Judgements are readable but do not obscure incoming notes.
- Hit effects make timing feel satisfying without hiding the lane.

### 5. Note Set Polish

- [ ] Tap note final
- [ ] Heavy note final
- [ ] Air note final
- [ ] Hold head final
- [ ] Hold rail final
- [ ] Hold tail or release marker
- [ ] Judgeline marker final
- [ ] Note shadow consistency pass

Acceptance:
- Each note type has a distinct silhouette.
- Notes remain readable over both normal and drop backgrounds.

### 6. Luma Character Stage

- [ ] Luma idle pose or loop
- [ ] Luma hit reaction
- [ ] Luma miss reaction
- [ ] Luma combo reaction
- [ ] Drop/evolved Luma look
- [ ] Stage base or platform under Luma
- [ ] Better Luma shadow/contact with the scene

Acceptance:
- Luma feels integrated into the stage, not pasted over it.
- Character animation gives rhythm energy without distracting from play.

### 7. Background And Lane Readability

- [ ] Background dimming or readability overlay behind lanes
- [ ] Lane side borders final
- [ ] Near/mid/far lane decal consistency pass
- [ ] Drop lane decal consistency pass
- [ ] Gateway/tunnel scale and placement polish
- [ ] Background motion pass

Acceptance:
- Notes can be read instantly on all three lanes.
- Background keeps the collage personality without overpowering gameplay.

### 8. Pause, Fail, And Results Screens

- [ ] Pause panel
- [ ] Resume button
- [ ] Restart button
- [ ] Fail screen
- [ ] Results screen
- [ ] Rank badges: S / A / B / C / D
- [ ] Result stats layout: Score, Max Combo, Perfect, Great, Good, Miss

Acceptance:
- The demo has a complete presentation loop: title, play, fail/results, restart.

### 9. Asset Cleanup

- [ ] Promote final generated assets out of `tmp/`
- [ ] Keep source sheets under `assets/**/source/`
- [ ] Remove or archive unused duplicate candidates
- [ ] Normalize final asset names
- [ ] Add import settings notes for pixel-art assets

Acceptance:
- A new contributor can tell which assets are final and which are sources.

## Suggested Build Order

1. Hide/debug-clean current HUD and create final gameplay HUD.
2. Add countdown/start feedback to remove gray/prototype start feel.
3. Polish judgement badges and hit VFX.
4. Integrate Luma with a stage base and simple reactions.
5. Add title screen.
6. Add results/fail screens.
7. Final background and lane readability pass.
8. Cleanup and screenshot pass.

## Screenshot QA Checklist

Capture these after each major art task:

- Title screen
- Countdown
- Normal gameplay at 3-6 seconds
- Dense note moment
- Drop section
- Miss moment
- Good combo moment
- Results screen
