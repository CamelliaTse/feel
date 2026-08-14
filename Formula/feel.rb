# 这份 formula 的正式位置是 tap 仓库 CamelliaTse/homebrew-tap 的 Formula/feel.rb。
# 主仓库保留一份源文件便于随版本一起维护，发布时把文件复制过来并回填
# url 与 sha256。
#
# 用户安装：
#   brew tap CamelliaTse/tap
#   brew install feel
# 或一步到位：
#   brew install CamelliaTse/tap/feel

class Feel < Formula
  include Language::Python::Shebang

  desc "Record your current feelings from the command line"
  homepage "https://github.com/CamelliaTse/feel"
  url "https://github.com/CamelliaTse/feel/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "9884d61d081da37b2c124aefc49b12998f87a612cddd24c54d28a6a52d184890"
  license "MIT"
  head "https://github.com/CamelliaTse/feel.git", branch: "main"

  # 单文件脚本，只用标准库，运行时只需要一个 Python。
  depends_on "python@3.14"

  def install
    # 上游 shebang 是 #!/usr/bin/env python3，改写成 brew 的 python，
    # 免得依赖用户 PATH 里恰好有哪个 python3。
    bin.install "feel"
    rewrite_shebang detected_python_shebang, bin/"feel"
  end

  test do
    # 版本号能打印，说明脚本可执行且 shebang 改写没有写坏。
    assert_match "feel v#{version}", shell_output("#{bin}/feel version")

    # 端到端跑一遍「记录 -> 查看」，日志落在测试沙箱里，不碰用户真实目录。
    ENV["XDG_DATA_HOME"] = testpath/"data"
    shell_output("#{bin}/feel 'homebrew smoke test'")

    # 默认扩展名为 .feel，主日志为 log.feel。
    log = testpath/"data/feel/log.feel"
    assert_predicate log, :exist?
    assert_equal 1, log.read.lines.length
    assert_match "homebrew smoke test", log.read

    assert_match "homebrew smoke test", shell_output("#{bin}/feel list")
  end
end
