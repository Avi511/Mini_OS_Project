# Mini_OS_Project

**MiniOS** is a simple 16-bit real-mode operating system created in pure Assembly by **Avishka (Avi511)** as part of a university project. It runs on QEMU or VirtualBox and provides a basic command-line interface with a few useful commands.

---

## 🖼️ Preview

![preview](https://github.com/user-attachments/assets/32dbadb9-85bd-46c8-8dd7-5410392e0897)

> *Preview of MiniOS running in QEMU terminal.*

---

## ⚙️ Features

- Written in pure x86 Assembly (NASM)
- Boots with a custom bootloader
- Displays a welcome screen and command list on startup
- Accepts and executes built-in commands via keyboard input

---

## 💻 Supported Commands

### `info`

Displays basic hardware-related information.

![info](https://github.com/user-attachments/assets/73c2fe8a-6813-46a7-ad61-743fbd84d54c)

### `help`

Shows the list of available commands with a short description.

![help](https://github.com/user-attachments/assets/e818aa15-3a31-4f1e-aff5-662f9f5f3aeb)

### `clear`

Clears the screen **and** re-displays the welcome message, instructions, and command list — simulating a full refresh.

![clear](https://github.com/user-attachments/assets/848f5433-ee21-49ac-8727-a725c14ec364)

![after clear](https://github.com/user-attachments/assets/5f4e11b5-f134-435f-8a68-3091ba889bdd)



## 🛠️ Build Instructions

1. Assemble the bootloader and kernel:

```bash
nasm -f bin bootloader.asm -o bootloader.bin
nasm -f bin kernel.asm -o kernel.bin
```

2. Combine them into a bootable image:
```bash
cat bootloader.bin kernel.bin > myos.img
```

3. Run the OS using QEMU:
```bash
qemu-system-i386 -fda myos.img
```
📂 Files Included

bootloader.asm – Custom bootloader that loads the kernel

kernel.asm – Main MiniOS kernel with command logic

myos.img – Bootable OS image generated from the above

preview.png – Screenshot showing MiniOS running in QEMU

🧑‍💻 Author

Avishka Ishan

GitHub: Avi511

