# ARCHIAI

ARCHIAI is an interior renovation workspace with a Next.js interface and a FastAPI layout service.

## Run locally

1. In `backend`, create and activate a Python virtual environment, then install dependencies with `pip install -r requirements.txt`.
2. Start the API from `backend` with `uvicorn app.main:app --reload --port 8000`.
3. In a second terminal, open `frontend`, install packages with `npm ci`, and start the interface with `npm run dev`.
4. Open <http://localhost:3000>.

Photorealistic image rendering uses the optional GPU stack described in `ai_services/requirements.txt` and downloads model weights on first use.
