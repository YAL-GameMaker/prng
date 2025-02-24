# PRNGs for GameMaker!

Included generators:

- [MINSTD](https://en.wikipedia.org/wiki/Lehmer_random_number_generator#Parameters_in_common_use)\
  This appears as `minstd_rand` in C++. Quick and simple.
- An LCG with mod=2³¹, mult=1103515245, and inc=12345\
  This typically appears as type-0 RNG in `random_r` in C++. Also quick and simple.
- [XorShift64](https://en.wikipedia.org/wiki/Xorshift)\
  
- [WELL512](https://www.lomont.org/papers/2008/Lomont_PRNG_2008.pdf)\
  This is what GameMaker uses for the random functions.

<!--
Worth thinking about:
- mt19937: is that too slow for GML?
- XorShift128: used by Unity and V8, hard to init without uint64_t
  - https://github.com/v8/v8/blob/main/src/base/utils/random-number-generator.h
  - https://github.com/v8/v8/blob/main/src/base/utils/random-number-generator.cc
  - https://vigna.di.unimi.it/ftp/papers/xorshiftplus.pdf
  - https://stackoverflow.com/a/34432126/5578773
- https://en.wikipedia.org/wiki/Multiply-with-carry_pseudorandom_number_generator
- https://github.com/cmcqueen/simplerandom/blob/main/c/lecuyer/lfsr88.c
- https://github.com/khinsen/MMTK/blob/master/Examples/LangevinDynamics/ranf.c
- https://stackoverflow.com/questions/1046714/what-is-a-good-random-number-generator-for-a-game
-->