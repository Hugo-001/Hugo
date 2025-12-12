# Hugo OS

Hugo OS is a tiny Multiboot-compliant hobby kernel that boots into 32-bit protected mode and writes a greeting directly to the VGA text buffer. It is intentionally small so you can experiment with low-level concepts like memory-mapped I/O, boot protocols, and bare-metal development.

## Features

- Multiboot header and stack setup written in NASM assembly.
- Minimal C kernel that clears the screen and writes text without a standard library.
- Simple `Makefile` that builds freestanding 32-bit objects and links them with `ld`.
- `run` target for quick iteration in QEMU (if installed).

## Building

You will need:

- `gcc` with 32-bit support for freestanding builds (`-m32`).
- `nasm` for assembling the boot code.
- `ld` (binutils) capable of producing `elf_i386` binaries.
- `qemu-system-i386` if you want to run the kernel locally.

Commands:

```sh
# Build the kernel binary
make

# Run in QEMU
make run
```

> The `iso` target is intentionally a stub. Add your preferred bootloader configuration (e.g., GRUB or Limine) before generating a bootable image.

## Project layout

- `boot/boot.s` – Multiboot header and early entry code that sets up a stack and jumps to `kernel_main`.
- `src/kernel.c` – Minimal freestanding kernel that writes messages to VGA text mode.
- `linker.ld` – Places sections at 1MB and defines `_start` as the entry point.
- `Makefile` – Builds the kernel and provides a QEMU run helper.

## Next steps

- Add a real bootloader configuration so you can create an ISO and boot on hardware.
- Extend the kernel with interrupts, a GDT/IDT, and paging to move toward protected long mode.
- Implement basic drivers (keyboard, timer) and a simple memory allocator.
