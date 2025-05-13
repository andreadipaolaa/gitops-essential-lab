#!/usr/bin/env python
import os
from datetime import datetime, timezone

name = os.getenv("NAME", "World")
now  = datetime.now(timezone.utc).isoformat(timespec="seconds")

print(f"Hello, {name}! It is {now} UTC.")
