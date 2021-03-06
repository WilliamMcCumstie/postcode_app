#==============================================================================
# Copyright 2021 William McCumstie
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#==============================================================================

class Postcode
  include ActiveModel::Model

  attr_accessor :code
  validates :code, presence: true

  attr_accessor :lsoa

  # Checks if the LSOA is within the service area
  validate do
    if lsoa
      shortened_lsoa = Settings.shortened_lsoas.find do |area|
        area == lsoa[0...area.length]
      end
      unless shortened_lsoa
        @errors.add(:lsoa, 'is not within the service area')
      end
    elsif ! Settings.allowed_postcodes.any? { |p| p.downcase == code.downcase }
      @errors.add(:lsoa, 'has not been given')
    end
  end

  # Primarily used to facilitate testing
  attr_accessor :last_postcodes_response

  # Checks if the postcode is valid, fetching it if required
  def orchestrated_valid?
    return true if valid?
    fetch
    valid?
  end

  def fetch
    return unless /\A[a-zA-Z\d ]+\Z/.match?(code)
    url = "http://postcodes.io/postcodes/#{URI.escape code}"
    response = Faraday.get url
    self.last_postcodes_response = response
    return unless response.status == 200
    json = JSON.parse response.body
    self.lsoa = json["result"]["lsoa"]
  end
end
