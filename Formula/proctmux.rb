class Proctmux < Formula
  desc "tmux-based process manager with interactive TUI"
  homepage "https://github.com/napisani/proctmux"
  version "v0.1.1"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/napisani/proctmux/releases/download/v0.1.1/proctmux-darwin-arm64.tar.gz"
      sha256 "1b61d6098d7a7b88d9498ef74701572af4bdd2cf4a318e8bb1784cd800ef9ebe"
    else
      url "https://github.com/napisani/proctmux/releases/download/v0.1.1/proctmux-darwin-amd64.tar.gz"
      sha256 "c53e567a677e27df778ac57543fe8d914d2f94844493cba854875348edbd83ab"
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
