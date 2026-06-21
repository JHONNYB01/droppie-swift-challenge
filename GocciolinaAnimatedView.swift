import SwiftUI
import WebKit
import UIKit
import Combine

struct GocciolinaAnimatedView: View {

    // MARK: - SVG centralizzati

    static let defaultSvgOpen: String = """
    
           <svg width="1098" height="1205" viewBox="0 0 1098 1205" fill="none" xmlns="http://www.w3.org/2000/svg">
           <path d="M327.5 725.5C335 710 347.5 689 347.5 689L371 653.5L389.5 628L411.5 598L439.5 564L458.5 538.5L473.5 515L485.5 494L498.5 472L509 451.5L518 428.5L522.5 415L526 403L528.5 392.5L530.926 385.569C531.639 383.532 532.617 381.598 533.836 379.816L535.081 377.997C537.299 374.755 540.517 372.328 544.245 371.085L544.57 370.977C548.399 369.7 552.556 369.823 556.304 371.322C560.585 373.034 563.99 376.405 565.746 380.669L566.5 382.5L571.5 400.5L577 418.5L586 441.5L594.5 460L606 482.5L617.5 502.5L629 521.5L640.5 538L653 555L667.5 573L682 590.5L697 608.5L711 626.5L728 647L744.5 669C744.5 669 749.5 675.5 755.5 685C761.5 694.5 758 689 768 705C778 721 779 727 783.5 738C788 749 788.5 754 791.5 768.5C794.5 783 796.5 803.5 796.5 803.5C796.5 803.5 797.5 821 797.5 826.5V835.979C797.5 841.984 797.017 847.978 796.056 853.906L795.946 854.582C794.984 860.518 793.545 866.366 791.643 872.071L788 883L783.889 893.535C781.302 900.163 778.09 906.53 774.296 912.548L765.5 926.5C760.833 933.167 750 946.5 748 948.5C745.5 951 740 958 730.5 965C721 972 721.833 971.5 717 975L706.63 981.518C701.883 984.502 696.919 987.125 691.78 989.365L680 994.5L659 1002L631.5 1010L613.004 1013.96C606.68 1015.32 600.25 1016.12 593.787 1016.37L564 1017.5L528.5 1018.5L497 1015.5L468 1009.5L441.5 1001L420.527 993.045C415.183 991.018 410.003 988.585 405.031 985.767L390.811 977.71C385.281 974.576 380.026 970.976 375.106 966.951L366 959.5L358 952.016C353.01 947.348 348.459 942.234 344.401 936.737L335 924L323.661 906.82C320.226 901.616 317.232 896.134 314.71 890.431L312.232 884.829C308.756 876.969 306.195 868.735 304.602 860.29L303.942 856.792C302.65 849.946 302 842.994 302 836.026V821.5L302.41 813.91C302.802 806.654 303.9 799.453 305.687 792.41L311.5 769.5C311.5 769.5 320 741 327.5 725.5Z" fill="url(#paint0_linear_23_2)" stroke="url(#paint1_linear_23_2)" stroke-width="18" stroke-linejoin="round"/>
           <ellipse cx="459.5" cy="771.5" rx="25.5" ry="29.5" fill="#12396B"/>
           <ellipse cx="467" cy="755.5" rx="8" ry="8.5" fill="#FCFDFE"/>
           <ellipse cx="650.5" cy="771.5" rx="25.5" ry="29.5" fill="#12396B"/>
           <ellipse cx="658" cy="755.5" rx="8" ry="8.5" fill="#FCFDFE"/>
           <ellipse cx="413" cy="820" rx="30" ry="24" fill="#F2B1C5"/>
           <ellipse cx="701" cy="819" rx="30" ry="24" fill="#F2B1C5"/>
           <ellipse cx="593.5" cy="570.5" rx="27.5" ry="33.5" fill="#FDFEFE"/>
           <circle cx="539" cy="573" r="7" fill="#FDFEFE"/>
           <ellipse cx="564" cy="520.5" rx="11" ry="11.5" fill="#FDFEFE"/>
           <ellipse cx="650.5" cy="640.5" rx="14.5" ry="15.5" fill="#FDFEFE"/>
           <path d="M512 828C512.995 831.316 514.458 834.474 516.345 837.377L517.883 839.742C519.29 841.908 520.921 843.921 522.747 845.747C526.537 849.537 531.105 852.46 536.134 854.312L538 855L543.832 856.591C547.262 857.526 550.802 858 554.357 858C556.934 858 559.27 858 559.5 858C559.764 858 562.951 856.837 566.093 855.663C569.024 854.567 571.806 853.109 574.392 851.346L577.002 849.567C579.985 847.533 582.656 845.077 584.933 842.274C586.969 839.769 588.671 837.009 589.996 834.065L592.5 828.5" stroke="black" stroke-width="15" stroke-linecap="round"/>
           <path d="M517.02 267.215L520.035 258.226L524.139 249.828L527.489 244.032L531.342 237.172L536.032 229.129L539.215 223.097L541.728 217.538L543.738 212.57L545.915 207.366L547.674 202.516L549.182 197.075L549.935 193.882L550.773 190.925L551.108 188.559L551.404 186.887C551.485 186.427 551.63 185.98 551.834 185.56L552.228 184.745C552.479 184.228 552.899 183.813 553.419 183.568L553.555 183.504C554.225 183.189 555.007 183.227 555.642 183.605C556.017 183.827 556.318 184.155 556.508 184.548L556.957 185.473C557.188 185.951 557.351 186.459 557.441 186.982L557.976 190.097L559.065 194.71L560.572 200.151L561.996 204.527L563.922 209.849L565.849 214.581L567.775 219.075L569.701 222.978L571.795 227L574.224 231.258L576.653 235.398L579.165 239.656L581.511 243.914L584.358 248.763L587.122 253.968L588.965 257.753C589.495 259.251 590.724 261.419 591.059 262.484C591.394 263.548 592.873 267.688 593.655 270.29L595.162 277.505L596 285.667V291.226V295.602L595.497 299.978L594.409 304.591C593.517 307.82 592.383 310.977 591.018 314.035L590.64 314.882C589.858 316.459 588.211 319.731 587.876 320.204C587.457 320.796 584.442 324.408 584.777 324.108C585.112 323.807 583.325 325.527 582.516 326.355L582.047 326.821C580.855 328.005 579.548 329.069 578.146 329.996C576.93 330.8 575.646 331.498 574.31 332.082L572.8 332.742L568.194 334.634L566.809 335.053C564.608 335.719 562.361 336.217 560.085 336.543L559.503 336.626C557.761 336.875 556.004 337 554.245 337C552.046 337 549.852 336.805 547.688 336.417L545.664 336.054L540.806 334.634L536.367 332.742C533.082 331.012 529.981 328.95 527.115 326.589L526.401 326C524.621 324.351 523.053 322.486 521.735 320.449L521.04 319.376L518.36 314.645L515.68 308.495L515.621 308.294C514.434 304.254 513.558 300.13 513 295.957V290.043L513.168 285.667L514.424 277.624L517.02 267.215Z" fill="url(#paint2_linear_23_2)" stroke="url(#paint3_linear_23_2)" stroke-width="18"/>
           <ellipse cx="565.5" cy="260.5" rx="12.5" ry="14.5" fill="#FDFEFE"/>
           <path d="M512 828H592" stroke="black" stroke-width="15" stroke-linecap="round"/>
           <path d="M524 839.5C523.6 839.1 560.833 839.333 579.5 839.5" stroke="black" stroke-width="15" stroke-linecap="round"/>
           <path d="M537.5 848.5H566" stroke="black" stroke-width="15" stroke-linecap="round"/>
           <defs>
           <linearGradient id="paint0_linear_23_2" x1="549.75" y1="369" x2="549.75" y2="1020" gradientUnits="userSpaceOnUse">
           <stop stop-color="#CDF5FE"/>
           <stop offset="0.4375" stop-color="#BFF2FD"/>
           <stop offset="0.639423" stop-color="#B1EEFC"/>
           <stop offset="0.831731" stop-color="#69DDF7"/>
           <stop offset="0.985577" stop-color="#07C5F0"/>
           </linearGradient>
           <linearGradient id="paint1_linear_23_2" x1="549.75" y1="369" x2="549.75" y2="1020" gradientUnits="userSpaceOnUse">
           <stop offset="0.278846" stop-color="#378FD0"/>
           <stop offset="0.591346" stop-color="#378FD0"/>
           <stop offset="0.831731" stop-color="#378FD0"/>
           <stop offset="1" stop-color="#378FD0"/>
           </linearGradient>
           <linearGradient id="paint2_linear_23_2" x1="554.5" y1="183" x2="554.5" y2="337" gradientUnits="userSpaceOnUse">
           <stop stop-color="#CDF5FE"/>
           <stop offset="0.4375" stop-color="#BFF2FD"/>
           <stop offset="0.639423" stop-color="#B1EEFC"/>
           <stop offset="0.831731" stop-color="#69DDF7"/>
           <stop offset="0.985577" stop-color="#07C5F0"/>
           </linearGradient>
           <linearGradient id="paint3_linear_23_2" x1="554.5" y1="183" x2="554.5" y2="337" gradientUnits="userSpaceOnUse">
           <stop offset="0.278846" stop-color="#378FD0"/>
           <stop offset="0.591346" stop-color="#378FD0"/>
           <stop offset="0.831731" stop-color="#378FD0"/>
           <stop offset="1" stop-color="#378FD0"/>
           </linearGradient>
           </defs>
           </svg>
    """

    static let defaultSvgClosed: String = """
           <svg width="1098" height="1205" viewBox="0 0 1098 1205" fill="none" xmlns="http://www.w3.org/2000/svg">
           <path d="M327.5 725.5C335 710 347.5 689 347.5 689L371 653.5L389.5 628L411.5 598L439.5 564L458.5 538.5L473.5 515L485.5 494L498.5 472L509 451.5L518 428.5L522.5 415L526 403L528.5 392.5L530.926 385.569C531.639 383.532 532.617 381.598 533.836 379.816L535.081 377.997C537.299 374.755 540.517 372.328 544.245 371.085L544.57 370.977C548.399 369.7 552.556 369.823 556.304 371.322C560.585 373.034 563.99 376.405 565.746 380.669L566.5 382.5L571.5 400.5L577 418.5L586 441.5L594.5 460L606 482.5L617.5 502.5L629 521.5L640.5 538L653 555L667.5 573L682 590.5L697 608.5L711 626.5L728 647L744.5 669C744.5 669 749.5 675.5 755.5 685C761.5 694.5 758 689 768 705C778 721 779 727 783.5 738C788 749 788.5 754 791.5 768.5C794.5 783 796.5 803.5 796.5 803.5C796.5 803.5 797.5 821 797.5 826.5V835.979C797.5 841.984 797.017 847.978 796.056 853.906L795.946 854.582C794.984 860.518 793.545 866.366 791.643 872.071L788 883L783.889 893.535C781.302 900.163 778.09 906.53 774.296 912.548L765.5 926.5C760.833 933.167 750 946.5 748 948.5C745.5 951 740 958 730.5 965C721 972 721.833 971.5 717 975L706.63 981.518C701.883 984.502 696.919 987.125 691.78 989.365L680 994.5L659 1002L631.5 1010L613.004 1013.96C606.68 1015.32 600.25 1016.12 593.787 1016.37L564 1017.5L528.5 1018.5L497 1015.5L468 1009.5L441.5 1001L420.527 993.045C415.183 991.018 410.003 988.585 405.031 985.767L390.811 977.71C385.281 974.576 380.026 970.976 375.106 966.951L366 959.5L358 952.016C353.01 947.348 348.459 942.234 344.401 936.737L335 924L323.661 906.82C320.226 901.616 317.232 896.134 314.71 890.431L312.232 884.829C308.756 876.969 306.195 868.735 304.602 860.29L303.942 856.792C302.65 849.946 302 842.994 302 836.026V821.5L302.41 813.91C302.802 806.654 303.9 799.453 305.687 792.41L311.5 769.5C311.5 769.5 320 741 327.5 725.5Z" fill="url(#paint0_linear_11_40)" stroke="url(#paint1_linear_11_40)" stroke-width="18" stroke-linejoin="round"/>
           <ellipse cx="459.5" cy="771.5" rx="25.5" ry="29.5" fill="#12396B"/>
           <ellipse cx="467" cy="755.5" rx="8" ry="8.5" fill="#FCFDFE"/>
           <ellipse cx="650.5" cy="771.5" rx="25.5" ry="29.5" fill="#12396B"/>
           <ellipse cx="658" cy="755.5" rx="8" ry="8.5" fill="#FCFDFE"/>
           <ellipse cx="413" cy="820" rx="30" ry="24" fill="#F2B1C5"/>
           <ellipse cx="701" cy="819" rx="30" ry="24" fill="#F2B1C5"/>
           <ellipse cx="593.5" cy="570.5" rx="27.5" ry="33.5" fill="#FDFEFE"/>
           <circle cx="539" cy="573" r="7" fill="#FDFEFE"/>
           <ellipse cx="564" cy="520.5" rx="11" ry="11.5" fill="#FDFEFE"/>
           <ellipse cx="650.5" cy="640.5" rx="14.5" ry="15.5" fill="#FDFEFE"/>
           <path d="M513 828C513.995 831.316 515.458 834.474 517.345 837.377L518.883 839.742C520.29 841.908 521.921 843.921 523.747 845.747C527.537 849.537 532.105 852.46 537.134 854.312L539 855L544.832 856.591C548.262 857.526 551.802 858 555.357 858C557.934 858 560.27 858 560.5 858C560.764 858 563.951 856.837 567.093 855.663C570.024 854.567 572.806 853.109 575.392 851.346L578.002 849.567C580.985 847.533 583.656 845.077 585.933 842.274C587.969 839.769 589.671 837.009 590.996 834.065L593.5 828.5" stroke="black" stroke-width="15" stroke-linecap="round"/>
           <path d="M517.02 267.215L520.035 258.226L524.139 249.828L527.489 244.032L531.342 237.172L536.032 229.129L539.215 223.097L541.728 217.538L543.738 212.57L545.915 207.366L547.674 202.516L549.182 197.075L549.935 193.882L550.773 190.925L551.108 188.559L551.404 186.887C551.485 186.427 551.63 185.98 551.834 185.56L552.228 184.745C552.479 184.228 552.899 183.813 553.419 183.568L553.555 183.504C554.225 183.189 555.007 183.227 555.642 183.605C556.017 183.827 556.318 184.155 556.508 184.548L556.957 185.473C557.188 185.951 557.351 186.459 557.441 186.982L557.976 190.097L559.065 194.71L560.572 200.151L561.996 204.527L563.922 209.849L565.849 214.581L567.775 219.075L569.701 222.978L571.795 227L574.224 231.258L576.653 235.398L579.165 239.656L581.511 243.914L584.358 248.763L587.122 253.968L588.965 257.753C589.495 259.251 590.724 261.419 591.059 262.484C591.394 263.548 592.873 267.688 593.655 270.29L595.162 277.505L596 285.667V291.226V295.602L595.497 299.978L594.409 304.591C593.517 307.82 592.383 310.977 591.018 314.035L590.64 314.882C589.858 316.459 588.211 319.731 587.876 320.204C587.457 320.796 584.442 324.408 584.777 324.108C585.112 323.807 583.325 325.527 582.516 326.355L582.047 326.821C580.855 328.005 579.548 329.069 578.146 329.996C576.93 330.8 575.646 331.498 574.31 332.082L572.8 332.742L568.194 334.634L566.809 335.053C564.608 335.719 562.361 336.217 560.085 336.543L559.503 336.626C557.761 336.875 556.004 337 554.245 337C552.046 337 549.852 336.805 547.688 336.417L545.664 336.054L540.806 334.634L536.367 332.742C533.082 331.012 529.981 328.95 527.115 326.589L526.401 326C524.621 324.351 523.053 322.486 521.735 320.449L521.04 319.376L518.36 314.645L515.68 308.495L515.621 308.294C514.434 304.254 513.558 300.13 513 295.957V290.043L513.168 285.667L514.424 277.624L517.02 267.215Z" fill="url(#paint2_linear_11_40)" stroke="url(#paint3_linear_11_40)" stroke-width="18"/>
           <ellipse cx="565.5" cy="260.5" rx="12.5" ry="14.5" fill="#FDFEFE"/>
           <defs>
           <linearGradient id="paint0_linear_11_40" x1="549.75" y1="369" x2="549.75" y2="1020" gradientUnits="userSpaceOnUse">
           <stop stop-color="#CDF5FE"/>
           <stop offset="0.4375" stop-color="#BFF2FD"/>
           <stop offset="0.639423" stop-color="#B1EEFC"/>
           <stop offset="0.831731" stop-color="#69DDF7"/>
           <stop offset="0.985577" stop-color="#07C5F0"/>
           </linearGradient>
           <linearGradient id="paint1_linear_11_40" x1="549.75" y1="369" x2="549.75" y2="1020" gradientUnits="userSpaceOnUse">
           <stop offset="0.278846" stop-color="#378FD0"/>
           <stop offset="0.591346" stop-color="#378FD0"/>
           <stop offset="0.831731" stop-color="#378FD0"/>
           <stop offset="1" stop-color="#378FD0"/>
           </linearGradient>
           <linearGradient id="paint2_linear_11_40" x1="554.5" y1="183" x2="554.5" y2="337" gradientUnits="userSpaceOnUse">
           <stop stop-color="#CDF5FE"/>
           <stop offset="0.4375" stop-color="#BFF2FD"/>
           <stop offset="0.639423" stop-color="#B1EEFC"/>
           <stop offset="0.831731" stop-color="#69DDF7"/>
           <stop offset="0.985577" stop-color="#07C5F0"/>
           </linearGradient>
           <linearGradient id="paint3_linear_11_40" x1="554.5" y1="183" x2="554.5" y2="337" gradientUnits="userSpaceOnUse">
           <stop offset="0.278846" stop-color="#378FD0"/>
           <stop offset="0.591346" stop-color="#378FD0"/>
           <stop offset="0.831731" stop-color="#378FD0"/>
           <stop offset="1" stop-color="#378FD0"/>
           </linearGradient>
           </defs>
           </svg>
    """

    // MARK: - Parametri

    let svgOpen: String
    let svgClosed: String

    var size: CGFloat = 280
    var mouthInterval: TimeInterval = 0.22
    var floatAmplitude: CGFloat = 14
    var floatDuration: TimeInterval = 2.2

    // 🔑 controllo esterno
    @Binding var isSpeaking: Bool

    // MARK: - Stati interni

    @State private var isMouthOpen = false
    @State private var mouthTimer: Timer?
    @State private var floatUp = false

    @State private var isPressed = false
    @State private var hapticTrigger = false

    private var baseFloatOffset: CGFloat { floatUp ? -floatAmplitude : floatAmplitude }
    private var pressOffset: CGFloat { isPressed ? 10 : 0 }
    private var yOffset: CGFloat { baseFloatOffset + pressOffset }

    private var lift01: CGFloat {
        let base: CGFloat = floatUp ? 1.0 : 0.0
        return max(0, min(1, base - (isPressed ? 0.35 : 0.0)))
    }

    // MARK: - Init

    init(
        svgOpen: String = GocciolinaAnimatedView.defaultSvgOpen,
        svgClosed: String = GocciolinaAnimatedView.defaultSvgClosed,
        size: CGFloat = 280,
        mouthInterval: TimeInterval = 0.22,
        floatAmplitude: CGFloat = 14,
        floatDuration: TimeInterval = 2.2,
        isSpeaking: Binding<Bool>
    ) {
        self.svgOpen = svgOpen
        self.svgClosed = svgClosed
        self.size = size
        self.mouthInterval = mouthInterval
        self.floatAmplitude = floatAmplitude
        self.floatDuration = floatDuration
        self._isSpeaking = isSpeaking
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            DropShadowView(lift: lift01)
                .offset(y: size * 0.42)

            SVGWebView(svg: isMouthOpen ? svgOpen : svgClosed)
                .frame(width: size, height: size)
                .offset(y: yOffset)
        }
        .frame(height: size + 70)
        .contentShape(Rectangle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.spring(.snappy(duration: 0.05))) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.spring(.snappy(duration: 0.05))) {
                        isPressed = false
                    }
                }
        )
        .onTapGesture { hapticTrigger.toggle() }
        .sensoryFeedback(.selection, trigger: hapticTrigger)
        .onAppear {
            startFloating()
        }
        .onChange(of: isSpeaking) { speaking in
            if speaking {
                startMouth()
            } else {
                stopMouth()
            }
        }
        .onDisappear {
            stopMouth()
        }
    }

    // MARK: - Animazioni

    private func startFloating() {
        floatUp = false
        withAnimation(.easeInOut(duration: floatDuration).repeatForever(autoreverses: true)) {
            floatUp = true
        }
    }

    private func startMouth() {
        stopMouth()
        mouthTimer = Timer.scheduledTimer(withTimeInterval: mouthInterval, repeats: true) { _ in
            withAnimation(.easeInOut(duration: mouthInterval * 0.6)) {
                isMouthOpen.toggle()
            }
        }
        if let mouthTimer {
            RunLoop.current.add(mouthTimer, forMode: .common)
        }
    }

    private func stopMouth() {
        mouthTimer?.invalidate()
        mouthTimer = nil
        isMouthOpen = false
    }
}

// MARK: - SVG WebView

struct SVGWebView: UIViewRepresentable {
    let svg: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences.allowsContentJavaScript = false

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <!doctype html>
        <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
            html, body { margin:0; padding:0; background:transparent; }
            svg { width:100%; height:100%; display:block; }
          </style>
        </head>
        <body>
          \(svg)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
}

// MARK: - Ombra

private struct DropShadowView: View {
    var lift: CGFloat

    var body: some View {
        ZStack {
            Ellipse()
                .fill(Color.black)
                .opacity(0.28 - 0.14 * lift)
                .frame(width: 120 + 36 * lift, height: 18 + 5 * lift)
                .blur(radius: 12 + 6 * lift)

            Ellipse()
                .fill(Color.black)
                .opacity(0.12 - 0.07 * lift)
                .frame(width: 72 + 18 * lift, height: 10 + 3 * lift)
                .blur(radius: 6 + 3 * lift)
        }
        .offset(y: 6)
    }
}
