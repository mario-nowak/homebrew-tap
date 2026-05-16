class Matcha < Formula
  desc "Experimental compiled language for match-first backend programming"
  homepage "https://github.com/mario-nowak/matcha"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mario-nowak/matcha/releases/download/matcha-compiler-v0.1.0/matcha-compiler-v0.1.0-macos-arm64.tar.gz"
      sha256 "9c9f1c5be5662613854fa51dd31f53576885d05e7977ad9c1f056201940afc76"
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
