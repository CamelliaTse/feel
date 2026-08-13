class Feel < Formula
  desc "记录当前感受的命令行工具 / CLI tool to record your current feelings"
  homepage "https://github.com/CamelliaTse/feel"
  url "https://github.com/CamelliaTse/feel/archive/refs/tags/v2.2.0.tar.gz"
  sha256 ""
  license "MIT"

  depends_on "python@3.12"

  def install
    bin.install "feel"
  end

  test do
    assert_match "feel", shell_output("#{bin}/feel help")
  end
end
