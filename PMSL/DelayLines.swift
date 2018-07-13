import Foundation

/** This **class** creates, modifies and processes fractional delay lines. By using linear interpolation between two successive samples, one can use this class for accurate physical modelling of musical instruments.
 - Author: Alexandros Gounis
 
 ## Functions: ##
 
    - **Create**: **create** a delay line of Maximum delay, **SetDelay** is used automatically
    - **Clear**: **clear** the delay line by placing 0 everywhere
    - **SetDelay**: provide a *delay* and a *Maximum* and set or change the delay
    - **Compute**: **calculate** the next output, that is to feed the delay line with a sample (float) and return the delayed output
 */
open class DelayLine {
    
    public init() {}
    
    public var delayLine = [Float]()        // array containing the delay line (float)
    public var indexWrite: Int = 0          // pointer that feeds the delay line with a value
    public var indexRead:  Int = 0          // pointer used to read the delayed sample
    public var indexReadFrac: Float = 0     // actual delay (real number)
    public var frac: Float = 0.0            // fractional part of the actual delay: in the range of [0,1]
    public var compfrac: Float = 0.0        // complementary number, such as frac + compfrac = 1
    public var output: Float = 0.0          // additional float variable, used for processing samples
    public var MaxFixed: Int = 5000         // default Maximum fixed value for a delay line
    
    /** Function that creates a delay line of **Maximum** delay.
    - note: Writing before reading is necessary, in order to allow fractional delays between [0,1]. This means that the maximum delay one can set is only **Maximum - 1**. Therefore, the true maximum delay is set to *Maximum + 1* in the backend.
     - parameter delay: float number of delayed samples
     - parameter Maximum: integer number of maximum delay
 */
    open func Create(delay: Float, Maximum: Int) {
        
        // Error checking: checking if delay <= Maximum and delay >= 0
        // setting delay to maximum otherwise
        guard (delay <= Float(Maximum) && delay >= 0) else {
            print("Delay is not in the range [0,Maximum], \n so it has been set to Maximum...")
            MaxFixed = Maximum + 1 // (Maximum + 1) allows for true maximum delay
            delayLine = Array(repeating: 0.0, count: MaxFixed)
            self.SetDelay(newDelay: Float(Maximum))
            return
        }
        MaxFixed = Maximum + 1
        delayLine = Array(repeating: 0.0, count: MaxFixed)
        self.SetDelay(newDelay: delay)
    }
    
    /** Function that sets the *delay* in a delay line of pre-assigned *Maximum* delay.
    - parameter newDelay: **float** number of delayed samples
     */
    open func SetDelay(newDelay: Float) {
        
        indexReadFrac = Float(indexWrite) - newDelay
        
        while indexReadFrac < 0 {
            indexReadFrac += Float(MaxFixed)
        }
        indexRead = Int(indexReadFrac)
        if indexRead == delayLine.count {
            indexRead = 0
        }
        frac = indexReadFrac - Float(indexRead)
        compfrac = 1 - frac
    }
    
    open func Clear() {
        for i in 0 ..< delayLine.count {
            delayLine[i] = 0.0
        }
    }
    
    /** Function for feeding the delay line with a sample (input: sample)
        and returning the *delayed* output sample by using linear interpolation.
    - parameter sample: **input** sample
    - returns: *delayed sample* (by linear interpolation)
     */
    open func Compute(sample: Float) -> Float {
        delayLine[indexWrite] = sample
        indexWrite += 1
        if indexWrite == delayLine.count {
            indexWrite = 0
        }
        
        output = delayLine[indexRead]*compfrac
        if (indexRead + 1) < delayLine.count {
            output += delayLine[indexRead+1]*frac
        } else {
            output += delayLine[0]*frac
        }
        indexRead += 1
        if indexRead == delayLine.count {
            indexRead = 0
        }
        
        return output
    }
}

// Uncomment these lines when using playgrounds
// public var delayLineF = DelayLine()

