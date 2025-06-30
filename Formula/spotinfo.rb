class Spotinfo < Formula
  desc "CLI tool to explore AWS EC2 Spot instances with pricing and interruption analysis"
  homepage "https://github.com/alexei-led/spotinfo"
  version "2.0.0"
  license "Apache-2.0"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/#{version}/spotinfo_darwin_arm64"
      sha256 "e45fbc830c71b8bfe4753694d618c3974600a2d3ee6446d2d120bdf3f9e8d234"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/#{version}/spotinfo_darwin_amd64"
      sha256 "6fcef4f7ebc0724f2a72824f7e5b386f2cd32aaaec402d1620ad41fa4aadd83d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/alexei-led/spotinfo/releases/download/#{version}/spotinfo_linux_arm64"
      sha256 "16e5534d11e8b718eee57b713b093a5539a6f7fae88f74a17ecaaaf4af161c28"
    else
      url "https://github.com/alexei-led/spotinfo/releases/download/#{version}/spotinfo_linux_amd64"
      sha256 "292045af237466b0b501c1fe29a4339b8de3ba4a1a94a911379ccc46eeb35668"
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