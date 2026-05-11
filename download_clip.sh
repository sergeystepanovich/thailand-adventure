#!/bin/bash
RELEASE_URL="https://github.com/sergeystepanovich/thailand-adventure/releases/download/youtube-clip-35-39/clip_35-39.mp4"
OUTPUT="/home/user/thailand-adventure/clip_35-39.mp4"
LOG="/home/user/thailand-adventure/download_clip.log"

echo "[$(date)] Waiting for GitHub Release..." | tee "$LOG"
while true; do
  CODE=$(curl -s -o /dev/null -w "%{http_code}" -L --max-time 15 "$RELEASE_URL")
  echo "[$(date)] HTTP $CODE" >> "$LOG"
  if [ "$CODE" = "200" ]; then
    echo "[$(date)] Downloading..." | tee -a "$LOG"
    curl -L -o "$OUTPUT" "$RELEASE_URL" 2>&1 | tee -a "$LOG"
    echo "[$(date)] Done: $OUTPUT" | tee -a "$LOG"
    break
  fi
  sleep 30
done
