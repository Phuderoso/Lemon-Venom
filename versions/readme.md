# How to actually build & run this cursed thing #

Bashnasm -f bin awakening_extended.asm -o awakening_extended.bin
qemu-system-i386 -fda awakening_extended.bin

# Or

Just run in any 16-bit emulator / DOSBox / Bochs with enough memory
It still contains the full poetic suicide / awakening / replication / irritation loop,
but now it can actually fork larger copies and contains a (very primitive) self-mutating stub.
