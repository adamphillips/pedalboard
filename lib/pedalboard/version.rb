module Pedalboard
  module Version
    MAJOR    = 0
    MINOR    = 0
    REVISION = 1
  end

  def self.version
    "#{Version::MAJOR}.#{Version::MINOR}.#{Version::REVISION}"
  end
end
