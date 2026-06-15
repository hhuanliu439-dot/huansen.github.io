#!/usr/bin/env python3
"""Generate a flat paper-collage performance stage sprite."""

from __future__ import annotations

import math
import random
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter


ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "assets/backgrounds/performance_stage_collage_v1.png"

W, H = 1600, 1120
RNG = random.Random(614)


def jittered_rect(cx: int, cy: int, w: int, h: int, jitter: int) -> list[tuple[int, int]]:
    left, top = cx - w // 2, cy - h // 2
    right, bottom = cx + w // 2, cy + h // 2
    pts = []
    for x in range(left, right + 1, max(70, w // 10)):
        pts.append((x + RNG.randint(-jitter, jitter), top + RNG.randint(-jitter, jitter)))
    for y in range(top, bottom + 1, max(60, h // 8)):
        pts.append((right + RNG.randint(-jitter, jitter), y + RNG.randint(-jitter, jitter)))
    for x in range(right, left - 1, -max(70, w // 10)):
        pts.append((x + RNG.randint(-jitter, jitter), bottom + RNG.randint(-jitter, jitter)))
    for y in range(bottom, top - 1, -max(60, h // 8)):
        pts.append((left + RNG.randint(-jitter, jitter), y + RNG.randint(-jitter, jitter)))
    return pts


def poly_layer(size: tuple[int, int], points: list[tuple[int, int]], color: tuple[int, int, int, int], blur_shadow=False) -> Image.Image:
    layer = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(layer, "RGBA")
    draw.polygon(points, fill=color)
    if blur_shadow:
        return layer.filter(ImageFilter.GaussianBlur(6))
    return layer


def paste_rot(base: Image.Image, src: Image.Image, xy: tuple[int, int], angle: float) -> None:
    rot = src.rotate(angle, expand=True, resample=Image.Resampling.BICUBIC)
    base.alpha_composite(rot, (xy[0] - rot.width // 2, xy[1] - rot.height // 2))


def paper_texture(layer: Image.Image, strength: int = 12) -> Image.Image:
    pixels = layer.load()
    for y in range(layer.height):
        wave = int(math.sin(y * 0.035) * 3)
        for x in range(layer.width):
            r, g, b, a = pixels[x, y]
            if a == 0:
                continue
            grain = RNG.randint(-strength, strength) + wave
            pixels[x, y] = (
                max(0, min(255, r + grain)),
                max(0, min(255, g + grain)),
                max(0, min(255, b + grain)),
                a,
            )
    return layer


def make_tape(color: tuple[int, int, int, int], w: int, h: int) -> Image.Image:
    tape = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(tape, "RGBA")
    pts = jittered_rect(w // 2, h // 2, w - 12, h - 12, 10)
    draw.polygon(pts, fill=color)
    for _ in range(18):
        x = RNG.randint(10, w - 10)
        draw.line((x, 4, x + RNG.randint(-18, 18), h - 5), fill=(255, 255, 255, 42), width=2)
    return paper_texture(tape, 8)


def draw_halftone(draw: ImageDraw.ImageDraw, center: tuple[int, int], radius: int, color: tuple[int, int, int, int]) -> None:
    spacing = 28
    for y in range(center[1] - radius, center[1] + radius, spacing):
        for x in range(center[0] - radius, center[0] + radius, spacing):
            dist = math.hypot(x - center[0], y - center[1])
            if dist > radius:
                continue
            dot = int(8 + (1 - dist / radius) * 7)
            draw.ellipse((x - dot, y - dot, x + dot, y + dot), fill=color)


def draw_star(draw: ImageDraw.ImageDraw, cx: int, cy: int, r1: int, r2: int, color: tuple[int, int, int, int], outline: tuple[int, int, int, int]) -> None:
    pts = []
    for i in range(10):
        a = -math.pi / 2 + i * math.pi / 5
        r = r1 if i % 2 == 0 else r2
        pts.append((cx + math.cos(a) * r, cy + math.sin(a) * r))
    draw.polygon(pts, fill=outline)
    inner = []
    for i in range(10):
        a = -math.pi / 2 + i * math.pi / 5
        r = max(1, (r1 - 10) if i % 2 == 0 else (r2 - 8))
        inner.append((cx + math.cos(a) * r, cy + math.sin(a) * r))
    draw.polygon(inner, fill=color)


def main() -> None:
    OUT.parent.mkdir(parents=True, exist_ok=True)
    canvas = Image.new("RGBA", (W, H), (0, 0, 0, 0))

    shadow_pts = jittered_rect(800, 575, 1260, 760, 38)
    shadow = poly_layer((W, H), [(x + 46, y + 42) for x, y in shadow_pts], (24, 18, 30, 100), True)
    canvas.alpha_composite(shadow)

    backing_pts = jittered_rect(790, 545, 1260, 780, 44)
    backing = poly_layer((W, H), backing_pts, (240, 230, 204, 245))
    backing = paper_texture(backing, 16)
    canvas.alpha_composite(backing)

    purple_pts = jittered_rect(780, 530, 1180, 690, 32)
    purple = poly_layer((W, H), purple_pts, (78, 39, 121, 242))
    purple = paper_texture(purple, 12)
    canvas.alpha_composite(purple)

    dark_pts = jittered_rect(790, 548, 1030, 560, 22)
    dark = poly_layer((W, H), dark_pts, (37, 25, 31, 244))
    dark = paper_texture(dark, 10)
    canvas.alpha_composite(dark)

    draw = ImageDraw.Draw(canvas, "RGBA")
    for off in (0, 11):
        outline = [(x + off, y + off) for x, y in dark_pts]
        draw.line(outline + [outline[0]], fill=(18, 14, 21, 190), width=10)

    draw_halftone(draw, (575, 590), 250, (29, 173, 181, 92))
    draw_halftone(draw, (1010, 510), 210, (125, 217, 50, 92))
    draw_halftone(draw, (775, 830), 170, (251, 52, 112, 82))

    tapes = [
        ((25, 202, 216, 232), 500, 62, (455, 276), -8),
        ((148, 232, 37, 238), 530, 70, (790, 214), 2),
        ((255, 203, 28, 238), 470, 66, (1035, 335), 24),
        ((255, 92, 18, 238), 96, 510, (1320, 570), -2),
        ((255, 215, 29, 238), 690, 74, (800, 910), -3),
        ((16, 171, 190, 226), 410, 60, (430, 790), -7),
        ((142, 236, 45, 230), 360, 60, (1030, 802), 3),
    ]
    for color, tw, th, pos, angle in tapes:
        paste_rot(canvas, make_tape(color, tw, th), pos, angle)

    for _ in range(46):
        x = RNG.randint(260, 1260)
        y = RNG.randint(290, 870)
        if RNG.random() < 0.58 and 475 < x < 1115 and 355 < y < 745:
            continue
        color = RNG.choice([(245, 238, 211, 185), (30, 24, 34, 185), (21, 183, 205, 175), (255, 203, 27, 185), (255, 61, 118, 175)])
        draw.line((x, y, x + RNG.randint(-80, 80), y + RNG.randint(-46, 46)), fill=color, width=RNG.randint(6, 14))

    for _ in range(22):
        x = RNG.randint(270, 1260)
        y = RNG.randint(260, 890)
        if 510 < x < 1080 and 370 < y < 750:
            continue
        draw_star(draw, x, y, RNG.randint(24, 42), RNG.randint(9, 17), RNG.choice([(255, 213, 31, 230), (26, 190, 210, 220), (255, 72, 129, 220)]), (18, 14, 24, 230))

    for _ in range(95):
        x = RNG.randint(300, 1200)
        y = RNG.randint(330, 805)
        if RNG.random() < 0.65 and 500 < x < 1100 and 360 < y < 740:
            continue
        color = RNG.choice([(31, 183, 196, 135), (122, 212, 42, 128), (255, 207, 28, 132)])
        s = RNG.randint(8, 16)
        draw.rounded_rectangle((x, y, x + s, y + s), radius=3, fill=color)

    for _ in range(10):
        x = RNG.randint(220, 1320)
        y = RNG.randint(220, 930)
        draw.arc((x, y, x + RNG.randint(65, 130), y + RNG.randint(50, 110)), RNG.randint(0, 130), RNG.randint(170, 330), fill=(20, 16, 26, 210), width=6)

    canvas = canvas.filter(ImageFilter.UnsharpMask(radius=1.0, percent=70, threshold=3))
    canvas.save(OUT, optimize=True)
    print(OUT.relative_to(ROOT))


if __name__ == "__main__":
    main()
