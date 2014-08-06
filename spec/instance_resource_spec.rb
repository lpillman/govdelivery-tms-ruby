require 'spec_helper'
class Foo
  include TMS::InstanceResource
  writeable_attributes :bar
  collection_attribute :blah, 'EmailMessage'
  readonly_collection_attribute :shah, 'EmailMessage'
end

describe TMS::InstanceResource do
  context "creating a new inbound messages list" do
    let(:happy_response) do
      double(:status => 201,  :body => {})
    end

    let(:client) do
      double('client', :post => happy_response, :get => happy_response)
    end


    before do
      @instance_resource = Foo.new(client)
    end

    it 'should POST' do
      @instance_resource.bar = "OMG"
      @instance_resource.post.should be_true
    end

    it 'should correctly reflect on collection resources' do
      @instance_resource.blah.class.should == TMS::EmailMessage
      @instance_resource.shah.class.should == TMS::EmailMessage
    end

    it 'should not GET on initialization' do
      client.should_not receive(:get)
      Foo.new(client, 'https://example.com/foos/1')
    end

    it 'should return self on successful get' do
      client.should receive(:get)
      foo = Foo.new(client, 'https://example.com/foos/1')
      foo.should_not be_new_record
      foo.get.should == foo
    end

    it 'it exposes its attributes hash' do
      @instance_resource.attributes.should == {}
    end

  end
end
