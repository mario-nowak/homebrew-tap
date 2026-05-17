class MatchaLang < Formula
  desc "Experimental compiled language for match-first backend programming"
  homepage "https://github.com/mario-nowak/matcha"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mario-nowak/matcha/releases/download/matcha-compiler-v0.1.1/matcha-compiler-v0.1.1-macos-arm64.tar.gz"
      sha256 "8a430719f890804078d4dd53025a3ce1b64c399aeef8a0762e0cb68ccd56af93"
    end
  end

  depends_on "bdw-gc"

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
    assert_predicate testpath/"hello-emission.ll", :exist?
  end
end
