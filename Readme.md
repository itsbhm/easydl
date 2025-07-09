# 📥 EasyDL

**EasyDL** is a simple, lightweight Bash script to download **YouTube videos and audio** using [yt-dlp](https://github.com/yt-dlp/yt-dlp).  
Built for developers, students, and creators who want quick, reliable downloads without hassle.

---

## ✨ Features

✅ Download **Video** (with quality selection: 720p, 1080p, 2K, 4K, Best Available)  
✅ Download **Audio Only** (MP3 128kbps / 320kbps / M4A / OPUS / WAV)  
✅ Auto merge best video+audio  
✅ Playlist download toggle  
✅ Advanced options: `--prefer-insecure`, custom chunk size, retries  
✅ Simple one-file Bash script, no config needed  
✅ Supports Linux, macOS, WSL

---

## 📌 Requirements

- [yt-dlp](https://github.com/yt-dlp/yt-dlp)  
- [ffmpeg](https://ffmpeg.org/)

Install:  
```bash
pip install -U yt-dlp
sudo apt-get install ffmpeg    # Linux
brew install ffmpeg            # macOS
````

---

## 🚀 How to Use

1️⃣ **Save script:**

```bash
curl -O https://raw.githubusercontent.com/itsbhm/easydl/main/easydl.sh
```

2️⃣ **Make it executable:**

```bash
chmod +x easydl.sh
```

3️⃣ **Run it:**

```bash
./easydl.sh
```

---

## ⚙️ How it Works

* Prompts you for:

  * Video URLs
  * Output folder
  * Video or audio mode
  * Quality options
  * Playlist toggle
  * Advanced connection toggle

* Handles all merging & conversion with `yt-dlp` and `ffmpeg`.

* Final files saved with clean names.

---

## 📁 Example

```
$ ./easydl.sh

Enter one or more video URLs (space-separated):
URLs: https://www.youtube.com/watch?v=xxxx

Enter output folder [Default: current folder]:

Enable advanced connection options? (y/n, Default: n):

What do you want to download?
1) Video (default)
2) Audio Only

...
```

---

## 🔗 Author

* 👨‍💻 **Shubham Vishwakarma**
* 🌐 [itsbhm.com](https://itsbhm.com)
* 🐙 [github.com/itsbhm](https://github.com/itsbhm)

---

## 📜 License

MIT — free to use, modify, and share!

---

## ⭐️ Support

If you like it, leave a ⭐️ on GitHub and share with friends!
