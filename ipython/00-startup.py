from datetime import datetime
import subprocess
import json


bills = [
        3030.0, # mortgage 
        170.0,  # maid
        130.0,  # t-mobile
        45.21,  # Grand Junction 
        52,     # Ute water
        193     # Xcel Energy
        ]


def monthly_interest(apr: float = 0.0405) -> float:
    return apr / 12


def days_since_date(dt: str = '2024-11-18') -> int:
    td = datetime.now() - datetime.fromisoformat(dt)
    return td.days


def get_battery_info():
    cmd = ["system_profiler", "SPPowerDataType", "-json"]
    battery_data = subprocess.run(cmd, capture_output=True, text=True)
    return json.loads(battery_data.stdout)

