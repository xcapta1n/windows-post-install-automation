# Windows Post-Install Automation & Software Deployment Script 🚀

[English](#english) | [Türkçe](#türkçe)

---

<a name="english"></a>
## 🇬🇧 English

A modular, batch-script-based automation tool designed to streamline the software setup process immediately after a clean Windows installation.

### 📌 Project Overview
Setting up a fresh operating system and installing all essential development tools, browsers, gaming launchers, and performance utilities manually is a repetitive and time-consuming task. This project provides an interactive, menu-driven CLI tool that automates the entire post-install phase with administrative privilege handling and robust error checking.

### 🛠️ Core Features & Technical Highlights
* **Auto-Elevation:** Automatically checks for administrator privileges upon execution and safely relaunches itself with elevated rights if necessary.
* **Winget & Reboot Handler:** Detects the presence of Windows Package Manager (`winget`). If missing, it installs the official Microsoft App Installer package and automatically triggers a safe system reboot handler to ensure PATH variables and environment services bind correctly.
* **Multi-Source Installation Strategy:**
  * **Winget Packages:** Installs standard applications silently via official package IDs (e.g., Brave, Discord, 7-Zip, Revo Uninstaller, Process Lasso).
  * **Direct Web EXEs:** Handles direct downloads for custom applications where needed.
  * **Automated ZIP Extraction (PowerShell API):** Downloads tool archives directly from official sources (such as MSI Afterburner), extracts them securely using native PowerShell `Expand-Archive`, and executes silent installations without user friction.
* **Modular Menu Design:** Cleanly categorized interactive menus allowing selective installation across Internet/Media, Gaming Launchers, System Tools, and Runtimes.

### 🚀 How to Use
1. Download or clone this repository.
2. Right-click `ProgramKurulum.bat` and select **Run as Administrator**.
3. Follow the interactive CLI prompts to select and install your required software stack.

---

<a name="türkçe"></a>
## 🇹🇷 Türkçe

Temiz bir Windows kurulumundan hemen sonra yazılım kurulum sürecini otomatikleştirmek ve hızlandırmak için geliştirilmiş, modüler bir toplu iş (batch) otomasyon aracıdır.

### 📌 Proje Özeti
Yeni bir işletim sistemi kurduktan sonra tüm temel geliştirme araçlarını, tarayıcıları, oyun başlatıcıları ve performans programlarını tek tek manuel olarak indirmek vakit kaybına yol açar. Bu proje; yönetici yetkisi denetimi, hata korumaları ve interaktif menü yapısıyla tüm bu post-install (kurulum sonrası) aşamasını tamamen otomatikleştirir.

### 🛠️ Temel Özellikler ve Teknik Öne Çıkanlar
* **Otomatik Yönetici Yetkisi (Auto-Elevation):** Çalıştırıldığı anda yönetici yetkilerini kontrol eder; yetki yoksa süreci güvenli bir şekilde yönetici modunda yeniden başlatır.
* **Winget ve Yeniden Başlatma Yönetimi:** Sistemde Windows Paket Yöneticisi'nin (`winget`) varlığını denetler. Eğer eksikse resmi Microsoft App Installer paketini kurar ve PATH değişkenlerinin/servislerin doğru şekilde oturması için güvenli bir yeniden başlatma döngüsü tetikler.
* **Çoklu Kaynak Kurulum Stratejisi:**
  * **Winget Paketleri:** Standart uygulamaları resmi paket ID'leri üzerinden sessiz (silent) modda kurar (Brave, Discord, 7-Zip, Process Lasso vb.).
  * **Doğrudan Web EXE İndirme:** Özel kurulum gerektiren uygulamalar için doğrudan indirme tetikler.
  * **PowerShell Entegrasyonlu ZIP Arşiv Yönetimi:** MSI Afterburner gibi araçları doğrudan resmi kaynaklarından indirip, yerleşik PowerShell `Expand-Archive` komutuyla güvenle klasöre çıkartarak kurulumu otomatikleştirir.
* **Modüler Menü Tasarımı:** İnternet/Medya, Oyun Başlatıcıları, Sistem Araçları ve Çalışma Zamanları (Runtimes) olarak kategorize edilmiş kullanıcı dostu interaktif CLI arayüzü sunar.

### 🚀 Nasıl Kullanılır?
1. Bu reponun dosyalarını indirin veya klonlayın.
2. `ProgramKurulum.bat` dosyasına sağ tıklayıp **Yönetici olarak çalıştır (Run as Administrator)** seçeneğini seçin.
3. Ekrandaki interaktif menü yönlendirmelerini takip ederek kurulmasını istediğiniz yazılımları seçin.
