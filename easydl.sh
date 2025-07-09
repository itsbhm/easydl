#!/bin/bash

# ==============================================================
# 📥 EasyDL - Your Simple YouTube Video & Audio Downloader
# Developer : Shubham Vishwakarma
# Website   : https://itsbhm.com
# GitHub    : https://github.com/itsbhm
# Dependency: yt-dlp (https://github.com/yt-dlp/yt-dlp)
# ==============================================================

# ==============================================================
# 📌 How to Run (final)
# 1️⃣ Save as: easydl.sh
# 2️⃣ Make executable: chmod +x easydl.sh
# 3️⃣ Run: ./easydl.sh
# ==============================================================

# -----------------------------
# Function: Print error & exit
# -----------------------------
error_exit() {
    echo "❌ Error: $1"
    exit 1
}

# -----------------------------
# Check Dependencies
# -----------------------------
command -v yt-dlp >/dev/null 2>&1 || error_exit "yt-dlp is not installed.
Install it with: pip install -U yt-dlp"

command -v ffmpeg >/dev/null 2>&1 || error_exit "ffmpeg is not installed.
Install it using: sudo apt-get install ffmpeg OR brew install ffmpeg"

# -----------------------------
# Display Banner
# -----------------------------
echo "=============================================================="
echo " 📥 EasyDL - YouTube Video & Audio Downloader"
echo "--------------------------------------------------------------"
echo " Developer : Shubham Vishwakarma"
echo " Website   : https://itsbhm.com"
echo " GitHub    : https://github.com/itsbhm"
echo "--------------------------------------------------------------"
echo " 📌 How to Run:"
echo "   1️⃣ Save as: easydl.sh"
echo "   2️⃣ Make executable: chmod +x easydl.sh"
echo "   3️⃣ Run: ./easydl.sh"
echo "=============================================================="
echo ""

# -----------------------------
# Input: URLs
# -----------------------------
echo "Enter one or more video URLs (space-separated):"
read -rp "URLs: " urls
[ -z "$urls" ] && error_exit "No URLs provided."

# -----------------------------
# Input: Output Folder
# -----------------------------
read -rp "Enter output folder [Default: current folder]: " outdir
[ -z "$outdir" ] && outdir="."
mkdir -p "$outdir" || error_exit "Failed to create output folder."

# -----------------------------
# Advanced Options
# -----------------------------
echo ""
echo "Enable advanced connection options?"
echo "Includes: --prefer-insecure, --http-chunk-size, --retries"
read -rp "Enable advanced options? (y/n, Default: n): " adv_choice
adv_choice=${adv_choice:-n}

if [[ "$adv_choice" =~ ^[Yy]$ ]]; then
    adv_opts="--prefer-insecure --http-chunk-size 5M --retries 20 --fragment-retries 20"
    echo "✅ Advanced options enabled: $adv_opts"
else
    adv_opts=""
fi

# -----------------------------
# Mode: Video or Audio (Default: Video)
# -----------------------------
echo ""
echo "What do you want to download?"
echo "1) Video (default)"
echo "2) Audio Only"

read -rp "Enter choice [1-2, Default: 1]: " mode
mode=${mode:-1}
[[ "$mode" =~ ^[1-2]$ ]] || error_exit "Invalid mode selected."

# -----------------------------
# VIDEO MODE
# -----------------------------
if [ "$mode" == "1" ]; then
    echo ""
    echo "Select video quality:"
    echo "1) 720p"
    echo "2) 1080p"
    echo "3) 2K"
    echo "4) 4K"
    echo "5) Best Available (Highest) [default]"

    read -rp "Enter choice [1-5, Default: 5]: " v_choice
    v_choice=${v_choice:-5}

    case "$v_choice" in
        1) quality="bestvideo[height<=720]+bestaudio/best[height<=720]" ;;
        2) quality="bestvideo[height<=1080]+bestaudio/best[height<=1080]" ;;
        3) quality="bestvideo[height<=1440]+bestaudio/best[height<=1440]" ;;
        4) quality="bestvideo[height<=2160]+bestaudio/best[height<=2160]" ;;
        5) quality="bestvideo+bestaudio/best" ;;
        *) error_exit "Invalid video quality option." ;;
    esac

    echo ""
    echo "Download playlist if URL is playlist? (y/n, Default: n)"
    read -rp "Choice: " pl_choice
    pl_choice=${pl_choice:-n}
    if [[ "$pl_choice" =~ ^[Yy]$ ]]; then
        playlist="--yes-playlist"
    else
        playlist="--no-playlist"
    fi

    echo ""
    echo "▶️ Downloading video(s)..."
    yt-dlp $adv_opts -f "$quality" $playlist -o "$outdir/%(title)s.%(ext)s" --merge-output-format mp4 $urls \
        || error_exit "Video download failed."

# -----------------------------
# AUDIO MODE
# -----------------------------
elif [ "$mode" == "2" ]; then
    echo ""
    echo "Select audio quality & format:"
    echo "1) Best Available Audio"
    echo "2) MP3 128kbps"
    echo "3) MP3 320kbps"
    echo "4) M4A (YouTube default high quality)"
    echo "5) OPUS (High quality, small size)"
    echo "6) WAV (Uncompressed)"

    read -rp "Enter choice [1-6]: " a_choice

    case "$a_choice" in
        1) audio_format="bestaudio"; ext="mp3"; post_args="" ;;
        2) audio_format="bestaudio"; ext="mp3"; post_args="--audio-quality 128K" ;;
        3) audio_format="bestaudio"; ext="mp3"; post_args="--audio-quality 320K" ;;
        4) audio_format="bestaudio"; ext="m4a"; post_args="" ;;
        5) audio_format="bestaudio"; ext="opus"; post_args="" ;;
        6) audio_format="bestaudio"; ext="wav"; post_args="" ;;
        *) error_exit "Invalid audio option." ;;
    esac

    echo ""
    echo "Download playlist if URL is playlist? (y/n, Default: n)"
    read -rp "Choice: " pl_choice
    pl_choice=${pl_choice:-n}
    if [[ "$pl_choice" =~ ^[Yy]$ ]]; then
        playlist="--yes-playlist"
    else
        playlist="--no-playlist"
    fi

    echo ""
    echo "🎵 Downloading audio file(s)..."
    yt-dlp $adv_opts -f "$audio_format" \
        --extract-audio --audio-format "$ext" $post_args \
        $playlist \
        -o "$outdir/%(title)s.%(ext)s" \
        $urls || error_exit "Audio download failed."

else
    error_exit "Invalid mode selected."
fi

echo ""
echo "=============================================================="
echo "✅ EasyDL: Download complete! Files saved to: $outdir"
echo "=============================================================="
