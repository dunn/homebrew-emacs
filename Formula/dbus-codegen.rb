require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class DbusCodegen < EmacsFormula
  desc "Lisp code generation for D-Bus"
  homepage "http://elpa.gnu.org/packages/dbus-codegen.html"
  url "http://elpa.gnu.org/packages/dbus-codegen-0.1.el"
  sha256 "fc571aa29a09063995e1df525e001b1196f5193b8bbb1f007c141a9b0d9327be"
  head "http://git.savannah.gnu.org/cgit/emacs/elpa.git/plain/packages/dbus-codegen/dbus-codegen.el"

  depends_on :emacs
  depends_on "dunn/emacs/cl-lib" if Emacs.version < 24.3

  def install
    mv "dbus-codegen-#{version}.el", "dbus-codegen.el" if build.stable?
    byte_compile "dbus-codegen.el"
    (share/"emacs/site-lisp/dbus-codegen").install "dbus-codegen.el",
                                                   "dbus-codegen.elc"
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{HOMEBREW_PREFIX}/share/emacs/site-lisp")
      (load "dbus-codegen")
      (print (minibuffer-prompt-width))
    EOS
    assert_equal "0", shell_output("emacs -batch -l #{testpath}/test.el").strip
  end
end