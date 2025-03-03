# PRNGs for GameMaker!

**Quick links:**
[blog post​](https://yal.cc/gamemaker-custom-prngs) · [documentation​](https://yal.cc/docs/gm/prng) · [itch​.io](https://yellowafterlife.itch.io/gamemaker-prng) · [source code](https://github.com/YAL-GameMaker/prng)  
**Supported versions:** GM2022+, GM LTS  
**Supported platforms:** all  
**See also:** [more GameMaker things!](https://yellowafterlife.itch.io/)

This is a set of custom pseudorandom number generators for GameMaker!

You can use these to:

- Have separate random number generators for different parts of the game.
- Save/load generator's state (for example, to prevent "save scumming", or for networking)
- Have more control over PRNG in general

See the ["uses"](https://yal.cc/gamemaker-custom-prngs#uses) section in the post for detailed examples!

## Included generators

- [MINSTD](https://en.wikipedia.org/wiki/Lehmer_random_number_generator#Parameters_in_common_use)  
  This appears as `minstd_rand` in C++.  
  Quick and simple.
- A `random_r` style generator (called `Rand0` for convenience)  
  This is an LCG with mod=2³¹, mult=1103515245, inc=12345.  
  Also quick and simple.
- [Xorshift](https://en.wikipedia.org/wiki/Xorshift) (64-bit)  
  The GML version of this generator is slower than above in VM builds,
  but much faster in YYC builds!
- [Well Equidistributed Long-period Linear](https://www.lomont.org/papers/2008/Lomont_PRNG_2008.pdf) (512-bit)\
  This is a replica of what GameMaker itself uses for its random functions!  
  The GML version is slightly slower than other generators.

Each generator has several variants to choose from:

- GML: Constructor-based (`r = gen.float(100)`)
- GML: Array-based (`r = minstd_float(gen, 100)`)
- GML: Global (`r = minstd_float(100)`)
- C++ DLL edition (Windows-only)

See the ["tests"](https://yal.cc/gamemaker-custom-prngs#tests) section in the post for performance comparisons between different generators and their implementations! You might be surprised.

<!--
## (itch) Package contents
- GML scripts (one per variant per generator, self-contained)
- C++ DLL extension (optional)  
  See [notes](https://yal.cc/docs/gm/prng#etc-mix) on mixing it with scripts
- Test project with benchmarks and unit tests.
- Offline documentation
-->

## Building

See [BUILD.md](BUILD.md).

## Meta

A tool by [YellowAfterlife](https://yal.cc).  
(partially) written in [Haxe](https://yal.cc)!

[Custom license](LICENSE)

<!--
Could also think about:
- mt19937: allegedly just worse than WELL512
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

<!--
**Quick links:**
[blog post​](https://yal.cc/gamemaker-custom-prngs) · [documentation​](<https://yal.cc/docs/gm/prng>) · [itch​.io](<https://yellowafterlife.itch.io/gamemaker-prng>) · [source code](<https://github.com/YAL-GameMaker/prng>)  
**Supported versions:** GM2022+, GM LTS  
**Supported platforms:** all

I implemented a bunch of custom pseudorandom number generators for GameMaker!

These can be used to:

- Have separate random number generators for different parts of the game.
- Save/load generator's state (for example, to prevent "save scumming", or for networking)
- Have more control over PRNG in general

In the post I go over what PRNGs are, how these 4 generators work, and some of the common mishaps while working with random functions.
-->