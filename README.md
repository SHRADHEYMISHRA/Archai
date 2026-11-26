# InteriorMind

An offline-first native Windows prototype for turning architectural briefs into validated design specifications. It includes a deterministic local brief-drafting baseline, structured design fields, strict JSON schema validation, local project files, a scaled 2D furniture-footprint plan, a color/material-aware interactive room view with detailed local parametric furniture, an offline Blender image/scene renderer, a separate local GLB viewer, and an optional local image-generation integration. The brief baseline is **not a trained model**; room and furniture previews are design concepts, not photorealistic manufacturer assets or an architectural approval.

See the [original-request audit](docs/IMPLEMENTATION_AUDIT.md) for a requirement-by-requirement status and the [ten reference prompts and outputs](examples/architect_prompt_reference.jsonl).

The Windows packaging and per-user offline-install workflow is documented in [docs/OFFLINE_RELEASE.md](docs/OFFLINE_RELEASE.md). It is a build recipe, not a clean-machine verified release yet.

## Run

Requires 64-bit Python 3.13 or 3.14, Windows 10/11, and a GPU driver with OpenGL support. For everyday use, double-click `Start-InteriorMind.bat`. For setup or troubleshooting, use PowerShell from this folder:

```powershell
& "$env:LOCALAPPDATA\Python\bin\python.exe" -m venv .venv
.\.venv\Scripts\python -m pip install --upgrade pip
.\.venv\Scripts\python -m pip install -e .
.\.venv\Scripts\python -m interiormind.app
```

Package installation needs internet once unless wheels are already available. Normal app use is offline. No pretrained or third-party weights/assets are included. Locally trained synthetic-only experiment checkpoints are not enabled by default. The sample GLB was generated locally for this prototype.

Use the “Draft from brief” button to create a schema-checked starting specification. Review missing details in the clarification list, adjust values in “Design fields” or “Advanced JSON,” and validate before saving. The current parser only recognizes a limited local vocabulary. Furniture placement avoids collisions and reserves clearance for the default door swing and window access area. The floor plan shows measured width and length dimensions in the units entered; the same dimension annotations are included in vector SVG and landscape PDF exports. Read [ROADMAP.md](ROADMAP.md) and the [development guide](docs/DEVELOPMENT_GUIDE.md) for remaining build stages and known failure modes.

In the 2D plan, drag a door or window's round handle along its wall, or drag a furniture footprint to reposition it. The editor updates the design JSON and structured fields together and rejects moves that leave the room, collide with another item, or block an opening clearance. Dragging one piece from a quantity group makes only that piece individually positioned. Furniture coordinates are added by the deterministic editor in room units; the prompt model does not generate them. Saved positions are restored when the design is reopened.

The Openings fields support all four walls, center offset, width, height, and window sill height, all in the room's units. A single opening can have an exact offset; groups are evenly spaced along their selected wall. The geometry validator rejects openings that exceed their wall or ceiling and detects overlapping openings. The 2D plan draws openings on every wall. The 3D cutaway selects the opposite camera-facing wall pair with the most openings; if some openings are on the hidden pair, the app reports that limitation.

The current room geometry supports rectangular and square footprints. L-shaped and custom footprints are rejected or shown with an explicit unsupported-shape message; InteriorMind will not draw them as a misleading rectangle.

An explicitly stated room area can be recorded in square feet, square inches, square meters, or square centimeters. Area by itself does not determine room proportions, so the app preserves it and asks for length and width before planning. When both area and dimensions are supplied, the validator checks that they agree within a small rounding tolerance.

If Blender is present in the bundled `tools/blender-5.2.4` folder, `PATH`, or `INTERIORMIND_BLENDER`, “Render 3D image…” creates a PNG and matching editable `.blend` scene on this PC. The renderer and 2D plan consume the same validated opening positions and layout clearances. The interactive furniture view uses parametric local mesh models for beds, sofas, chairs, tables, and storage. The renderer adds locally built details such as cushions, frames, legs, panels, and finish colors. These are presentation models, not scanned or manufacturer-accurate assets, and the result is not construction-ready. “Export room as GLB / OBJ…” produces a textured 3D interchange model from the validated scene; OBJ includes a companion `.mtl` file. The 2D plan can also be exported as vector SVG or PDF; plan exports remain schematic.

## Local AI concept images

The “Generate AI concept image…” action first renders the validated room locally in Blender, then uses a compatible Diffusers-format image-to-image model selected from this PC, with network access disabled. This gives the image model a room preview to stylize; it still cannot preserve or verify exact dimensions. Install the optional package set with `python -m pip install -r requirements-imagegen.txt`, then select a local model folder containing `model_index.json`. InteriorMind does not bundle or download model weights. The current PC inspection found no Diffusers package or local image model, so this action remains unavailable until a compatible checkpoint is supplied. See [Diffusers image-to-image](https://huggingface.co/docs/diffusers/api/pipelines/stable_diffusion/img2img) and the [local-only loading option](https://huggingface.co/docs/diffusers/v0.42.0/api/pipelines/stable_diffusion/text2img).

## Experimental model training

The app remains on the rules baseline unless `models/architect_prompt_net.pt` contains a reviewed production-format checkpoint. Training checkpoints are marked experimental and are rejected by normal app loading. Optional CUDA training support is separate from normal app dependencies. The current local synthetic corpus is `data/generated/synthetic-100000-area-aware-v5.jsonl`; it was generated on this PC and is ready for experimental training. Install CUDA training support separately with `python -m pip install -r requirements-training-cu130.txt`, then train and evaluate:

```powershell
.\.venv\Scripts\python tools\train_architect_prompt_net.py data\generated\synthetic-100000-area-aware-v5.jsonl models\architect_prompt_net_experimental.pt --epochs 20 --batch-size 8 --device cuda
.\.venv\Scripts\python tools\evaluate_architect_prompt_net.py data\generated\synthetic-100000-area-aware-v5.jsonl models\architect_prompt_net_experimental.pt --limit 100 --device cuda
```

The generator creates synthetic English, Hinglish, and Hindi prompts. Training uses a deterministic 80/10/10 split grouped by identical target specifications, gradient accumulation, and linear warmup/decay. The generation and training tools refuse to overwrite an existing destination. Evaluation reports field accuracy, unit-normalized dimension error, furniture/opening/color/material/constraint precision/recall/F1, extra predicted items, rejection behavior, JSON/schema validity, and separates rules fallbacks from accepted model outputs. Synthetic metrics only measure the generated prompt grammar. They are not evidence of reliable understanding of real architectural briefs. Use a reviewed, licensed human dataset and separate validation set before deploying a trained checkpoint. See [the implementation audit](docs/IMPLEMENTATION_AUDIT.md) for the remaining requirements.
