require 'spec_helper'

describe TMS, "version" do
  it "should exist" do
    TMS::VERSION.should be_an_instance_of(String)
  end
end