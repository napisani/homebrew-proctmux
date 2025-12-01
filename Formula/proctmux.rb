class Proctmux < Formula
  desc "tmux-based process manager with interactive TUI"
  homepage "https://github.com/napisani/proctmux"
  version "v0.1.5"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/napisani/proctmux/releases/download/v0.1.5/proctmux-darwin-arm64.tar.gz"
      sha256 "df9947b3a7216ccc91b0da1739aad87279b4c0ee3702d17f3b3dea78fe831e54"
    else
      url "https://github.com/napisani/proctmux/releases/download/v0.1.5/proctmux-darwin-amd64.tar.gz"
      sha256 "ab3ef86709d8818f62721c1124c8665ccab0687b2e320bba05bbf62a3d4cbfd1"
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
