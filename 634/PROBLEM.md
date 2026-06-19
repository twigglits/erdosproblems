# CONJECTURE

Find all 𝑛 such that there is at least one triangle which can be cut into 𝑛 congruent triangles.

########################

Erdős' question was reported by Soifer. It is easy to see that all square numbers have this property (in fact for square numbers any triangle will do). Soifer has shown that numbers of the form 2⁢𝑛2,3⁢𝑛2,6⁢𝑛2,𝑛2 +𝑚2 also have this property. Beeson has shown (see the slides below) that 7 and 11 do not have this property. It is possible that any prime of the form 4⁢𝑛 +3 does not have this property.

In particular, it is not known if 19 has this property (i.e. are there 19 congruent triangles which can be assembled into a triangle?).

For more on this problem see these slides from a talk by Michael Beeson ( The pdf in this codebase ) . As a demonstration of this problem we include a picture of a cutting of an equilateral triangle into 27 congruent triangles from these slides.

Soifer proved that if we relax congruence to similarity then every triangle can be cut into 𝑁 similar triangles when 𝑁 ≠2,3,5.

If one requires the smaller triangles to be similar to the larger triangle then the only possible values of 𝑁 are 𝑛2,𝑛2 +𝑚2,3⁢𝑛2, proved by Snover, Waiveris, and Williams .

Zhang , among other results, has proved that for any integers 𝑎 ≥𝑏, if 𝑛≥3⁢⌈𝑎2+𝑏2+𝑎⁢𝑏−𝑎−𝑏𝑎⁢𝑏⌉
then 𝑛2⁢𝑎⁢𝑏 has this property (indeed, they explicitly show that an equilateral triangle can be tiled with 𝑛2⁢𝑎⁢𝑏 many triangles of side lengths 𝑎,𝑏,√𝑎2+𝑏2+2+𝑎⁢𝑏).
