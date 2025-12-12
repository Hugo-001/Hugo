ENTRY(_start)

PHDRS
{
    text PT_LOAD FLAGS(0x5); /* RX */
    data PT_LOAD FLAGS(0x6); /* RW */
}

SECTIONS
{
    /* Load the kernel at 1MB */
    . = 1M;

    .multiboot : {
        *(.multiboot)
    } :text

    .text : {
        *(.text*)
    } :text

    .rodata : {
        *(.rodata*)
    } :text

    .data : {
        *(.data*)
    } :data

    .bss : {
        *(.bss*)
        *(COMMON)
    } :data
}
