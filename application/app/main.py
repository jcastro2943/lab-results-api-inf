import os
import socket
import time
from datetime import datetime, timezone

from fastapi import FastAPI

APP_VERSION = os.getenv("APP_VERSION", "1.0.0")
START_TIME = time.time()

app = FastAPI(
    title="Laboratory Results API",
    description="Demo API serving simulated patient laboratory test results",
    version=APP_VERSION,
)


@app.get("/")
def root():
    return {
        "title": "Laboratory API",
        "version": APP_VERSION,
        "description": "Demo service for simulated patient laboratory results",
        "hostname": socket.gethostname(),
        "status": "operational",
    }


@app.get("/health")
def health():
    return {"status": "healthy"}


@app.get("/info")
def info():
    return {
        "service": "laboratory-api",
        "version": APP_VERSION,
        "hostname": socket.gethostname(),
        "uptime_seconds": round(time.time() - START_TIME, 2),
        "server_time_utc": datetime.now(timezone.utc).isoformat(),
    }


@app.get("/results")
def get_lab_results():
    """Returns static, hardcoded patient laboratory test results for demo purposes."""
    return {
        "patient_id": "PAT-98765",
        "specimen_id": "SPEC-456789",
        "collected_at": "2026-08-25T10:00:00Z",
        "status": "FINAL",
        "panels": [
            {
                "panel_name": "Complete Blood Count (CBC)",
                "tests": [
                    {
                        "code": "WBC",
                        "name": "White Blood Cell Count",
                        "value": 6.5,
                        "unit": "x10^3/uL",
                        "reference_range": "4.5 - 11.0",
                        "flag": "NORMAL",
                    },
                    {
                        "code": "RBC",
                        "name": "Red Blood Cell Count",
                        "value": 4.8,
                        "unit": "x10^6/uL",
                        "reference_range": "4.3 - 5.9",
                        "flag": "NORMAL",
                    },
                    {
                        "code": "HGB",
                        "name": "Hemoglobin",
                        "value": 11.2,
                        "unit": "g/dL",
                        "reference_range": "13.5 - 17.5",
                        "flag": "LOW",
                    },
                ],
            },
            {
                "panel_name": "Basic Metabolic Panel (BMP)",
                "tests": [
                    {
                        "code": "GLU",
                        "name": "Glucose",
                        "value": 105,
                        "unit": "mg/dL",
                        "reference_range": "70 - 99",
                        "flag": "HIGH",
                    },
                    {
                        "code": "CREAT",
                        "name": "Creatinine",
                        "value": 0.9,
                        "unit": "mg/dL",
                        "reference_range": "0.7 - 1.3",
                        "flag": "NORMAL",
                    },
                    {
                        "code": "POT",
                        "name": "Potassium",
                        "value": 4.2,
                        "unit": "mmol/L",
                        "reference_range": "3.5 - 5.1",
                        "flag": "NORMAL",
                    },
                ],
            },
        ],
    }