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
require 'rails_helper'

RSpec.describe Postcode, type: :model do
  context 'with basic model' do
    subject { build(:postcode) }
    it { should be_valid }
  end

  context 'with a missing code' do
    subject { build(:postcode, code: nil) }
    it { should_not be_valid }
  end

  context 'with a missing lsoa' do
    subject { build(:postcode, lsoa: nil) }
    it { should_not be_valid }
  end

  context 'with an unfetched postcode' do
    subject { build(:unfetched_postcode) }
    it { should_not be_valid }

    describe '#fetch' do
      before { subject.fetch }
      it { should be_valid }
    end
  end

  context 'with an unfetched postcode containing deviding spaces' do
    subject { build(:unfetched_postcode, code: "SE1   7QD", lsoa: "Southwark 034A") }

    describe '#fetch' do
      it { should be_valid }
    end
  end
end
