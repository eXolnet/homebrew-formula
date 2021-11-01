class LocalPhpSecurityChecker < Formula
  desc "PHP security vulnerabilities checker"
  homepage "https://github.com/fabpot/local-php-security-checker"
  url "https://github.com/fabpot/local-php-security-checker/releases/download/v1.0.0/local-php-security-checker_1.0.0_darwin_amd64"
  sha256 "8c363d605116e84cf9ac28ac3838ca7979f7306916049bdb3f0f1fe2a8764d82"
  license "AGPL-3.0"
  version "1.0.0"

  depends_on "composer"

  livecheck do
    url :stable
  end

  def install
    bin.install "local-php-security-checker_1.0.0_darwin_amd64" => "local-php-security-checker"
  end

  test do
    (testpath/"composer.json").write <<~EOS
      {
        "name": "homebrew/test",
        "authors": [
          {
            "name": "Homebrew"
          }
        ],
        "require": {
          "symfony/yaml": "2.0.4"
        }
      }
    EOS

    system "composer", "install"
    ouput = shell_output("#{bin}/local-php-security-checker --path=#{testpath}/composer.json", 1)

    assert_match "symfony/yaml", ouput
    assert_match "CVE-2013-1348", ouput
    assert_match "CVE-2013-1397", ouput
  end
end
