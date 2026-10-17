# The Homebrew cask for the desktop app. CI fills in the version and
# checksums for each release (desktop-v*), attaches the result to it as
# hangar.rb, and writes it into the tap, csnewman/homebrew-hangar:
#
#   brew tap csnewman/hangar
#   brew trust --cask csnewman/hangar/hangar
#   brew install --cask hangar
cask "hangar" do
  arch arm: "arm64", intel: "x64"

  version "0.1.2"
  sha256 arm:   "aa43e51488772cd2786c9ab1457c2463be2b051b7fa05cb24e316120cbc5b8f1",
         intel: "af0859bfda28939e943ffb5fe8f88323c67e5c26aaf469e08785dd72010359a3"

  url "https://github.com/csnewman/hangar/releases/download/desktop-v#{version}/Hangar-#{version}-mac-#{arch}.zip"
  name "Hangar"
  desc "Desktop control panel for Hangar development environments"
  homepage "https://github.com/csnewman/hangar"

  depends_on :macos

  app "Hangar.app"

  # The app is ad-hoc signed, not notarized, so macOS would refuse to open
  # it from a download; the flag that makes it do so is cleared here.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Hangar.app"]
  end

  zap trash: [
    "~/Library/Application Support/Hangar",
    "~/Library/Preferences/dev.hangar.desktop.plist",
    "~/Library/Saved Application State/dev.hangar.desktop.savedState",
  ]
end
