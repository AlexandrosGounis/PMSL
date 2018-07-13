import Foundation

/**
 This **class** implements the standard difference equation that defines how the **output** signal is calculated both from current and previous samples from the **input** and the **output** signal.
 - Author: Alexandros Gounis
 ## Difference Equation ##
 * y[n] : **output** *signal*
 * x[n] : **input**  *signal*
    - n ⋲ {0, 1, 2, ...}
 ````
 y[n] = 1/a[0]*(b[0]*x[n] + b[1]*x[n-1]... + b[nb]*x[n-nb]
- a[1]*y[n-1] - a[2]*y[n-2]... - a[na]*y[n-na])
 ````
 ## Functions: ##
 - **PassThrough()**: trivial function for pass through filtering, x[n] = y[n]
 - **SetFilter**: For setting the filter's coefficients
 - **Clear()**: For clearing the filter's coefficients by setting 0 everywhere
 - **Compute**: For computing the current *output* sample
 
 
 */
open class Filter {
    
    public init() {}
    
    /// Bs : **feedforward** coefficients
    public var Bs = [Float]()
    /// As : **feedback** coefficients
    public var As = [Float]()
    public var input = [Float]()
    public var output = [Float]()
    
    /** **Pass through** filter

     x[n] = y[n]
     
     */
    open func PassThrough() {
        
        Bs.append(1.0)
        As.append(1.0)
        
        input.append(0.0) // input
        output.append(0.0) // output
    }
    
    /**
        Function for setting the filter's coefficients
 - parameter inputBs: (B coefficients separated by commas)
     - (**b**0, **b**1, **b**2, ...)
 - parameter inputAs: (A coefficients separated by commas)
     - (**a**0, **a**1, **a**2, ...)
 */
    open func SetFilter(inputBs: Array<Float>,inputAs: Array<Float>) {
        Bs =  inputBs
        As = inputAs
        input = Array(repeating: 0.0, count: inputBs.count)
        output = Array(repeating: 0.0, count: inputAs.count)
        
    }
    
    /// **Clear** the filter and set all coefficients to 0
    open func Clear() {
        for i in 0 ..< Bs.count {
            Bs[i] = 0.0
            As[i] = 0.0
        }
    }
    
    /** This **function** takes as an input one sample only, which is then placed in the first memory block of the input vector (input[0]).  Subsequently, the signal is filtered as defined by the user (see function *SetFilter*) and the current output is calculated. This process allows for real-time modelling.
    - parameter sample: input sample (float)
     - returns: ouput[0]:  **float** number (current output sample)
 */
    open func Compute(sample: Float) -> Float {
        
        output[0] = Float(0.0)
        input[0] = sample
        
        for i in stride(from: Bs.count-1, to: 0, by: -1){
            output[0] += (Bs[i]/As[0])*input[i]
            input[i] = input[i-1]
        }
        output[0] += (Bs[0]/As[0])*input[0]
        
        for i in stride(from: As.count-1, to: 0, by: -1){
            output[0] += -(As[i]/As[0])*output[i]
            output[i] = output[i-1]
        }
        
        return output[0]
    }
    
}

// Uncomment this section when using playgrounds
// public var filter = Filter()
