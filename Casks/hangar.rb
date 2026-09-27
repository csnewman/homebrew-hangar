# The Homebrew cask for the desktop app. CI fills in the version and
# checksums for each release (desktop-v*), attaches the result to it as
# hangar.rb, and writes it into the tap, csnewman/homebrew-hangar:
#
#   brew tap csnewman/hangar
#   brew trust --cask csnewman/hangar/hangar
#   brew install --cask hangar
cask "hangar" do
  arch arm: "arm64", intel: "x64"

  version "0.1.1"
  sha256 arm:   "ea19a614c59b3119e573da021f01818e998d2127d6bddf1f62b05c7f7bcf4419",
         intel: "83bc22b311d23a70c81d03f106b396ba15d9b25d5d945e69c4556d94c7969ce9"

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
