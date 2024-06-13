# StagedFilters.jl - Lovingly handcrafted metaprogrammed code for all your DSP needs.

This package implements a staged-programming approach for a highly specialized version of a Savitzky-Golay filter. It is a **generalized, performant algorithm** of [rolling/moving functions](https://en.wikipedia.org/wiki/Moving_average), such as a `rolling/moving average`.

If you would like to read a full blog post on the implementation on it, [you can find some here](https://miguelraz.github.io/blog/smoothingjiahao/).
For a video explanation by Stefan Karpinski, check out the [following video](https://www.youtube.com/watch?v=DRKKAFYM9yo&feature=youtu.be&t=2047)

### Acknowledgments

Many people contributed to the eventual development of this code:
- Jiahao Chen, Matt Bauman and others for the original implementation
- Stefan Karpinski for some branch elisions
- Steven G Johnson, for help when benchmarking a PyCall code and being careful not to measure the conversion back and forth.

If you know the measurement to be missing / not be as fair as it could be, please reach out and let me know - we're trying to compare best in class implementations side by side, not cheat out. In particular, I don't know if the `savgol` method I'm calling is in place or not, and would appreciate if somone could point out how to opt into that. 

### Timing Python

Run the following script:

```python
python -m timeit -s "import scipy" -s "import numpy as np" -s "data = np.array([i for i in range(10_000_000)], dtype = np.float32)" -s "f = scipy.signal.savgol_filter" "f(data, 5, 2, mode = 'wrap')"
python -m timeit -s "import scipy" -s "import numpy as np" -s "data = np.array([i for i in range(10_000_000)], dtype = np.float64)" -s "f = scipy.signal.savgol_filter" "f(data, 5, 2, mode = 'wrap')"
```
or by running `python -m IPython` and copy pasting the `test/bench.py` script in.

