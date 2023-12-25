-- Get the name of the currently playing track in Spotify

-- Check if Spotify is running
if application "Spotify" is running then
    tell application "Spotify"
        if player state is playing then
            set trackName to name of current track
            set artistName to artist of current track
            set output to "  " & artistName & " - " & trackName
        else
            set output to ""
        end if
    end tell
else
    set output to ""
end if

-- Output the result
return output
