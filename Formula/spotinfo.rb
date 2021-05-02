class Spotinfo < Formula
  desc "Explore AWS EC2 Spot: types, savings, price, and interruption frequency"
  homepage "https://github.com/alexei-led/spotinfo"
  url "https://github.com/alexei-led/spotinfo/archive/refs/tags/1.0.7.tar.gz"
  sha256 "62b2acd00d1ead08279de8fac529903a84f94bd05360bf599ceba81e43845c4c"
  license "Apache-2.0"
  head "https://github.com/alexei-led/spotinfo.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "wget" => :build

  def install
    ENV["VERSION"]  = "#{version}"
    system "make", "build"
    bin.install ".bin/spotinfo"
  end

  test do
    output = shell_output("#{bin}/spotinfo --type=t4g.small --output=text")
    assert_match "type=t4g.small, vCPU=2, memory=2GiB", output
  end
end
