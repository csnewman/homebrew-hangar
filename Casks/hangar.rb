# The Homebrew cask for the desktop app. CI fills in the version and
# checksums for each release (desktop-v*), attaches the result to it as
# hangar.rb, and writes it into the tap, csnewman/homebrew-hangar:
#
#   brew tap csnewman/hangar
#   brew install --cask hangar
cask "hangar" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "d00aef5328ec4f71e36fd24d28145901fb6699e5492f6bc7cee8d35ba423ad1a",
         intel: "7c4a760bcf701deabea1d74fb5b87321cf0e2bbbdcd8b069fbb89f289c1301a2"

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
