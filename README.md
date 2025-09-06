# x86 Kali Container Setup

This repository provides a ready-to-use **x86 Kali Linux container** running on Apple Silicon macOS using **Colima** + **Docker**.  
It is pre-configured for **reverse engineering, binary exploitation, and debugging** with tools like **GDB, pwndbg**, and basic Linux utilities.  

The container uses **QEMU emulation** to run x86 binaries on Apple Silicon.

---

## Prerequisites

You need the following software installed on your macOS host:

- **Docker** – container runtime
- **Colima** – lightweight VM to run Docker with full syscall support
- **lima-additional-guestagents** – extra agents for Colima
- **QEMU** – x86 emulation

Install them using Homebrew:

```bash
brew install docker
brew install colima
brew install lima-additional-guestagents
brew install qemu
```

## How to Run
Start the container and set up the environment:

```bash
./start-kali.sh
```

This script will:
1.	Check that docker and colima are installed.
2.	Start Colima with x86_64 architecture using QEMU.
3.	Launch the Kali Linux container.
4.	Install pwndbg in the container if not already installed.
5.	Open an interactive bash shell inside the container.

Your host folder `./work` is mounted inside the container at `/home/user/work`, so you can easily share files between host and container.

## How to Stop
Stop the container and Colima:
```bash
./stop-kali.sh
```

This will:
1.	Stop the Kali container.
2.	Stop the Colima VM.