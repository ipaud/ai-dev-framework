# Adapter: GestureLab

> Worked example. Proves the core/adapter separation: every stack-specific detail lives here,
> none in `adf/core/`. GestureLab maps hand gestures (camera) to sound in real time.

## Stack

- **UI:** React 18 + TypeScript, built with Vite.
- **Styling:** Tailwind CSS.
- **Hand tracking:** MediaPipe Hand Landmarker (WASM).
- **Audio:** Tone.js over the Web Audio API.
- **MIDI:** Web MIDI (optional output).
- **Package manager:** pnpm.

## Gate commands (per tier)

A loop closes only when its tier's gates are green, with real output pasted into Validate.

| Gate | Command | trivial | change | feature |
|---|---|:---:|:---:|:---:|
| build | `pnpm build` |  | ✓ | ✓ |
| typecheck | `pnpm typecheck` |  | ✓ | ✓ |
| lint | `pnpm lint` | ✓ | ✓ | ✓ |
| test | `pnpm test` |  | ✓ | ✓ |
| test (affected) | `pnpm test:affected` | ✓ |  |  |
| performance | `pnpm perf` (size-limit) |  |  | ✓ |
| security | `pnpm audit` |  |  | ✓ |

## Performance budget

The performance-review skill checks against these:

- **Gesture→sound latency < 50 ms** end to end (landmark detected → audible change).
- **Sustained 60 fps** with the Hand Landmarker running; no dropped frames under load.
- **No per-frame allocations** in the render or landmark loop — reuse buffers/objects.
- **Initial JS < 250 KB gzip**; MediaPipe WASM is **lazy-loaded**, not in the initial bundle.
- **The landmark stream must not trigger a React re-render per frame** — landmarks flow through a
  ref/event channel, not component state.

## Security specifics

- **Camera permission is requested lazily, on an explicit user action** — never on page load.
- **No frames leave the device.** No network call in the capture path; processing is fully local.
- **CSP allows no inline scripts** (nonce-based; see ADF web security guidance).
- Web MIDI access is optional and requested only when the user enables MIDI output.

## Design tokens

The design-system skill enforces use of these (Tailwind theme + CSS custom properties):

- **Color:** `--color-surface`, `--color-text`, `--color-accent`, `--color-active` (gesture-on).
- **Type:** `--text-base`, `--text-display` (fluid `clamp()`).
- **Spacing:** `--space-1 … --space-8` scale.
- **Radius:** `--radius-sm`, `--radius-lg`.
- **Motion:** `--duration-fast`, `--ease-out-expo`; respect reduced-motion.

## Conventions

- **The audio engine and the gesture engine are separate modules.** Neither imports the other;
  they communicate through a thin mapping layer.
- **The UI never owns audio state.** Audio state lives in the audio engine; the UI observes it.
- Landmark data is hot-path: keep it out of React state (see the performance budget).

## Project skills

- **`gesture-mapping`** (in `adf-adapter/skills/gesture-mapping/`) — how to map landmark
  geometry to musical parameters: which landmarks, smoothing, range mapping, and debouncing. A
  project-specific skill; promote to core only after it proves useful in ≥2 projects (ADR-0006).

## Project agents

- None yet. Add under `adf-adapter/agents/` if a GestureLab-specific reviewer is warranted.
