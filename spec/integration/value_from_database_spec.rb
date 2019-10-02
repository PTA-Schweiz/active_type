require 'spec_helper'

module SampleSpec

  class Sample < ActiveRecord::Base
    scope :with_result, -> () { select("name, value, 42 as result") }
  end

  class CalculatedSample < ActiveType::Record[Sample]
    attribute :result, :integer, default: 20, ar_fallback: true
  end

end

describe SampleSpec::CalculatedSample do
  let(:sample) { SampleSpec::Sample.create(name: 'sample1', value: 20) }

  let(:calculated_sample) { described_class.with_result.find(sample.id) }
  let(:sample_without_calculation) { described_class.find(sample.id) }


  context 'with db result' do
    subject { calculated_sample.result }

    it { is_expected.to be(42) }

    describe 'overwrite by setting thourgh setter' do
      before { calculated_sample.result = 12 }
      it { is_expected.to eq 12 }
    end
  end

  context 'without db result' do
    subject { sample_without_calculation.result }
    it { is_expected.to eq(20) }

    describe 'overwrite by setting thourgh setter' do
      before { sample_without_calculation.result = 12 }
      it { is_expected.to eq 12 }
    end
  end

end
