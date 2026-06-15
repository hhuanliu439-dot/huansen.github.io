#!/usr/bin/env python3
"""Build perspective-aware lane decal mothers and near/mid/far PNG segments."""

from __future__ import annotations

import math
import random
from pathlib import Path

from PIL import Image, ImageDraw, ImageEnhance, ImageFilter


ROOT = Path(__file__).resolve().parents[1]
SCRAPS_DIR = ROOT / "assets/backgrounds/lane_scraps"
OUTPUT_DIR = ROOT / "assets/backgrounds/lane_decals_segmented"
SOURCE_DIR = ROOT / "assets/backgrounds/source"

WIDTH = 512
HEIGHT = 6144
SEGMENTS = {
    "far": (0, 2380),
    "mid": (2300, 4540),
    "near": (4460, HEIGHT),
}

LANES = {
    "green": (126, 180, 61),
    "yellow": (239, 184, 45),
    "blue": (42, 160, 184),
}

ACCENTS = [
    (250, 43, 116),
    (19, 183, 202),
    (255, 210, 32),
    (101, 56, 158),
    (245, 238, 211),
    (22, 18, 34),
]


def alpha_composite_at(canvas: Image.Image, image: Image.Image, xy: tuple[int, int]) -> None:
    canvas.alpha_composite(image, xy)


def irregular_strip_mask(seed: int) -> Image.Image:
    rng = random.Random(seed)
    mask = Image.new("L", (WIDTH, HEIGHT), 0)
    draw = ImageDraw.Draw(mask)
    left = []
    right = []
    step = 48
    for y in range(-step, HEIGHT + step, step):
        edge = 18 + rng.randint(-7, 8)
        left.append((edge, y))
        right.append((WIDTH - edge, y))
    draw.polygon(left + list(reversed(right)), fill=232)
    return mask.filter(ImageFilter.GaussianBlur(0.45))


def paper_fill(rgb: tuple[int, int, int], seed: int, drop: bool) -> Image.Image:
    rng = random.Random(seed)
    image = Image.new("RGBA", (WIDTH, HEIGHT), (*rgb, 0))
    pixels = image.load()
    base_alpha = 216 if drop else 198
    for y in range(HEIGHT):
        vertical = 7 * math.sin(y * 0.006) + 4 * math.sin(y * 0.019)
        for x in range(WIDTH):
            grain = rng.randint(-10, 10)
            center_fade = max(0.0, 1.0 - abs(x - WIDTH / 2) / (WIDTH * 0.28))
            clean_center = int(center_fade * (24 if drop else 34))
            pixels[x, y] = (
                max(0, min(255, rgb[0] + grain + int(vertical))),
                max(0, min(255, rgb[1] + grain + int(vertical))),
                max(0, min(255, rgb[2] + grain + int(vertical))),
                max(96, base_alpha - clean_center),
            )
    image.putalpha(Image.composite(image.getchannel("A"), Image.new("L", image.size, 0), irregular_strip_mask(seed + 91)))
    return image


def draw_torn_edges(canvas: Image.Image, seed: int, drop: bool) -> None:
    rng = random.Random(seed)
    draw = ImageDraw.Draw(canvas, "RGBA")
    paper = (248, 238, 211, 225 if drop else 205)
    ink = (19, 15, 28, 210 if drop else 165)
    for side in (0, 1):
        edge_x = 18 if side == 0 else WIDTH - 18
        for y in range(0, HEIGHT, 86):
            inward = rng.randint(14, 42)
            outward = rng.randint(2, 14)
            if side == 0:
                points = [(edge_x - outward, y), (edge_x + inward, y + 43), (edge_x - outward, y + 86)]
            else:
                points = [(edge_x + outward, y), (edge_x - inward, y + 43), (edge_x + outward, y + 86)]
            draw.polygon(points, fill=paper)
            if rng.random() < 0.55:
                x0 = edge_x + (inward * 0.25 if side == 0 else -inward * 0.25)
                draw.line((x0, y + 18, x0 + (-10 if side == 0 else 10), y + 66), fill=ink, width=5)


def draw_halftone(draw: ImageDraw.ImageDraw, x: int, y: int, radius: int, alpha: int) -> None:
    spacing = max(10, radius // 5)
    dot_radius = max(2, spacing // 4)
    for py in range(y - radius, y + radius, spacing):
        for px in range(x - radius, x + radius, spacing):
            if (px - x) ** 2 + (py - y) ** 2 <= radius**2:
                draw.ellipse((px - dot_radius, py - dot_radius, px + dot_radius, py + dot_radius), fill=(18, 14, 28, alpha))


def draw_chevrons(draw: ImageDraw.ImageDraw, y: int, size: int, alpha: int) -> None:
    color = (248, 238, 211, alpha)
    cx = WIDTH // 2
    for offset in (-size // 2, size // 2):
        yy = y + offset
        draw.line((cx - size, yy + size // 2, cx, yy, cx + size, yy + size // 2), fill=color, width=max(8, size // 6), joint="curve")


def paste_scrap(
    canvas: Image.Image,
    scrap: Image.Image,
    x: int,
    y: int,
    target_width: int,
    rotation: float,
    alpha: float,
) -> None:
    scale = target_width / scrap.width
    resized = scrap.resize((target_width, max(1, int(scrap.height * scale))), Image.Resampling.LANCZOS)
    if alpha < 1.0:
        resized.putalpha(resized.getchannel("A").point(lambda value: int(value * alpha)))
    rotated = resized.rotate(rotation, expand=True, resample=Image.Resampling.BICUBIC)
    alpha_composite_at(canvas, rotated, (x - rotated.width // 2, y - rotated.height // 2))


def decorate(canvas: Image.Image, seed: int, drop: bool) -> None:
    rng = random.Random(seed)
    scraps = [Image.open(path).convert("RGBA") for path in sorted(SCRAPS_DIR.glob("lane_scrap_*.png"))]
    draw = ImageDraw.Draw(canvas, "RGBA")

    zones = [
        (0, 2300, 8 if drop else 6, (90, 155), 0.48),
        (2250, 4500, 12 if drop else 9, (140, 230), 0.72),
        (4450, HEIGHT, 8 if drop else 6, (220, 350), 0.94),
    ]
    for y0, y1, count, widths, opacity in zones:
        for i in range(count):
            side = -1 if i % 2 == 0 else 1
            x = rng.randint(50, 142) if side < 0 else rng.randint(WIDTH - 142, WIDTH - 50)
            y = rng.randint(y0 + 80, y1 - 80)
            width = rng.randint(*widths)
            rotation = rng.uniform(72, 88) * side
            paste_scrap(canvas, rng.choice(scraps), x, y, width, rotation, opacity)

    for y, radius, alpha in [(620, 70, 100), (1880, 95, 115), (3400, 125, 135), (5200, 170, 155)]:
        draw_halftone(draw, 55 if (y // 600) % 2 == 0 else WIDTH - 55, y, radius, alpha)

    draw_chevrons(draw, 5320, 54, 225 if drop else 190)
    draw_chevrons(draw, 3650, 36, 190 if drop else 150)

    stroke_count = 38 if drop else 24
    for _ in range(stroke_count):
        y = rng.randrange(120, HEIGHT - 120)
        near_factor = 0.45 + 0.8 * (y / HEIGHT)
        length = int(rng.randint(28, 80) * near_factor)
        side = rng.choice((-1, 1))
        x = rng.randint(25, 130) if side < 0 else rng.randint(WIDTH - 130, WIDTH - 25)
        color = (*rng.choice(ACCENTS), rng.randint(115, 205))
        draw.line((x, y, x + side * length, y - rng.randint(16, 62)), fill=color, width=rng.randint(4, 10))


def build_mother(lane: str, rgb: tuple[int, int, int], mode: str) -> Image.Image:
    drop = mode == "drop"
    seed = sum(ord(char) for char in f"{lane}-{mode}") * 97
    canvas = paper_fill(rgb, seed, drop)
    draw_torn_edges(canvas, seed + 7, drop)
    decorate(canvas, seed + 19, drop)
    if not drop:
        canvas = ImageEnhance.Contrast(canvas).enhance(0.93)
    return canvas


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    SOURCE_DIR.mkdir(parents=True, exist_ok=True)
    for lane, rgb in LANES.items():
        for mode in ("base", "drop"):
            mother = build_mother(lane, rgb, mode)
            mother_path = SOURCE_DIR / f"lane_{lane}_{mode}_mother_v3.png"
            mother.save(mother_path, optimize=True)
            for segment, (top, bottom) in SEGMENTS.items():
                crop = mother.crop((0, top, WIDTH, bottom))
                crop.save(OUTPUT_DIR / f"lane_{lane}_{mode}_{segment}_v3.png", optimize=True)
            print(mother_path.relative_to(ROOT))


if __name__ == "__main__":
    main()
