# 🌟 Emoji Match - Aesthetic Memory Game

---

## 1.KOMPONEN 1: BLUEBRINT (RENCANA KERJA APLIKASI)

### 1. Tema & Konsep Utama Visual
Aplikasi ini adalah game edukasi asah memori (*Memory Card Game*) interaktif. Antarmuka dirancang dengan gaya minimalis-estetic menggunakan palet warna pastel yang lembut agar nyaman di mata dan memberikan kesan elegan:
* '#FFE4E1' (Misty Rose) - Latar belakang utama. 
* '#FFB6C1' (Linht Pink Menyala) - Gradasi warna cerah aksen visual.
* '#FFF0F5' (Lavender Blush) - Sentuhan warna lembut pelengkap.
* '#D87093' (Pale Violet Red) - Warna teks utama dan *border* konstras.
* '#FADADD' (Soft Pink) - Warna dasar kartu saat tertutup (💎) dan tombol.

### 2. Arsetektur Komputer Widget (Dart)
Proyek ini mengimplementasikan struktur komponen terpisah (*Component-Driver*) sebagai berikut:
* 'EmojiGameApp': *Root* pengatur tema global Material 3.
* 'BackroundAesthetic': Reusable widget untuk gradasi latar belakan dan ord cahaya menyala.
* 'MainMenuScreen': Antarmuka awal (Layar Menu Utama) + tobol PLAY.
* 'VariantSelectionScreen': Layar pemilihan kategori game (Hewan, Buah, Jajanan).
* 'GamePlayScreen': Papan permainan utama berukuran grid dinamis,
* 'BalloonAnimation': Komponen animasi menggunakan 'AnimationController' untuk selebrasi kemenangan.
* 'AnimatedCuteButton': Widget tombol interaktif dengan efek membal (*floating animation*).

## # 3. Intruksi Penyimpanan Proyek Ke GIT (Commit)
---

## ⚙️ COMPONEN 2: DOKUMENTASI CARA KERJA & DAFTAR FITUR

### 🛠️ Daftar Fitur Utama
1. **Layar Menu Utama Menarik:** Animasi tombol mengambang (*floating custom button*) interaktif berbasis fungsi trigonometrik matematioka ('math sin') untuk menarik perhatian pengguna.
2. **Sistem Kategori Dinamis:** Pengguna dapat memilih tipe memori berdasarkan 3 kategori mandiri: 🐶 Hewan Lucu, 🍎 Buah Segar, dan 🍕 jajanan.
3. **Core Memory Match Engine:** Mengunakan durasi pembalikan kartu otomatis (*Timer* 600ms) untuk menutup kembali kartu jika tebaka pemain tidak cocok.
4. **Dialog Skor & Efek Hadiah:** Penampakan skor dinamis (+20) setiap kali berhasil mencocokkan, serta memicu dekorasi balon meluncur di layar menggunakan sistem 'OverlayEntry'.
5. **Dialog Kemenangan Kustom:** Pop-up *AlertDialog* estetis untuk merayakan penyelesaian game dengan skor sempurna tanpa merusak hierarki navigasi halaman.

### 🧠 Logika Alur Kerja Sistem
* **Inisialisasi Acak (Shuffle Logic):** Ketika pengguna memilih kategori, data array emoji akan diduplikasi, digabungkan,dan diacak secara otomatis menggunakan fungsi bawaan Dart 'List.from()..shuffle()' di dalam metode 'initState()'. Hal ini menjamin posisi kartu selalu berbeda setiap kali dimulai kembali.
* **Menejemen State Pembalikan (State Management):** Status kartu dokontrol melalui array boolean 'cardFlips' untuk melacak kartu mana yang sedang terbuka. Sistem membatasi seleksi maksimal melalui kondisi 'selectedIndices.length < 2>' untuk menghindari eksploitasi klik ganda oleh pengguna saat proses pencocokan sedang berjalan.
* ** SistemOverlay Balon:** Menggunakan *Overlay* global Flutter sehingga animasi balon meluncur dari bawah ke atas layar dapat berjalan secara independen tanpa memicu *rebuild* pada seluruh widget papan permainan.

---
# 📋 Informasi Pengembangan 
* **Nama:** Luna Oktavia Syafitri
* **Proyek:** Aplikasi Pemrograman Mobile (Emoji Match)
* **Konsep Desain:** *Soft-toning, pastel,Aesthetic, & Calm Pink Visuals*
* **UAS Mata Kuliah Pemrograman Mobile**
---