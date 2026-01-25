class Proctmux < Formula
  desc "tmux-based process manager with interactive TUI"
  homepage "https://github.com/napisani/proctmux"
  version "v0.1.6"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/napisani/proctmux/releases/download/v0.1.6/proctmux-darwin-arm64.tar.gz"
      sha256 "d7ede3f39cdbbd78adf31b3b36a1882d81023bbfba1a44fba235c7b0d3c96126"
    else
      url "https://github.com/napisani/proctmux/releases/download/v0.1.6/proctmux-darwin-amd64.tar.gz"
      sha256 "e0284b8a79c351f78c643aa4029c94b0882152b5d5b60923ea70301bdcd99504"
    end
  end

  depends_on "tmux"

  def install
    bin.install "proctmux-darwin-arm64" => "proctmux" if Hardware::CPU.arm?
    bin.install "proctmux-darwin-amd64" => "proctmux" if Hardware::CPU.intel?
  end

  def caveats
    <<~EOS
      proctmux requires tmux to be running.
      
      To use proctmux:
        1. Start a tmux session: tmux
        2. Run proctmux inside the tmux session
      
      See https://github.com/napisani/proctmux for configuration and usage.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/proctmux --version 2>&1", 1)
  end
end
