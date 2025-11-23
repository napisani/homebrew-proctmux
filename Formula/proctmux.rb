class Proctmux < Formula
  desc "tmux-based process manager with interactive TUI"
  homepage "https://github.com/napisani/proctmux"
  version "v0.1.3"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/napisani/proctmux/releases/download/v0.1.3/proctmux-darwin-arm64.tar.gz"
      sha256 "040d67e437887cc8ff136bd55de5efe2218537728fc1e2e927f867bd04a70d56"
    else
      url "https://github.com/napisani/proctmux/releases/download/v0.1.3/proctmux-darwin-amd64.tar.gz"
      sha256 "38e0c7bc6fc388efb8118588dd9a3db79b4a4255028c22d8d2a9fc4db525b4ee"
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
