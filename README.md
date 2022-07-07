# Advanced SwiftUI techniques & tricks

### Setup

- replace the main view with each sub lessons main view to run

```swift
struct AdvancedSwiftUITechniquesApp: App {
    var body: some Scene {
        WindowGroup {
            MachedGeoEffectTwo()
        }
    }
}
```

## Custom View Modifiers

- [Files](AdvancedSwiftUITechniques/Lessons/ViewModifiers)

```swift
struct DefaultButtonViewModifier: ViewModifier {

    var backgroundColor: Color
    var frameSize: CGFloat
    var font: Font

    init(backgroundColor: Color, frameSize: CGFloat = 55, font: Font = .headline) {
        self.backgroundColor = backgroundColor
        self.frameSize = frameSize
        self.font = font
    }

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: frameSize)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    func mainButtonFormat(backgroundColor: Color, frameSize: CGFloat = 55, font: Font = .headline) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor, frameSize: frameSize, font: font))
    }
}

struct CustomViewModifiers: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .modifier(DefaultButtonViewModifier(backgroundColor: .blue, font: .title))

            Text("Whats up")
                .mainButtonFormat(backgroundColor: .red, frameSize: 100)

            Text("Omboi")
                .mainButtonFormat(backgroundColor: .black)
        }
    }
}
```

## Button Styles

- [Files](AdvancedSwiftUITechniques/Lessons/ButtonStyles)

```swift
struct PressableButtonStyle: ButtonStyle {

    let scaledAmount: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1)

            // Custom highlight on opacity
            .opacity(configuration.isPressed ? 0.8 : 1)
//            .brightness(configuration.isPressed ? 0.5 : 0)
    }
}

extension View {

    func pressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
//        self.buttonStyle(PressableButtonStyle())
    }
}

struct CustomButtonStyle: View {
    var body: some View {
        Button {
            //
        } label: {
            Text("Click Me")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 10)
        }
        .pressableStyle()
        //.buttonStyle(PressableButtonStyle())
        .padding()
    }
}
```

## Custom Transitions

- [Files](AdvancedSwiftUITechniques/Lessons/Transitions)

```swift
struct RotateViewModifier: ViewModifier {
    let rotation: Double
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
        // Rotate on and off screen from bottom corner
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    static var rotating: Self {
        modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0))
        // Add scale effect
       // .combined(with: .scale.animation(.easeInOut))
    }

    static func rotating(rotation: Double) -> Self {
        modifier(
            active: RotateViewModifier(rotation: rotation),
            identity: RotateViewModifier(rotation: 0))
        // Add scale effect
       // .combined(with: .scale.animation(.easeInOut))
    }

    // Rotates ON screen & slides OFF via leading
    static var rotateOn: Self {
        asymmetric(insertion: .rotating, removal: .move(edge: .leading))
    }
}

struct TransitionLesson: View {

    @State private var showRectangle: Bool = false

    var body: some View {
        VStack {
            Spacer()


            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                // Rotates ON screen & slides OFF via leading
                    .transition(.rotateOn)
                // Spirals on & screen
//                    .transition(.rotating(rotation: 1080))
                // 1st Custom Transition
                    .transition(AnyTransition.rotating)
                // Scale in & out to nothing
//                    .transition(AnyTransition.scale.animation(.easeInOut))
                // Slides in & out from leading edge
//                    .transition(.move(edge: .leading))

            }

            Spacer()

            Text("Click Me!")
                .mainButtonFormat()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.75)) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}
```

## Matched Geometry Effect

- [Files](AdvancedSwiftUITechniques/Lessons/MatchedGeometry)

- works best with geometry shapes - `Circle` `Capsule` etc

```swift
struct MatchedGeoEffect: View {

    @State private var isClicked: Bool = false
    @Namespace private var namespace

    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25)
                // Best with actual shapes Circle, Capsule etc
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)

            }

            Spacer()

            if isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)

            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeoEffect_Previews: PreviewProvider {
    static var previews: some View {
        MachedGeoEffectTwo()
    }
}


struct MachedGeoEffectTwo: View {

    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespaceTwo

    var body: some View {
        HStack {
            ForEach(categories, id:\.self) { category in
                ZStack {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.5))
                            .matchedGeometryEffect(id: "square", in: namespaceTwo)

                    }
                    Text(category)
                        .foregroundColor(selected == category ? .white : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}
```
