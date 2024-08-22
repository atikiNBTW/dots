# chatgpt generated cuz i dont ever want to learn bash syntax with ifs and elses with strange double square brackets and many commands and awk and sort AAAAAAAAAAA
cd ~/.config/hypr/videowallpapers

# Read the current last wallpaper
last_wallpaper=$(cat lastwallpaper)

# Initialize the new wallpaper variable
new_wallpaper=""

# Loop until we find a different file
while [ -z "$new_wallpaper" ] || [ "$new_wallpaper" = "$last_wallpaper" ] || [ "$new_wallpaper" = "lastwallpaper" ]; do
  new_wallpaper=$(ls | sort -R | tail -n 1)
done

# Update the lastwallpaper file
echo $new_wallpaper > lastwallpaper

# Play the new wallpaper with mpv
mpv --wayland-app-id="mpvbg" $new_wallpaper --loop --no-audio
