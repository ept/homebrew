require 'formula'

class Plv8 < Formula
  homepage 'http://code.google.com/p/plv8js/'
  url 'http://plv8js.googlecode.com/files/plv8js-20110911.tar.gz'
  md5 '57bfd5cf7f4af123b7c76ca5f586ae17'
  head 'https://code.google.com/p/plv8js/', :using => :hg

  depends_on 'postgresql'
  depends_on 'v8'

  def patches
    # Fixes hardcoded badness in the Makefile -- and there is no ./configure
    DATA
  end

  def install
    system "make"
    system "make install"
  end

  def test
    # Requires Postgres to be running and plv8 to be installed
    system "make installcheck"
  end
end

__END__
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,5 @@
-V8DIR = ../v8
+V8DIR = /usr/local/Cellar/v8/HEAD
+CUSTOM_CC = g++   # by default PGXS uses /usr/bin/cc as linker, which fails on Mac OS
 
 SRCS = plv8.cc plv8_type.cc plv8_func.cc
 OBJS = $(SRCS:.cc=.o)
