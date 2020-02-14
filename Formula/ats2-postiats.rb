class Ats2Postiats < Formula
  desc "Programming language with formal specification features"
  homepage "http://www.ats-lang.org/"
  url "https://downloads.sourceforge.net/project/ats2-lang/ats2-lang/ats2-postiats-0.4.0/ATS2-Postiats-0.4.0.tgz"
  sha256 "a749b62d429eda45ec304075f1743e1a2638c4772d37b579839d7797470869c0"

  bottle do
    cellar :any
    sha256 "4e6f3f3bdc1f4491c1e2dd0955c302f9a375315d924095f5f85a2eafc268381c" => :catalina
    sha256 "751f4582b45bf5b5f3e319f7cd40d3c02ccdca5024e5700062cb14faf3106888" => :mojave
    sha256 "1c0c128bf522b6780e1ff36b2ad959e9ccad36198411dbd5d21395baa412bfde" => :high_sierra
    sha256 "ee94f5c6675016834a7d864d6aa78515589f26a10ad3a650983259f3732e1630" => :sierra
  end

  depends_on "gmp"

  def install
    ENV.deparallelize
    system "./configure", "--prefix=#{prefix}"
    system "make", "all", "install"
  end

  test do
    (testpath/"hello.dats").write <<~EOS
      val _ = print ("Hello, world!\n")
      implement main0 () = ()
    EOS
    system "#{bin}/patscc", "hello.dats", "-o", "hello"
    assert_match "Hello, world!", shell_output(testpath/"hello")
  end
end
