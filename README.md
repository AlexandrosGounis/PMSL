<p align="center">
  <img src="https://raw.githubusercontent.com/AlexandrosGounis/PMSL/master/Assets/Logo/PMSLLogo_466x130.png">
</p>

#### Physical Modelling Swift Library
- Author: Alexandros Gounis
---
### Filters: (declared in *filters.swift*)
> This **class** implements the standard difference equation that defines how the **output** signal is calculated both from  current and previous samples from the **input** and the **output** signal.
>  ## Difference Equation ##
>  * y[n] : **output** *signal*
>  * x[n] : **input**  *signal*
>     - n ⋲ {0, 1, 2, ...}
> ````
> y[n] = 1/a[0]*(b[0]*x[n] + b[1]*x[n-1]... + b[nb]*x[n-nb]
> - a[1]*y[n-1] - a[2]*y[n-2]... - a[na]*y[n-na])
> ````
> ## Functions: ##
> - **PassThrough()**: trivial function for pass through filtering, x[n] = y[n]
> - **SetFilter**: For setting the filter's coefficients
> - **Clear()**: For clearing the filter's coefficients by setting 0 everywhere
> - **Compute**: For computing the current *output* sample
---
### Delay lines: (declared in *DelayLines.swift*)
> This **class** creates, modifies and processes fractional delay lines. By using linear interpolation between two successive samples, one can use this class for accurate physical modelling of musical instruments.
> - Author: Alexandros Gounis
> 
> ## Functions: ##
> 
> - **Create**: **create** a delay line of Maximum delay, **SetDelay** is used automatically
> - **Clear**: **clear** the delay line by placing 0 everywhere
> - **SetDelay**: provide a *delay* and a *Maximum* and set or change the delay
> - **Compute**: **calculate** the next output, that is to feed the delay line with a sample (float) and return the delayed output


---

| Files             | Functionality |
| -------------     |:-------------:|
| Filters.swift     | Create IIR filters defining the standard difference equation |
| DelayLines.swift  | Create fractional delay lines by linear interpolation     |
| FFT.swift         | (to be added)      |
