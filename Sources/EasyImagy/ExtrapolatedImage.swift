internal struct ExtrapolatedImage<Pixels : ImageProtocol> : ImageProtocol {
    public typealias SubImage = AnyImage<Pixels.Pixel>
    public typealias Iterator = ImageIterator<ExtrapolatedImage<Pixels>>
    public typealias Element = Pixels.Pixel // FIXME: Remove this line in the future. Swift 4.1 needs it to build `ExtrapolatedImage`.

    private var image: Pixels
    private let extrapolationMethod: ExtrapolationMethod<Pixels.Pixel>
    
    public let xRange: CountableRange<Int> = .min ..< .max
    public let yRange: CountableRange<Int> = .min ..< .max
    
    internal init(image: Pixels, extrapolationMethod: ExtrapolationMethod<Pixels.Pixel>) {
        self.image = image
        self.extrapolationMethod = extrapolationMethod
    }
    
    public subscript(x: Int, y: Int) -> Pixels.Pixel {
        get {
            return image[x, y, extrapolatedBy: extrapolationMethod]
        }
        set {
            fatalError("Unsupported.")
        }
    }
    
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> AnyImage<Pixels.Pixel> {
        return AnyImage<Pixels.Pixel>(self, xRange: xRange, yRange: yRange)
    }
    
    public func makeIterator() -> ImageIterator<ExtrapolatedImage<Pixels>> {
        return ImageIterator(self)
    }
}
