class Spotinfo < Formula
  desc "CLI tool to explore AWS EC2 Spot instances with pricing and interruption analysis"
  homepage "https://github.com/alexei-led/spotinfo"
  version "2.0.1"
  license "Apache-2.0"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/#{version}/spotinfo_darwin_arm64"
      sha256 "b6a80fcf3cbac183f6a573a25da013d04fe2060b1478b50209858e3ee256990a"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/#{version}/spotinfo_darwin_amd64"
      sha256 "a3f6aa758b0c922b34d6a7c12f5d7e382d8db3ec78ec4c1ee1d8680a8bbc4bd9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/#{version}/spotinfo_linux_arm64"
      sha256 "20810ba3d95ac8bd851f0019c77f7860c21f58f298889578045a8adb65eb1bf5"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/#{version}/spotinfo_linux_amd64"
      sha256 "adc9cdd134936265976a161607f16457bf353fd46fa26a438520991f449b1019"
    end
  end

  def install
    # Install the downloaded binary with architecture suffix as 'spotinfo'
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "spotinfo_darwin_arm64" : "spotinfo_darwin_amd64"
    else
      Hardware::CPU.arm? ? "spotinfo_linux_arm64" : "spotinfo_linux_amd64"
    end
    
    bin.install binary_name => "spotinfo"
  end

  test do
    # Test basic functionality
    assert_match "explore AWS EC2 Spot instances", shell_output("#{bin}/spotinfo --help")
    
    # Test version command runs without error
    system bin/"spotinfo", "--version"
    
    # Test help shows expected usage
    help_output = shell_output("#{bin}/spotinfo --help")
    assert_match "USAGE:", help_output
    assert_match "GLOBAL OPTIONS:", help_output
  end
end