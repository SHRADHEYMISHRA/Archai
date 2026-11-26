# InteriorMind build roadmap

This is a staged product build. A check mark means the item exists in the current prototype; it does not claim production readiness.

## Current foundation

- [x] Offline-first native Windows shell using PySide6.
- [x] Strict JSON design-spec schema and deterministic validation.
- [x] Local project save/open.
- [x] Local GLB import and interactive triangle preview.
- [x] Natural-language brief draft using a transparent rules baseline; schema-valid output and explicit clarification requests.
- [x] Basic scaled 2D footprint plan from the validated specification.
- [x] Accurate-shape guard: rectangular/square plans are supported; unsupported L-shaped/custom requests show a clear rejection instead of a false rectangular preview.
- [x] Explicit room-area capture in square feet/inches/meters/centimeters; area-only prompts ask for length and width, and area/dimension conflicts are checked.
- [x] Basic cutaway 3D schematic derived from the same layout.
- [x] Interactive 3D preview uses parametric bed, sofa, chair, table, and storage meshes with distinct finish colors; this remains presentation geometry, not scanned furniture assets.
- [x] Optional local-only Diffusers concept-image integration and UI action; it refuses network model loading and requires a local checkpoint.
- [ ] Install a compatible, licensed local image model and benchmark generation quality, speed, and VRAM on the RTX 4060.
- [ ] Add reviewed manufacturer-quality furniture assets with redistribution licenses and accurate dimensions.
- [x] Initial offline Blender render to PNG plus editable `.blend` scene; all four wall openings use shared measured positions and preview defaults, while furniture remains procedural preview geometry.
- [x] Schematic 2D plan export to vector SVG and landscape PDF; exports refuse to replace existing files.
- [x] Offline Blender room export to GLB or OBJ plus OBJ material file; GLB export was reopened and parsed by the local viewer.
- [x] Experimental from-scratch decoder-only Transformer for complete schema-JSON generation, with strict validation fallback.
- [x] Local synthetic English/Hinglish/Hindi corpus generation (100,000 rows; supported ready shapes, rejected unsupported shapes, and area-unit coverage) and deterministic leakage-safe 80/10/10 data splitting.
- [ ] Add reviewed licensed prompts, ambiguity/conflict/rejection examples, and independent human evaluation before any production checkpoint.
- [ ] Reviewed domain dataset, leakage-safe train/validation/test splits, meaningful held-out evaluation, and production-quality local inference checkpoint.
- [x] Experimental training supports gradient accumulation and linear learning-rate warmup/decay; schedule configuration is recorded in checkpoints.
- [ ] Resume-from-interruption checkpoints, progress logging, and measured RTX 4060 VRAM/speed validation.
- [x] Basic structured room and furniture editor to reduce routine JSON editing.
- [x] Basic deterministic furniture footprint placement with collision spacing checks and keep-out zones for default door swings/window access; full circulation/accessibility constraints remain future work.
- [ ] Architectural 2D floor-plan editor with direct editing. Users can drag doors/windows along any wall and reposition furniture with collision and opening-clearance validation; width/length dimension lines in entered units now appear in the plan, SVG, and PDF. Wall editing, opening/furniture dimension strings, and construction-ready export remain future work. The structured form and plan support measured openings on all four walls.
- [ ] Production-quality 3D rendering: manufacturer-quality furniture assets, accurate joinery, material and camera controls, full-room visibility for openings on both opposite wall pairs, broader scene interchange QA, and visual regression coverage. The current renderer remains procedural.
- [x] PyInstaller Windows bundle recipe and no-overwrite per-user offline install script; see `docs/OFFLINE_RELEASE.md`.
- [ ] Build and verify on a clean Windows profile with networking disabled; project schema migration, uninstall support, and release validation remain open. Project saves already use a temporary file plus atomic replacement.

No external weights, design assets, or training data are bundled or downloaded without explicit approval.

## Delivery plan and current status

The detailed 12-week implementation plan, exit checks, and common mistakes are in [docs/DEVELOPMENT_GUIDE.md](docs/DEVELOPMENT_GUIDE.md). Weeks 1–2 have a prototype contract and synthetic corpus but still lack reviewed/licensed human data. Later weeks remain planned until their exit evidence exists; the plan does not imply production readiness.
