class Dl < Formula
  desc "A tiny tool for creating a local directory in a project that should not be published"
  homepage "https://github.com/vanyauhalin/dl"
  url "https://github.com/vanyauhalin/dl/releases/download/v0.1.0/dl.zip"
  sha256 "30fd3a07fde18648d9a82c6070d02252d1ae45ca6832214af79940944f01087d"
  license "MIT"
  head "https://github.com/vanyauhalin/dl", branch: "main"

  def install
    bin.install "dl"
  end

  test do
    system bin/"dl", "--help"
    system bin/"dl", "version", "0.1.0"
  end
end
