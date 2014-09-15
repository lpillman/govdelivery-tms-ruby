require 'spec_helper'

describe TMS::Errors do
  context "an errors hash" do
    let(:object_with_errors) do
      double('instance', href: 'href', errors: {"body" => ["can't be blank"], "subject" => ["can't be blank"]})
    end
    subject { TMS::Errors::InvalidVerb.new(object_with_errors) }
    it 'should work' do
      subject.message.should =~ /body can't be blank, subject can't be blank/
    end
  end
end