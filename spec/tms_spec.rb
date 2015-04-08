require 'spec_helper'

describe TMS, "version" do
  it "should exist" do
    expect(TMS::VERSION).to be_an_instance_of(String)
  end
end