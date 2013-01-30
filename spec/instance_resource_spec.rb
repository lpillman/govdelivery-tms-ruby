require 'spec_helper'
class Foo
  include TMS::InstanceResource
  writeable_attributes :bar
end

describe TMS::InstanceResource do
  context "creating a new inbound messages list" do
    let(:happy_response) do
      double(:status => 201,  :body => {})
    end

    let(:client) do
      double('client', :post => happy_response)
    end


    before do
      @instance_resource = Foo.new(client)
    end

    it 'should POST' do
      @instance_resource.bar = "OMG"
      @instance_resource.post.should be_true
    end
  end
end
