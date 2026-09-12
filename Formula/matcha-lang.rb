class MatchaLang < Formula
  desc "Experimental compiled language for match-first backend programming"
  homepage "https://github.com/mario-nowak/matcha"
  version "0.2.0"
  license "MIT"

  depends_on "bdw-gc"

  on_macos do
    on_arm do
      url "https://github.com/mario-nowak/matcha/releases/download/matcha-compiler-v0.2.0/matcha-compiler-v0.2.0-macos-arm64.tar.gz"
      sha256 "326e4fd690908d4c979b980b91068819bbd4814a99333122e04fec10807b4eb9"
    end
  end

  def install
    bin.install "bin/matcha"
    lib.install "lib/libmatcha_runtime.a"
  end

  def caveats
    <<~EOS
      Matcha requires `clang` to be available on PATH.
      On macOS, install Xcode Command Line Tools if needed:

        xcode-select --install
    EOS
  end

  test do
    (testpath/"hello.mt").write <<~EOS
      printString("hello");
    EOS

    system bin/"matcha", "emit", "hello.mt"
    assert_path_exists testpath/"hello-emission.ll"
  end
end
