class Proctmux < Formula
  desc "tmux-based process manager with interactive TUI"
  homepage "https://github.com/napisani/proctmux"
  version "v0.1.4"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/napisani/proctmux/releases/download/v0.1.4/proctmux-darwin-arm64.tar.gz"
      sha256 "257323cbaa30f47b86531f748838c759b4fcccdbc142379a06d7d4857881a309"
    else
      url "https://github.com/napisani/proctmux/releases/download/v0.1.4/proctmux-darwin-amd64.tar.gz"
      sha256 "c75b24b447f1d09d204b986a492c030d3eef92a34dc6e3a0e597229e3f9069a8"
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
