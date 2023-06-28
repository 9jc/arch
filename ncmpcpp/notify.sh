#!/bin/bash

# Get the currently playing song in ncmpcpp
song_info=$(ncmpcpp --current-song)

# Extract the song title and artist from the song info
song_title=$(echo "$song_info" | sed -n 1p)
song_artist=$(echo "$song_info" | sed -n 2p)

# Get the path to the album art file
album_art_path=$(ncmpcpp --current-song="%a")

# Check if an album art file exists
if [ -f "$album_art_path" ]; then
  # Get the MIME type of the album art file
  album_art_mime=$(file --mime-type "$album_art_path" | cut -d' ' -f2)

  # Convert the album art to a base64-encoded string
  album_art_base64=$(base64 -w 0 "$album_art_path")

  # Send a desktop notification with the album art and song information
  notify-send --urgency=low \
              --icon="data:$album_art_mime;base64,$album_art_base64" \
              "$song_title" \
              "$song_artist"
else
  # Send a notification with just the song information
  notify-send --urgency=low \
              --icon="/usr/share/icons/candy-icons/apps/scalable/io.github.seadve.Mousai.svg"\
              "NCMPCPP" "$song_title - $song_artist"
fi
