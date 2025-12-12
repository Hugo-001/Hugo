BUILD_DIR := build
ISO := $(BUILD_DIR)/hugo-os.iso
KERNEL := $(BUILD_DIR)/kernel.bin

CFLAGS := -m32 -ffreestanding -O2 -Wall -Wextra -fno-asynchronous-unwind-tables -fno-stack-protector
LDFLAGS := -m elf_i386

.PHONY: all clean run iso

all: $(KERNEL)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/boot.o: boot/boot.s | $(BUILD_DIR)
	nasm -f elf32 $< -o $@

$(BUILD_DIR)/kernel.o: src/kernel.c | $(BUILD_DIR)
	gcc $(CFLAGS) -c $< -o $@

$(KERNEL): linker.ld $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o
	ld $(LDFLAGS) -T $< -o $@ $(word 2,$^) $(word 3,$^)

iso: $(KERNEL)
	@echo "Creating ISO requires grub-mkrescue and xorriso installed."
	@echo "Add your preferred bootloader setup (e.g., GRUB or Limine) before running."

run: $(KERNEL)
	qemu-system-i386 -kernel $(KERNEL)

clean:
	rm -rf $(BUILD_DIR)
