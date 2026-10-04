class MatchaLang < Formula
  desc "Experimental compiled language for match-first backend programming"
  homepage "https://github.com/mario-nowak/matcha"
  version "0.3.0"
  license "MIT"

  depends_on "bdw-gc"

  on_macos do
    on_arm do
      url "https://github.com/mario-nowak/matcha/releases/download/matcha-compiler-v0.3.0/matcha-compiler-v0.3.0-macos-arm64.tar.gz"
      sha256 "a548cc8cd8a6f5310ca62bba8bc9e5a3eafd931375075c11019aa02499823cc3"
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
